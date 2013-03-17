unit unLoginMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, WinSock,
  Dialogs, RzDBStat, RzTray, RzStatus, RzPanel, JSocket, ExtCtrls, RzBorder, IniFiles,
  Menus, StdCtrls, mir3_server_global, mir3_global_config, mir3_game_en_decode, unGateConfig,
  ImgList, unConfigEngine;

type
  TfrmLoginGate = class(TForm)
    RzPanel1: TRzPanel;
    Image1: TImage;
    plInfoBackground: TRzPanel;
    RzStatusBar1: TRzStatusBar;
    RzVersionInfoStatus1: TRzVersionInfoStatus;
    LoginGateVersionInfo: TRzVersionInfo;
    triLoginGate: TRzTrayIcon;
    spStatus: TRzDBStatusPane;
    ProgressDisplay: TRzProgressDisplay;
    MainMenu1: TMainMenu;
    GateControl1: TMenuItem;
    MENU_CONTROL_START: TMenuItem;
    MENU_CONTROL_STOP: TMenuItem;
    N1: TMenuItem;
    ReconnectGateService1: TMenuItem;
    laActiveConnectionInfo: TLabel;
    laMessageCountInfo: TLabel;
    N2: TMenuItem;
    QuitGate1: TMenuItem;
    Logging1: TMenuItem;
    ClearLog1: TMenuItem;
    ActivateLogging1: TMenuItem;
    pmTryIcon: TPopupMenu;
    CloseLoginGate1: TMenuItem;
    N3: TMenuItem;
    ShowLoginGate1: TMenuItem;
    HideLoginGate1: TMenuItem;
    SendToServer: TTimer;
    laActiveConnection: TLabel;
    laMessageCount: TLabel;
    Option1: TMenuItem;
    GateOption1: TMenuItem;
    DecodeTimer: TTimer;
    GateToServer: TTimer;
    spInfo: TRzDBStatusPane;
    N4: TMenuItem;
    StartLoginServiceGate1: TMenuItem;
    StopLoginServiceGate1: TMenuItem;
    StartTimer: TTimer;
    laDecodeTime: TLabel;
    Label2: TLabel;
    Label1: TLabel;
    laAttaccount: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure ShowLoginGate1Click(Sender: TObject);
    procedure CloseLoginGate1Click(Sender: TObject);
    procedure HideLoginGate1Click(Sender: TObject);
    procedure SendToServerTimer(Sender: TObject);
    procedure MENU_CONTROL_STARTClick(Sender: TObject);
    procedure GateOption1Click(Sender: TObject);
    procedure DecodeTimerTimer(Sender: TObject);
    procedure GateToServerTimer(Sender: TObject);
    procedure MENU_CONTROL_STOPClick(Sender: TObject);
    procedure QuitGate1Click(Sender: TObject);
    procedure StartLoginServiceGate1Click(Sender: TObject);
    procedure StopLoginServiceGate1Click(Sender: TObject);
    procedure StartTimerTimer(Sender: TObject);
  private
    FLoginServer       : TServerSocket;
    FLoginClient       : TClientSocket;
    FSocketMessageList : TStringList;
    FTempLogList       : TStringList;
    FSessionArray      : TSessionArray;
    FSessionCount      : Integer;
    FServerReady       : Boolean;
    FShowLocked        : Boolean;
    FShowMainLogTick   : LongWord;
    FGateToServerTick  : LongWord;
    FSendKeepAliveTick : LongWord;
    FDecodeMsgTime     : LongWord;
    FProcMsg           : String;
  private
    { Gate Service Funtion }
    procedure StartGateService;
    procedure StopGateService;
    procedure LoadGateConfiguration;
    procedure ShowMainLogMessages;
    function SendUserMessage(AUserSession: PUserSession; ASendMessage: String): Integer;
    { Network Function }
    procedure CloseConnection(AIPaddr: String);
    procedure ClientConnect(Sender: TObject; Socket: TCustomWinSocket);
    procedure ClientDisconnect(Sender: TObject; Socket: TCustomWinSocket);
    procedure ClientError(Sender: TObject; Socket: TCustomWinSocket;  ErrorEvent: TErrorEvent; var ErrorCode: Integer);
    procedure ClientRead(Sender: TObject; Socket: TCustomWinSocket);
    procedure ServerClientConnect(Sender: TObject; Socket: TCustomWinSocket);
    procedure ServerClientDisconnect(Sender: TObject; Socket: TCustomWinSocket);
    procedure ServerClientError(Sender: TObject; Socket: TCustomWinSocket; ErrorEvent: TErrorEvent; var ErrorCode: Integer);
    procedure ServerClientRead(Sender: TObject; Socket: TCustomWinSocket);
    { Session Function }
    procedure ResetUserSessionArray;
    procedure SetupUserSessionArray;
    procedure CloseUserSessionArray(ASockedHandle: Integer);
    function CloseSocketAndGetIPAddr(ASocketHandle: Integer): String;
    procedure CloseAllUserSessionArray;
    { Test Function }
    function TestIsBlockIP(AIPaddr: String): Boolean;
    function TestIsConnLimited(AIPaddr: String; ASocketHandle: Integer): Boolean;
    function TestIsAttAck(AMessage: String): Boolean;
    { Add Function }
    function AddAttackIP(AIPaddr: String): Boolean;
    function AddBlockIP(AIPaddr: String): Integer;
    function AddBlockIPText(AIPaddr: String): Integer;
    function AddTempBlockIP(AIPaddr: String): Integer;
    { Message Communictaion Function }
    procedure CenterMessage(var Message: TWMCopyData); Message WM_COPYDATA;
  end;

var
  frmLoginGate: TfrmLoginGate;


implementation

{$R *.dfm}

  {$REGION ' - TfrmLoginGate Form Functions '}
    procedure TfrmLoginGate.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    begin
      if GCloseGate then Exit;
      if Application.MessageBox('Would you stop the server and exit?',
        'Close Login Gate', MB_YESNO + MB_ICONQUESTION) = IDYES then
      begin
        if GServiceStart then
        begin
          StartTimer.Enabled := True;
          CanClose           := False;
        end;
      end else CanClose := False;
    end;
    
    procedure TfrmLoginGate.FormCreate(Sender: TObject);
    var
      FX, FY : Integer;
    begin
      { For Game Center Software Using }
      GGameCenterHandle := StrToIntDef(ParamStr(1), 0);
      if GGameCenterHandle <> 0 then
      begin
        FX := StrToIntDef(ParamStr(2), -1);
        FY := StrToIntDef(ParamStr(3), -1);
        if (FX >= 0) or (FY >= 0) then
        begin
          Left := FX;
          Top  := FY;
        end;
        SendControlCenterMessage(SG_FORM_HANDLE, IntToStr(Self.Handle));
      end;
    
      { Setup Client and Server Socket }
      FLoginServer := TServerSocket.Create(nil);
      with FLoginServer do
      begin
        OnClientConnect    := ServerClientConnect;
        OnClientDisconnect := ServerClientDisconnect;
        OnClientRead       := ServerClientRead;
        OnClientError      := ServerClientError;
      end;
    
      FLoginClient := TClientSocket.Create(nil);
      with FLoginClient do
      begin
        OnConnect    := ClientConnect;
        OnDisconnect := ClientDisconnect;
        OnRead       := ClientRead;
        OnError      := ClientError;
      end;

      FTempLogList       := TStringList.Create;
      FSocketMessageList := TStringList.Create;
      SetupUserSessionArray;
    end;
    
    procedure TfrmLoginGate.FormDestroy(Sender: TObject);
    var
      FIndex : Integer;
    begin
      if Assigned(FLoginClient) then
        FreeAndNil(FLoginClient);
      if Assigned(FLoginServer) then
        FreeAndNil(FLoginServer);
      if Assigned(FSocketMessageList) then
        FreeAndNil(FSocketMessageList);

      if Assigned(FTempLogList) then
      begin
        FTempLogList.Clear;
        FreeAndNil(FTempLogList);
      end;
    
      for FIndex := 0 to GATE_MAX_SESSION - 1 do
      begin
        FSessionArray[FIndex].usMessageList.Free;
      end;
    end;

{$ENDREGION}

/////////////// Main Menue Function///////////////////////////////////////////

procedure TfrmLoginGate.MENU_CONTROL_STARTClick(Sender: TObject);
begin
  StartGateService;
end;

procedure TfrmLoginGate.MENU_CONTROL_STOPClick(Sender: TObject);
begin
  StopGateService;
end;

procedure TfrmLoginGate.QuitGate1Click(Sender: TObject);
begin
  Close;
end;

procedure TfrmLoginGate.GateOption1Click(Sender: TObject);
begin
  frmGateConfig.Top  := Self.Top + 20;
  frmGateConfig.Left := Self.Left;
  with frmGateConfig do
  begin
    meGateIP.Text         := GGateAddr;
    meGatePort.Text       := IntToStr(GGatePort);
    meServerIP.Text       := GServerAddr;
    meServerPort.Text     := IntToStr(GServerPort);
    meServerName.Text     := GServerName;
    laLogLevel.Caption    := IntToStr(GShowLogLevel);
    tbLogLevel.Position   := GShowLogLevel;
    cbMinimizeApp.Checked := GMinimize;
    meKeepConTimeOut.Text := IntToStr(GKeepConnectTimeOut);
    meMaxConIP.Text       := IntToStr(GMaxConnOfIPaddr);
    meMaxMessageLen.Text  := IntToStr(GMaxMessageLen);
  end;
  frmGateConfig.ShowModal;
end;

procedure TfrmLoginGate.GateToServerTimer(Sender: TObject);
var
  I: Integer;
begin
  if FLoginServer.Active then
  begin
    if GClearTempList then
    begin
      if GetTickCount - GAttackTick > 1000 * GClearTempListInt then
      begin
        GAttackCount := 0;
        if GTempBlockIPList <> nil then
        begin
          GTempBlockIPList.Lock;
          try
            for I := 0 to GTempBlockIPList.Count - 1 do
            begin
              Dispose(PSockAddr(GTempBlockIPList.Items[I]));
            end;
            GTempBlockIPList.Clear;
          finally
            GTempBlockIPList.UnLock;
          end;
        end;
      end;
    end;

    if GAttackCount > 0 then
    begin
      laAttaccount.Caption := IntToStr(GAttackCount);
    end;

    spInfo.FieldLabel := IntToStr(FLoginServer.Port);
  end;
  laDecodeTime.Caption := IntToStr(FDecodeMsgTime);
  if not GGateReady then
  begin
    spInfo.FieldLabel := 'Not Ready';
    spStatus.FieldLabel := '--]   [--';
  end else begin
    if GKeepAliveTimeOut then
    begin
      spInfo.FieldLabel := 'TimeOut';
    end else begin
      spInfo.FieldLabel := spInfo.FieldLabel + ' - Ready';
      spStatus.FieldLabel := '---][---';
      laMessageCount.Caption := IntToStr(GMessageCount) + '/' + IntToStr(GSendMessageCount);
    end;
  end;
end;

//////////////////////////////////////////////////////////

  {$REGION ' - TfrmLoginGate Help Functions '}
    procedure TfrmLoginGate.StartGateService;
    begin
      try
        LogMessage('Start Login Gate...', 3);
        SendControlCenterMessage(SG_START_NOW, Format(GInfo_NowStartGate,['Login']));
    
        { Setup Main Menue }
        MENU_CONTROL_START.Enabled := False;
        MENU_CONTROL_STOP.Enabled  := True;
    
        { Base Gate Options }
        GServiceStart        := True;
        GGateReady           := False;
        FServerReady         := False;
        GKeepAliveTimeOut    := False;
        GSendHoldTimeOut     := False;
        FSessionCount        := 0;
        GSendMessageCount    := 0;
        GMessageCount        := 0;
        FGateToServerTick    := GetTickCount - 25 * 1000;
        GSendHoldTick        := GetTickCount;
    
        { Filter List SetUp}
        GCurrentIPAddrList   := TLockableList.Create;
        GBlockIPList         := TLockableList.Create;
        GBlockIPText         := TLockableList.Create;
        GTempBlockIPList     := TLockableList.Create;
        GAttackIPaddrList    := TLockableList.Create;
        GDataFilterList      := TStringList.Create;
    
        { Reset Session and Load Gate Config }
        ResetUserSessionArray;
        LoadGateConfiguration;
    
        { Gate Network SetUp}
        FLoginClient.Active  := False;
        FLoginClient.Host    := GServerAddr;
        FLoginClient.Port    := GServerPort;
        FLoginClient.Active  := True;
    
        { Server Network SetUp}
        FLoginServer.Active  := False;
        FLoginServer.Address := GGateAddr;
        FLoginServer.Port    := GGatePort;
        FLoginServer.Active  := True;

        SendToServer.Enabled := True;
        SendControlCenterMessage(SG_START_OK, Format('%s' + GInfo_NowStartOK,['Login']));
        LogMessage('Login Gate for ['+ GServerName +'] Started...', 3);
    
        if GMinimize then
          triLoginGate.MinimizeApp;
      except
        on E: Exception do
        begin
          MENU_CONTROL_START.Enabled := True;
          MENU_CONTROL_STOP.Enabled  := False;
          LogMessage('ERROR - Start Gate : ' + E.Message, 0);
        end;
      end;
    end;

    procedure TfrmLoginGate.StopGateService;
    var
      FIndex  : Integer;
      I, II   : Integer;
      FIPaddr : PSockAddr;
      FIPList : TList;
    begin
      try
        LogMessage('Stop Login Gate...', 0);
    
        { Set Service Stopped }
        GServiceStart        := False;
        GGateReady           := False;
        SendToServer.Enabled := False;
    
        for FIndex := 0 to GATE_MAX_SESSION-1 do
        begin
          if FSessionArray[FIndex].usSocket <> nil then
            FSessionArray[FIndex].usSocket.Close;
        end;
    
        { Close and cleanup Network }
        FLoginServer.Close;
        FLoginClient.Close;
        FSocketMessageList.Clear;
    
        {$REGION ' - GCurrentIPAddrList '}
          GCurrentIPAddrList.Lock;
          try
            for I := 0 to GCurrentIPAddrList.Count - 1 do
            begin
              FIPList := TList(GCurrentIPAddrList.Items[I]);
              if FIPList <> nil then
              begin
                for II := 0 to FIPList.Count - 1 do
                begin
                  if PSockaddr(FIPList.Items[II]) <> nil then
                    Dispose(PSockaddr(FIPList.Items[II]));
                end;
                FIPList.Free;
              end;
            end;
          finally
            GCurrentIPAddrList.UnLock;
            GCurrentIPAddrList.Clear;
            FreeAndNil(GCurrentIPAddrList);
          end;
        {$ENDREGION}
    
        {$REGION ' - GBlockIPList       '}
          GBlockIPList.Lock;
          try
            for I := 0 to GBlockIPList.Count - 1 do
            begin
              FIPaddr := PSockAddr(GBlockIPList.Items[I]);
              Dispose(FIPaddr);
            end;
          finally
            GBlockIPList.UnLock;
            GBlockIPList.Clear;
            FreeAndNil(GBlockIPList);
          end;
        {$ENDREGION}
    
        {$REGION ' - GBlockIPText       '}
          GBlockIPText.Lock;
          try
            for I := 0 to GBlockIPText.Count - 1 do
            begin
              FIPaddr := PSockAddr(GBlockIPText.Items[I]);
              Dispose(FIPaddr);
            end;
          finally
            GBlockIPText.UnLock;
            GBlockIPText.Clear;
            FreeAndNil(GBlockIPText);
          end;
        {$ENDREGION}
    
        {$REGION ' - GTempBlockIPList   '}
          GTempBlockIPList.Lock;
          try
            for I := 0 to GTempBlockIPList.Count - 1 do
            begin
              FIPaddr := PSockaddr(GTempBlockIPList.Items[I]);
              Dispose(FIPaddr);
            end;
          finally
            GTempBlockIPList.UnLock;
            GTempBlockIPList.Clear;
            FreeAndNil(GTempBlockIPList);
          end;
        {$ENDREGION}
    
        {$REGION ' - GAttackIPaddrList  '}
          GAttackIPaddrList.Lock;
          try
            for I := 0 to GAttackIPaddrList.Count - 1 do
            begin
              FIPaddr := PSockAddr(GAttackIPaddrList.Items[I]);
              Dispose(FIPaddr);
            end;
          finally
            GAttackIPaddrList.UnLock;
            GAttackIPaddrList.Clear;
            FreeAndNil(GAttackIPaddrList);
          end;
        {$ENDREGION}

        if Assigned(GDataFilterList) then
          FreeAndNil(GDataFilterList);
    
        { Setup Main Menue }
        MENU_CONTROL_START.Enabled := True;
        MENU_CONTROL_STOP.Enabled  := False;
    
        LogMessage('Login Gate Stopped...', 3);
      except
        LogMessage('ERROR - Login Gate Stop Fail...', 3);
      end;
    end;

    procedure TfrmLoginGate.LoadGateConfiguration;
    var
      FIniConf   : TIniFile;
      FGateClass : String;
    begin
      FIniConf            := TIniFile.Create(GATE_CONFIG_PATH+'.\Mir3LoginGateConfig.ini');
      GServerPort         := FIniConf.ReadInteger('Gate_Network', 'ServerPort'        , GServerPort);
      GServerAddr         := FIniConf.ReadString( 'Gate_Network', 'ServerIP'          , GServerAddr);
      GGatePort           := FIniConf.ReadInteger('Gate_Network', 'GatePort'          , GGatePort);
      GGateAddr           := FIniConf.ReadString( 'Gate_Network', 'GateIP'            , GGateAddr);
      GServerName         := FIniConf.ReadString( 'Gate_Option' , 'ServerName'        , GServerName);
      GShowLogLevel       := FIniConf.ReadInteger('Gate_Option' , 'ShowLogLevel'      , GShowLogLevel);
      GMinimize           := FIniConf.ReadBool(   'Gate_Option' , 'Minimize'          , GMinimize);
      GKeepConnectTimeOut := FIniConf.ReadInteger('Gate_Option' , 'KeepConnectTimeOut', GKeepConnectTimeOut);
      GMaxConnOfIPaddr    := FIniConf.ReadInteger('Gate_Option' , 'MaxConnectOfIPAddr', GMaxConnOfIPaddr);
      GMaxMessageLen      := FIniConf.ReadInteger('Gate_Option' , 'MaxMessageLen'     , GMaxMessageLen);
    
      FIniConf.Free;
    end;
    
    procedure TfrmLoginGate.ShowMainLogMessages;
    var
      I: Integer;
    begin
      if (GetTickCount - FShowMainLogTick) < 200 then Exit;
        FShowMainLogTick := GetTickCount;
      try
        FShowLocked := True;
        try
          CSGateMain.Enter;
          for I := 0 to GLogMessageList.Count - 1 do
          begin
            FTempLogList.Add(GLogMessageList.Strings[I]);
          end;
          GLogMessageList.Clear;
        finally
          CSGateMain.Leave;
        end;
        for I := 0 to FTempLogList.Count - 1 do
        begin
          ProgressDisplay.AddStep(FTempLogList.Strings[I]);
        end;
        FTempLogList.Clear;
      finally
        FShowLocked := False;
      end;
    end;
    
    function TfrmLoginGate.SendUserMessage(AUserSession: PUserSession; ASendMessage: String): Integer;
    begin
      Result := -1;
      if AUserSession.usSocket <> nil then
      begin
        if not AUserSession.usSendLock then
        begin
          if not AUserSession.usSendAvailable and (GetTickCount > AUserSession.usSendLockTimeOut) then
          begin
            AUserSession.usSendAvailable   := True;
            AUserSession.usCheckSendLength := 0;
            GSendHoldTimeOut  := True;
            GSendHoldTick    := GetTickCount;
          end;
          if AUserSession.usSendAvailable then
          begin
            if AUserSession.usCheckSendLength >= 250 then
            begin
              if not AUserSession.usSendCheck then
              begin
                AUserSession.usSendCheck := True;
                ASendMessage             := '*' + ASendMessage;
              end;
              if AUserSession.usCheckSendLength >= 512 then
              begin
                AUserSession.usSendAvailable   := False;
                AUserSession.usSendLockTimeOut := GetTickCount + 3 * 1000;
              end;
            end;
            AUserSession.usSocket.SendText(ASendMessage);
            Inc(AUserSession.usSendMsgLen, Length(ASendMessage));
            Inc(AUserSession.usCheckSendLength, Length(ASendMessage));
            Result := 1;
          end else begin
            Result := 0;
          end;
        end else begin
          Result := 0;
        end;
      end;
    end;
    
  {$ENDREGION}

  {$REGION ' - TfrmLoginGate Timer Functions '}

    procedure TfrmLoginGate.StartTimerTimer(Sender: TObject);
    begin
      if GGateStarted then
      begin
        StartTimer.Enabled := False;
        StopGateService;
        GCloseGate         := True;
        Close;
      end else begin
        GGateStarted       := True;
        StartTimer.Enabled := False;
        StartGateService;
      end;
    end;

    procedure TfrmLoginGate.SendToServerTimer(Sender: TObject);
    var
      FUserSession : PUserSession;
      FIndex       : Integer;
    begin
      { Show Client Connections }
      if FLoginServer.Active then
      begin
        GActiveConnection := FLoginServer.Socket.ActiveConnections;
      end;
      { ---------------- }
      if GSendHoldTimeOut then
      begin
        laActiveConnection.Caption := IntToStr(GActiveConnection) + '#';
        if (GetTickCount - GSendHoldTick) > 3000 then
          GSendHoldTimeOut := False;
      end else begin
        laActiveConnection.Caption := IntToStr(GActiveConnection);
      end;
      { ---------------- }
      if GGateReady and (not GKeepAliveTimeOut) then
      begin
        for FIndex := 0 to GATE_MAX_SESSION - 1 do
        begin
          FUserSession := @FSessionArray[FIndex];
          if FUserSession.usSocket <> nil then
          begin
            if (GetTickCount - FUserSession.usUserTimeOutTick) > 3600000 then
            begin
              FUserSession.usSocket.Close;
              FUserSession.usSocket       := nil;
              FUserSession.usSocketHandle := -1;
              FUserSession.usRemoteIPaddr := '';
              FUserSession.usMessageList.Clear;
            end;
          end;
        end;
      end;
      { ---------------- }
      if not GGateReady and (GServiceStart) then
      begin
        if (GetTickCount - FGateToServerTick) > 1000 then
        begin
          FGateToServerTick   := GetTickCount;
          FLoginClient.Active := False;
          FLoginClient.Port   := GServerPort;
          FLoginClient.Host   := GServerAddr;
          FLoginClient.Active := True;
        end;
      end;
    end;
    
    procedure TfrmLoginGate.DecodeTimerTimer(Sender: TObject);
    var
      FIndex           : Integer;
      FUserSession     : PUserSession;
      FRemoteIPaddr    : String;
      FProcessMsg      : String;
      FSocketMsg       : String;
      FSocketHandle    : String;
      FSocketHandleInt : Integer;
      FMsgCount        : Integer;
      FSendRetCode     : Integer;
      FDecodeTick      : LongWord;
      FDecodeTime      : LongWord;
    begin
      ShowMainLogMessages;
      if GDecodeLock or (not GGateReady) then Exit;
      try
        FDecodeTick  := GetTickCount();
        GDecodeLock  := True;
        FProcessMsg  := '';
        while True do
        begin
          if FSocketMessageList.Count <= 0 then break;
          FProcessMsg := FProcMsg + FSocketMessageList.Strings[0];
          FProcMsg    := '';
          FSocketMessageList.Delete(0);
          while (True) do begin
            if CharCount(FProcessMsg, '$') < 1 then break;
            FProcessMsg := ArrestStringEx(FProcessMsg, '%', '$', FSocketMsg);
            if FSocketMsg    = ''  then break;
            if FSocketMsg[1] = '+' then
            begin
              case FSocketMsg[2] of
                '-': begin
                  CloseSocket(StrToIntDef(Copy(FSocketMsg, 3, Length(FSocketMsg) - 2), 0));
                  Continue;
                end;
                'B': begin
                  Inc(GAttackCount);
                  GAttackTick   := GetTickCount;
                  FRemoteIPaddr := CloseSocketAndGetIPAddr(StrToIntDef(Copy(FSocketMsg, 3, Length(FSocketMsg) - 2), 0));
                  AddBlockIP(FRemoteIPaddr);
                  Continue;
                end;
                'T': begin
                  Inc(GAttackCount);
                  GAttackTick   := GetTickCount;
                  FRemoteIPaddr := CloseSocketAndGetIPAddr(StrToIntDef(Copy(FSocketMsg, 3, Length(FSocketMsg) - 2), 0));
                  AddTempBlockIP(FRemoteIPaddr);
                  Continue;
                end;
                else begin
                  GKeepAliveTick    := GetTickCount();
                  GKeepAliveTimeOut := False;
                  Continue;
                end;
              end;
            end;
            FSocketMsg       := GetValidStr3(FSocketMsg, FSocketHandle, ['/']);
            FSocketHandleInt := StrToIntDef(FSocketHandle, -1);
            if FSocketHandleInt < 0 then Continue;
            for FIndex := 0 to GATE_MAX_SESSION - 1 do
            begin
              if FSessionArray[FIndex].usSocketHandle = FSocketHandleInt then
              begin
                FSessionArray[FIndex].usMessageList.Add(FSocketMsg);
                break;
              end;
            end;
          end;
        end;
    
        if FProcessMsg <> '' then
          FProcMsg := FProcessMsg;
    
        GSendMessageCount := 0;
        GMessageCount     := 0;
        for FIndex := 0 to GATE_MAX_SESSION - 1 do
        begin
          if FSessionArray[FIndex].usSocketHandle <= -1 then Continue;
    
          if (GAttackLevel > 0) and ((GetTickCount - FSessionArray[FIndex].usConnctCheckTick) > GKeepConnectTimeOut * GAttackLevel) then
          begin
            FRemoteIPaddr := FSessionArray[FIndex].usRemoteIPaddr;
            FSessionArray[FIndex].usSocket.Close;
            LogMessage('Socked close at Ip : ' + FRemoteIPaddr + ' - (Session TimeOut) ',1);
            Continue;
          end;
          
          while (True) do
          begin
            if FSessionArray[FIndex].usMessageList.Count <= 0 then break;
            FUserSession := @FSessionArray[FIndex];
            FSendRetCode := SendUserMessage(FUserSession, FUserSession.usMessageList.Strings[0]);
            if (FSendRetCode >= 0) then
            begin
              if FSendRetCode = 1 then
              begin
                FUserSession.usConnctCheckTick := GetTickCount();
                FUserSession.usMessageList.Delete(0);
                Continue;
              end;
              if FUserSession.usMessageList.Count > 100 then
              begin
                FMsgCount := 0;
                while FMsgCount <> 51 do begin
                  FUserSession.usMessageList.Delete(0);
                  Inc(FMsgCount);
                end;
              end;
              Inc(GMessageCount, FUserSession.usMessageList.Count);
              LogMessage(FUserSession.usIP + ' : ' + IntToStr(FUserSession.usMessageList.Count), 5);
              Inc(GSendMessageCount);
            end else begin
              FUserSession.usSocketHandle := -1;
              FUserSession.usSocket       := nil;
              FUserSession.usMessageList.Clear;
            end;
          end;
        end;
        if (GetTickCount - FSendKeepAliveTick) > 2 * 1000 then
        begin
          FSendKeepAliveTick := GetTickCount();
          if GGateReady then
            FLoginClient.Socket.SendText('%--$');
        end;
        if (GetTickCount - GKeepAliveTick) > 10 * 1000 then
        begin
          GKeepAliveTimeOut := True;
          FLoginClient.Close;
        end;
      finally
        GDecodeLock := False;
      end;
      FDecodeTime := GetTickCount - FDecodeTick;
      if FDecodeMsgTime < FDecodeTime then
        FDecodeMsgTime := FDecodeTime;
      if FDecodeMsgTime > 50 then
        Dec(FDecodeMsgTime, 50);
    end;
    
    
  {$ENDREGION}

  {$REGION ' - TfrmLoginGate Network Functions '}
    procedure TfrmLoginGate.CloseConnection(AIPaddr: String);
    var
      I      : Integer;
      FCheck : Boolean;
    begin
      if FLoginServer.Active then
      begin
        while (True) do
        begin
          FCheck := False;
          for I := 0 to FLoginServer.Socket.ActiveConnections - 1 do
          begin
            if AIPaddr = FLoginServer.Socket.Connections[I].RemoteAddress then
            begin
              FLoginServer.Socket.Connections[I].Close;
              FCheck := True;
              Break;
            end;
          end;
          if not FCheck then break;
        end;
      end;
    end;

    procedure TfrmLoginGate.ClientConnect(Sender: TObject; Socket: TCustomWinSocket);
    begin
      GKeepAliveTick := GetTickCount;
      GGateReady     := True;
      FServerReady   := True;
      FSessionCount  := 0;
      ResetUserSessionArray;
    end;
    
    procedure TfrmLoginGate.ClientDisconnect(Sender: TObject; Socket: TCustomWinSocket);
    begin
      CloseAllUserSessionArray;
      ResetUserSessionArray();
      FSocketMessageList.Clear;
      GGateReady    := False;
      FSessionCount := 0;
    end;
    
    procedure TfrmLoginGate.ClientError(Sender: TObject; Socket: TCustomWinSocket;  ErrorEvent: TErrorEvent; var ErrorCode: Integer);
    begin
      Socket.Close;
      ErrorCode    := 0;
      FServerReady := False;
    end;

    procedure TfrmLoginGate.ClientRead(Sender: TObject; Socket: TCustomWinSocket);
    var
      FReceivedMessage : String;
    begin
      FReceivedMessage := Socket.ReceiveText;
      FSocketMessageList.Add(FReceivedMessage);
    end;

    procedure TfrmLoginGate.ServerClientConnect(Sender: TObject; Socket: TCustomWinSocket);
    var
      FUserSession  : PUserSession;
      FRemoteIPaddr : String;
      FLocalIPaddr  : String;
      FIndex        : Integer;
    begin
      Socket.nIndex := -1;
      FRemoteIPaddr := Socket.RemoteAddress;

      if TestIsBlockIP(FRemoteIPaddr) then
      begin
        Inc(GAttackCount);
        GAttackTick := GetTickCount;
        if GAttackCount < 10 then
        begin
          LogMessage('Close Connect Remote IP: ' + FRemoteIPaddr, 1);
        end;
        Socket.Close;
        Exit;
      end;

      if TestIsConnLimited(FRemoteIPaddr, Socket.SocketHandle) then
      begin
        if GChgDefendLevel then
        begin
          Inc(GAttackCount);
          GAttackTick := GetTickCount;
          if GAttackCount >= GChgDefendLevelInt then
          begin
            if GBlockMethod = mDisconnect then
              GBlockMethod := mBlock;
            if GAttackLevel > 1 then
              GAttackLevel := 1;
          end;
        end;

        case GBlockMethod of
          mDisconnect: begin
            Socket.Close;
          end;
          mBlock: begin
            AddTempBlockIP(FRemoteIPaddr);
            CloseConnection(FRemoteIPaddr);
          end;
          mBlockList: begin
            AddBlockIP(FRemoteIPaddr);
            CloseConnection(FRemoteIPaddr);
          end;
          mBlockText: begin
            AddBlockIPText(FRemoteIPaddr);
            CloseConnection(FRemoteIPaddr);
          end;
        end;

        if GAttackCount < 10 then
        begin
          LogMessage('Banned Remote IP: ' + FRemoteIPaddr, 1);
        end;
        Exit;
      end;

      if GDisableDynamicIPMode then
      begin
        FLocalIPaddr := FLoginClient.Socket.RemoteAddress;
      end else begin
        FLocalIPaddr := Socket.LocalAddress;
      end;

      if GGateReady then
      begin
        for FIndex := 0 to GATE_MAX_SESSION - 1 do
        begin
          FUserSession := @FSessionArray[FIndex];
          if FUserSession.usSocket = nil then
          begin
            FUserSession.usSocket          := Socket;
            FUserSession.usRemoteIPaddr    := FRemoteIPaddr;
            FUserSession.usSendMsgLen      := 0;
            FUserSession.usReviceMsgLen    := 0;
            FUserSession.usSendLock        := False;
            FUserSession.us10Tick          := GetTickCount;
            FUserSession.usConnctCheckTick := GetTickCount;
            FUserSession.usSendAvailable   := True;
            FUserSession.usSendCheck       := False;
            FUserSession.usCheckSendLength := 0;
            FUserSession.usMessageLen      := 0;
            FUserSession.usUserTimeOutTick := GetTickCount;
            FUserSession.usSocketHandle    := Socket.SocketHandle;
            FUserSession.usIP              := FRemoteIPaddr;
            FUserSession.usReceiveTick     := GetTickCount;
            FUserSession.usReliefenbao     := 0;
            FUserSession.usReceiveMsgTick  := GetTickCount;
            FUserSession.usMessageList.Clear;
            Socket.nIndex := FIndex;
            Inc(FSessionCount);
            Break;
          end;
        end;

        if Socket.nIndex >= 0 then
        begin
         FLoginClient.Socket.SendText('%N' +
                                       IntToStr(Socket.SocketHandle) +
                                       '/' +
                                       FRemoteIPaddr +
                                       '/' +
                                       FLocalIPaddr +
                                       '$');
          LogMessage('Connect: ' + FRemoteIPaddr,5);
        end else begin
          Socket.Close;
          LogMessage('Kick Off: ' + FRemoteIPaddr, 1);
        end;
      end else begin
        Socket.Close;
        LogMessage('Kick Off: ' + FRemoteIPaddr, 1);
      end;
    end;

    procedure TfrmLoginGate.ServerClientDisconnect(Sender: TObject; Socket: TCustomWinSocket);
    var
      I, II         : Integer;
      FIndex        : Integer;
      FUserSession  : PUserSession;
      FIPaddrSock   : PSockaddr;
      FRemoteIPaddr : String;
      FIPaddr       : Integer;
      FIPList       : TList;
    begin
      FRemoteIPaddr := Socket.RemoteAddress;
      FIndex        := Socket.nIndex;
      FIPaddr       := inet_addr(PChar(FRemoteIPaddr));
      GCurrentIPAddrList.Lock;
      try
        for I := GCurrentIPAddrList.Count - 1 downto 0 do
        begin
          FIPList := TList(GCurrentIPAddrList.Items[I]);
          if FIPList <> nil then begin
            for II := FIPList.Count - 1 downto 0 do
            begin
              FIPaddrSock := FIPList.Items[II];
              if (FIPaddrSock.saIPaddr = FIPaddr) and (FIPaddrSock.saSocketHandle = Socket.SocketHandle) then
              begin
                Dispose(FIPaddrSock);
                FIPList.Delete(II);
                if FIPList.Count <= 0 then
                begin
                  FIPList.Free;
                  GCurrentIPAddrList.Delete(I);
                end;
                break;
              end;
            end;
          end;
        end;
      finally
        GCurrentIPAddrList.UnLock;
      end;

      if (FIndex >= 0) and (FIndex < GATE_MAX_SESSION) then
      begin
        FUserSession := @FSessionArray[FIndex];
        FUserSession.usSocket := nil;
        FUserSession.usRemoteIPaddr := '';
        FUserSession.usSocketHandle := -1;
        FUserSession.usMessageList.Clear;
        Dec(FSessionCount);
        if GGateReady then
        begin
          FLoginClient.Socket.SendText('%C' +
                                       IntToStr(Socket.SocketHandle) +
                                       '$');
          LogMessage('DisConnect: ' + FRemoteIPaddr, 5);
        end;
      end;
    end;

    procedure TfrmLoginGate.ServerClientError(Sender: TObject; Socket: TCustomWinSocket; ErrorEvent: TErrorEvent; var ErrorCode: Integer);
    begin
      // TODO : Add Ask system show this message or not
      LogMessage('Error ' + IntToStr(ErrorCode) + ': ' + Socket.RemoteAddress, 3);
      Socket.Close;
      ErrorCode := 0;
    end;

    procedure TfrmLoginGate.ServerClientRead(Sender: TObject; Socket: TCustomWinSocket);
    var
      FIndex           : Integer;
      FPos             : Integer;
      FMessageLen      : Integer;
      FMessageCount    : Integer;
      FUserSession     : PUserSession;
      FRemoteAddress   : String;
      FReceivedMessage : String;
      FTemp_1, FTemp_2 : String;
      bo01: Boolean;
      bo02: Boolean;
       DefMsg                    : TDefaultMessage;
    begin
      bo01 := False;
      bo02 := False;
      FIndex         := Socket.nIndex;
      FRemoteAddress := Socket.RemoteAddress;
      if (FIndex >= 0) and (FIndex < GATE_MAX_SESSION) then
      begin
        FUserSession     := @FSessionArray[FIndex];
        FReceivedMessage := Socket.ReceiveText;

        if TestIsAttack(FReceivedMessage) then
        begin
          LogMessage('Attacker IP: ' + Socket.RemoteAddress, 4);
          Socket.Close;
          Exit;
        end;

        if Length(FReceivedMessage) > GMaxMessageLen then
        begin
          LogMessage('To Big Message! IP : ' + Socket.RemoteAddress ,4);
          Socket.Close;
          Exit;
        end;
        
        if (FReceivedMessage <> '') and (FServerReady) then
        begin
          FMessageLen := Length(FReceivedMessage);
          if GAttackLevel > 0 then
          begin
            Inc(FUserSession.usReviceMsgLen, FMessageLen);
            FMessageCount := CharCount(FReceivedMessage, '!');

            if FMessageCount > GMaxClientMsgCount * GAttackLevel then bo02 := True;
            if FMessageLen   > GReliefenbaoInt                   then bo01 := True;
            if bo01 or bo02 then
            begin

              if GChgDefendLevel then
              begin
                Inc(GAttackCount);
                GAttackTick := GetTickCount;
                if GAttackCount >= GChgDefendLevelInt then
                begin
                  if GBlockMethod = mDisconnect then GBlockMethod := mBlock;
                  if GAttackLevel > 1           then GAttackLevel := 1;
                end;
              end;

              case GBlockMethod of
                mDisconnect: begin
                  Socket.Close;
                end;
                mBlock: begin
                  AddTempBlockIP(FRemoteAddress);
                  CloseConnection(FRemoteAddress);
                end;
                mBlockList: begin
                  AddBlockIP(FRemoteAddress);
                  CloseConnection(FRemoteAddress);
                end;
                mBlockText: begin
                  AddBlockIPText(FRemoteAddress);
                  CloseConnection(FRemoteAddress);
                end;
              end;
              if GAttackCount < 10 then
              begin
                if bo01 then
                  LogMessage('User: ' + FRemoteAddress + ' MaxMsgLen: ' + IntToStr(FUserSession.usReviceMsgLen), 1);
                if bo02 then
                  LogMessage('User: ' + FRemoteAddress + ' MaxClient: ' + IntToStr(FMessageCount), 1);
              end;
              Socket.Close;
              Exit;
            end;
          end;

          FPos := Pos('*', FReceivedMessage);
          if FPos > 0 then
          begin
            FUserSession.usSendAvailable   := True;
            FUserSession.usSendCheck       := False;
            FUserSession.usCheckSendLength := 0;
            FUserSession.usReceiveTick     := GetTickCount();
            FTemp_1 := Copy(FReceivedMessage, 1, FPos - 1);
            FTemp_2 := Copy(FReceivedMessage, FPos + 1, Length(FReceivedMessage) - FPos);
            FReceivedMessage := FTemp_1 + FTemp_2;
          end;
          FMessageLen := Length(FReceivedMessage);

          if FUserSession.usReliefenbao <= 0 then
            FUserSession.usReceiveMsgTick := GetTickCount();
          Inc(FUserSession.usReliefenbao, FMessageLen);

          if (FReceivedMessage <> '') and (GGateReady) and (not GKeepAliveTimeOut) then
          begin
            FUserSession.usConnctCheckTick := GetTickCount();
            if (GetTickCount - FUserSession.usUserTimeOutTick) < 1000 then
            begin
              Inc(FUserSession.usMessageLen, FMessageLen);
            end else FUserSession.usMessageLen := FMessageLen;

            FLoginClient.Socket.SendText('%D' +
                                         IntToStr(Socket.SocketHandle) +
                                         '/' +
                                         FReceivedMessage +
                                         '$');
          end;
        end;
      end;
    end;

  {$ENDREGION}

  {$REGION ' - TfrmLoginGate Test and Add Functions '}
    function TfrmLoginGate.TestIsBlockIP(AIPaddr: String): Boolean;
    var
      I           : Integer;
      FIPaddrSock : PSockAddr;
      FIPaddr     : Integer;
    begin
      Result := False;
      GTempBlockIPList.Lock;
      try
        FIPaddr := inet_addr(PChar(AIPaddr));
        for I := 0 to GTempBlockIPList.Count - 1 do
        begin
          FIPaddrSock := PSockAddr(GTempBlockIPList.Items[I]);
          if FIPaddrSock.saIPaddr = FIPaddr then
          begin
            Result := True;
            break;
          end;
        end;
      finally
        GTempBlockIPList.UnLock;
      end;
    
      if not Result then
      begin
        GBlockIPText.Lock;
        try
          for I := 0 to GBlockIPText.Count - 1 do
          begin
            FIPaddrSock := PSockAddr(GBlockIPText.Items[I]);
            if FIPaddrSock.saIPaddr = FIPaddr then
            begin
              Result := True;
              break;
            end;
          end;
        finally
          GBlockIPText.UnLock;
        end;
    
        if not Result then
        begin
          GBlockIPList.Lock;
          try
            for I := 0 to GBlockIPList.Count - 1 do
            begin
              FIPaddrSock := PSockAddr(GBlockIPList.Items[I]);
              if FIPaddrSock.saIPaddr = FIPaddr then
              begin
                Result := True;
                break;
              end;
            end;
          finally
            GBlockIPList.UnLock;
          end;
        end;
      end;
    end;
    
    function TfrmLoginGate.TestIsConnLimited(AIPaddr: String; ASocketHandle: Integer): Boolean;
    var
      I            : Integer;
      FIPaddrSock  : PSockaddr;
      FAttackIPaddr: PSockaddr;
      FIPaddr      : Integer;
      FIsAttack    : Boolean;
      FIPList      : TList;
    begin
      Result := False;
      GCurrentIPAddrList.Lock;
      try
        if GAttackLevel > 0 then
        begin
          FIsAttack := False;
          FIPaddr   := inet_addr(PChar(AIPaddr));
          for I := 0 to GCurrentIPAddrList.Count - 1 do
          begin
            FIPList := TList(GCurrentIPAddrList.Items[I]);
            if (FIPList <> nil) and (FIPList.Count > 0) then
            begin
              FIPaddrSock := PSockaddr(FIPList.Items[0]);
              if FIPaddrSock <> nil then
              begin
                if FIPaddrSock.saIPaddr = FIPaddr then
                begin
                  FIsAttack := True;
                  Result    := AddAttackIP(AIPaddr);
                  if Result then break;
                  New(FAttackIPaddr);
                  FillChar(FAttackIPaddr^, SizeOf(TSockaddr), 0);
                  FAttackIPaddr^.saIPaddr       := FIPaddr;
                  FAttackIPaddr^.saSocketHandle := ASocketHandle;
                  FIPList.Add(FAttackIPaddr);
                  if FIPList.Count > GMaxConnOfIPaddr * GAttackLevel then Result := True;
                  Break;
                end;
              end;
            end;
          end;
          if not FIsAttack then
          begin
            FIPList := nil;
            New(FIPaddrSock);
            FillChar(FIPaddrSock^, SizeOf(TSockaddr), 0);
            FIPaddrSock^.saIPaddr       := FIPaddr;
            FIPaddrSock^.saSocketHandle := ASocketHandle;
            FIPList                     := TList.Create;
            FIPList.Add(FIPaddrSock);
            GCurrentIPAddrList.Add(FIPList);
          end;
        end;
      finally
        GCurrentIPAddrList.UnLock;
      end;
    end;
    
    function TfrmLoginGate.TestIsAttAck(AMessage: String): Boolean;
    var
      I    : Integer;
      FPos : Integer;
    begin
      Result := False;
      for I := 0 to GDataFilterList.Count - 1 do
      begin
        FPos := Pos(GDataFilterList.Strings[I], AMessage);
        if FPos <> 0 then
        begin
          Result := True;
          Exit;
        end;
      end;
    end;
    
    
    function TfrmLoginGate.AddAttackIP(AIPaddr: String): Boolean;
    var
      I           : Integer;
      FIPaddrSock : PSockaddr;
      FAddIPaddr  : PSockaddr;
      FIPaddr     : Integer;
      FIsAttack  : Boolean;
    begin
      Result := False;
      GAttackIPaddrList.Lock;
      try
        if GAttackLevel > 0 then
        begin
          FIsAttack := False;
          FIPaddr := inet_addr(PChar(AIPaddr));
          for I := GAttackIPaddrList.Count - 1 downto 0 do
          begin
            FIPaddrSock := PSockAddr(GAttackIPaddrList.Items[I]);
            if FIPaddrSock.saIPaddr = FIPaddr then
            begin
              if (GetTickCount - FIPaddrSock.saStartAttackTick) <= GAttackTime div GAttackLevel then
              begin
                FIPaddrSock.saStartAttackTick := GetTickCount;
                Inc(FIPaddrSock.saAttackCount);
                LogMessage('AttackCount : ' + IntToStr(FIPaddrSock.saAttackCount), 5);
                if FIPaddrSock.saAttackCount >= GAttackCount * GAttackLevel then
                begin
                  GAttackIPaddrList.Delete(I);
                  Dispose(FIPaddrSock);
                  Result := True;
                end;
              end else begin
                if FIPaddrSock.saAttackCount > GAttackCount * GAttackLevel then
                begin
                  Inc(GAttackCount);
                  GAttackTick := GetTickCount;
                  Result     := True;
                end;
                GAttackIPaddrList.Delete(I);
                Dispose(FIPaddrSock);
              end;
              FIsAttack := True;
              Break;
            end;
          end;
          if not FIsAttack then
          begin
            New(FAddIPaddr);
            FillChar(FAddIPaddr^, SizeOf(TSockaddr), 0);
            FAddIPaddr^.saIPaddr          := FIPaddr;
            FAddIPaddr^.saStartAttackTick := GetTickCount;
            FAddIPaddr^.saAttackCount     := 0;
            GAttackIPaddrList.Add(FAddIPaddr);
          end;
        end;
      finally
        GAttackIPaddrList.UnLock;
      end;
    end;
    
    function TfrmLoginGate.AddBlockIP(AIPaddr: String): Integer;
    var
      I           : Integer;
      FIPaddrSock : PSockaddr;
      FIPaddr     : Integer;
    begin
      GBlockIPList.Lock;
      try
        Result := 0;
        FIPaddr := inet_addr(PChar(AIPaddr));
        for I := 0 to GBlockIPList.Count - 1 do
        begin
          FIPaddrSock := PSockAddr(GBlockIPList.Items[I]);
          if FIPaddrSock.saIPaddr = FIPaddr then
          begin
            Result := GBlockIPList.Count;
            break;
          end;
        end;
        if Result <= 0 then
        begin
          New(FIPaddrSock);
          FIPaddrSock^.saIPaddr := FIPaddr;
          GBlockIPList.Add(FIPaddrSock);
          Result := GBlockIPList.Count;
        end;
      finally
        GBlockIPList.UnLock;
      end;
    end;
    
    function TfrmLoginGate.AddBlockIPText(AIPaddr: String): Integer;
    var
      I           : Integer;
      FIPaddrSock : PSockaddr;
      FIPaddr     : Integer;
    begin
      GBlockIPText.Lock;
      try
        Result := 0;
        FIPaddr := inet_addr(PChar(AIPaddr));
        for I := 0 to GBlockIPText.Count - 1 do
        begin
          FIPaddrSock := PSockaddr(GBlockIPText.Items[I]);
          if FIPaddrSock.saIPaddr = FIPaddr then
          begin
            Result := GBlockIPText.Count;
            Break;
          end;
        end;
        if Result <= 0 then
        begin
          New(FIPaddrSock);
          FIPaddrSock^.saIPaddr := FIPaddr;
          GBlockIPText.Add(FIPaddrSock);
          Result := GBlockIPText.Count;
        end;
      finally
        GBlockIPText.UnLock;
      end;
    end;
    
    function TfrmLoginGate.AddTempBlockIP(AIPaddr: String): Integer;
    var
      I           : Integer;
      FIPaddrSock : PSockaddr;
      FIPaddr     : Integer;
    begin
      GTempBlockIPList.Lock;
      try
        Result := 0;
        FIPaddr := inet_addr(PChar(AIPaddr));
        for I := 0 to GTempBlockIPList.Count - 1 do
        begin
          FIPaddrSock := PSockAddr(GTempBlockIPList.Items[I]);
          if FIPaddrSock.saIPaddr = FIPaddr then
          begin
            Result := GTempBlockIPList.Count;
            Break;
          end;
        end;
        if Result <= 0 then
        begin
          New(FIPaddrSock);
          FillChar(FIPaddrSock^, SizeOf(TSockaddr), 0);
          FIPaddrSock^.saIPaddr := FIPaddr;
          GTempBlockIPList.Add(FIPaddrSock);
          Result := GTempBlockIPList.Count;
        end;
      finally
        GTempBlockIPList.UnLock;
      end;
    end;
    
    
  {$ENDREGION}

  {$REGION ' - TfrmLoginGate Session Funktions '}
    procedure TfrmLoginGate.ResetUserSessionArray;
    var
      FUserSession : PUserSession;
      FIndex       : Integer;
    begin
      for FIndex := 0 to GATE_MAX_SESSION-1 do
      begin
        FUserSession                := @FSessionArray[FIndex];
        FUserSession.usSocket       := nil;
        FUserSession.usRemoteIPaddr := '';
        FUserSession.usSocketHandle := -1;
        FUserSession.usMessageList.Clear;
      end;
    end;
    
    procedure TfrmLoginGate.SetupUserSessionArray;
    var
      FUserSession : PUserSession;
      FIndex       : Integer;
    begin
      for FIndex := 0 to GATE_MAX_SESSION - 1 do
      begin
        FUserSession                    := @FSessionArray[FIndex];
        FUserSession.usSocket           := nil;
        FUserSession.usRemoteIPaddr     := '';
        FUserSession.usSendMsgLen       := 0;
        FUserSession.usSendLock         := False;
        FUserSession.us10Tick           := GetTickCount;
        FUserSession.usSendAvailable    := True;
        FUserSession.usSendCheck        := False;
        FUserSession.usCheckSendLength  := 0;
        FUserSession.usMessageLen       := 0;
        FUserSession.usUserTimeOutTick  := GetTickCount;
        FUserSession.usSocketHandle     := -1;
        FUserSession.usReceiveTick      := GetTickCount;
        FUserSession.usReliefenbao      := 0;
        FUserSession.usReceiveMsgTick   := GetTickCount;
        FUserSession.usMessageList      := TStringList.Create;
      end;
    end;

    procedure TfrmLoginGate.CloseUserSessionArray(ASockedHandle: Integer);
    var
      FUserSession : PUserSession;
      FIndex       : Integer;
    begin
      for FIndex := 0 to GATE_MAX_SESSION - 1 do
      begin
        FUserSession := @FSessionArray[FIndex];
        if (FUserSession.usSocket     <>            nil) and
           (FUserSession.usSocketHandle = ASockedHandle) then
        begin
          FUserSession.usSocket.Close;
          Break;
        end;
      end;
    end;

    function TfrmLoginGate.CloseSocketAndGetIPAddr(ASocketHandle: Integer): String;
    var
      FUserSession : PUserSession;
      FIndex       : Integer;
    begin
      Result := '';
      for FIndex := 0 to GATE_MAX_SESSION - 1 do begin
        FUserSession := @FSessionArray[FIndex];
        if (FUserSession.usSocket <> nil) and (FUserSession.usSocketHandle = ASocketHandle) then
        begin
          Result := FUserSession.usRemoteIPaddr;
          FUserSession.usSocket.Close;
          break;
        end;
      end;
    end;

    procedure TfrmLoginGate.CloseAllUserSessionArray;
    var
      FUserSession : PUserSession;
      FIndex       : Integer;
    begin
      for FIndex := 0 to GATE_MAX_SESSION - 1 do
      begin
        FUserSession := @FSessionArray[FIndex];
        if FUserSession.usSocket <> nil then
        begin
          FUserSession.usSocket.Close;
        end;
        FUserSession.usSocket       := nil;
        FUserSession.usRemoteIPaddr := '';
        FUserSession.usSocketHandle := -1;
      end;
    end;
  {$ENDREGION}

  {$REGION ' - TfrmLoginGate TryIcon Popup Funktions '}
    procedure TfrmLoginGate.StartLoginServiceGate1Click(Sender: TObject);
    begin
      StartGateService;
    end;

    procedure TfrmLoginGate.StopLoginServiceGate1Click(Sender: TObject);
    begin
      StopGateService;
    end;

    procedure TfrmLoginGate.CloseLoginGate1Click(Sender: TObject);
    begin
      Close;
    end;

    procedure TfrmLoginGate.ShowLoginGate1Click(Sender: TObject);
    begin
      triLoginGate.RestoreApp;
    end;

    procedure TfrmLoginGate.HideLoginGate1Click(Sender: TObject);
    begin
      triLoginGate.MinimizeApp;
    end;
  {$ENDREGION}

  procedure TfrmLoginGate.CenterMessage(var Message: TWMCopyData);
  var
    FIdent : Word;
    FData  : String;
  begin
    FIdent := HiWord(Message.From);
    case FIdent of
      GS_QUIT : begin
        if GServiceStart then
        begin
          StartTimer.Enabled := True;
        end else begin
          GCloseGate := True;
          Close;
        end;
      end;
      GS_RECORD: begin
        //FData := StrPas(Message.CopyDataStruct^.lpData);
        //Das gleiche geht mit gepackten Records
      end;
    end;
  end;

end.
