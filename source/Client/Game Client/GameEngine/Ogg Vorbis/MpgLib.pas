unit MpgLib;

interface

uses Windows;

const
   MPGLIB_ERROR     = -1;
   MPGLIB_OK        = 0;
   MPGLIB_NEED_MORE = 1;

type
   MPGLIB_ERR = integer;
   H_STREAM   = integer;
var
   MpgLib_OpenStream  : function(var hStream : H_STREAM) : MPGLIB_ERR; cdecl;
   MpgLib_DecodeChunk : function(hStream : H_STREAM;
                                 pInStream : PBYTE;
                                 nInSize : integer;
                                 pOutStream : PBYTE;
                                 nOutSize : integer;
                                 var pnOutBytes : integer) : MPGLIB_ERR; cdecl;
   MpgLib_CloseStream : function(hStream : H_STREAM) : MPGLIB_ERR; cdecl;
   MpgLib_Version     : procedure(lpszVersionString : PChar; nSize : integer); cdecl;
   MpgLib_GetBitRate  : function  : integer; cdecl;
   MpgLib_Flush       : function  : integer; cdecl;   // for new version of MPGLIB.DLL

function RequestDLLLoading: Boolean;

implementation

var
     MPGLibDLL : THANDLE = 0;

function RequestDLLLoading: Boolean;
begin
   if (MPGLibDLL = 0) then
   begin
      MPGLibDLL := LoadLibrary('lib\MPGLib.DLL');
      if (MPGLibDLL <> 0) then
      begin
         @MpgLib_OpenStream   := GetProcAddress(MPGLibDLL, 'MpgLib_OpenStream');
         @MpgLib_DecodeChunk  := GetProcAddress(MPGLibDLL, 'MpgLib_DecodeChunk');
         @MpgLib_CloseStream  := GetProcAddress(MPGLibDLL, 'MpgLib_CloseStream');
         @MpgLib_Version      := GetProcAddress(MPGLibDLL, 'MpgLib_Version');
         @MpgLib_GetBitRate   := GetProcAddress(MPGLibDLL, 'MpgLib_GetBitRate');
         @MpgLib_Flush        := GetProcAddress(MPGLibDLL, 'MpgLib_Flush');
      end;
   end;
   Result := (MPGLibDLL <> 0);
end;

initialization
finalization
   if (MPGLibDLL <> 0) then
      FreeLibrary(MPGLibDLL);

end.
