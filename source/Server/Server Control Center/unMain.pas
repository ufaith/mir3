unit unMain;

interface

uses
  { Delphi }
  Windows,
  Messages,
  SysUtils,
  Variants,
  Classes,
  Graphics,
  Controls,
  Forms,
  Dialogs,
  ExtCtrls,
  StdCtrls,
  Menus,
  { Raize }
  RzPanel,
  RzTabs,
  RzDBStat,
  RzStatus,
  RzBckgnd,
  RzLabel,
  RzTray,
  { Mir3 Game Starter }
  mir3_global_config,
  mir3_server_global;

type
  TfrmControlCenter = class(TForm)
    RzPanel1: TRzPanel;
    Image1: TImage;
    pcMain: TRzPageControl;
    RzStatusBar1: TRzStatusBar;
    RzVersionInfoStatus1: TRzVersionInfoStatus;
    spStatus: TRzDBStatusPane;
    spInfo: TRzDBStatusPane;
    tsControlMain: TRzTabSheet;
    plInfoBackground: TRzPanel;
    gbLoginGate: TRzGroupBox;
    gbSelCharGate: TRzGroupBox;
    gbRunGameGate: TRzGroupBox;
    gbLoginServer: TRzGroupBox;
    gbDBServer: TRzGroupBox;
    gbGameServer: TRzGroupBox;
    imgLoginGate: TImage;
    imgSelCharGate: TImage;
    imgRunGameGate: TImage;
    imgLoginServer: TImage;
    imgDBServer: TImage;
    imgGameServer: TImage;
    laStatusHH1: TRzLabel;
    laStatus_LoginGate: TRzLabel;
    laChangeConfig_LoginGate: TRzLabel;
    laStart_LoginGate: TRzLabel;
    RzSeparator1: TRzSeparator;
    laStop_LoginGate: TRzLabel;
    laReloadConfig_LoginGate: TRzLabel;
    laUserHH1: TRzLabel;
    laUser_LoginGate: TRzLabel;
    laStatusHH2: TRzLabel;
    laStatus_SelectCharGate: TRzLabel;
    laChangeConfig_SelectCharGate: TRzLabel;
    laStart_SelectCharGate: TRzLabel;
    RzSeparator2: TRzSeparator;
    laStop_SelectCharGate: TRzLabel;
    laReloadConfig_SelectCharGate: TRzLabel;
    laUserHH2: TRzLabel;
    laUser_SelectCharGate: TRzLabel;
    laStatusHH3: TRzLabel;
    laStatus_RunGameGate: TRzLabel;
    laChangeConfig_RunGameGate: TRzLabel;
    laStart_RunGameGate: TRzLabel;
    RzSeparator3: TRzSeparator;
    laStop_RunGameGate: TRzLabel;
    laReloadConfig_RunGameGate: TRzLabel;
    laUserHH3: TRzLabel;
    laUser_RunGameGate: TRzLabel;
    laStatusHH4: TRzLabel;
    laStatus_LoginServer: TRzLabel;
    laChangeConfig_LoginServer: TRzLabel;
    laStart_LoginServer: TRzLabel;
    RzSeparator4: TRzSeparator;
    laStop_LoginServer: TRzLabel;
    laReloadConfig_LoginServer: TRzLabel;
    laStatusHH5: TRzLabel;
    laStatus_DataBaseServer: TRzLabel;
    laChangeConfig_DBServer: TRzLabel;
    laStart_DBServer: TRzLabel;
    RzSeparator5: TRzSeparator;
    laStop_DBServer: TRzLabel;
    laReloadConfig_DBServer: TRzLabel;
    laStatusHH7: TRzLabel;
    laStatus_GameServer: TRzLabel;
    laChangeConfig_GameServer: TRzLabel;
    laStart_GameServer: TRzLabel;
    RzSeparator6: TRzSeparator;
    laStop_GameServer: TRzLabel;
    laReloadConfig_GameServer: TRzLabel;
    trServerControlCenter: TRzTrayIcon;
    LoginGateVersionInfo: TRzVersionInfo;
    pmTryIcon: TPopupMenu;
    N4: TMenuItem;
    CloseLoginGate1: TMenuItem;
    StopallServerandGates1: TMenuItem;
    gbAdmin: TRzGroupBox;
    imgAdminService: TImage;
    laChangeConfig_Admin: TRzLabel;
    tsLoginGate: TRzTabSheet;
    tsSelectCharGate: TRzTabSheet;
    tsRunGameGate: TRzTabSheet;
    tsLoginServer: TRzTabSheet;
    tsDBServer: TRzTabSheet;
    tsGameServer: TRzTabSheet;
    tsAdministration: TRzTabSheet;
    gbLogServer: TRzGroupBox;
    imgLogServer: TImage;
    laStatusHH6: TRzLabel;
    laStatus_LogServer: TRzLabel;
    laChangeConfig_LogServer: TRzLabel;
    laStart_LogServer: TRzLabel;
    RzSeparator7: TRzSeparator;
    laStop_LogServer: TRzLabel;
    laReloadConfig_LogServer: TRzLabel;
    tsLogServer: TRzTabSheet;
    laStartFullGameServerSystem: TRzLabel;
    laStopFullGameServerSystem: TRzLabel;
    CheckStatus: TTimer;
    StartServerSystem: TTimer;
    procedure laStart_LoginGateMouseEnter(Sender: TObject);
    procedure laStart_LoginGateMouseLeave(Sender: TObject);
    procedure laStart_LoginGateClick(Sender: TObject);
    procedure laStop_LoginGateClick(Sender: TObject);
    procedure laChangeConfig_LoginGateClick(Sender: TObject);
    procedure laReloadConfig_LoginGateClick(Sender: TObject);
    procedure StartServerSystemTimer(Sender: TObject);
    procedure CheckStatusTimer(Sender: TObject);
  private
    { Reload Config Handling }
    procedure ReloadConfig_LoginGate;
    procedure ReloadConfig_SelectCharGate;
    procedure ReloadConfig_RunGameGate;
    procedure ReloadConfig_LoginServer;
    procedure ReloadConfig_DBServer;
    procedure ReloadConfig_LogServer;
    procedure ReloadConfig_GameServer;
    { Message Handling }
    procedure CenterMessage(var Message: TWMCopyData); Message WM_COPYDATA;
    { Message Processing }
    procedure Process_Login_Gate_Message(AIdent: Word; AMessage: TWMCopyData);
    procedure Process_SelectChar_Gate_Message(AIdent: Word; AMessage: TWMCopyData);
    procedure Process_Run_Game_Gate_Message(AIdent: Word; AMessage: TWMCopyData);
    procedure Process_Login_Server_Message(AIdent: Word; AMessage: TWMCopyData);
    procedure Process_DataBase_Server_Message(AIdent: Word; AMessage: TWMCopyData);
    procedure Process_Game_Server_Message(AIdent: Word; AMessage: TWMCopyData);
    procedure Process_Log_Server_Message(AIdent: Word; AMessage: TWMCopyData);
  end;

var
  frmControlCenter: TfrmControlCenter;

implementation

{$R *.dfm}

  {$REGION ' - Button Handling '}
    // Start Service ( Gate and Server )
    procedure TfrmControlCenter.laStart_LoginGateClick(Sender: TObject);
    begin
      if (Sender is TRzLabel) then
      begin
        if TRzLabel(Sender).Font.Color <> $00828282 then
        begin
          case TRzLabel(Sender).Tag of
            { Gate Start }
            1:;
            2:;
            3:;
            { Server Start }
            4:;
            5:;
            6:;
            7:;
           11:; //Full Game Server System Start
          end;
        end;
      end;
    end;
    
    // Stop Service ( Gate and Server )
    procedure TfrmControlCenter.laStop_LoginGateClick(Sender: TObject);
    begin
      if (Sender is TRzLabel) then
      begin
        if TRzLabel(Sender).Font.Color <> $00828282 then
        begin
          case TRzLabel(Sender).Tag of
            { Gate Stop }
            1:;
            2:;
            3:;
            { Server Stop }
            4:;
            5:;
            6:;
            7:;
           11:; //Full Game Server System Stop            
          end;
        end;
      end;
    end;
    
    // Change Config Service ( Gate and Server and Admin )
    procedure TfrmControlCenter.laChangeConfig_LoginGateClick(Sender: TObject);
    begin
      if (Sender is TRzLabel) then
      begin
        if TRzLabel(Sender).Font.Color <> $00828282 then
        begin
          case TRzLabel(Sender).Tag of
            { Gate Change Config }
            1: pcMain.ActivePage := tsLoginGate;
            2: pcMain.ActivePage := tsSelectCharGate;
            3: pcMain.ActivePage := tsRunGameGate;
            { Server Change Config }
            4: pcMain.ActivePage := tsLoginServer;
            5: pcMain.ActivePage := tsDBServer;
            6: pcMain.ActivePage := tsLogServer;
            7: pcMain.ActivePage := tsGameServer;
            { Admin Change Config }
           10: pcMain.ActivePage := tsAdministration;
          end;
        end;
      end;
    end;
    
    // Reload Config Service ( Gate and Server )
    procedure TfrmControlCenter.laReloadConfig_LoginGateClick(Sender: TObject);
    begin
      if (Sender is TRzLabel) then
      begin
        if TRzLabel(Sender).Font.Color <> $00828282 then
        begin
          case TRzLabel(Sender).Tag of
            { Gate Reload Config }
            1: ReloadConfig_LoginGate;
            2: ReloadConfig_SelectCharGate;
            3: ReloadConfig_RunGameGate;
            { Server Reload Config }
            4: ReloadConfig_LoginServer;
            5: ReloadConfig_DBServer;
            6: ReloadConfig_LogServer;
            7: ReloadConfig_GameServer;
          end;
        end;
      end;
    end;
    
    procedure TfrmControlCenter.laStart_LoginGateMouseEnter(Sender: TObject);
    begin
      if (Sender is TRzLabel) then
      begin
        if TRzLabel(Sender).Font.Color = $00400000 then
        begin
          TRzLabel(Sender).Font.Color := $00A67000;
        end;
      end;
    end;
    
    procedure TfrmControlCenter.laStart_LoginGateMouseLeave(Sender: TObject);
    begin
      if (Sender is TRzLabel) then
      begin
        if TRzLabel(Sender).Font.Color = $00A67000 then
        begin
          TRzLabel(Sender).Font.Color := $00400000;
        end;
      end;
    end;
    
  {$ENDREGION}

  {$REGION ' - Reload Config Functions '}
    procedure TfrmControlCenter.ReloadConfig_LoginGate;
    begin
      try
    
      except
    
      end;
    end;
    
    procedure TfrmControlCenter.ReloadConfig_SelectCharGate;
    begin
      try
    
      except
    
      end;
    end;

    procedure TfrmControlCenter.ReloadConfig_RunGameGate;
    begin
      try
    
      except
    
      end;
    end;
    
    procedure TfrmControlCenter.ReloadConfig_LoginServer;
    begin
      try
    
      except
    
      end;
    end;
    
    procedure TfrmControlCenter.ReloadConfig_DBServer;
    begin
      try
    
      except
    
      end;
    end;

    procedure TfrmControlCenter.ReloadConfig_LogServer;
    begin
      try
    
      except
    
      end;
    end;
    
    procedure TfrmControlCenter.ReloadConfig_GameServer;
    begin
      try
    
      except
    
      end;
    end;

  {$ENDREGION}

  {$REGION ' - Message Handling and Processing Function '}
    procedure TfrmControlCenter.CenterMessage(var Message: TWMCopyData);
    var
      FIdent   : Word;
      FService : Word;
      FData    : String;
    begin
      FIdent   := HiWord(Message.From);
      FService := LoWord(Message.From);
      case FService of
        IDENT_LOGIN_GATE      : Process_Login_Gate_Message(FIdent, Message);
        IDENT_SELECTCHAR_GATE : Process_SelectChar_Gate_Message(FIdent, Message);
        IDENT_RUN_GAME_GATE   : Process_Run_Game_Gate_Message(FIdent, Message);
        IDENT_LOGIN_SERVER    : Process_Login_Server_Message(FIdent, Message);
        IDENT_DB_SERVER       : Process_DataBase_Server_Message(FIdent, Message);
        IDENT_GAME_SERVER     : Process_Game_Server_Message(FIdent, Message);
        IDENT_LOG_SERVER      : Process_Log_Server_Message(FIdent, Message);
      end;
    end;
    
    procedure TfrmControlCenter.Process_Login_Gate_Message(AIdent: Word; AMessage: TWMCopyData);
    begin //FData := StrPas(AMessage.CopyDataStruct^.lpData);
      case AIdent of
        SG_FORM_HANDLE :;

        SG_START_NOW:
        begin
          laStatus_LoginGate.Caption    := 'Starting';
          laStatus_LoginGate.Font.Color := $0000BFBF;
        end;

        SG_START_OK:
        begin
          laStatus_LoginGate.Caption    := 'Online';
          laStatus_LoginGate.Font.Color := $0000AA00;
        end;

        SG_STOP_OK:
        begin
          laStatus_LoginGate.Caption    := 'Online';
          laStatus_LoginGate.Font.Color := $00000093;
        end;
      end;
    end;
    
    procedure TfrmControlCenter.Process_SelectChar_Gate_Message(AIdent: Word; AMessage: TWMCopyData);
    begin //FData := StrPas(AMessage.CopyDataStruct^.lpData);
      case AIdent of
        SG_FORM_HANDLE :;

        SG_START_NOW:
        begin
          laStatus_SelectCharGate.Caption    := 'Starting';
          laStatus_SelectCharGate.Font.Color := $0000BFBF;
        end;

        SG_START_OK:
        begin
          laStatus_SelectCharGate.Caption    := 'Online';
          laStatus_SelectCharGate.Font.Color := $0000AA00;
        end;

        SG_STOP_OK:
        begin
          laStatus_SelectCharGate.Caption    := 'Online';
          laStatus_SelectCharGate.Font.Color := $00000093;
        end;
      end;
    end;
    
    procedure TfrmControlCenter.Process_Run_Game_Gate_Message(AIdent: Word; AMessage: TWMCopyData);
    begin //FData := StrPas(AMessage.CopyDataStruct^.lpData);
      case AIdent of
        SG_FORM_HANDLE :;

        SG_START_NOW:
        begin
          laStatus_RunGameGate.Caption    := 'Starting';
          laStatus_RunGameGate.Font.Color := $0000BFBF;
        end;

        SG_START_OK:
        begin
          laStatus_RunGameGate.Caption    := 'Online';
          laStatus_RunGameGate.Font.Color := $0000AA00;
        end;

        SG_STOP_OK:
        begin
          laStatus_RunGameGate.Caption    := 'Online';
          laStatus_RunGameGate.Font.Color := $00000093;
        end;
      end;
    end;
    
    procedure TfrmControlCenter.Process_Login_Server_Message(AIdent: Word; AMessage: TWMCopyData);
    begin //FData := StrPas(AMessage.CopyDataStruct^.lpData);
      case AIdent of
        SG_FORM_HANDLE :;

        SG_START_NOW:
        begin
          laStatus_LoginServer.Caption    := 'Starting';
          laStatus_LoginServer.Font.Color := $0000BFBF;
        end;

        SG_START_OK:
        begin
          laStatus_LoginServer.Caption    := 'Online';
          laStatus_LoginServer.Font.Color := $0000AA00;
        end;

        SG_STOP_OK:
        begin
          laStatus_LoginServer.Caption    := 'Online';
          laStatus_LoginServer.Font.Color := $00000093;
        end;
      end;
    end;
    
    procedure TfrmControlCenter.Process_DataBase_Server_Message(AIdent: Word; AMessage: TWMCopyData);
    begin //FData := StrPas(AMessage.CopyDataStruct^.lpData);
      case AIdent of
        SG_FORM_HANDLE :;

        SG_START_NOW:
        begin
          laStatus_DataBaseServer.Caption    := 'Starting';
          laStatus_DataBaseServer.Font.Color := $0000BFBF;
        end;

        SG_START_OK:
        begin
          laStatus_DataBaseServer.Caption    := 'Online';
          laStatus_DataBaseServer.Font.Color := $0000AA00;
        end;

        SG_STOP_OK:
        begin
          laStatus_DataBaseServer.Caption    := 'Online';
          laStatus_DataBaseServer.Font.Color := $00000093;
        end;
      end;
    end;
    
    procedure TfrmControlCenter.Process_Game_Server_Message(AIdent: Word; AMessage: TWMCopyData);
    begin //FData := StrPas(AMessage.CopyDataStruct^.lpData);
      case AIdent of
        SG_FORM_HANDLE :;

        SG_START_NOW:
        begin
          laStatus_GameServer.Caption    := 'Starting';
          laStatus_GameServer.Font.Color := $0000BFBF;
        end;

        SG_START_OK:
        begin
          laStatus_GameServer.Caption    := 'Online';
          laStatus_GameServer.Font.Color := $0000AA00;
        end;

        SG_STOP_OK:
        begin
          laStatus_GameServer.Caption    := 'Online';
          laStatus_GameServer.Font.Color := $00000093;
        end;
      end;
    end;
    
    procedure TfrmControlCenter.Process_Log_Server_Message(AIdent: Word; AMessage: TWMCopyData);
    begin //FData := StrPas(AMessage.CopyDataStruct^.lpData);
      case AIdent of
        SG_FORM_HANDLE :;

        SG_START_NOW:
        begin
          laStatus_LogServer.Caption    := 'Starting';
          laStatus_LogServer.Font.Color := $0000BFBF;
        end;

        SG_START_OK:
        begin
          laStatus_LogServer.Caption    := 'Online';
          laStatus_LogServer.Font.Color := $0000AA00;
        end;

        SG_STOP_OK:
        begin
          laStatus_LogServer.Caption    := 'Online';
          laStatus_LogServer.Font.Color := $00000093;
        end;
      end;
    end;
  {$ENDREGION}

  {$REGION ' - Button Handling '}
    procedure TfrmControlCenter.StartServerSystemTimer(Sender: TObject);
    begin
      //
    end;

    procedure TfrmControlCenter.CheckStatusTimer(Sender: TObject);
    begin
      //
    end;
  {$ENDREGION}

end.
