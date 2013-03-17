// Unit to interface applications to Vorbis.DLL
//    Version 1.0      written by Silhwan Hyun, hsh@chollian.net      2002-04-30
unit VorbisDll;

interface

uses windows, SysUtils;  //type definitions

const
  // encoding formats
   VB_CONFIG_MP3 = 0;
   VB_CONFIG_LAME = 256;
   VB_CONFIG_VORBIS = 1024;

   VB_DEC_STRUCT_VERSION = 0;
   VB_ENC_STRUCT_VERSION = 0;
   VB_ALB_STRUCT_VERSION = 1;

  // Error codes
   VB_ERROR  = -1;
   VB_ERR_OK = 0;

  // ENCODER ERROR NUMBERS
   VB_ERR_ENCODE                    = $00001000;
   VB_ERR_INVALID_FORMAT            = $00001001;
   VB_ERR_INVALID_FORMAT_PARAMETERS = $00001002;
   VB_ERR_NO_MORE_HANDLES           = $00001003;
   VB_ERR_INVALID_HANDLE            = $00001004;
   VB_ERR_BUFFER_TOO_SMALL          = $00001005;

  // DECODER ERROR NUMBERS
   VB_ERR_DECODE            = $00002000;
   VB_ERR_OPEN_FILE         = $00002001;
   VB_ERR_TOO_MANY_CHANNELS = $00002002;
   VB_ERR_EOS               = $00002003;

  // format specific variables
   MPEG1 = 1;
   MPEG2 = 0;

  // Mode constants
   VB_MODE_A = 100;
   VB_MODE_B = 200;
   VB_MODE_C = 300;
   VB_MODE_D = 400;
   VB_MODE_E = 500;

  // other constants
   VB_MAX_HOMEPAGE = 256;

type
   HVB_STREAM  = longInt;
   PHVB_STREAM = ^HVB_STREAM;
   PSHORT      = ^ShortInt;
   VB_ERR      = ULONG;

   PTVB_ALBUM_INFO_RECORD = ^TVB_ALBUM_INFO_RECORD;
   TVB_ALBUM_INFO_RECORD = packed record
      dwSize : DWORD;
      dwVersion : DWORD;

      strArtist : LPCSTR;
      strAlbum : LPCSTR;
      strTitle : LPCSTR;
      strComment : LPCSTR;

      dwTrackNumber : DWORD;
      dwTotalTracks : DWORD;

   // added in version 1
      strGenre : LPCSTR;
      strEncodedBy : LPCSTR;
      strDateTime : LPCSTR;
   end;

   PTVB_ALBUM_INFO = ^TVB_ALBUM_INFO;
   PPTVB_ALBUM_INFO = ^PTVB_ALBUM_INFO;
   TVB_ALBUM_INFO = packed record
      dwSize : DWORD;
      dwVersion : DWORD;

      dwRecords : DWORD;
      infoRecord : TVB_ALBUM_INFO_RECORD;
   end;

   PTVB_CONFIG = ^TVB_CONFIG;
   TVB_CONFIG = packed record
      dwConfig : DWORD;         // VB_CONFIG_XXXXX
                                // Currently only VB_CONFIG_MP3 is supported

     // STRUCTURE INFORMATION for Vorbis header version 1
      dwStructVersion : DWORD;
      dwStructSize : DWORD;

     // BASIC ENCODER SETTINGS
      dwChannels : DWORD;      // Number of channels
      dwSampleRate : DWORD;    // Sample rate of input file
      lMinBitRate : LongInt;   // Minimum bit rate, in bits per second
      lNomBitRate : LongInt;   // Nominal bit rate, in bits per second
      lMaxBitRate : LongInt;   // Maximum bit rate, in bits per second
      dwInfoMode  : DWORD;     // Vorbis Info Mode VB_MODE_A .. VB_MODE_F
      fQuality    : single;    // Quality Setting
      btReserved  : array[1..256 - 5 * sizeof(DWORD) - 3 * sizeof(LongInt) - 1 * sizeof(single)] of byte; // FUTURE USE, SET TO 0
   //   btReserved  : array[1..256-9*sizeof(DWORD)] of BYTE;	// FUTURE USE, SET TO 0
     // end of STRUCTURE INFORMATION for Vorbis header version 1 (VBV1);					//
   end;

//   PTVB_VERSION = ^TVB_VERSION;
   type TVB_VERSION = packed record
    // Vorbis DLL Version number
      byDLLMajorVersion : BYTE;
      byDLLMinorVersion : BYTE;

    // Vorbis Engine Version Number
      byMajorVersion : BYTE;
      byMinorVersion : BYTE;

    // DLL Release date
      byDay : BYTE;
      byMonth : BYTE;
      wYear : WORD;

    // Vorbis Homepage URL
     zHomepage : array[0..VB_MAX_HOMEPAGE] of char;
   end;

  // Vorbis Decoder Info struct
   PTVB_DEC_INFO = ^TVB_DEC_INFO;
   TVB_DEC_INFO = packed record
      dwStructSize : DWORD;
      dwStructVersion : DWORD;

      hStream :	HVB_STREAM;

      dwTotTime_in_ms : DWORD;
      dwCurTime_in_ms : DWORD;

      dwBufferSize : DWORD;

      nBitRate : LongInt;
      dwSampleRate : DWORD;
      dwChannels : DWORD;

      btReserved : array[1..256 - sizeof(DWORD)*9] of Char;
   end;

var
  // GENERAL EXPORT FUNCTIONS
   vbVersion : procedure(var VB_VERSION : TVB_VERSION); cdecl;

  // ENCODER SPECIFIC EXPORT FUNCTIONS
   vbEncOpen : function(pvbConfig : PTVB_CONFIG;
		        pAlbumInfo : PTVB_ALBUM_INFO;
		        var dwSamples : DWORD;
		        var dwBufferSize : DWORD;
		        var hbeStream : HVB_STREAM) : VB_ERR ; cdecl;

   vbEncWrite : function(hbeStream : HVB_STREAM;
		         nSamples : DWORD;
		         pSamples : PSHORT;
		         pOutput : PBYTE;
		         var pdwOutput : DWORD) : VB_ERR; cdecl;

   vbEncClose : function(hbeStream : HVB_STREAM;
 		         pOutput : PBYTE;
		         var pdwOutput : DWORD) : VB_ERR; cdecl;

  // DECODER SPECIFIC EXPORT FUNCTIONS
   vbDecOpen : function(pvbDecInfo : PTVB_DEC_INFO;
		        ppAlbumInfo : PPTVB_ALBUM_INFO;
	                pszFileName : LPCSTR) : VB_ERR; cdecl;

   vbDecRead : function(pvbDecInfo : PTVB_DEC_INFO;
		        pOutBuffer : PBYTE;
		        var pdwBytesOut : Integer) : VB_ERR; cdecl;

   vbDecSeek : function(pvbDecInfo : PTVB_DEC_INFO;
		        dwSeekTime_in_ms : DWORD) : VB_ERR; cdecl;

   vbDecClose : function(pvbDecInfo : PTVB_DEC_INFO) : VB_ERR; cdecl;

   function VorbisDllLoaded : Boolean;
   function VorbisDLLVersionStr : string;
   function RequestDLLLoading: Boolean;

implementation

var
     VorbisEncDLL : THANDLE = 0;

function RequestDLLLoading: Boolean;
begin
   if (VorbisEncDLL = 0) then
   begin
      VorbisEncDLL := LoadLibrary('lib\Vorbis.DLL');
      if (VorbisEncDLL <> 0) then
      begin
         @vbEncOpen   := GetProcAddress(VorbisEncDLL,'vbEncOpen');
         @vbEncWrite  := GetProcAddress(VorbisEncDLL,'vbEncWrite');
         @vbEncClose  := GetProcAddress(VorbisEncDLL,'vbEncClose');
         @vbDecOpen   := GetProcAddress(VorbisEncDLL,'vbDecOpen');
         @vbDecRead   := GetProcAddress(VorbisEncDLL,'vbDecRead');
         @vbDecSeek   := GetProcAddress(VorbisEncDLL,'vbDecSeek');
         @vbDecClose  := GetProcAddress(VorbisEncDLL,'vbDecClose');
         @vbVersion   := GetProcAddress(VorbisEncDLL,'vbVersion');
      end;
   end;
   Result := (VorbisEncDLL <> 0);
end;

function VorbisDllLoaded : Boolean;
begin
   VorbisDllLoaded := (VorbisEncDLL <> 0);
end;

function VorbisDLLVersionStr : string;
var
   vbVersionInfo : TVB_VERSION;
   tmpDLLMinorStr, tmpMinorStr : string;
begin
   if VorbisDLLLoaded then
   begin
      vbVersion(vbVersionInfo);

      if vbVersionInfo.byDLLMinorVersion < 10 then
         tmpDLLMinorStr := '0' + intToStr(vbVersionInfo.byDLLMinorVersion)
      else
         tmpDLLMinorStr := intToStr(vbVersionInfo.byDLLMinorVersion);

      if vbVersionInfo.byMinorVersion < 10 then
         tmpMinorStr := '0' + intToStr(vbVersionInfo.byMinorVersion)
      else
         tmpMinorStr := intToStr(vbVersionInfo.byMinorVersion);

      result := 'Ver '
                + intToStr(vbVersionInfo.byDLLMajorVersion) + '.'
                + tmpDLLMinorStr
                + ' (Engine Ver : '
                + intToStr(vbVersionInfo.byMajorVersion) + '.'
                + tmpMinorStr
                + ', Date : '
                + intToStr(vbVersionInfo.wYear) + '-'
                + intToStr(vbVersionInfo.byMonth) + '-'
                + intToStr(vbVersionInfo.byDay) + ')';
   end else
      result := '';
end;

initialization
//   RequestDLLLoading;
finalization
   if (VorbisEncDLL <> 0) then
      FreeLibrary(VorbisEncDLL);


end.
