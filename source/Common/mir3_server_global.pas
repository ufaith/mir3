unit mir3_server_global;

interface

uses Windows, Messages, Classes, SysUtils, StrUtils, SyncObjs,
     mir3_global_config, JSocket;

const
  GATE_LOG_PATH      = 'Log\';
  GATE_CONFIG_PATH   = 'Config\';
  GATE_MAX_SESSION   = 10000;

type
  TProgamType    = (ptDBServer  , ptLoginSrv, ptLogServer, ptM3Server, ptLoginGate,
                    ptLoginGate1, ptSelGate , ptSelGate1 , ptRunGate , ptRunGate1,
                    ptRunGate3  , ptRunGate4, ptRunGate5 , ptRunGate6, ptRunGate7, ptRunGate2);
  TBlockIPMethod = (mDisconnect, mBlock, mBlockList, mBlockText);

type
  { TProgram }
  PProgram = ^TProgram;
  TProgram = record
    prGetStart       : Boolean;
    prReStart        : Boolean;
    prStartStatus    : Byte;
    prProgramFile    : String[50];
    prDirectory      : String[100];
    prProcessInfo    : TProcessInformation;
    prProcessHandle  : THandle;
    prMainFormHandle : THandle;
    prMainFormX      : Integer;
    prMainFormY      : Integer;
  end;

  { TSockAddr }
  PSockAddr = ^TSockAddr;
  TSockAddr = record
    saIPaddr          : Integer;
    saAttackCount     : Integer;
    saStartAttackTick : LongWord;
    saSocketHandle    : Integer;
  end;

  { TUserSession }
  PUserSession = ^TUserSession;
  TUserSession = record
    usSocket           : TCustomWinSocket;
    usRemoteIPaddr     : string;
    usSendMsgLen       : Integer;
    usReviceMsgLen     : Integer;
    usSendLock         : Boolean;
    us10Tick           : LongWord;
    usCheckSendLength  : Integer;
    usSendAvailable    : Boolean;
    usSendCheck        : Boolean;
    usSendLockTimeOut  : LongWord;
    usMessageLen       : Integer;
    usUserTimeOutTick  : LongWord;
    usSocketHandle     : Integer;
    usIP               : string;
    usMessageList      : TStringList;
    usConnctCheckTick  : LongWord;
    usReceiveTick      : LongWord;
    usReceiveTimeTick  : LongWord;
    usReliefenbao      : Integer;
    usReceiveMsgTick   : LongWord;
  end;
  TSessionArray = array[0..GATE_MAX_SESSION - 1] of TUserSession;

 (****************************************************
  *        Gate Configuration Records                *
  ****************************************************)

  { TConfig_Login_Gate }
  PConfig_Login_Gate = ^TConfig_Login_Gate;
  TConfig_Login_Gate = packed record
   {Service Option}                    // Default Settings
   cfPos_X              : Integer;     // 10 fix me
   cfPos_Y              : Integer;     // 10 fix me
   cfStartMinimized     : Boolean;     // True
   cfLogLevel           : Byte;        // 10
   {Network Option}     
   cfGate_Address       : String[20];  // 127.0.0.1
   cfGate_Port          : Integer;     // 7000
   cfServer_Address     : String[20];  // 127.0.0.1
   cfServer_Port        : Integer;     // 5500
   {Internal Option}
   cfBlockMethod        : Byte;        // {0} mDisconnect
   cfKeepConnectTimeOut : DWord;       // 60000
   cfAttackLevel        : Word;        // 1
   cfMaxMessageLen      : Word;        // 800
   cfMaxConnectOfIPAddr : Word;        // 20
   cfReliefDefendUse    : Boolean;     // False
   cfReliefDefendTime   : Word;        // 120
   cfMessageLenBlock    : Word;        // 371          g_boReliefenbao
   cfDefendLevelUse     : Boolean;     // False
   cfDefendLevel        : Word;        // 0
   cfDefendLevelCount   : Word;        // 3
   cfClearTempListUse   : Boolean;     // False   
   cfClearTempList      : Word;        // 120
  end;
  
  { TConfig_SelectChar_Gate }
  PConfig_SelectChar_Gate = ^TConfig_SelectChar_Gate;
  TConfig_SelectChar_Gate = packed record
   {Service Option}                    // Default Settings
   cfPos_X              : Integer;     // 10 fix me
   cfPos_Y              : Integer;     // 10 fix me
   cfStartMinimized     : Boolean;     // True
   cfLogLevel           : Byte;        // 3
   {Network Option}     
   cfGate_Address       : String[20];  // 127.0.0.1
   cfGate_Port          : Integer;     // 7101
   cfServer_Address     : String[20];  // 127.0.0.1
   cfServer_Port        : Integer;     // 5100
   {Internal Option}
   cfBlockMethod        : Byte;        // {0} mDisconnect
   cfKeepConnectTimeOut : DWord;       // 120000
   cfAttackLevel        : Word;        // 1
   cfMaxMessageLen      : Word;        // 800
   cfMaxConnectOfIPAddr : Word;        // 20
   cfReliefDefendUse    : Boolean;     // False
   cfReliefDefendTime   : Word;        // 120
   cfMessageLenBlock    : Word;        // 408          g_boReliefenbao
   cfDefendLevelUse     : Boolean;     // True
   cfDefendLevel        : Word;        // 0
   cfDefendLevelCount   : Word;        // 3
   cfClearTempListUse   : Boolean;     // True
   cfClearTempList      : Word;        // 120
  end;

  { TConfig_Run_Game_Gate }
  PConfig_Run_Game_Gate = ^TConfig_Run_Game_Gate;
  TConfig_Run_Game_Gate = packed record
   {Service Option}                    // Default Settings
   cfPos_X              : Integer;     // 10 fix me
   cfPos_Y              : Integer;     // 10 fix me
   cfStartMinimized     : Boolean;     // True
   cfLogLevel           : Byte;        // 2
   {Network Option}     
   cfGate_Address       : String[20];  // 127.0.0.1
   cfGate_Port          : Integer;     // 7201
   cfServer_Address     : String[20];  // 127.0.0.1
   cfServer_Port        : Integer;     // 5000
   {Internal Option}
   
   {Speed Option}   
   
  end;  
  
 (****************************************************
  *        Server Configuration Records              *
  ****************************************************)
  
  { TConfig_Login_Server }
  PConfig_Login_Server = ^TConfig_Login_Server;
  TConfig_Login_Server = packed record
   {Service Option}                    // Default Settings
   cfPos_X              : Integer;     // 10 fix me
   cfPos_Y              : Integer;     // 10 fix me
   cfStartMinimized     : Boolean;     // True
   cfLogLevel           : Byte;        // 2
   {Network Option}     
   cfGate_Address       : String[20];  // 127.0.0.1
   cfGate_Port          : Integer;     // 5500
   cfServer_Address     : String[20];  // 127.0.0.1
   cfServer_Port        : Integer;     // 5600
   cfDBServer_Address   : String[20];  // 127.0.0.1
   cfDBServer_Port      : Integer;     // 16300
   cfLogServer_Address  : String[20];  // 127.0.0.1
   cfLogServer_Port     : Integer;     // 16301
   {Internal Option}
   cfCharReplaceWord    : String[1];   // *
   {DB Setup Option}
   cfDBType             : Byte;        // dbtMSSQL
   cfSQLAddress         : String[50];  // (local)
   cfSQLUserName        : String[50];  // sa   
   cfSQLPassword        : String[50];  // sa
   cfDataBaseName       : String[50];  // LomCN_MIR3_V1   
  end;
  
  { TConfig_DataBase_Server }
  PConfig_DataBase_Server = ^TConfig_DataBase_Server;
  TConfig_DataBase_Server = packed record
   {Service Option}                    // Default Settings
   cfPos_X              : Integer;     // 10 fix me
   cfPos_Y              : Integer;     // 10 fix me
   cfStartMinimized     : Boolean;     // True
   cfLogLevel           : Byte;        // 2
   {Network Option}     
   cfGate_Address       : String[20];  // 127.0.0.1
   cfGate_Port          : Integer;     // 5100
   cfServer_Address     : String[20];  // 127.0.0.1
   cfServer_Port        : Integer;     // 6000
   {DB Setup Option}
   cfDBType             : Byte;        // dbtMSSQL
   cfSQLAddress         : String[50];  // (local)
   cfSQLUserName        : String[50];  // sa   
   cfSQLPassword        : String[50];  // sa
   cfDataBaseName       : String[50];  // LomCN_MIR3_V1     
  end;

  { TConfig_Log_Server }
  PConfig_Log_Server = ^TConfig_Log_Server;
  TConfig_Log_Server = packed record
   {Service Option}                    // Default Settings
   cfPos_X              : Integer;     // 10 fix me
   cfPos_Y              : Integer;     // 10 fix me
   cfStartMinimized     : Boolean;     // True
   cfLogLevel           : Byte;        // 2
   {Network Option}     
   cfServer_Address     : String[20];  // 127.0.0.1
   cfServer_Port        : Integer;     // 10000   
  end;  
  
  { TConfig_Game_Server }
  PConfig_Game_Server = ^TConfig_Game_Server;
  TConfig_Game_Server = packed record
   {Service Option}                    // Default Settings
   cfPos_X              : Integer;     // 10 fix me
   cfPos_Y              : Integer;     // 10 fix me
   cfStartMinimized     : Boolean;     // True
   cfLogLevel           : Byte;        // 2
   cfServerName         : String[50];  // TestServer
   {Network Option}     
   cfGate_Address       : String[20];  // 127.0.0.1
   cfGate_Port          : Integer;     // 5000       
   cfDBServer_Address   : String[20];  // 127.0.0.1
   cfDBServer_Port      : Integer;     // 6000
   cfLogServer_Address  : String[20];  // 127.0.0.1
   cfLogServer_Port     : Integer;     // 10000
   cfMsgServer_Address  : String[20];  // 127.0.0.1
   cfMsgServer_Port     : Integer;     // 4900
   {DB Setup Option}
   cfDBType             : Byte;        // dbtMSSQL
   cfSQLAddress         : String[50];  // (local)
   cfSQLUserName        : String[50];  // sa   
   cfSQLPassword        : String[50];  // sa
   cfDataBaseName       : String[50];  // LomCN_MIR3_V1     
   
  end;

  { TConfig_Game_Server }
  PConfig_Administration = ^TConfig_Administration;
  TConfig_Administration = packed record
  end;

  
  
 (****************************************************
  *        Help Classes and functions                *
  ****************************************************)  
  
type
  TLockableList = class(TList)
  private
    FLock: TRTLCriticalSection;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Lock;
    procedure UnLock;
  end;

  TFileEngine = class
  public
    FBlockIPList  : TLockableList;
    FBlockIPText  : TLockableList;
  public
    constructor Create;
    destructor Destroy; override;
    procedure LoadFilterList;
    procedure SaveFilterList;
  end;

var
  CSGateMain              : TCriticalSection;
  GBlockMethod            : TBlockIPMethod = mBlock;
  GServerName             : String    = 'TestServer';
  GShowLogLevel           : Integer   = 10;
  GSendMessageCount       : Integer   = 0;
  GMessageCount           : Integer   = 0;
  GActiveConnection       : Integer   = 0;  
  GMaxConnOfIPaddr        : Integer   = 20;
  GMaxMessageLen          : Integer   = 800;
  GMaxClientMsgCount      : Integer   = 1;
  GAttackLevel            : Integer   = 1;
  GAttackCount            : Integer   = 5;
  GAttackTime             : LongWord  = 100;
  GAttackTick             : LongWord  = 0;
  GSendHoldTick           : LongWord;
  GKeepAliveTick          : LongWord;
  GKeepConnectTimeOut     : LongWord  = 120000;
  GChgDefendLevel         : Boolean   = True;
  GChgDefendLevelInt      : Integer   = 3;
  GReliefenbao            : Boolean   = True;
  GReliefenbaoInt         : LongWord  = 400;
  GReliefDefend           : Boolean   = True;
  GReliefDefendInt        : LongWord  = 120;
  GClearTempList          : Boolean   = True;
  GClearTempListInt       : LongWord  = 120;
  GDisableDynamicIPMode   : Boolean   = False;
  GSendHoldTimeOut        : Boolean   = False;
  GKeepAliveTimeOut       : Boolean   = False;
  GGateReady              : Boolean   = False;
  GCloseGate              : Boolean   = False;
  GGateStarted            : Boolean   = False;
  GServiceStart           : Boolean   = False;
  GMinimize               : Boolean   = True;
  GDecodeLock             : Boolean   = False;
  { Lists }
  GLogMessageList         : TStringList;
  GDataFilterList         : TStringList;
  GCurrentIPAddrList      : TLockableList;
  GBlockIPList            : TLockableList;
  GBlockIPText            : TLockableList;
  GTempBlockIPList        : TLockableList;
  GAttackIPaddrList       : TLockableList;
  { Gate / Server Network }
  GServerPort             : Integer = 5500;
  GServerAddr             : String = '127.0.0.1';
  GGatePort               : Integer = 7000;
  GGateAddr               : String = '0.0.0.0';
  { Game Center }
  GInfo_NowStartGate      : String = 'Start %s Gate...';
  GInfo_NowStartOK        : String = ' Gate Start OK..';


{Global Functions}
  procedure LogMessage(AMessage: String; AMessageLevel: Integer);
  procedure SendControlCenterMessage(AIdent: Word; AMessage: String);
  function TestIPAddr(AIP: String): Boolean;
  function CharCount(ASource: string; ATag: Char): Integer;
  function ArrestStringEx(Source, SearchAfter, ArrestBefore: string; var ArrestStr: string): String;
  function GetValidStr3(Str: string; var Dest: string; const Divider: array of Char): String;

implementation

{$REGION ' - TLockableList  '}
  constructor TLockableList.Create;
  begin
    inherited Create;
    InitializeCriticalSection(FLock);
  end;

  destructor TLockableList.Destroy;
  begin
    DeleteCriticalSection(FLock);
    inherited;
  end;
  
  procedure TLockableList.Lock;
  begin
    EnterCriticalSection(FLock);
  end;
  
  procedure TLockableList.UnLock;
  begin
    LeaveCriticalSection(FLock);
  end;

{$ENDREGION}


constructor TFileEngine.Create;
begin
  inherited Create;
  FBlockIPList  := TLockableList.Create;
  FBlockIPText  := TLockableList.Create;
end;

destructor TFileEngine.Destroy;
begin
  if Assigned(FBlockIPList) then
    FreeAndNil(FBlockIPList);
  if Assigned(FBlockIPText) then
    FreeAndNil(FBlockIPText);
  inherited;
end;

procedure TFileEngine.LoadFilterList;
begin

end;

procedure TFileEngine.SaveFilterList;
begin

end;

procedure LogMessage(AMessage: String; AMessageLevel: Integer);
var
  FMessage: string;
begin
  try
    CSGateMain.Enter;
    if AMessageLevel <= GShowLogLevel then
    begin
      FMessage := '[' + TimeToStr(Now) + '] ' + AMessage;
      GLogMessageList.Add(FMessage);
    end;
  finally
    CSGateMain.Leave;
  end;
end;

procedure SendControlCenterMessage(AIdent: Word; AMessage: String);
var
  FData  : TCopyDataStruct;
  FParam : Integer;
begin
  FParam       := MakeLong(Word(ptLoginGate), AIdent);
  FData.cbData := Length(AMessage) + 1;
  GetMem(FData.lpData, FData.cbData);
  StrCopy(FData.lpData, PChar(AMessage));
  SendMessage(GGameCenterHandle, WM_COPYDATA, FParam, Cardinal(@FData));
  FreeMem(FData.lpData);
end;

function TestIPAddr(AIP: String): Boolean;
var
  FNodeArray : array[0..3] of Integer;
  FIP        : String;
  FNode      : String;
  FPos       : Integer;
  FLen       : Integer;
begin
  Result := False;
  FIP    := AIP;
  FLen   := Length(FIP);
  FPos   := Pos('.', FIP);
  FNode  := MidStr(FIP, 1, FPos - 1);
  FIP    := MidStr(FIP, FPos + 1, FLen - FPos);
  if not TryStrToInt(FNode, FNodeArray[0]) then Exit;

  FLen  := Length(FIP);
  FPos  := Pos('.', FIP);
  FNode := MidStr(FIP, 1, FPos - 1);
  FIP   := MidStr(FIP, FPos + 1, FLen - FPos);
  if not TryStrToInt(FNode, FNodeArray[1]) then Exit;

  FLen  := Length(FIP);
  FPos  := Pos('.', FIP);
  FNode := MidStr(FIP, 1, FPos - 1);
  FIP   := MidStr(FIP, FPos + 1, FLen - FPos);
  if not TryStrToInt(FNode, FNodeArray[2]) then Exit;

  if not TryStrToInt(FIP, FNodeArray[3]) then Exit;
  for FLen := Low(FNodeArray) to High(FNodeArray) do
  begin
    if (FNodeArray[FLen] < 0) or (FNodeArray[FLen] > 255) then Exit;
  end;
  Result := True;
end;

function CharCount(ASource: string; ATag: Char): Integer;
var
   i: Integer;
begin
   Result := 0;
   for i:=1 to Length(ASource) do
      if ASource[i] = ATag then
         Inc (Result);
end;

function ArrestStringEx(Source, SearchAfter, ArrestBefore: string; var ArrestStr: string): string;
var
 srclen: Integer;
  GoodData, fin: Boolean;
  I, N: Integer;
begin
  ArrestStr := ''; {result string}
  if Source = '' then begin
    Result := '';
    Exit;
  end;

  try
    srclen := Length(Source);
    GoodData := False;
    if srclen >= 2 then
      if Source[1] = SearchAfter then begin
        Source := Copy(Source, 2, srclen - 1);
        srclen := Length(Source);
        GoodData := True;
      end else begin
        N := Pos(SearchAfter, Source);
        if N > 0 then begin
          Source := Copy(Source, N + 1, srclen - (N));
          srclen := Length(Source);
          GoodData := True;
        end;
      end;
    fin := False;
    if GoodData then begin
      N := Pos(ArrestBefore, Source);
      if N > 0 then begin
        ArrestStr := Copy(Source, 1, N - 1);
        Result := Copy(Source, N + 1, srclen - N);
      end else begin
        Result := SearchAfter + Source;
      end;
    end else begin
      for I := 1 to srclen do begin
        if Source[I] = SearchAfter then begin
          Result := Copy(Source, I, srclen - I + 1);
          Break;
        end;
      end;
    end;
  except
    ArrestStr := '';
    Result := '';
  end;
end;

function GetValidStr3(Str: string; var Dest: string; const Divider: array of Char): String;
const
  BUF_SIZE = 30000; //$7FFF;
var
  buf: array[0..BUF_SIZE] of  Char;
  BufCount, Count, srclen, I, ArrCount: LongInt;
  Ch: Char;
label
  CATCH_DIV;
begin
  Ch := #0; //Jacky
  try
    srclen := Length(Str);
    BufCount := 0;
    Count := 1;

    if srclen >= BUF_SIZE - 1 then begin
      Result := '';
      Dest := '';
      Exit;
    end;

    if Str = '' then begin
      Dest := '';
      Result := Str;
      Exit;
    end;
    ArrCount := SizeOf(Divider) div SizeOf(Char);

    while True do begin
      if Count <= srclen then begin
        Ch := Str[Count];
        for I := 0 to ArrCount - 1 do
          if Ch = Divider[I] then
            goto CATCH_DIV;
      end;
      if (Count > srclen) then begin
        CATCH_DIV:
        if (BufCount > 0) then begin
          if BufCount < BUF_SIZE - 1 then begin
            buf[BufCount] := #0;
            Dest := string(buf);
            Result := Copy(Str, Count + 1, srclen - Count);
          end;
          Break;
        end else begin
          if (Count > srclen) then begin
            Dest := '';
            Result := Copy(Str, Count + 2, srclen - 1);
            Break;
          end;
        end;
      end else begin
        if BufCount < BUF_SIZE - 1 then begin
          buf[BufCount] := Ch;
          Inc(BufCount);
        end; // else
        //ShowMessage ('BUF_SIZE overflow !');
      end;
      Inc(Count);
    end;
  except
    Dest := '';
    Result := '';
  end;
end;

function StartGameService(var AProgramInfo: TProgram; AHandle: String; AWaitTime: LongWord): LongWord;
var
  FStartupInfo  : TStartupInfo;
  FCommandLine  : String;
  FCurDirectory : String;
begin
  Result := 0;
  FillChar(FStartupInfo, SizeOf(TStartupInfo), #0);
  GetStartupInfo(FStartupInfo);
  FCommandLine  := Format('%s%s %s %d %d', [AProgramInfo.prDirectory, AProgramInfo.prProgramFile, AHandle, AProgramInfo.prMainFormX, AProgramInfo.prMainFormY]);
  FCurDirectory := AProgramInfo.prDirectory;
  if not CreateProcess(nil, PChar(FCommandLine), nil, nil, True, 0, nil, PChar(FCurDirectory), FStartupInfo, AProgramInfo.prProcessInfo) then
  begin
    Result := GetLastError();
  end;
  Sleep(AWaitTime);
end;

function StopGameService(var AProgramInfo: TProgram; AWaitTime: LongWord): Integer;
var
  FExitCode: LongWord;
begin
  Result := 0;
  if TerminateProcess(AProgramInfo.prProcessHandle, FExitCode) then
  begin
    Result := GetLastError();
  end;
  Sleep(AWaitTime);
end;




procedure IntialServerGlobal;
begin
  if not DirectoryExists('.\Config') then
    MkDir('.\Config');
  if not DirectoryExists('.\Log') then
    MkDir('.\Log');
  CSGateMain      := TCriticalSection.Create;
  GLogMessageList := TStringList.Create;
end;

procedure DeintialServerGlobal;
begin
  FreeAndNil(CSGateMain);
  if Assigned(GLogMessageList) then
  begin
    GLogMessageList.Clear;
    FreeAndNil(GLogMessageList);
  end;
end;

initialization
  IntialServerGlobal;

finalization
  DeintialServerGlobal;

end.
