unit MP3Util;

{$WARNINGS OFF} 

interface

uses SysUtils, WinTypes, Messages, Classes;

const
   MaxFrameLength = 1729; // Max. frame length for MPEG Version 1 (layer 2, 3)
   MinFrameLength = 96;   // Min. frame length for MPEG Version 1 (layer 2, 3)

   MPEG_SAMPLE_RATES : array[1..3] of array[0..3] of word =
     { Version 1   }
    ((44100, 48000, 32000, 0),
     { Version 2   }
     (22050, 24000, 16000, 0),
     { Version 2.5 }
     (11025, 12000, 8000, 0));

   MPEG_BIT_RATES : array[1..3] of array[1..3] of array[0..15] of word =
       { Version 1, Layer I     }
     (((0,32,64,96,128,160,192,224,256,288,320,352,384,416,448,0),
       { Version 1, Layer II    }
       (0,32,48,56, 64, 80, 96,112,128,160,192,224,256,320,384,0),
       { Version 1, Layer III   }
       (0,32,40,48, 56, 64, 80, 96,112,128,160,192,224,256,320,0)),
       { Version 2, Layer I     }
      ((0,32,64,96,128,160,192,224,256,288,320,352,384,416,448,0),
       { Version 2, Layer II    }
       (0,32,48,56, 64, 80, 96,112,128,160,192,224,256,320,384,0),
       { Version 2, Layer III   }
       (0, 8,16,24, 32, 64, 80, 56, 64,128,160,112,128,256,320,0)),
       { Version 2.5, Layer I   }
      ((0,32,64,96,128,160,192,224,256,288,320,352,384,416,448,0),
       { Version 2.5, Layer II  }
       (0,32,48,56, 64, 80, 96,112,128,160,192,224,256,320,384,0),
       { Version 2.5, Layer III }
       (0, 8,16,24, 32, 64, 80, 56, 64,128,160,112,128,256,320,0)));
type
   TMP3Version = (Version_Unknown, Version_1, Version_2, Version_25);
   TMP3Layer = (Layer_Unknown, Layer_1, Layer_2, Layer_3);
   TMP3Mode = (Mode_Stereo, Mode_JStereo, Mode_DualCh, Mode_Mono);
   TMP3Result = (NoError, NoFile, NoValidFile, WriteInhibited);

   TFrameInfo = record
        FrameHeaderPos : DWORD;
        Version : TMP3Version;   { MPEG audio version index }
        Layer : TMP3Layer;       { MPEG audio layer index }
        SampleRate : LongInt;    { Sampling rate in Hz}
        BitRate : LongInt;       { Bit Rate in KHz}
        Mode : TMP3Mode;         { MPEG audio channel mode index }
        Copyright : Boolean;     { Copyrighted ? }
        Original : Boolean;      { Original ? }
        ErrorProtection : boolean; { Error protected ? }
        Padding : Boolean;       { Frame is padded ? }
        FrameLength : Word;      { Total frame size including CRC }
   end;

   TMP3Info = record
        FileName : string;
        FileLength : longint;
        FileDateTime : LongInt;  { File last modification date and time
                                                in DOS internal format }
        ReadOnlyFile : boolean;  { File is read only, i.e. write inhibited ? }
        Duration : DWORD;        { Song duration in milli second }

        FrameInfo : TFrameInfo;

        HasTag : boolean;
        Title : string[30];
        Artist : string[30];
        Album : string[30];
        Year : string[4];
        Comment : string[30];
        Genre : byte;
     end;

const
   GenreTypes = 81;
   VersionNames : array[Version_Unknown..Version_25] of string[16] =
     ('Version Unknown', 'MPEG Version 1', 'MPEG Version 2', 'MPEG Version 2.5');
   LayerNames : array[Layer_Unknown..Layer_3] of string[13] =
     ('Layer Unknown', 'Layer I', 'Layer II', 'Layer III');
   ModeNames : array[Mode_Stereo..Mode_Mono] of string[12] =
     ('Stereo', 'Joint Stereo', 'Dual Channel', 'Mono');
   GenreNames : array[0..GenreTypes-1] of string[18] =
     ('Blues', 'Classic Rock', 'Country', 'Dance', 'Disco', 'Funk', 'Grunge',
      'Hip-Hop', 'Jazz', 'Metal', 'New Age', 'Oldies', 'Other', 'Pop', 'R&B',
      'Rap', 'Reggae', 'Rock', 'Techno', 'Industrial', 'Alternative', 'Ska',
      'Death Metal', 'Pranks', 'Soundtrack', 'Euro-Techno', 'Ambient',
      'Trip-Hop', 'Vocal', 'Jazz+Funk', 'Fusion', 'Trance', 'Classical',
      'Instrumental', 'Acid', 'House', 'Game', 'Sound Clip', 'Gospel', 'Noise',
      'Altern Rock', 'Bass', 'Soul', 'Punk', 'Space', 'Meditative',
      'Instrumental Pop', 'Instrumental Rock', 'Ethnic', 'Gothic', 'Darkwave',
      'Techno-Industrial', 'Electronic', 'Pop-Folk', 'Eurodance', 'Dream',
      'Southern Rock', 'Comedy', 'Cult', 'Gangsta', 'Top 40', 'Christian Rap',
      'Pop/Funk', 'Jungle', 'Native American', 'Cabaret', 'New Wave',
      'Psychadelic', 'Rave', 'Showtunes', 'Trailer', 'Lo-Fi', 'Tribal',
      'Acid Punk', 'Acid Jazz', 'Polka', 'Retro', 'Musical', 'Rock & Roll',
      'Hard Rock', 'Unknown');

 function DecodeFrameHeader(FrameHeader : LongInt;
                           var FrameInfo : TFrameInfo) : Boolean;
 function FindFrameHeader(var MP3Stream : TFileStream;
                         DetectionLimit : word;
                         var FrameInfo : TFrameInfo) : boolean;
 procedure GetMP3Info(FilePath : string;
                      var ValidFile : boolean;
                      var MP3Info : TMP3Info);
 procedure SetMP3Tag(FilePath : string;
                     MP3Info : TMP3Info;
                     var Result : TMP3Result);
 function GetGenreName(Genre : byte) : string;

implementation

var
   f : file;
   Buffer : array[1..128] of char;
   SearchRec : TSearchRec;


function CalcFrameLength (SampleRate, BitRate : LongInt; Padding : Boolean) : Integer;
begin
  If SampleRate > 0 then
     Result := Trunc (144 * BitRate * 1000 / SampleRate + Integer (Padding))
  else
     Result := 0;
end;


function FrameHeaderValid(FrameData : TFrameInfo) : Boolean;
begin
   Result := (ord(FrameData.Version) > 0) and (ord(FrameData.Layer) > 0) and
              (FrameData.BitRate > 0) and (FrameData.SampleRate > 0);
end;

function DecodeFrameHeader(FrameHeader : LongInt;
                           var FrameInfo : TFrameInfo) : Boolean;
  { Decode MPEG Frame Header and store data to FrameInfo.
    Return true if header seems valid. }

var
  BitrateIndex : byte;
  VersionIndex : byte;
  LayerIndex : byte;
  ModeIndex : byte;
begin
  FrameInfo.Version := Version_Unknown;
  FrameInfo.Layer := Layer_Unknown;
  FrameInfo.SampleRate := 0;
  FrameInfo.Copyright := False;
  FrameInfo.Original := False;
  FrameInfo.ErrorProtection := False;
  FrameInfo.Padding := False;
  FrameInfo.BitRate := 0;
  FrameInfo.FrameLength := 0;

  If (FrameHeader and $ffe00000) = $ffe00000 then begin
    VersionIndex := (FrameHeader shr 19) and $3;
    case VersionIndex of
      0 : FrameInfo.Version := Version_25;      { Version 2.5 }
      1 : FrameInfo.Version := Version_Unknown; { Unknown }
      2 : FrameInfo.Version := Version_2;       { Version 2 }
      3 : FrameInfo.Version := Version_1;       { Version 1 }
    end;
    { if Version is known, read other data }
    If FrameInfo.Version <> Version_Unknown then begin
      LayerIndex := (FrameHeader shr 17) and $3;
      case LayerIndex of
         0 : FrameInfo.Layer := Layer_Unknown;
         1 : FrameInfo.Layer := Layer_3;
         2 : FrameInfo.Layer := Layer_2;
         3 : FrameInfo.Layer := Layer_1;
      end;

      BitrateIndex := ((FrameHeader shr 12) and $F);
      FrameInfo.SampleRate := MPEG_SAMPLE_RATES[ord(FrameInfo.Version)]
                                              [((FrameHeader shr 10) and $3)];
      FrameInfo.ErrorProtection := ((FrameHeader shr 16) and $1) = 1;
      FrameInfo.Copyright := ((FrameHeader shr 3) and $1) = 1;
      FrameInfo.Original := ((FrameHeader shr 2) and $1) = 1;
      ModeIndex := (FrameHeader shr 6) and $3;
      case ModeIndex of
         0 : FrameInfo.Mode := Mode_Stereo;
         1 : FrameInfo.Mode := Mode_JStereo;
         2 : FrameInfo.Mode := Mode_DualCh;
         3 : FrameInfo.Mode := Mode_Mono;
      end;
      FrameInfo.Padding := ((FrameHeader shr 9) and $1) = 1;
      FrameInfo.BitRate := MPEG_BIT_RATES[ord(FrameInfo.Version)]
                                        [ord(FrameInfo.Layer)][BitrateIndex];

      FrameInfo.FrameLength := CalcFrameLength(FrameInfo.SampleRate,
                                            FrameInfo.BitRate, FrameInfo.Padding);
    end;
    Result := FrameHeaderValid(FrameInfo);
  end else
    Result := False;

end;

function FindFrameHeader(var MP3Stream : TFileStream;
                         DetectionLimit : word;
                         var FrameInfo : TFrameInfo) : boolean;
var
   mp3hdrread : array[1..4] of byte;
   mp3hdr : LongInt ABSOLUTE mp3hdrread;
   tempbyte : byte;
   tempLongInt : LongInt;

   StartPos : DWORD;
   //BytesRead : longint;
   tmpFrameInfo : TFrameInfo;

  procedure WinProcessMessages;
  { Allow Windows to process other system messages }
  var
    ProcMsg  :  TMsg;
  begin
    while PeekMessage(ProcMsg, 0, 0, 0, PM_REMOVE) do begin
      if (ProcMsg.Message = WM_QUIT) then Exit;
      TranslateMessage(ProcMsg);
      DispatchMessage(ProcMsg);
    end; { while }
  end; { winProcessMessages }

begin
   StartPos := MP3Stream.Position;
   FrameInfo.BitRate := 0;      // for validity check
   tmpFrameInfo.BitRate := 0;
   result := false;             // Set default result value

   repeat
   // skip upto the sync byte ($FF)
      repeat
         //BytesRead :=
         MP3Stream.Read(tempbyte, 1);
      until (tempbyte = $FF) or (MP3Stream.Position >= (MP3Stream.Size - MinFrameLength - 1));

      if tempbyte <> $FF then   // not found sync byte
         exit;

      //BytesRead :=
      MP3Stream.Read(mp3hdrread, 3);
      mp3hdrread[4] := tempbyte;
      tempbyte := mp3hdrread[1];
      mp3hdrread[1] := mp3hdrread[3];
      mp3hdrread[3] := tempbyte;

      while (MP3Stream.Position < (MP3Stream.Size - MinFrameLength))
           and (MP3Stream.Position < (StartPos + DetectionLimit)) do
      begin
       { if mpeg header is not at the begining of the file, search file
          to find proper frame sync. This block can be speed up by reading
          blocks of bytes instead reading single byte from file }
         if mp3hdrread[4] = $FF then
            if DecodeFrameHeader(mp3hdr, FrameInfo) then
               break;

         mp3hdr := mp3hdr shl 8;
         //BytesRead :=
         MP3Stream.Read(tempbyte, 1);
         mp3hdrread[1] := tempbyte;

       // On each 300 bytes read, release procesor to allow OS do something else too
         if (MP3Stream.Position MOD 300) = 0 then
             WinProcessMessages;
      end; { while }

      if not FrameHeaderValid(FrameInfo) then
         exit;

    { Ok, one header is found, but that is not good proof that file realy
      is MPEG Audio. But, if we look for the next header which must be
      FrameLength bytes after first one, we may be very sure file is
      valid. }
      FrameInfo.FrameHeaderPos := MP3Stream.Position - 4;
      tempLongInt := MP3Stream.Size - FrameInfo.FrameHeaderPos
                     - FrameInfo.FrameLength + (2 * Byte(FrameInfo.ErrorProtection));

      if tempLongInt > 0 then
      begin
         MP3Stream.Seek(FrameInfo.FrameHeaderPos + FrameInfo.FrameLength, soFromBeginning);
         //BytesRead :=
         MP3Stream.Read(mp3hdrread, 4);
         tempbyte := mp3hdrread[1];
         mp3hdrread[1] := mp3hdrread[4];
         mp3hdrread[4] := tempbyte;
         tempbyte := mp3hdrread[2];
         mp3hdrread[2] := mp3hdrread[3];
         mp3hdrread[3] := tempbyte;

         if DecodeFrameHeader(mp3hdr, tmpFrameInfo) then
            break  { Next header is also valid. So, escape from repeat routine }
         else
            { well, next header is not valid.
              Set file position back to the second byt of header that
              seemed valid to let function read all bytes that were
              skipped in atempt to find second header }
            MP3Stream.Seek(FrameInfo.FrameHeaderPos + 1, soFromBeginning);
      end;
   until (MP3Stream.Position >= (MP3Stream.Size - MinFrameLength))
      or (MP3Stream.Position >= (StartPos + DetectionLimit));

   if FrameHeaderValid(tmpFrameInfo) then
   begin
      result := true;
   end else
      result := false;
end;


procedure GetMP3Info(FilePath : string; var ValidFile : boolean;
                             var MP3Info : TMP3Info);
var
   i, NumRead, NullPos : integer;
   MP3Stream : TFileStream;
begin
   ValidFile := false;
   MP3Info.FileLength := 0;
   MP3Info.FileDateTime := 0;
   MP3Info.ReadOnlyFile := false;
   MP3Info.FileName := '';
   MP3Info.HasTag := false;
   MP3Info.Title := '';
   MP3Info.Artist := '';
   MP3Info.Album := '';
   MP3Info.Year := '';
   MP3Info.Comment := '';
   MP3Info.Genre := 80;   { = Unknown  }

   try
      MP3Stream := TFileStream.Create(FilePath, fmOpenRead);
   except
      exit;
   end;

   ValidFile := FindFrameHeader(MP3Stream, 4096{DetectionLimit}, MP3Info.FrameInfo);
   MP3Stream.Free;

   if not ValidFile then
      exit;

   if FindFirst(FilePath, faReadOnly, SearchRec) <> 0 then
   begin
      SysUtils.FindClose(SearchRec);
      exit;
   end;

   SysUtils.FindClose(SearchRec);
   if SearchRec.Attr = faReadOnly then
      MP3Info.ReadOnlyFile := true;
   MP3Info.FileName := ExtractFileName(FilePath);

   AssignFile(f, FilePath);
   Reset(f, 1);
   MP3Info.FileLength := filesize(f);

   if MP3Info.FileLength < (MinFrameLength * 2) then
   begin
      CloseFile(f);
      exit;
   end;

   MP3Info.FileDateTime := FileAge(FilePath);

 { File Pointer to TAG Data Block }
   Seek(f, MP3Info.FileLength - 128);
   BlockRead(f, Buffer, SizeOf(Buffer), NumRead);
   CloseFile(f);
   if (Buffer[1] = 'T') and (Buffer[2] = 'A') and (Buffer[3] = 'G') then
   begin
      MP3Info.HasTag := true;

      for i := 1 to 30 do
      begin
         MP3Info.Title := MP3Info.Title + Buffer[3 + i];
         MP3Info.Artist := MP3Info.Artist + Buffer[33 + i];
         MP3Info.Album := MP3Info.Album + Buffer[63 + i];
         MP3Info.Comment := MP3Info.Comment + Buffer[97 + i];
      end;

    { Remove characters after Null code }
      NullPos := Pos(chr(0), MP3Info.Title);
      if NullPos > 0 then
         MP3Info.Title := copy(MP3Info.Title, 1, NullPos-1);
      NullPos := Pos(chr(0), MP3Info.Artist);
      if NullPos > 0 then
         MP3Info.Artist := copy(MP3Info.Artist, 1, NullPos-1);
      NullPos := Pos(chr(0), MP3Info.Album);
      if NullPos > 0 then
         MP3Info.Album := copy(MP3Info.Album, 1, NullPos-1);
      NullPos := Pos(chr(0), MP3Info.Comment);
      if NullPos > 0 then
         MP3Info.Comment := copy(MP3Info.Comment, 1, NullPos-1);

    { Remove trailing spaces }
      MP3Info.Title := Trim(MP3Info.Title);
      MP3Info.Artist := Trim(MP3Info.Artist);
      MP3Info.Album := Trim(MP3Info.Album);
      MP3Info.Comment := Trim(MP3Info.Comment);

      for i := 1 to 4 do
         MP3Info.Year := MP3Info.Year + Buffer[93 + i];

      MP3Info.Genre := ord(Buffer[128]);
   end else
      MP3Info.HasTag := false;

   if MP3Info.FrameInfo.BitRate = 0 then
      MP3Info.Duration := 0
   else
      if MP3Info.HasTag then
         MP3Info.Duration :=
            ((MP3Info.FileLength - MP3Info.FrameInfo.FrameHeaderPos - 128) * 8)
                      div MP3Info.FrameInfo.BitRate
      else
         MP3Info.Duration :=
            ((MP3Info.FileLength - MP3Info.FrameInfo.FrameHeaderPos) * 8)
                      div MP3Info.FrameInfo.BitRate;
end;

procedure SetMP3Tag(FilePath : string; MP3Info : TMP3Info; var Result : TMP3Result);
var
   i, NumRead, NumWritten : integer;
   ValidFile, FileHasTag : boolean;
   OneChar : string[1];
   MP3Stream : TFileStream;
begin
   try
      MP3Stream := TFileStream.Create(FilePath, fmOpenRead);
   except
      exit;
   end;

   ValidFile := FindFrameHeader(MP3Stream, 4096{DetectionLimit}, MP3Info.FrameInfo);
   MP3Stream.Free;

   if not ValidFile then
      exit;

   if FindFirst(FilePath, faReadOnly, SearchRec) <> 0 then
   begin
      Result := NoFile;
      SysUtils.FindClose(SearchRec);
      exit;
   end;
   SysUtils.FindClose(SearchRec);
   if SearchRec.Attr = faReadOnly then
   begin
      Result := WriteInhibited;
      exit;
   end;

   AssignFile(f, FilePath);
   Reset(f, 1);
   MP3Info.FileLength := filesize(f);
   if MP3Info.FileLength <= (MinFrameLength * 2) then
   begin
      Result := NoValidFile;
      CloseFile(f);
      exit;
   end;
   MP3Info.FileDateTime := FileAge(FilePath);

   Seek(f, MP3Info.FileLength - 128);
   BlockRead(f, Buffer, SizeOf(Buffer), NumRead);

   if (Buffer[1] = 'T') and (Buffer[2] = 'A') and (Buffer[3] = 'G') then
      FileHasTag := true
   else
      FileHasTag := false;
   if not FileHasTag then
   begin
      Buffer[1] := 'T';
      Buffer[2] := 'A';
      Buffer[3] := 'G';
      Seek(f, MP3Info.FileLength);
   end else
      Seek(f, MP3Info.FileLength - 128);

   if Length(MP3Info.Title) > 30 then
      MP3Info.Title := copy(MP3Info.Title, 1, 30);
   for i := 1 to Length(MP3Info.Title) do
   begin
      OneChar := copy(MP3Info.Title, i, 1);
      Buffer[3 + i] := OneChar[1];
   end;
   if Length(MP3Info.Title) < 30 then
      for i := (4 + Length(MP3Info.Title)) to 33 do
          Buffer[i] := ' ';

   if Length(MP3Info.Artist) > 30 then
      MP3Info.Artist := copy(MP3Info.Artist, 1, 30);
   for i := 1 to Length(MP3Info.Artist) do
   begin
      OneChar := copy(MP3Info.Artist, i, 1);
      Buffer[33 + i] := OneChar[1];
   end;
   if Length(MP3Info.Artist) < 30 then
      for i := (34 + Length(MP3Info.Artist)) to 63 do
         Buffer[i] := ' ';

   if Length(MP3Info.Album) > 30 then
      MP3Info.Album := copy(MP3Info.Album, 1, 30);
   for i := 1 to Length(MP3Info.Album) do
   begin
      OneChar := copy(MP3Info.Album, i, 1);
      Buffer[63 + i] := OneChar[1];
   end;
   if Length(MP3Info.Album) < 30 then
      for i := (64 + Length(MP3Info.Album)) to 93 do
         Buffer[i] := ' ';

   if Length(MP3Info.Year) > 4 then
      MP3Info.Year := copy(MP3Info.Year, 1, 4);
   for i := 1 to Length(MP3Info.Year) do
   begin
      OneChar := copy(MP3Info.Year, i, 1);
      Buffer[93 + i] := OneChar[1];
   end;
   if Length(MP3Info.Year) < 4 then
      for i := (94 + Length(MP3Info.Year)) to 97 do
         Buffer[i] := ' ';

   if Length(MP3Info.Comment) > 30 then
      MP3Info.Comment := copy(MP3Info.Comment, 1, 30);
   for i := 1 to Length(MP3Info.Comment) do
   begin
      OneChar := copy(MP3Info.Comment, i, 1);
      Buffer[97 + i] := OneChar[1];
   end;
   if Length(MP3Info.Comment) < 30 then
      for i := (98 + Length(MP3Info.Comment)) to 127 do
         Buffer[i] := ' ';

   Buffer[128] := chr(MP3Info.Genre);

   BlockWrite(f, Buffer, SizeOf(Buffer), NumWritten);
   CloseFile(f);
   Result := NoError;
end;

function GetGenreName(Genre : byte) : string;
begin
   if Genre > (GenreTypes-1) then
      Result := 'Invalid Genre Number'
   else
      Result := GenreNames[Genre];
end;


end.
