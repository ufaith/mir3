// Unit to interface applications to CDRip3.DLL
//   Version 1.0   written by Silhwan Hyun, hsh@chollian.net      2002-04-30
//
// CDRip3.DLL is revised version of CDRip.DLL.
// CDRip.DLL is an element of CDex and CDex is a open source project which is
//  able to extract audio tracks from a CD-ROM digitally, and save those files
//  to disk as either regular WAV file or MP3 files.
// Visit Cdex Home Page http://www.cdex.n3.net/ for further details.
//
// The functions of CDRip3.DLL are just same as CDRip.DLL except some added
//  or modified functions.
// Followings are added or modified functions of CDRip3.DLL
//  CR_GetCDROMID         : (Added) Get the ID of current CDROM
//  CR_GetCDROMIDByIndex  : (Added) Get the ID of specified CDROM
//  CR_IsMMC              : (Added) Check if CDROM is MMC type
//  CR_IsMediaLoaded      : (Added) Check if a media is present in CDROM
//  CR_DriveStatus        : (Added) Check the status of CDROM
//  CR_GetTocEntry2       : (Added) Get a track information of CD in CDROM
//  CR_GetSenseKey2       : (Added) Sorry, I do not know the purpose of this function.
//                                  It is just a substitute for CR_GetSenseKey.
//  CR_IsAudioPlaying     : (Modified) Check if CDROM is playing audio track
//
// Please see the CDRip3.cpp for better understanding on each function of
// CDRip3.DLL


unit CDRipIntf;

// Represent enumerated types as double-words, for interfacing with C++ library.
{$Z4}

interface

uses SysUtils, WinTypes, Extctrls, Messages, Forms, MMSystem;

const
// Constants for error type
   CDEX_OK                 = 0;
   CDEX_ERROR              = 1;
   CDEX_FILEOPEN_ERROR     = 2;
   CDEX_JITTER_ERROR       = 3;
   CDEX_RIPPING_DONE       = 4;
   CDEX_RIPPING_INPROGRESS = 5;
   CDEX_NO_DISC            = 6;
   CDEX_DATA_DISC          = 7;

   CDROMDATAFLAG = $04;
   AUDIOTRKFLAG  = $10;

 // Constants for track type
   DataTrack     = 0;
   AudioTrack    = 1;

 // Constants for disc type
   DataDisc      = 0;
   AudioDisc     = 1;
   CompositeDisc = 2;   // Disc which has both data track(s) and audio track(s)

   MaxTrack = 99;

// Constants for representing drive status
   DrNoDisc   = 0;
   DrNotKnown = CDEX_ERROR;
   DrPlaying  = 17;
   DrPaused   = 18;
   DrRipping  = 19;
   DrStopped  = 21;

// Constants for representing ripping mode
   CR_RIPPING_MODE_NORMAL   = 0;
   CR_RIPPING_MODE_PARANOIA = 1;

// Constants for representing PARANOIA_MODE
   PARANOIA_MODE_FULL      = $ff;
   PARANOIA_MODE_DISABLE   = 0;
   PARANOIA_MODE_VERIFY    = 1;
   PARANOIA_MODE_FRAGMENT  = 2;
   PARANOIA_MODE_OVERLAP   = 4;
   PARANOIA_MODE_SCRATCH   = 8;
   PARANOIA_MODE_REPAIR    = 16;
   PARANOIA_MODE_NEVERSKIP = 32;

type
   TCDEX_Err = longint;

   TDriveType = (GENERIC,    TOSHIBA, TOSHIBANEW, IBM,      NEC,     DECorp,     IMS,
                 KODAK,      RICOH,   HP,         PHILIPS,  PLASMON, GRUNDIGCDR100IPW,
                 MITSUMICDR, PLEXTOR, SONY,       YAMAHA,   NRC,     IMSCDD5, CUSTOMDRIVE,
                 NUMDRIVETYPES);

   TReadMethod = (READMMC, READ10, READNEC, READSONY, READMMC2, READMMC3,
                  READC1,  READC2, READC3,  READMMC4, NUMREADMETHODS);

   TSetSpeed = (SPEEDNONE,    SPEEDMMC, SPEEDSONY, SPEEDYAMAHA, SPEEDTOSHIBA,
                SPEEDPHILIPS, SPEEDNEC, NUMSPEEDMETHODS);

   TEndian = (BIGENDIAN, LITTLEENDIAN, NUMENDIAN);

   TEnableMode = (ENABLENONE, ENABLESTD, NUMENABLEMODES);

   TOutputFormat = (STEREO44100, MONO44100, STEREO22050, MONO22050,
                    STEREO11025, MONO11025, NUMOUTPUTFORMATS);

   TDriveTable = record
      DriveType  : TDriveType;
      ReadMethod : TReadMethod;
      SetSpeed   : TSetSpeed;
      Endian     : TEndian;
      EnableMode : TEnableMode;
      nDensity   : longint;
      bAtapi     : longbool;
   end;

   TCDROMParams = record
      lpszCDROMID         : array[0..255] of char; // CD-ROM ID, must be unique to index settings in INI file
      nNumReadSectors     : LongInt;		   // Number of sector to read per burst
      nNumOverlapSectors  : LongInt;		   // Number of overlap sectors for jitter correction
      nNumCompareSectors  : LongInt;		   // Number of sector to compare for jitter correction
      nOffsetStart	  : LongInt;		   // Fudge factor at start of ripping in sectors
      nOffsetEnd	  : LongInt;		   // Fudge factor at the end of ripping in sectors
      nSpeed		  : LongInt;		   // CD-ROM speed factor 0 .. 32 x
      nSpinUpTime	  : LongInt;		   // CD-ROM spin up time in seconds
      bJitterCorrection   : LongBool;     	   // Boolean indicates whether to use Jitter Correction
      bSwapLefRightChannel: LongBool;    	   // Swap left and right channel ?
      DriveTable	  : TDriveTable;	   // Drive specific parameters

      btTargetID	  : BYTE;		   // SCSI target ID
      btAdapterID	  : BYTE;		   // SCSI Adapter ID
      btLunID		  : BYTE;		   // SCSI LUN ID

      bAspiPosting	  : LongBool;		    // When set ASPI posting is used, otherwhiese ASPI polling is used
  //  nOutputFormat	  : LongInt{TOutputFormat}; // Determines the sample rate and channels of the output format
      nAspiRetries        : Integer;
      nAspiTimeOut        : Integer;

      bEnableMultiRead    : LongBool;             // Enables Multiple Read Verify Feature
      bMultiReadFirstOnly : LongBool;             // Only do the multiple reads on the first bloc
      nMultiReadCount     : Integer;              // Number of times to reread and compare
      bLockDuringRead     : LongBool;

      nRippingMode        : Integer;
      nParanoiaMode       : Integer;
   end;

   TTOCEntry = record
      dwStartSector : DWORD;
      btFlag        : byte;
      btTrackNumber : byte;
   end;

   TSenseKey = record
      SK     : byte;
      ASC    : byte;
      ASCQ   : byte;
   end;

   TTrackData = record
      TrackNumber : byte;
      TrackType   : byte;
      Loc         : longint;   // Track location (Min_Sec_Frame)
      Length      : longint;   // Track length  (Min_Sec_Frame)
      SectLoc     : longint;   // Track location (by sector number)
      SectLength  : longint;   // Track length (by number of sectors)
    end;

    TDiscData = record
       DiscType     : smallint;
       CdId         : longint;   // CD Identifier
       Lowest       : smallint;  // number of 1st track
       Highest      : smallint;  // number of last track
       TrackCount   : smallint;  // number of total tracks
       StartTime    : longint;   // start time of 1st track
       EndTime      : longint;   // end time of last track
       PlayTime     : longint;   // overall playing time
       LeadOutPos   : longint;   // Lead-Out position of CD
       TrackData    : array[1..MaxTrack+1] of TTrackData;
    end;

   TMCI_Open_Params = record
      dwCallBack : DWORD;
      wDeviceID : MCIDEVICEID;
    //  lpstrDeviceType : PChar;
      lpstrDeviceType : DWORD;
      lpstrElementName : PChar;
      lpstrAlias : PChar;
   end;

   TMCI_Generic_Params = record
      dwCallBack : DWORD;
   end;

   TMCI_Status_Params = record
      dwCallback : DWORD;
      dwReturn : DWORD;
      dwItem : DWORD;
      dwTrack : DWORD;
   end;

   TMCI_Set_Params = record
      dwCallback : DWORD;
      dwTimeFormat : DWORD;
      dwAudio : DWORD;
   end;

   TMCI_SysInfo_Parms = record
     dwCallback: DWORD;
     lpstrReturn: Pointer;
     dwRetSize: DWORD;
     dwNumber: DWORD;
     wDeviceType: UINT;
   end;

   TMCI_Play_Params = record
      dwCallBack : longint;
      dwFrom : longint;
      dwTo : longint;
   end;

var
   CR_Init : function(strIniFName : PChar) : TCDEX_Err; stdcall;
   CR_GetCDRipVersion : function : longint; stdcall;

   CR_GetNumCDROM : function : longint; stdcall;
   CR_SetActiveCDROM : procedure(nActiveDrive : longint); stdcall;
   CR_GetActiveCDROM : function : longint; stdcall;
   CR_GetCDROMID : function : PChar; stdcall;
   CR_GetCDROMIDByIndex : function(i : integer) : PChar; stdcall;

   CR_SelectCDROMType : function(cdType : TDriveType) : TCDEX_Err; stdcall;
   CR_GetCDROMType : function : TDriveType; stdcall;

// CR_IsMMC returns true if CDROM drive support MMC, else false.
// The lpszInfo would be one of following text string
//     'Drive is MMC style'
//     'MMC drive, but reports CDDA incapable'
//     'Drive does not support MMC'
   CR_IsMMC : function(lpszInfo : PChar) : boolean; stdcall;
   CR_GetCDROMParameters : function(var Param : TCDROMParams) : TCDEX_Err; stdcall;
   CR_SetCDROMParameters : function(var Param : TCDROMParams) : TCDEX_Err; stdcall;

   CR_OpenRipper : function(var plBufferSize : longint; dwStartSector, dwEndSector : longint) : TCDEX_Err; stdcall;
   CR_CloseRipper : function : TCDEX_Err; stdcall;
   CR_RipChunk : function(pDataBuffer : pointer; var NumBytes : longint;  var bAbort : LongBool) : TCDEX_Err; stdcall;

   CR_GetPeakValue : function : longint; stdcall;
   CR_GetPercentCompleted : function : longint; stdcall;
   CR_GetNumberOfJitterErrors : function : longint; stdcall;
   CR_GetJitterPosition : function : longint; stdcall;
   CR_GetLastJitterErrorPosition : procedure(var StartSector, EndSector : DWORD); stdcall;
   CR_NormalizeChunk : procedure(pDataBuffer : pointer; NumSamples : longint; ScaleFactor : double); stdcall;

   CR_LoadSettings : function : TCDEX_Err; stdcall;
   CR_SaveSettings : function : TCDEX_Err; stdcall;

   CR_ReadToc : function : TCDEX_Err; stdcall;
   CR_GetNumTocEntries : function : longint; stdcall;

// The result type of CR_GetTocEntry is record type.
// Unlike C++, Dephi cannot receive the record type return value directly.
//  (My misunderstanding ?)
// So, I added CR_GetTocEntry2 for easier interface to Delphi.
   CR_GetTocEntry : function(nTocEntry : longint) : TTOCEntry; stdcall;
   CR_GetTocEntry2 : function(nTocEntry : longint; var TocInfo : TTOCEntry) : TCDEX_Err; stdcall;
// CR_GetSenseKey2 -> same case as CR_GetTocEntry2
   CR_GetSenseKey : function : TSenseKey; stdcall;
   CR_GetSenseKey2 : function(var SenseKey : TSenseKey) : TCDEX_Err; stdcall;

// Use CR_IsMediaLoaded to check if the media is present instead of CR_IsUnitReady,
//  which returns true when media is not present in drive.
   CR_IsUnitReady : function :boolean; stdcall;
   CR_IsMediaLoaded : function : boolean; stdcall;
// bLock : true -> lock drive, false -> unlock drive
   CR_LockCD : procedure(bLock : boolean); stdcall;

// The return value of CR_DriveStatus is one of followings
//   0 : No Media in Drive     1 : CDEX_ERROR     17 : Playing
//  18 : Paused               19 : Ripping        21 : Stopped
   CR_DriveStatus : function : integer; stdcall;

// bEject : true -> eject, false -> close
   CR_EjectCD : function(bEject : boolean) : boolean; stdcall;

   CR_IsAudioPlaying : function : boolean; stdcall;
   CR_PlayTrack : function(nTrack : integer) : TCDEX_Err; stdcall;
   CR_PlaySection : function(StartSector, EndSector : longint) : TCDEX_Err; stdcall;
   CR_GetPlayPosition : function(var dwRelPos, dwAbsPos : DWORD) : TCDEX_Err; stdcall;
   CR_SetPlayPosition : function(dwAbsPos : DWORD) : TCDEX_Err; stdcall;
   CR_StopPlayTrack : function : TCDEX_Err; stdcall;

// bPause : true -> pause, false -> resume
   CR_PauseCD : function(bPause : boolean) : TCDEX_Err; stdcall;

   CR_GetSubChannelTrackInfo : procedure(var nReadIndex : integer;
                                         var nReadTrack : integer;
                                         var dwReadPos  : DWORD); stdcall;
   CR_ReadCDText : function(pbtBuffer : pointer; nBufferSize : integer;
                             var pnCDTextSize : integer) : TCDEX_Err; stdcall;
   CR_GetTransportLayer : function : integer; stdcall;
   CR_SetTransportLayer : procedure(nTransportLayer : integer); stdcall;
   CR_ScanForC2Errors : procedure(lStartSector : longint;
                                  lEndSector : longint;
                                  var nErrors : integer;
                                  var pnErrorSectors : integer;
                                  nMaxErrors : integer;
                                  var bAbort : boolean); stdcall;

procedure SplitTime(CompositeTime : longint; var Min, Sec, Frame : byte);
function CompTime(Min, Sec, Frame : byte) : longint;
function TimePos2SectorPos(RedBookTime : longint) : longint;
function SectorPos2TimePos(SectorPos : longint) : longint;
function Sector2Time(Sector : longint) : longint;
function Time2Sector(Time : longint) : longint;
function TimeAdd(Time1 : longint; Time2 : longint) : longint;
function TimeSub(Time1 : longint; Time2 : longint) : longint;

procedure SelectActiveCDROM(NewDrive : longint);

function CDRipDllLoaded : Boolean;
function CDRipDllReady : boolean;

function GetDiscInfo(var DiscInfoTable : TDiscData) : TCDEX_Err;


implementation


var
   CDRipDLL : THANDLE = 0;
   CDEX_Ready : boolean;

   MCIOpened : boolean = false;
   wDeviceID : MCIDEVICEID;
   MCI_SysInfo_Parms : TMCI_SysInfo_Parms;
   MCI_Play_Params : TMCI_Play_Params;
   MCI_Open_Params : TMCI_Open_Params;
   MCI_Generic_Params : TMCI_Generic_Params;
   MCI_Status_Params : TMCI_Status_Params;
   MCI_Set_Params : TMCI_Set_Params;
   MCIResult : MCIERROR;


procedure SplitTime(CompositeTime : longint; var Min, Sec, Frame : byte);
begin
   Min := (CompositeTime shr 16) and $00ff;
   Sec := (CompositeTime shr 8) and $00ff;
   Frame := CompositeTime and $00ff;
end;

function CompTime(Min, Sec, Frame : byte) : longint;
var
   TimeValue : longint;
begin
   TimeValue := Min;
   TimeValue := (TimeValue shl 8) + Sec;
   CompTime := (TimeValue shl 8) + Frame;
end;

function Sector2Time(Sector : longint) : longint;
var
    Min, Sec, Frame : longint;
begin
    Frame := Sector mod 75;
    Sec := (Sector div 75) mod 60;
    Min := Sector div 4500;
    Sector2Time := (Min shl 16) + (Sec shl 8) + Frame;
end;

function Time2Sector(Time : longint) : longint;
var
    Min, Sec, Frame : byte;
begin
    SplitTime(Time, Min, Sec, Frame);
    Time2Sector := longint(Min) * 4500 + longint(Sec) * 75 + Frame;
end;

// RedBook Time Format -> High Sierra Sector Address Conversion
function TimePos2SectorPos(RedBookTime : longint) : longint;
var
    Min, Sec, Frame : byte;
begin
    SplitTime(RedBookTime, Min, Sec, Frame);
    TimePos2SectorPos := longint(Min) * 4500 + Longint(Sec) * 75
                       + Frame - 150;
end;

function TimeAdd(Time1 : longint; Time2 : longint) : longint;
begin
   TimeAdd := SectorPos2TimePos(TimePos2SectorPos(Time1) + Time2Sector(Time2));
end;

function TimeSub(Time1 : longint; Time2 : longint) : longint;
begin
   TimeSub := SectorPos2TimePos(TimePos2SectorPos(Time1) - Time2Sector(Time2));
end;

// High Sierra Sector Address -> RedBook Time Format Conversion
function SectorPos2TimePos(SectorPos : longint) : longint;
var
    Min, Sec, Frame : longint;
begin
    Frame := SectorPos mod 75;
    Sec := ((SectorPos + 150) div 75) mod 60;
    Min := (SectorPos + 150) div 4500;
    SectorPos2TimePos := (Min shl 16) + (Sec shl 8) + Frame;;
end;


// Get the number of CDROM surpported by MCI service.
// note) The number of CDROM surpported by MCI service would be less than the
//       number of CDROM in your system.
function NumOfMCI_CD_AUDIO : integer;
var
   MCINum : DWORD;
begin
   MCI_SysInfo_Parms.dwRetSize := 4;
   MCI_SysInfo_Parms.lpstrReturn := @MCINum;
   MCI_SysInfo_Parms.wDeviceType := MCI_DEVTYPE_CD_AUDIO;
   MCIResult := mciSendCommand(wDeviceID, MCI_SYSINFO, MCI_SYSINFO_QUANTITY,
                                         DWORD(@MCI_SysInfo_Parms));
   if MCIResult = 0 then
      NumOfMCI_CD_AUDIO := MCINum
   else
      NumOfMCI_CD_AUDIO := 0;
end;


procedure OpenMCIDevice;
var
   ActiveCDROMNumb : DWORD;
begin
   if MCIOpened then
      exit;

   if CR_GetNumCDROM = 0 then
      exit;

   ActiveCDROMNumb := CR_GetActiveCDROM;

   if (ActiveCDROMNumb + 1) > NumOfMCI_CD_AUDIO then
      exit;

   MCI_Open_Params.lpstrDeviceType := (ActiveCDROMNumb shl 16)
                                      + MCI_DEVTYPE_CD_AUDIO;
   MCIResult := mciSendCommand(wDeviceID, MCI_OPEN,
                   MCI_OPEN_TYPE+MCI_OPEN_TYPE_ID, DWORD(@MCI_Open_Params));

   if MCIResult <> 0 then
      exit;

   wDeviceID := MCI_Open_Params.wDeviceID;
   MCIOpened := true;
end;

procedure CloseMCIDevice;
begin
   if not MCIOpened then
      exit;

 // Releases access to MCI device
   MCIResult := mciSendCommand(wDeviceID, MCI_CLOSE, 0, DWORD(@MCI_Generic_Params));
   if MCIResult <> 0 then
      exit;
   MCIOpened := false;
end;


// I have experienced that the length of last track of a CD obtained using
// CR_GetTocEntry2 may not be correct in the case that the CD has both audio
// track(s) and data track(s).
// So, use GetMCILastTrackInfo to reconfirm the length of last track for such
// case.
procedure GetMCILastTrackInfo(var TrackNo, TrackPos, TrackLength : DWORD);
var
   Tracks : DWORD;
   MCITrackPos, MCITrackLength : DWORD;
begin
   TrackNo := 0;
   TrackPos := 0;
   TrackLength := 0;

   if not MCIOpened then
      exit;

   MCI_Status_Params.dwItem := MCI_STATUS_NUMBER_OF_TRACKS;
   MCIResult := mciSendCommand(wDeviceID, MCI_STATUS,
                               MCI_STATUS_ITEM, DWORD(@MCI_Status_Params));
   if MCIResult <> 0 then
      exit;

   Tracks := MCI_Status_Params.dwReturn;
   TrackNo := Tracks;      // TrackNo <- last track number

 // Set time format to Min-Sec-Frame style.
   MCI_Set_Params.dwTimeFormat := MCI_FORMAT_MSF;
   MCIResult := mciSendCommand(wDeviceID, MCI_SET, MCI_SET_TIME_FORMAT,
                                DWORD(@MCI_Set_Params));
   if MCIResult <> 0 then
      exit;

   MCI_Status_Params.dwTrack := Tracks;   // dwTrack <- last track

   MCI_Status_Params.dwItem := MCI_STATUS_POSITION;
   MCIResult := mciSendCommand(wDeviceID, MCI_STATUS,
                   (MCI_STATUS_ITEM or MCI_TRACK), DWORD(@MCI_Status_Params));
   if MCIResult <> 0 then
      exit;

   MCITrackPos := MCI_Status_Params.dwReturn;

 // change the byte order
   TrackPos := (mci_MSF_Minute(MCITrackPos) SHL 16)
             + (mci_MSF_Second(MCITrackPos) SHL 8)
             + (mci_MSF_Frame(MCITrackPos));

   MCI_Status_Params.dwItem := MCI_STATUS_LENGTH;
   MCIResult := mciSendCommand(wDeviceID, MCI_STATUS,
                   (MCI_STATUS_ITEM or MCI_TRACK), DWORD(@MCI_Status_Params));
   if MCIResult <> 0 then
      exit;

   MCITrackLength := MCI_Status_Params.dwReturn;

 // change the byte order
   TrackLength := (mci_MSF_Minute(MCITrackLength) SHL 16)
                + (mci_MSF_Second(MCITrackLength) SHL 8)
                + (mci_MSF_Frame(MCITrackLength));

end;

procedure SelectActiveCDROM(NewDrive : longint);
begin
   if (NewDrive > (CR_GetNumCDROM - 1)) or (NewDrive < 0) then
      exit;
   if NewDrive = CR_GetActiveCDROM then
      exit;

   CR_SetActiveCDROM(NewDrive);

   CloseMCIDevice;

   if NewDrive < NumOfMCI_CD_AUDIO then
      OpenMCIDevice;
end;


function GetDiscInfo(var DiscInfoTable : TDiscData) : TCDEX_Err;

  function CalcCdId : longint;
  var
    tracknumb     : Integer;
    magicNumb     : Byte;
    dwTemp, dwID  : LongInt;
  begin
    if DiscInfoTable.TrackCount = 0 then
    begin
       CalcCdId := 0;
       exit;
    end;

    dwID := 0;
    For tracknumb := 1 To DiscInfoTable.TrackCount do
    begin
      dwTemp := DiscInfoTable.TrackData[tracknumb].Loc;
      begin
        dwID := dwID + DiscInfoTable.TrackData[tracknumb].Loc;
	if trackNumb = 1 then
           magicNumb := LoWord(lo(dwTemp));
      end;
    end;

    if DiscInfoTable.TrackCount < 3 then
    begin
      dwID := dwID + magicNumb;
       dwID := dwID + Lo(DiscInfoTable.PlayTime shr 16) * 60 * 75
                    + Hi(LoWord(DiscInfoTable.PlayTime)) * 75
                    + Lo(LoWord(DiscInfoTable.PlayTime));
      if dwid > $FFFFF then
         dwid := dwid - $21;
    end;

    CalcCdId := dwID;
  end;

var
   AudioFlag, DataFlag : boolean;
   i, TrackNum : integer;
   TrackEndPos, tmpPlaySectors : longint;
   TocInfo : TTOCEntry;
   TrackNo, TrackPos, TrackLength : DWORD;
begin
   DiscInfoTable.TrackCount := 0;

   if not CR_IsMediaLoaded then
   begin
      result := CDEX_NO_DISC;
      exit;
   end;

   if CR_ReadToc <> CDEX_OK then
   begin
      result := CDEX_ERROR;
      exit;
   end;

   TrackNum := CR_GetNumTocEntries;

   if TrackNum < 1 then
   begin
      result := CDEX_ERROR;
      exit;
   end;

   DiscInfoTable.TrackCount := TrackNum;
   DiscInfoTable.PlayTime := 0;

   CR_GetTocEntry2(TrackNum, TocInfo);
   TrackEndPos := TocInfo.dwStartSector - 1;
   DiscInfoTable.LeadOutPos := SectorPos2TimePos(TocInfo.dwStartSector);

   for i := (TrackNum - 1) downto 0 do
   begin
      CR_GetTocEntry2(i, TocInfo);
      DiscInfoTable.TrackData[i+1].TrackNumber := TocInfo.btTrackNumber;

      if (TocInfo.btFlag and CDROMDATAFLAG) = CDROMDATAFLAG then
         DiscInfoTable.TrackData[i+1].TrackType := DataTrack
      else
         DiscInfoTable.TrackData[i+1].TrackType := AudioTrack;

      DiscInfoTable.TrackData[i+1].Loc := SectorPos2TimePos(TocInfo.dwStartSector);
      DiscInfoTable.TrackData[i+1].Length := Sector2Time(TrackEndPos - TocInfo.dwStartSector + 1);
      DiscInfoTable.TrackData[i+1].SectLoc := TocInfo.dwStartSector;
      DiscInfoTable.TrackData[i+1].SectLength := TrackEndPos - TocInfo.dwStartSector + 1;

      if i > 0 then
         TrackEndPos := TocInfo.dwStartSector - 1;

      if i = 0 then
         DiscInfoTable.Lowest := TocInfo.btTrackNumber;
      if i = (TrackNum - 1) then
         DiscInfoTable.Highest := TocInfo.btTrackNumber;
   end;

   DiscInfoTable.StartTime := SectorPos2TimePos(TocInfo.dwStartSector);

   GetMCILastTrackInfo(TrackNo, TrackPos, TrackLength);
   if TrackNo > 0 then
      DiscInfoTable.TrackData[TrackNo].Length := TrackLength;

   DiscInfoTable.EndTime := TimeAdd(DiscInfoTable.TrackData[TrackNum].Loc,
                                    DiscInfoTable.TrackData[TrackNum].Length);

   AudioFlag := false;
   DataFlag := false;
   tmpPlaySectors := 0;
   for i := 1 to DiscInfoTable.TrackCount do
      if DiscInfoTable.TrackData[i].TrackType = DataTrack then
         DataFlag := true
      else begin
         AudioFlag := true;
         tmpPlaySectors := tmpPlaySectors
                         + DiscInfoTable.TrackData[i].SectLength;
      end;
   if (AudioFlag and DataFlag) then
      DiscInfoTable.DiscType := CompositeDisc
   else if AudioFlag then
      DiscInfoTable.DiscType := AudioDisc
   else
      DiscInfoTable.DiscType := DataDisc;

   if not (DiscInfoTable.DiscType = DataDisc) then
      DiscInfoTable.PlayTime := Sector2Time(tmpPlaySectors);

   DiscInfoTable.CDId := CalcCDId;
   result := CDEX_OK;
end;


function CDRipDllLoaded : Boolean;
begin
   CDRipDllLoaded := (CDRipDLL <> 0);
end;


function CDRipDllReady : boolean;
begin
   CDRipDllReady := CDEX_Ready;
end;


function RequestDLLLoading: Boolean;
begin
   if (CDRipDLL = 0) then
   begin
      CDRipDLL := LoadLibrary('CDRIP3.DLL');
      if (CDRipDLL <> 0) then
      begin
         @CR_Init := GetProcAddress(CDRipDLL,'CR_Init');
         @CR_GetCDRipVersion := GetProcAddress(CDRipDLL,'CR_GetCDRipVersion');
         @CR_GetNumCDROM := GetProcAddress(CDRipDLL,'CR_GetNumCDROM');
         @CR_SetActiveCDROM := GetProcAddress(CDRipDLL,'CR_SetActiveCDROM');
         @CR_GetActiveCDROM := GetProcAddress(CDRipDLL,'CR_GetActiveCDROM');
         @CR_GetCDROMID := GetProcAddress(CDRipDLL,'CR_GetCDROMID');
         @CR_GetCDROMIDByIndex := GetProcAddress(CDRipDLL,'CR_GetCDROMIDByIndex');
         @CR_SelectCDROMType := GetProcAddress(CDRipDLL,'CR_SelectCDROMType');
         @CR_GetCDROMType := GetProcAddress(CDRipDLL,'CR_GetCDROMType');
         @CR_IsMMC := GetProcAddress(CDRipDLL,'CR_IsMMC');
         @CR_GetCDROMParameters := GetProcAddress(CDRipDLL,'CR_GetCDROMParameters');
         @CR_SetCDROMParameters := GetProcAddress(CDRipDLL,'CR_SetCDROMParameters');
         @CR_OpenRipper := GetProcAddress(CDRipDLL,'CR_OpenRipper');
         @CR_CloseRipper := GetProcAddress(CDRipDLL,'CR_CloseRipper');
         @CR_RipChunk := GetProcAddress(CDRipDLL,'CR_RipChunk');
         @CR_GetPeakValue := GetProcAddress(CDRipDLL,'CR_GetPeakValue');
         @CR_GetPercentCompleted := GetProcAddress(CDRipDLL,'CR_GetPercentCompleted');
         @CR_GetNumberOfJitterErrors := GetProcAddress(CDRipDLL,'CR_GetNumberOfJitterErrors');
         @CR_GetJitterPosition := GetProcAddress(CDRipDLL,'CR_GetJitterPosition');
         @CR_GetLastJitterErrorPosition := GetProcAddress(CDRipDLL,'CR_GetLastJitterErrorPosition');
         @CR_NormalizeChunk := GetProcAddress(CDRipDLL,'CR_NormalizeChunk');
         @CR_LoadSettings := GetProcAddress(CDRipDLL,'CR_LoadSettings');
         @CR_SaveSettings := GetProcAddress(CDRipDLL,'CR_SaveSettings');
         @CR_ReadToc := GetProcAddress(CDRipDLL,'CR_ReadToc');
         @CR_GetNumTocEntries := GetProcAddress(CDRipDLL,'CR_GetNumTocEntries');
         @CR_GetTocEntry := GetProcAddress(CDRipDLL,'CR_GetTocEntry');
         @CR_GetTocEntry2 := GetProcAddress(CDRipDLL,'CR_GetTocEntry2');
         @CR_GetSenseKey := GetProcAddress(CDRipDLL,'CR_GetSenseKey');
         @CR_GetSenseKey2 := GetProcAddress(CDRipDLL,'CR_GetSenseKey2');
         @CR_IsUnitReady := GetProcAddress(CDRipDLL,'CR_IsUnitReady');
         @CR_IsMediaLoaded := GetProcAddress(CDRipDLL,'CR_IsMediaLoaded');
         @CR_LockCD := GetProcAddress(CDRipDLL,'CR_LockCD');
         @CR_DriveStatus := GetProcAddress(CDRipDLL,'CR_DriveStatus');
         @CR_EjectCD := GetProcAddress(CDRipDLL,'CR_EjectCD');
         @CR_IsAudioPlaying := GetProcAddress(CDRipDLL,'CR_IsAudioPlaying');
         @CR_PlayTrack := GetProcAddress(CDRipDLL,'CR_PlayTrack');
         @CR_PlaySection := GetProcAddress(CDRipDLL,'CR_PlaySection');
         @CR_GetPlayPosition := GetProcAddress(CDRipDLL,'CR_GetPlayPosition');

         @CR_SetPlayPosition := GetProcAddress(CDRipDLL,'CR_SetPlayPosition');
         @CR_StopPlayTrack := GetProcAddress(CDRipDLL,'CR_StopPlayTrack');
         @CR_PauseCD := GetProcAddress(CDRipDLL,'CR_PauseCD');

     // Followings are new functions of CDRip.DLL version 1.1.5
         @CR_GetSubChannelTrackInfo := GetProcAddress(CDRipDLL, 'CR_GetSubChannelTrackInfo');
         @CR_ReadCDText := GetProcAddress(CDRipDLL, 'CR_ReadCDText');
         @CR_GetTransportLayer := GetProcAddress(CDRipDLL, 'CR_GetTransportLayer');
	 @CR_SetTransportLayer := GetProcAddress(CDRipDLL, 'CR_SetTransportLayer');
         @CR_ScanForC2Errors := GetProcAddress(CDRipDLL, 'CR_ScanForC2Errors');
      end;
   end;
   Result := (CDRipDLL <> 0);
end;


initialization

   CDEX_Ready := false;
   if RequestDLLLoading then     // Load CDRip3.DLL module
      if CR_Init('CDRipper.ini') = CDEX_OK then
         CDEX_Ready := true;

finalization
   if MCIOpened then
      CloseMCIDevice;

   if (CDRipDLL <> 0) then
      FreeLibrary(CDRipDLL);   // Unload CDRip3.DLL module

end.
