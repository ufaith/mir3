(*******************************************************************
 *   LomCN Mir3 mpeg core File 2012                                *
 *                                                                 *
 *   Web       : http://www.lomcn.co.uk                            *
 *   Version   : 0.0.0.1                                           *
 *                                                                 *
 *   - File Info -                                                 *
 *                                                                 *
 *   This file holds all mir3 sound core systems                   *
 *   - ogg layer things                                            *
 *   - mpeg layer things                                           *
 *   - wav layer things over HGE                                   *
 *                                                                 *
 *                                                                 *
 *                                                                 *
 *******************************************************************
 * Change History                                                  *
 *                                                                 *
 *  - 0.0.0.1 [2012-03-11] Coly : fist final clean up              *
 *                                                                 *
 *                                                                 *
 *                                                                 *
 *                                                                 *
 *                                                                 *
 *******************************************************************
 *  - TODO List for this *.pas file -                              *
 *-----------------------------------------------------------------*
 *  if a todo finished, then delete it here...                     *
 *  if you find a global TODO thats need to do, then add it here.. *
 *-----------------------------------------------------------------*
 *                                                                 *
 *  - TODO : -all -fill *.pas header information                   *
 *                 (how to need this file etc.)                    *
 *                                                                 *
 *******************************************************************)

unit mir3_game_sound;

interface

uses
  Windows, Messages, ActiveX, Controls, Classes, SysUtils, StdCtrls,
  mir3_game_engine, mir3_global_config, DShow, OggVorbis, MP3Util,
  MpgLib, VorbisDll, AudioOut, Sleeper;

{$WARNINGS OFF} 

 { Ogg Vorbis Const }
const
   MP3HeaderLength      = 4;              // The length of MP3 file's header
   SamplesPerFrame      = 1152;           // Samples per frame for Layer II & Layer III
   BytesPerSample       = 4;              // Bytes per sample for stereo output
   FramesPerAudioBuffer = 2;              // Buffer size in frame for wave-out
   WM_BitRateChange     = WM_USER + 104;  // message for bit rate change
   WM_PosChange         = WM_USER + 105;  // message for playing position change

  { Mir3 Sound Consts }
const
  SOUND_LIST_NAME               = 'SoundList.wwl';

 (****************************************************
  *        Foot steps Sounds Consts                  *
  ****************************************************)
  SOUND_WALK_GROUND_LEFT        = 1;
  SOUND_WALK_GROUND_RIGHT       = 2;
  SOUND_RUN_GROUND_LEFT         = 3;
  SOUND_RUN_GROUND_RIGHT        = 4;
  SOUND_WALK_STONE_LEFT         = 5;
  SOUND_WALK_STONE_RIGHT        = 6;
  SOUND_RUN_STONE_LEFT          = 7;
  SOUND_RUN_STONE_RIGHT         = 8;
  SOUND_WALK_LAWN_LEFT          = 9;
  SOUND_WALK_LAWN_RIGHT         = 10;
  SOUND_RUN_LAWN_LEFT           = 11;
  SOUND_RUN_LAWN_RIGHT          = 12;
  SOUND_WALK_ROUGH_LEFT         = 13;
  SOUND_WALK_ROUGH_RIGHT        = 14;
  SOUND_RUN_ROUGH_LEFT          = 15;
  SOUND_RUN_ROUGH_RIGHT         = 16;
  SOUND_WALK_WOOD_LEFT          = 17;
  SOUND_WALK_WOOD_RIGHT         = 18;
  SOUND_RUN_WOOD_LEFT           = 19;
  SOUND_RUN_WOOD_RIGHT          = 20;
  SOUND_WALK_CAVE_LEFT          = 21;
  SOUND_WALK_CAVE_RIGHT         = 22;
  SOUND_RUN_CAVE_LEFT           = 23;
  SOUND_RUN_CAVE_RIGHT          = 24;
  SOUND_WALK_ROOM_LEFT          = 25;
  SOUND_WALK_ROOM_RIGHT         = 26;
  SOUND_RUN_ROOM_LEFT           = 27;
  SOUND_RUN_ROOM_RIGHT          = 28;
  SOUND_WALK_WATER_LEFT         = 29;
  SOUND_WALK_WATER_RIGHT        = 30;
  SOUND_RUN_WATER_LEFT          = 31;
  SOUND_RUN_WATER_RIGHT         = 32;

 (****************************************************
  *        Hitting Sounds Consts                     *
  ****************************************************)
  SOUND_HIT_SHORT               = 50;
  SOUND_HIT_WOODEN              = 51;
  SOUND_HIT_SWORD               = 52;
  SOUND_HIT_DO                  = 53;
  SOUND_HIT_AXE                 = 54;
  SOUND_HIT_CLUB                = 55;
  SOUND_HIT_LONG                = 56;
  SOUND_HIT_FIST                = 57;

 (****************************************************
  *        Struck Sounds Consts                      *
  ****************************************************)
  SOUND_STRUCK_SHORT            = 60;
  SOUND_STRUCK_WOODEN           = 61;
  SOUND_STRUCK_SWORD            = 62;
  SOUND_STRUCK_DO               = 63;
  SOUND_STRUCK_AXE              = 64;
  SOUND_STRUCK_CLUB             = 65;

 (****************************************************
  *        Struck Body Sounds Consts                 *
  ****************************************************)
  SOUND_STRUCK_BODY_SWORD       = 70;
  SOUND_STRUCK_BODY_AXE         = 71;
  SOUND_STRUCK_BODY_LONGSTICK   = 72;
  SOUND_STRUCK_BODY_FIST        = 73;

 (****************************************************
  *        Struck Armor Sounds Consts                *
  ****************************************************)
  SOUND_STRUCK_ARMOR_SWORD      = 80;
  SOUND_STRUCK_ARMOR_AXE        = 81;
  SOUND_STRUCK_ARMOR_LONGSTICK  = 82;
  SOUND_STRUCK_ARMOR_FIST       = 83;

  (****************************************************
  *        Stone Sounds Consts                        *
  ****************************************************)
  SOUND_STRIKE_STONE            = 91;
  SOUND_DROP_STONE_PIECE        = 92;

  (****************************************************
  *        Other Sounds Consts                        *
  ****************************************************)
  SOUND_ROCK_DOOR_OPEN          = 100;
  SOUND_INTRO_THEME             = 102;
  SOUND_MELT_STONE              = 101;
  SOUND_MAIN_THEME              = 102;
  SOUND_NORMAL_BUTTON_CLICK     = 103;
  SOUND_ROCK_BUTTON_CLICK       = 104;
  SOUND_GLASS_BUTTON_CLICK      = 105;
  SOUND_MONEY                   = 106;
  SOUND_EAT_DRUG                = 107;
  SOUND_CLICK_DRUG              = 108;
  SOUND_SPACEMOVE_OUT           = 109;
  SOUND_SPACEMOVE_IN            = 110;

  (****************************************************
  *        Click Sounds Consts                        *
  ****************************************************)
  SOUND_CLICK_WEAPON            = 111;
  SOUND_CLICK_ARMOR             = 112;
  SOUND_CLICK_RING              = 113;
  SOUND_CLICK_ARM_RING          = 114;
  SOUND_CLICK_NECKLACE          = 115;
  SOUND_CLICK_HELMET            = 116;
  SOUND_CLICK_GROBES            = 117;
  SOUND_CLICK_ITEM              = 118;

  (****************************************************
  *        Other Sounds Consts                        *
  ****************************************************)
  SOUND_YEDO_MAN                = 130;
  SOUND_YEDO_WOMAN              = 131;
  SOUND_LONG_HIT                = 132;
  SOUND_WIDE_HIT                = 133;
  SOUND_RUSH_LEFT               = 134;
  SOUND_RUSH_RIGHT              = 135;
  SOUND_FIRE_HIT_READY          = 136;
  SOUND_FIRE_HIT                = 137;

  (****************************************************
  *        Other Sounds Consts                        *
  ****************************************************)
  SOUND_MAN_STRUCK              = 138;
  SOUND_WOMAN_STRUCK            = 139;
  SOUND_34_HIT                  = 140;
  SOUND_35_HIT                  = 141;
  SOUND_103_HIT                 = 11030;
  SOUND_MAN_DIE                 = 144;
  SOUND_WOMAN_DIE               = 145;
  


var
  g_SoundVolume     : integer = 5000;
  g_BGVolume        : integer = 100;
  g_SoundPan        : integer = 0;
  g_BGmus           : IEffect;
  g_BGChannel       : IChannel;
  g_Soundmus        : IEffect;
  g_SoundChannel    : IChannel;

type
  TFileType                 = (ftWav, ftOgg, ftMP3);
  TStreamType               = (stUnknown, stMP3, stOGG);
  TPlayerMode               = (plmUnknown, plmClosed, plmReady, plmStopped, plmPlaying, plmPaused);
  TNotifyEvent              = procedure(Sender: TObject) of object;
  TNotifyPosChangeEvent     = procedure(Sender: TObject; NewPos : DWORD) of object;
  TNotifyBitRateChangeEvent = procedure(Sender: TObject; BitRate : LongInt) of object;

  TStreamInfo = record
     FileName    : string;
     FileSize    : DWORD;
     StreamType  : TStreamType;
     SampleRate  : LongInt;      { Sampling rate in Hz }
     BitRate     : LongInt;      { Bit Rate in BPS }
     Duration    : DWORD;        { Song duration in mili second }
     Channels    : Word;         { 1- Mono, 2 - Stereo }
     Title       : string;
     Artist      : string;
     Album       : string;
     Genre       : string;
  end;

  { Mir3 Ogg Player Lib }
  TOggPlayer = class(TObject)
  private
    { Private declarations }
    MP3Stream        : TFileStream;
    MP3StreamInfo    : TMP3Info;
    MP3StartPos      : longint;
    MP3EndPos        : longint;
    InBuffer         : PBYTE;
    OutBufferSize    : Integer;
    OutBuffer        : array[0..FramesPerAudioBuffer-1] of PByte;
    BufferFilled     : array[0..FramesPerAudioBuffer-1] of word;
    hStream          : H_STREAM;
    PlayerThread     : hwnd;
    ReadCount        : Integer;
    StreamOpened     : Boolean;
    DecodeErrEnd     : Boolean;
    CurrPos          : DWORD;
    CurrBitRate      : LongInt;
    ReposSkipCounter : word;
    vbDecInfo        : TVB_DEC_INFO;
    pAlbumInfo       : ^TVB_ALBUM_INFO;
    Vorbis           : TOggVorbis;
    Sleeper1         : TSleeper;
    AudioOut1        : TAudioOut;
    MessageHandle    : hwnd;
    FMP3PlayReady    : boolean;
    FOGGPlayReady    : boolean;
    FMP3DLLLoaded    : boolean;
    FVorbisDLLLoaded : boolean;
    FDLLVersionStr   : string;
    FStreamName      : string;
    FStreamType      : TStreamType;
    FStreamInfo      : TStreamInfo;
    FPlayerMode      : TPlayerMode;
    FPriority        : integer;
    FOnPosChange     : TNotifyPosChangeEvent;
    FOnPlayEnd       : TNotifyEvent;
    FOnNewFFTData    : TNotifyNewFFTDataEvent;
    FOnBitRateChange : TNotifyBitRateChangeEvent;
    function  Init : boolean;
    procedure GetDLLVersionStr;
    function  GetBuffers(BufferSize : word) : boolean;
    procedure FreeBuffers;
    function  GetPriority : TThreadPriority;
    procedure SetPriority(ThreadPriority : TThreadPriority);
    procedure PreparePlay;
    procedure PausePlay;
    procedure ResumePlay;
    //procedure NewFFTData(Sender: TObject; BandOut : TBandOut; var PostFlag : boolean); virtual;
    procedure ProcMessage(var Msg: TMessage);
    procedure AudioOut1Stop(Sender: TObject);
    function  AudioOut1BufferPlayed(Buffer: PChar; var Size: Word): Boolean;
    function  CurrentPosition : DWORD;
    procedure SetPosition(Value : DWORD);
  public
    { Public declarations }
    constructor Create;
    destructor  Destroy; override;
    function  GetStreamInfo(StreamName : string; var StreamInfo : TStreamInfo) : boolean;
    function  Open(StreamName : string) : boolean;
    function  PlayLength : DWORD;
    procedure Play;
    procedure Stop;
    procedure Pause(pAction : boolean);
    procedure Restart;
    procedure Close;
    property  MP3DLLLoaded : boolean read FMP3DLLLoaded;
    property  VorbisDLLLoaded : boolean read FVorbisDLLLoaded;
    property  DLLVersionStr : string read FDLLVersionStr;
    property  MP3PlayReady : boolean read FMP3PlayReady;
    property  OGGPlayReady : boolean read FOGGPlayReady;
    property  StreamInfo : TStreamInfo read FStreamInfo;
    property  Mode : TPlayerMode read FPlayerMode;
    property  Position : DWORD read CurrentPosition write SetPosition;
    property  StreamName : string read FStreamName;
  published
    { Published declarations }
    property  Priority : TThreadPriority read GetPriority write SetPriority;
    property  OnPosChange : TNotifyPosChangeEvent read FOnPosChange write FOnPosChange;
    property  OnPlayEnd : TNotifyEvent read FOnPlayEnd write FOnPlayEnd;
    property  OnNewFFTData : TNotifyNewFFTDataEvent read FOnNewFFTData write FOnNewFFTData;
    property  OnBitRateChange : TNotifyBitRateChangeEvent read FOnBitRateChange write FOnBitRateChange;
  end;

  { Mir3 MPEG Lib }
  TMPEG = Class
  private
    FGraphBuilder : IGraphBuilder;
    FMediaControl : IMediaControl;
    FMediaSeeking : IMediaSeeking;
    FAudioControl : IBasicAudio;
    FVideoWindow  : IVideoWindow;
    FInit         : Boolean;
    FPlay         : Boolean;
    //FFileName     : String;
    FMovieWindow  : TWinControl;
    procedure Close();
  public
    constructor Create(PlayWindow: TWinControl);
    destructor Destroy; Override;
    function Init(): Boolean;
    function Play(FFileName: String): Boolean;
    procedure Pause();
    procedure Stop();
  end;

  TSoundListHeader = packed record
    First : Array [0..49] of char;
    Count : Word;
    Third : Array [0..7] of char;
  end;

  TSoundBody       = packed record
    FileName : Array [0..15] of char;
  end;

  TMir3_Sound_Engine = class
  private
    //FDXSound           : TDXSound;
    //FInternalWav       : TSoundEngine;
    FInternalOgg       : TOggPlayer;
    FInternalMp3       : TMPEG;
    FInternalSoundList : TStringList;
  private
    procedure LoadSoundListFile;
  public
    constructor Create;
    destructor Destroy; override;
    procedure PlaySoundClick(AStdItem: TStdItem);
    procedure PlaySoundItem(AStdMode: Integer);
    procedure PlaySound(AType: TFileType; AIndex: Integer = -1);   overload;
    procedure PlaySound(AType: TFileType; AFileName: String = ''); overload;
    procedure PlaySoundLoop(AFileName: String);
    procedure PlayBackgroundMusic(AFileName: String);
    procedure StopBackgroundMusic;
    procedure StopWavFile;
    procedure StopOggFile;
  end;


//  function GMir3GameSoundEngine: TMir3_Sound_Engine;
//  procedure GMir3GameSoundEngineFree;

Implementation

uses mir3_game_backend;

{$REGION ' - TOggPlayer '}
  
  procedure winProcessMessages;
  var
    ProcMsg  :  TMsg;
  begin
    while PeekMessage(ProcMsg, 0, 0, 0, PM_REMOVE) do
    begin
      if (ProcMsg.Message = WM_QUIT) then Exit;
      TranslateMessage(ProcMsg);
      DispatchMessage(ProcMsg);
    end; { while }
  end;
  
  constructor TOggPlayer.Create;
  begin
     inherited Create;
     FPriority        := THREAD_PRIORITY_HIGHEST;
     FMP3PlayReady    := false;
     FOGGPlayReady    := false;
     FMP3DLLLoaded    := false;
     FVorbisDLLLoaded := false;
     FStreamName      := '';
     StreamOpened     := false;
     OutBufferSize    := 0;
     FPlayerMode      := plmUnknown;
     MessageHandle    := AllocateHWnd(ProcMessage);
     Vorbis           := TOggVorbis.Create;
     Init;
  end;
  
  destructor  TOggPlayer.Destroy;
  begin
    if (FPlayerMode = plmPlaying) then
      Stop;

    if MP3Stream <> nil then
      MP3Stream.Free;

    if StreamOpened then
      case FStreamType of
        stMP3 : MpgLib_CloseStream(hStream);
        stOGG : vbDecClose(@vbDecInfo);
      end;

    if MessageHandle <> 0 then
       DeallocateHWnd(MessageHandle);
    FreeBuffers;
    if AudioOut1 <> nil then
       AudioOut1.Free;
    if Sleeper1 <> nil then
       Sleeper1.Free;

    Vorbis.Free;

    inherited Destroy;
  end;
  
  function TOggPlayer.GetBuffers(BufferSize : word) : boolean;
  var
    i : integer;
    InBufferSize : integer;
  begin
    try
       for i := 0 to (FramesPerAudioBuffer - 1) do
         GetMem(OutBuffer[i], BufferSize);
       OutBufferSize := BufferSize;
       InBufferSize  := OutBufferSize div 2;   // Assume minimum compression ratio is 2.
       GetMem(InBuffer, InBufferSize);
       result := true;
    except
       result := false;
    end;
  end;
  
  procedure TOggPlayer.FreeBuffers;
  var
    i : integer;
  begin
    if InBuffer <> nil then
       FreeMem(InBuffer);
    for i := 0 to (FramesPerAudioBuffer - 1) do
      if OutBuffer[i] <> nil then
        FreeMem(OutBuffer[i]);
  end;
  
  // Get the length of play time in milli seconds
  function TOggPlayer.PlayLength : DWORD;
  begin
     if StreamOpened then
        result := FStreamInfo.Duration
     else
        result := 0;
  end;
  
  // Get the playing position in milli seconds
  function TOggPlayer.CurrentPosition : DWORD;
  begin
    if not StreamOpened then
    begin
      result := 0;
      exit;
    end;

    case FStreamType of
      stMP3 : result :=
         ((MP3Stream.Position - MP3StreamInfo.FrameInfo.FrameHeaderPos) * 8)
                      div (FStreamInfo.BitRate div 1000);
      stOGG : result := vbDecInfo.dwCurTime_in_ms;
    else
      result := 0;
    end;
  end;
  
  function TOggPlayer.GetPriority : TThreadPriority;
  begin
    Result := tpIdle;
    case FPriority of
      THREAD_PRIORITY_ABOVE_NORMAL  : Result := tpHigher;
      THREAD_PRIORITY_BELOW_NORMAL  : Result := tpLower;
      THREAD_PRIORITY_HIGHEST       : Result := tpHighest;
      THREAD_PRIORITY_IDLE          : Result := tpIdle;
      THREAD_PRIORITY_LOWEST        : Result := tpLowest;
      THREAD_PRIORITY_NORMAL        : Result := tpNormal;
      THREAD_PRIORITY_TIME_CRITICAL : Result := tpTimeCritical;
    end;
  end;

  procedure TOggPlayer.SetPriority(ThreadPriority : TThreadPriority);
  begin
    case ThreadPriority of
      tpHigher       : FPriority := THREAD_PRIORITY_ABOVE_NORMAL;
      tpLower        : FPriority := THREAD_PRIORITY_BELOW_NORMAL;
      tpHighest      : FPriority := THREAD_PRIORITY_HIGHEST;
      tpIdle         : FPriority := THREAD_PRIORITY_IDLE;
      tpLowest       : FPriority := THREAD_PRIORITY_LOWEST;
      tpNormal       : FPriority := THREAD_PRIORITY_NORMAL;
      tpTimeCritical : FPriority := THREAD_PRIORITY_TIME_CRITICAL;
    end;
  end;
  
  // Get the version information as string
  procedure TOggPlayer.GetDLLVersionStr;
  const
    VerStrSize = 14;   // String size for MP3 decoder DLL Version representation
  var
     MpgVerPStr : array[0..VerStrSize-1] of Char;
  begin
    if FMP3DLLLoaded then
    begin
      MpgLib_Version(MpgVerPStr, VerStrSize);
      FDLLVersionStr := 'MpgLib.dll : ' + string(MpgVerPStr);
    end else FDLLVersionStr := 'MpgLib.dll : N.A.';

    if FVorbisDLLLoaded then
      FDLLVersionStr := FDLLVersionStr + ', Vorbis.dll : ' + VorbisDLLVersionStr
    else FDLLVersionStr := FDLLVersionStr + ', Vorbis.dll : N.A.';
  end;
  
  function TOggPlayer.Init : boolean;
  var
    GotError : boolean;
  begin
    if FMP3PlayReady or FOGGPlayReady then
    begin
       result := true;
       exit;
    end;

    if MpgLib.RequestDLLLoading then
      FMP3DLLLoaded := true
    else FMP3DLLLoaded := false;

    if VorbisDll.RequestDLLLoading then
      FVorbisDLLLoaded := true
    else FVorbisDLLLoaded := false;

    result := false;  // assume any error
    if (not FMP3DLLLoaded) and (not FVorbisDLLLoaded) then
       exit;

    GotError := false;

    try
      AudioOut1                      := TAudioOut.Create(nil);
      AudioOut1.Player.BitsPerSample := _16;
      AudioOut1.Player.NoSamples     := SamplesPerFrame * FramesPerAudioBuffer;
      AudioOut1.OnBufferPlayed       := AudioOut1BufferPlayed;
      AudioOut1.OnPlayed             := AudioOut1Stop;
      Sleeper1                       := TSleeper.Create(nil);
      Sleeper1.Interval              := 1000;

      if not GetBuffers(SamplesPerFrame * BytesPerSample) then
        GotError := true;
    except
      GotError := true;
    end;

    if GotError or (not AudioOut1.ReadyToGo) then
    begin
      result := false;
    end else begin
      result := true;
      if FMP3DLLLoaded then
         FMP3PlayReady := true;   // Ready to play mp3 file
      if FVorbisDLLLoaded then
         FOGGPlayReady := true;   // Ready to play Ogg Vorbis file
      FPlayerMode := plmClosed;
    end;

    GetDLLVersionStr;
    PlayerThread := GetCurrentThread;
  end;

  // Get the information on a stream file
  function TOggPlayer.GetStreamInfo(StreamName : string; var StreamInfo : TStreamInfo) : boolean;
  var
     ExtCode : string;
     MP3Info : TMP3Info;
     ValidMP3File : boolean;
  begin
     ExtCode := UpperCase(ExtractFileExt(StreamName));
  
     StreamInfo.StreamType := stUnknown;
     result := false;
  
     if ExtCode = '.MP3' then
     begin
       GetMP3Info(StreamName, ValidMP3File, MP3Info);
       if ValidMP3File and (MP3Info.FrameInfo.Layer = Layer_3) then
       begin
         with StreamInfo do
         begin
           FileName := MP3Info.FileName;
           FileSize := MP3Info.FileLength;
           StreamType := stMP3;
           SampleRate := MP3Info.FrameInfo.SampleRate;
           BitRate := MP3Info.FrameInfo.BitRate * 1000;
           Duration := MP3Info.Duration;
           Title := MP3Info.Title;
           Artist := MP3Info.Artist;
           Album := MP3Info.Album;
           Genre := GetGenreName(MP3Info.Genre);
           if MP3Info.FrameInfo.Mode = Mode_Mono then
             Channels := 1
           else Channels := 2;
         end;
         result := true;
       end;
     end else if ExtCode = '.OGG' then
              begin
                Vorbis.ReadFromFile(StreamName);
                if Vorbis.Valid then
                begin
                  with StreamInfo do
                  begin
                    FileName := StreamName;
                    FileSize := Vorbis.FileSize;
                    StreamType := stOGG;
                    SampleRate := Vorbis.SampleRate;
                    BitRate := Vorbis.BitRate;
                    Duration := round(Vorbis.Duration * 1000);
                    Title := Vorbis.Title;
                    Artist := Vorbis.Artist;
                    Album := Vorbis.Album;
                    Genre := Vorbis.Genre;
                    Channels := Vorbis.ChannelModeID;
                  end;
                  result := true;
                end;
              end;
  end;
  
  // Open a MP3 or a Ogg Vorbis file and set parameters to play it.
  function TOggPlayer.Open(StreamName : string) : boolean;
  var
     ValidFile : boolean;
     ExtCode : string;
     ReqBufferSize : word;
     PStream : array[0..255] of Char;
  
    function OpenMP3Stream : boolean;
    begin
      result := false;

      GetMP3Info(StreamName, ValidFile, MP3StreamInfo);
      if not ValidFile then  exit;

      if MP3Stream <> nil then
      begin
        MP3Stream.Free;
        MP3Stream := nil;
      end;

      try
        MP3Stream := TFileStream.Create(StreamName, fmOpenRead);
      except
        exit;
      end;

      if MpgLib_OpenStream(hStream) = MPGLIB_ERROR{= MPGLIB_OK} then  exit;

      with FStreamInfo do
      begin
        FileName   := MP3StreamInfo.FileName;
        FileSize   := MP3StreamInfo.FileLength;
        SampleRate := MP3StreamInfo.FrameInfo.SampleRate;
        BitRate    := MP3StreamInfo.FrameInfo.BitRate * 1000;
        Duration   := MP3StreamInfo.Duration;
        Title      := MP3StreamInfo.Title;
        Artist     := MP3StreamInfo.Artist;
        Album      := MP3StreamInfo.Album;
        Genre      := GetGenreName(MP3StreamInfo.Genre);
      end;

      if MP3StreamInfo.FrameInfo.Mode = Mode_Mono then
        FStreamInfo.Channels := 1
      else FStreamInfo.Channels := 2;

      MP3StartPos := MP3StreamInfo.FrameInfo.FrameHeaderPos;
      if MP3StreamInfo.HasTag then
        MP3EndPos := MP3Stream.Size - 128
      else MP3EndPos := MP3Stream.Size;

      ReadCount := MP3StreamInfo.FrameInfo.FrameLength + MP3HeaderLength;

      result := true;
    end;

    function OpenOGGStream : boolean;
    begin
      result := false;

      vbDecInfo.dwStructVersion := VB_DEC_STRUCT_VERSION;
      vbDecInfo.dwStructSize    := sizeof(vbDecInfo);
      StrPCopy(PStream, StreamName);

      if vbDecOpen(@vbDecInfo, @pAlbumInfo, PStream) = VB_ERR_OK then
      begin
        with FStreamInfo do
        begin
          FileName   := StreamName;
          Channels   := vbDecInfo.dwChannels;
          SampleRate := vbDecInfo.dwSampleRate;
          Duration   := vbDecInfo.dwTotTime_in_ms;
          BitRate    := vbDecInfo.nBitRate;  // Average bitrate
          Title      := strPas(pAlbumInfo^.infoRecord.strTitle);
          Artist     := strPas(pAlbumInfo^.infoRecord.strArtist);
          Album      := strPas(pAlbumInfo^.infoRecord.strAlbum);
          Vorbis.ReadFromFile(StreamName);
          FileSize   := Vorbis.FileSize;
          Genre      := Vorbis.Genre;
        end;
      end else exit;
      result := true;
    end;

  begin
    result := false;

    if (not FMP3PlayReady) and (not FOGGPlayReady) then
       exit;

    if StreamOpened then
       exit;

    ExtCode := UpperCase(ExtractFileExt(StreamName));
    if ExtCode = '.MP3' then
    begin
      if (not FMP3PlayReady) then
        exit
      else if OpenMP3Stream then
           begin
             ReqBufferSize := SamplesPerFrame * BytesPerSample;
             FStreamType := stMP3;
           end else exit;   // invalid MP3 file
    end else if ExtCode = '.WES' then
             begin
               if (not FOGGPlayReady) then
                  exit
               else if OpenOGGStream then
               begin
                 ReqBufferSize := vbDecInfo.dwBufferSize;
                 FStreamType := stOGG;
               end  else exit;   // invalid Ogg Vorbis file
             end else exit;

    StreamOpened := true;
    CurrBitRate  := FStreamInfo.BitRate;
    if FStreamInfo.Channels = 1 then
      AudioOut1.Player.Channels := Mono
    else AudioOut1.Player.Channels := Stereo;
    AudioOut1.Player.SampleRate := FStreamInfo.SampleRate;;
    //  AudioOut1.Player.NoSamples := SamplesPerFrame * FramesPerAudioBuffer;
    FStreamName := StreamName;

    if ReqBufferSize > OutBufferSize then
    begin
      FreeBuffers;
      if GetBuffers(ReqBufferSize) then
        FPlayerMode := plmReady;
    end else FPlayerMode := plmReady;

    if FPlayerMode = plmReady then
    begin
      if Assigned(FOnPosChange) then
      begin
        CurrPos := 0;
        FOnPosChange(Self, 0);
      end;
      result := true;
    end;
  end;

  procedure TOggPlayer.PreparePlay;
  begin
   { if not StreamOpened then
       exit; }
    if (FPlayerMode = plmStopped) or (FPlayerMode = plmReady) then
      case FStreamType of
        stMP3 : begin
                  ReposSkipCounter := 0;
                  MP3Stream.Seek(MP3StartPos, soFromBeginning);
                end;
        stOGG : begin
                  vbDecSeek(@vbDecInfo, 0);
                  DecodeErrEnd := false;
                end;
      end;
  end;
  
  procedure TOggPlayer.Play;
  begin
    if not StreamOpened then
      exit;

    if FPlayerMode = plmPlaying then
      exit;
    // Add following statement if you do not want to allow using 'Play' instead of
    // 'ResumePlay' or 'Restart' while TOggPlayer is in the state of plmPaused or
    // plmStopped
    { if FPlayerMode <> plmReady then
        exit; }
  
    PreparePlay;
    if AudioOut1.Player.Start then
    begin
      FPlayerMode := plmPlaying;
      SetThreadPriority(PlayerThread, FPriority);
     //  SetPriorityClass(GetCurrentProcess, HIGH_PRIORITY_CLASS);
    end else AudioOut1Stop(Self);
  end;

  procedure TOggPlayer.Stop;
  begin
    if (FPlayerMode <> plmPaused) and (FPlayerMode <> plmPlaying) then
      exit;

    if FPlayerMode = plmPlaying then
    begin
      AudioOut1.Player.StopGracefully;
      repeat
        winProcessMessages;
      until AudioOut1.Player.QueuedBuffers = 0;
    end else FPlayerMode := plmStopped;

    Sleeper1.SleepFor(100); // Consider delay time until closing wave-out device
  end;
  
  procedure TOggPlayer.PausePlay;
  begin
    if (FPlayerMode <> plmPlaying) then
      exit;

    AudioOut1.Player.StopGracefully;

    repeat
      winProcessMessages;
    until AudioOut1.Player.QueuedBuffers = 0;

    Sleeper1.SleepFor(100); // Consider delay time until closing wave-out device
    FPlayerMode := plmPaused;
  end;
  
  procedure TOggPlayer.ResumePlay;
  begin
    if (FPlayerMode <> plmPaused) then
      exit;

    case FStreamType of
      stMP3 : if MP3Stream.Position >= MP3EndPos then
              begin
                AudioOut1Stop(Self);
                exit;
              end;
      stOGG : if vbDecInfo.dwCurTime_in_ms >= vbDecInfo.dwTotTime_in_ms then
              begin
                AudioOut1Stop(Self);
                exit;
              end;
    end;

    if AudioOut1.Player.Start then
    begin
      FPlayerMode := plmPlaying;
      SetThreadPriority(PlayerThread, FPriority);
     //  SetPriorityClass(GetCurrentProcess, HIGH_PRIORITY_CLASS);
    end else AudioOut1Stop(Self);
  end;
  
  procedure TOggPlayer.Pause(pAction : boolean);
  begin
    if pAction then
      PausePlay
    else ResumePlay;
  end;
  
  procedure TOggPlayer.Restart;
  begin
    if (FPlayerMode <> plmStopped) then
      exit;

    PreparePlay;

    if AudioOut1.Player.Start then
    begin
      FPlayerMode := plmPlaying;
      SetThreadPriority(PlayerThread, FPriority);
     //  SetPriorityClass(GetCurrentProcess, HIGH_PRIORITY_CLASS);
    end else AudioOut1Stop(Self);
  end;
  
  // Stop playing and release opened stream file.
  procedure TOggPlayer.Close;
  begin
    if not StreamOpened then
      exit;

    if (FPlayerMode = plmPlaying) then
      Stop;

    if MP3Stream <> nil then
    begin
      MP3Stream.Free;
      MP3Stream := nil;
    end;

    case FStreamType of
      stMP3 : MpgLib_CloseStream(hStream);
      stOGG : vbDecClose(@vbDecInfo);
    end;

    FStreamName  := '';
    FPlayerMode  := plmClosed;
    FStreamType  := stUnknown;
    StreamOpened := false;
  end;
  
  // Procedure to change playing position
  procedure TOggPlayer.SetPosition(Value : DWORD);  // Value in milli seconds
  var
    tmpPaused : boolean;
    SeekPos   : DWORD;
    FrameInfo : TFrameInfo;
  begin
    if not StreamOpened then
      exit;
  // Add following statement if you do not want to allow changing position while
  // TOggPlayer is not in the state of plmPlaying or plmPaused
    { if (FPlayerMode <> plmPlaying) and (FPlayerMode <> plmPaused) then
        exit; }

    if Value > FStreamInfo.Duration then
      exit;

    if (FPlayerMode = plmPlaying) then
    begin
      Pause(true);
      tmpPaused := true;
     // Set skip counter to avoid click noise at resuming playing
      if FStreamType = stMP3 then
        ReposSkipCounter := 6;
    end else
       tmpPaused := false;

    case FStreamType of
      stMP3 : begin
                SeekPos := (Value * ((FStreamInfo.BitRate div 1000) div 8));
                MP3Stream.Seek(SeekPos + MP3StartPos, soFromBeginning);
                if FindFrameHeader(MP3Stream, MaxFrameLength, FrameInfo) then
                begin
                  SeekPos   := FrameInfo.FrameHeaderPos;
                  MP3Stream.Seek(SeekPos, soFromBeginning);
                  ReadCount := FrameInfo.FrameLength + MP3HeaderLength;
                end;
              end;
      stOGG : if (vbDecSeek(@vbDecInfo, Value) <> VB_ERR_OK) then
                exit;
    end;

    if Assigned(FOnPosChange) then FOnPosChange(Self, Value);
    if tmpPaused              then Play;
  end;
  
//  procedure TOggPlayer.NewFFTData(Sender: TObject; BandOut : TBandOut;
//                                               var PostFlag : boolean);
//  begin
//    if Assigned(FOnNewFFTData) then
//       FOnNewFFTData(Sender, BandOut, PostFlag);
//  end;
  
  procedure TOggPlayer.ProcMessage(var Msg: TMessage);
  begin
    case Msg.Msg of
      WM_BitRateChange   : if Assigned(FOnBitRateChange) then
                             FOnBitRateChange(Self, Msg.WParam);
      WM_PosChange       : if Assigned(FOnPosChange) then
                             FOnPosChange(Self, Msg.WParam);
      WM_QueryEndSession : Msg.Result := 1;  // Allow termination of program
    end;
  end;
  
  procedure TOggPlayer.AudioOut1Stop(Sender: TObject);
  var
     GotToEnd : boolean;
  begin
    SetThreadPriority(PlayerThread, THREAD_PRIORITY_NORMAL);
    GotToEnd := false;

    case FStreamType of
      stMP3 : begin
                MpgLib_CloseStream(hStream);
                MpgLib_OpenStream(hStream);
                if MP3Stream.Position >= MP3EndPos then
                  GotToEnd := true;
              end;
      stOGG : if (vbDecInfo.dwCurTime_in_ms >= vbDecInfo.dwTotTime_in_ms) or DecodeErrEnd then
                GotToEnd := true;
    end;

    if GotToEnd then
    begin
      FPlayerMode := plmStopped;
      if Assigned(FOnPosChange) then
        FOnPosChange(Self, FStreamInfo.Duration);
      if Assigned(FOnPlayEnd) then
        FOnPlayEnd(Self);
    end else if FPlayerMode <> plmpaused then
               FPlayerMode := plmStopped;
  end;
  
  function TOggPlayer.AudioOut1BufferPlayed(Buffer: PChar; var Size: Word): Boolean;
  var
    p1, p2       : ^Byte;
    i, bIndex    : integer;
    BytesDecoded : integer;
    NewBitRate   : LongInt;
    NewPos       : DWORD;

   procedure DecodeMP3Frame;
   var
      i : integer;
      BytesRead : longint;
      MPGResult : integer;
   begin
      bIndex := 0;
      for i := 0 to (FramesPerAudioBuffer - 1) do
         BufferFilled[i] := 0;
  
      while (bIndex < FramesPerAudioBuffer) do
      begin
         BytesRead := MP3Stream.Read(InBuffer^, ReadCount);
         if BytesRead <> ReadCount then
            break;
         MPGResult := MpgLib_DecodeChunk(hStream, InBuffer, BytesRead,
                                   OutBuffer[bIndex], OutBufferSize, BytesDecoded);
         if MPGResult = MPGLIB_NEED_MORE then
         begin
            if MP3Stream.Position < MP3EndPos then
            begin
               BytesRead := MP3Stream.Read(InBuffer^, ReadCount);
               if BytesRead <> ReadCount then
                  break;
               MPGResult := MpgLib_DecodeChunk(hStream, InBuffer, BytesRead,
                                   OutBuffer[bIndex], OutBufferSize, BytesDecoded);
               NewBitRate := MpgLib_GetBitRate;
               if (NewBitRate = 0) or (ReposSkipCounter > 0) then
               begin
                  BytesDecoded := 0;
                  if ReposSkipCounter > 0 then
                     dec(ReposSkipCounter);
                  Continue;
               end;
               if NewBitRate <> CurrBitRate then
               begin
                  ReadCount := Trunc (144 * NewBitRate / MP3StreamInfo.FrameInfo.SampleRate
                                    + Integer(MP3StreamInfo.FrameInfo.Padding)) + MP3HeaderLength;
                  CurrBitRate := NewBitRate;
                  PostMessage(MessageHandle, WM_BitRateChange, CurrBitRate, 0);
               end;
            end;
         end else if (MPGResult = MPGLIB_OK) then
         begin
            NewBitRate := MpgLib_GetBitRate;
            if (NewBitRate = 0) or (ReposSkipCounter > 0) then
            begin
               BytesDecoded := 0;
               if ReposSkipCounter > 0 then
                  dec(ReposSkipCounter);
               Continue;
            end;
            if NewBitRate <> CurrBitRate then
            begin
               ReadCount := Trunc (144 * NewBitRate / MP3StreamInfo.FrameInfo.SampleRate
                                    + Integer(MP3StreamInfo.FrameInfo.Padding)) + MP3HeaderLength;
               CurrBitRate := NewBitRate;
               PostMessage(MessageHandle, WM_BitRateChange, CurrBitRate, 0);
            end;
         end;
  
         if MPGResult <> MPGLIB_OK then
            if MP3Stream.Position >= MP3EndPos then
               break
            else
               continue;
  
     // Message out if playing position is changed(> 0.1 second).
         if Assigned(FOnPosChange) then
         begin
            NewPos := CurrentPosition div 100;
            if NewPos <> CurrPos then
            begin
               CurrPos := NewPos;
               PostMessage(MessageHandle, WM_PosChange, CurrentPosition, 0);
            end;
         end;
  
         if BytesDecoded > 0 then
         begin
            BufferFilled[bIndex] := BytesDecoded;  // Save the number of decoded bytes
            inc(bIndex);
         end;
  
         if MP3Stream.Position >= MP3EndPos then
            break;
  
      end;    // end of while
   end;       // end of DecodeMP3Frame

   procedure DecodeOggFrame;
   var
      i : integer;
   begin
      bIndex := 0;
      for i := 0 to (FramesPerAudioBuffer - 1) do
         BufferFilled[i] := 0;
  
      while (bIndex < FramesPerAudioBuffer) do
      begin
      // You may get VB_ERR_EOS instead of VB_ERR_OK for the return value of
      // vbDecRead at the end of stream file, if you do not change playing
      // position during playing.
         if vbDecRead(@vbDecInfo, OutBuffer[bIndex], BytesDecoded) <> VB_ERR_OK then
         begin
            DecodeErrEnd := true;
            break;
         end;
  
         if BytesDecoded > 0 then
         begin
            BufferFilled[bIndex] := BytesDecoded;  // Save the number of decoded bytes
            inc(bIndex);
         end;
  
      // Message out if bit rate is changed
         if vbDecInfo.nBitRate <> CurrBitRate then
         begin
            PostMessage(MessageHandle, WM_BitRateChange, vbDecInfo.nBitRate, 0);
            CurrBitRate := vbDecInfo.nBitRate;
         end;
  
      // Message out if playing position is changed(> 0.1 second).
         if Assigned(FOnPosChange) then
         begin
            NewPos := vbDecInfo.dwCurTime_in_ms div 100;
            if NewPos <> CurrPos then
            begin
               CurrPos := NewPos;
               PostMessage(MessageHandle, WM_PosChange, vbDecInfo.dwCurTime_in_ms, 0);
            end;
         end;
  
         if (vbDecInfo.dwCurTime_in_ms >= vbDecInfo.dwTotTime_in_ms) then
            break;
  
      end;    // end of while
   end;       // end of DecodeMP3Frame

  begin
    Result := false;
    Size := 0;

    case FStreamType of
      stMP3 : DecodeMP3Frame;
      stOGG : DecodeOGGFrame;
    end;

    p1 := pointer(Buffer);

    for i := 0 to (bIndex - 1) do
    begin
      p2 := pointer(OutBuffer[i]);
      if p2 <> nil then
      begin
        try
          if BufferFilled[i] > 0 then
          begin
            Move(p2^, p1^, BufferFilled[i]);
            Size := Size + BufferFilled[i];
            inc(p1, BufferFilled[i]);
          end;
        except
          exit;
        end;
      end;
    end;

    if Size > 0 then
       result := true;

  end;
  
{$ENDREGION}

{$REGION ' - TMPEG      '}
  constructor TMPEG.Create(PlayWindow: TWinControl);
  begin
    FMovieWindow  := PlayWindow;
    FGraphBuilder := nil;
    FMediaControl := nil;
    FMediaSeeking := nil;
    FAudioControl := nil;
    FVideoWindow  := nil;
    FInit         := False;
  end;

  destructor TMPEG.Destroy;
  begin
    Close();
    Inherited;
  end;

  function TMPEG.Init: Boolean;
  begin
    Result := False;
    if Failed(CoInitialize(nil)) then
      Exit;
    if Failed(CoCreateInstance(TGUID(CLSID_FilterGraph), nil, CLSCTX_INPROC, TGUID(IID_IGraphBuilder), FGraphBuilder)) then
      Exit;
    if Failed(FGraphBuilder.QueryInterface(IID_IMediaControl, FMediaControl)) then
      Exit;
    if Failed(FGraphBuilder.QueryInterface(IID_IMediaSeeking, FMediaSeeking)) then
      Exit;
    if Failed(FGraphBuilder.QueryInterface(IID_IBasicAudio, FAudioControl)) then
      Exit;
    if Failed(FGraphBuilder.QueryInterface(IID_IVideoWindow, FVideoWindow)) then
      Exit;
    Result := True;
  end;
  
  procedure TMPEG.Pause;
  begin
    FMediaControl.Pause;
  end;
  
  function TMPEG.Play(FFileName: String): Boolean;
  Var
    HR    : Hresult;
    wFile : Array[0..(MAX_PATH * 2) - 1] Of Char;
  begin
    Result := False;
    FInit  := Init();
    MultiByteToWideChar(CP_ACP, 0, PChar(FFileName), -1, @wFile, MAX_PATH);
    HR := FGraphBuilder.renderfile(@wFile, nil);
    if Failed(HR) then
      Exit;
    if FMovieWindow <> nil then
    begin
      FVideoWindow.put_Owner(FMovieWindow.Handle);
      FVideoWindow.put_windowstyle(WS_CHILD Or WS_Clipsiblings);
      FVideoWindow.SetWindowposition(0, 0, FMovieWindow.Width, FMovieWindow.Height);
    end;
  
    FMediaControl.Run;
    FPlay := True;
  end;
  
  procedure TMPEG.Stop;
  begin
    if not FInit then
      Exit;
    FMediaControl.Stop;
    Close();
  end;
  
  procedure TMPEG.Close;
  begin
    if Assigned(FMediaControl) then
      FMediaControl.Stop;
    if Assigned(FAudioControl) then
      FAudioControl := nil;
    if Assigned(FMediaSeeking) then
      FMediaSeeking := nil;
    if Assigned(FMediaControl) then
      FMediaControl := nil;
    if Assigned(FVideoWindow)  then
      FVideoWindow  := nil;
    if Assigned(FGraphBuilder) then
      FGraphBuilder := nil;
  
    CoUninitialize;
    FInit := False;
  end;
  
{$ENDREGION}

constructor TMir3_Sound_Engine.Create;
begin
  Inherited;
  FInternalOgg       := TOggPlayer.Create;
  FInternalSoundList := TStringList.Create;
  FInternalMp3       := TMPEG.Create(nil);
  if Assigned(FInternalMp3) then
    FInternalMp3.Init;
  LoadSoundListFile;

  if Assigned(GRenderEngine) then
    GRenderEngine.System_Log('Sound engine initialized..');
end;

destructor TMir3_Sound_Engine.Destroy;
begin

  if Assigned(FInternalOgg) then
    FreeAndNil(FInternalOgg);

  if Assigned(FInternalMp3) then
    FreeAndNil(FInternalMp3);

  if Assigned(FInternalSoundList) then
  begin
    FInternalSoundList.Clear;
    FreeAndNil(FInternalSoundList);
  end;

  if Assigned(g_BGChannel) then
     g_BGChannel.Stop;

  if Assigned(GRenderEngine) then
    GRenderEngine.System_Log('Sound engine destroy success..');
  Inherited;
end;

procedure TMir3_Sound_Engine.LoadSoundListFile;
var
  I         : Integer;
  FHandle   : Integer;
  FData     : String;
  FHeader   : TSoundListHeader;
  FFileBody : TSoundBody;
begin
  if FileExists(SOUND_LIST_NAME) then
  begin
    FHandle := FileOpen(SOUND_LIST_NAME, fmOpenRead or fmShareDenyNone);
    if FHandle > 0 then
    begin
      FileRead (FHandle, FHeader, SizeOf(TSoundListHeader));
      for I := 0 to FHeader.Count - 1 do
      begin
        FileRead(FHandle, FFileBody, SizeOf(TSoundBody));
        FData := FFileBody.FileName;
        FInternalSoundList.Add(FData);
      end;
    end;
  end;
end;

procedure TMir3_Sound_Engine.PlaySoundClick(AStdItem: TStdItem);
begin
  case AStdItem.StdMode of
    0, 31      : PlaySound(ftWav, SOUND_CLICK_DRUG);
    5, 6       : PlaySound(ftWav, SOUND_CLICK_WEAPON);
    10, 11     : PlaySound(ftWav, SOUND_CLICK_ARMOR);
    22, 23     : PlaySound(ftWav, SOUND_CLICK_RING);
    24, 26     : begin
      if (Pos('ÊÖïí', AStdItem.Name) > 0) or
         (Pos('ÊÖÌ×', AStdItem.Name) > 0) then
        PlaySound(ftWav, SOUND_CLICK_GROBES)
      else PlaySound(ftWav, SOUND_CLICK_ARM_RING);
    end;
    19, 20, 21 : PlaySound(ftWav, SOUND_CLICK_NECKLACE);
    15         : PlaySound(ftWav, SOUND_CLICK_HELMET);
    else         PlaySound(ftWav, SOUND_CLICK_ITEM);
  End;
end;

procedure TMir3_Sound_Engine.PlaySoundItem(AStdMode: Integer);
begin
  case AStdMode of
    0    : PlaySound(ftWav, SOUND_CLICK_DRUG);
    1, 2 : PlaySound(ftWav, SOUND_EAT_DRUG);
  end;
end;

procedure TMir3_Sound_Engine.PlaySound(AType: TFileType; AIndex: Integer);
begin
  try
    case AType of
      ftWav : begin
       if not GGame_Option.gos_Sound_Effects then exit;

       //if g_boSound then
       //begin
         if (AIndex >=0) and (AIndex < FInternalSoundList.Count) then
         begin
           if FInternalSoundList[AIndex] <> '' then
           begin
             if FileExists(FSoundFilePath + FInternalSoundList[AIndex]) then
             begin
               try
                 g_Soundmus     := GRenderEngine.Effect_Load(FSoundFilePath + FInternalSoundList[AIndex]);
                 g_SoundChannel := g_Soundmus.PlayEx(g_BGVolume, 0, 1.0, False);
               except
               end;
             end;
           end;
         end;
       //end;
      end;
      ftOgg : begin

      end;
      ftMp3 : begin

      end;
    end;
  except
  end;
end;

procedure TMir3_Sound_Engine.PlaySound(AType: TFileType; AFileName: String);
begin
  try
    case AType of
      ftWav : begin
       if not Assigned(GRenderEngine) then exit;

       //if g_boSound then
       //begin
         if FileExists(FSoundFilePath + AFileName) then
         begin
           try
             g_Soundmus     := GRenderEngine.Effect_Load(FSoundFilePath + AFileName);
             g_SoundChannel := g_Soundmus.PlayEx(g_BGVolume, 0, 1.0, False);
           except
           end;
         end;
       //end;
      end;
      ftOgg : begin

      end;
      ftMp3 : begin

      end;
    end;
  except
  end;
end;

procedure TMir3_Sound_Engine.PlaySoundLoop(AFileName: String);
begin
  try
    if not Assigned(GRenderEngine) then exit;
    if FileExists(FSoundFilePath + AFileName) then
    begin
      try
        g_Soundmus     := GRenderEngine.Effect_Load(FSoundFilePath + AFileName);
        g_SoundChannel := g_Soundmus.PlayEx(g_BGVolume, 0, 1.0, TRue);
      except
      end;
    end;
  except
  end;
end;

procedure TMir3_Sound_Engine.PlayBackgroundMusic(AFileName: String);
begin
  try
    if not Assigned(GRenderEngine) then exit;
    if FileExists(FSoundFilePath + AFileName) then
    begin
      g_BGVolume  := 10;
      g_BGmus     := GRenderEngine.Effect_Load(FSoundFilePath + AFileName);
      g_BGChannel := g_BGmus.PlayEx(g_BGVolume, 0, 1.0, True);
    end else if Assigned(g_BGChannel) then
               g_BGChannel.Stop;

    if (AFileName = 'SelChr.wav' ) or
       (AFileName = 'opening.wav') then
      exit;
      
    if Assigned(g_BGChannel) then
      if not GGame_Option.gos_Back_Ground_Music then
        g_BGChannel.Pause
      else g_BGChannel.Resume;
  except
  end;
end;

procedure TMir3_Sound_Engine.StopBackgroundMusic;
begin
  if Assigned(g_BGChannel) then
    g_BGChannel.Stop;
end;

procedure TMir3_Sound_Engine.StopWavFile;
begin
//  if Assigned(FInternalWav) then
//    FInternalWav.Clear;
end;

procedure TMir3_Sound_Engine.StopOggFile;
begin
  if Assigned(FInternalOgg) then
    FInternalOgg.Stop;
end;

end.

