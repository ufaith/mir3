unit mir3_launcher_main;

interface

uses
{ Delphi }
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, ExtCtrls, OleCtrls, SHDocVw, MSHTML,
{ Raize }
  RzCmboBx, RzButton,RzTabs, RzStatus, RzRadChk, RzBmpBtn, RzPanel,
{ Game }
  mir3_game_config_definition, mir3_launcher_language, mir3_game_en_decode;

type
  { TfrmLauncherMain }
  TfrmLauncherMain = class(TForm)
    verInfo: TRzVersionInfo;
    laVerInfo: TRzVersionInfoStatus;
    imgBackground: TImage;
    btnClose: TRzBmpButton;
    wbGameServerNews: TWebBrowser;
    btnStartGame: TRzBmpButton;
    Image1: TImage;
    Image2: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Image3: TImage;
    Image4: TImage;
    Label3: TLabel;
    imgLogo: TImage;
    Label4: TLabel;
    btnGameOption: TRzBmpButton;
    RzBmpButton2: TRzBmpButton;
    RzBmpButton3: TRzBmpButton;
    plGameOption: TRzPanel;
    cbLanguage: TRzComboBox;
    procedure btnStartGameClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure wbGameServerNewsDocumentComplete(ASender: TObject; const pDisp: IDispatch; var URL: OleVariant);
    procedure FormCreate(Sender: TObject);
    procedure btnGameOptionClick(Sender: TObject);
    procedure imgBackgroundMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure cbLanguageChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    FLib_Path                : String;
    FGameSystemConfig        : TMir3_GameSystemConfig;
    FGameSystemConfigVersion : TMir3_GameSystemConfigVersion;
    FLanguageEngine          : TMir3_LauncherLanguageEngine;
  private
    procedure ProcessConfigFile;
  public
    { Public - Declarations }
  end;

var
  frmLauncherMain: TfrmLauncherMain;

implementation

{$R *.dfm}

uses ActiveX;


  {$REGION ' - Help functions '}
    procedure TfrmLauncherMain.ProcessConfigFile;
    var
      FTempMem : TMemoryStream;

      procedure CreateDefaultFile;
      begin
        ZeroMemory(@FGameSystemConfig       , SizeOf(TMir3_GameSystemConfig));
        ZeroMemory(@FGameSystemConfigVersion, SizeOf(TMir3_GameSystemConfigVersion));

        with FGameSystemConfigVersion do
        begin
          FFileTypeInfo      := FILE_TYPE_INFO;
          FConfigFileVersion := 1;
        end;
        FTempMem.WriteBuffer(FGameSystemConfigVersion, SizeOf(TMir3_GameSystemConfigVersion));

        with FGameSystemConfig do
        begin
          FServer_Count                := 1;
          FServer_1_Name               := EncodeString('TestServer');  //EncodeString('LomCNTitanBeta');
          FServer_1_Caption            := EncodeString('Test Server'); //EncodeString('LomCN Titan Beta');
          FServer_1_IP                 := EncodeString('127.0.0.1');
          FServer_1_Port               := 7000;
          FServer_2_Name               := EncodeString('-');
          FServer_2_Caption            := EncodeString('-');
          FServer_2_IP                 := EncodeString('0.0.0.0');
          FServer_2_Port               := 0;
          FServer_3_Name               := EncodeString('-');
          FServer_3_Caption            := EncodeString('-');
          FServer_3_IP                 := EncodeString('0.0.0.0');
          FServer_3_Port               := 0;
          FServer_4_Name               := EncodeString('-');
          FServer_4_Caption            := EncodeString('-');
          FServer_4_IP                 := EncodeString('0.0.0.0');
          FServer_4_Port               := 0;
          { Update System }
          FUpdateServer_Host           := EncodeString('-');
          FUpdateServer_Port           := 0;
          FUpdateServer_Protocol       := 1;
          FUpdateServer_User           := EncodeString('-');
          FUpdateServer_Password       := EncodeString('-');
          FUpdateBaseDirectory         := EncodeString('-');
          FUpdate_Passive_Mode         := True;
          FUpdate_List_File            := '!lomcn_mir3_list.lst.gz';
          { Fallback System }
          FFallbackServer_Host         := EncodeString('-');
          FFallbackServer_Port         := 0;
          FFallbackServer_Protocol     := 1;
          FFallbackServer_User         := EncodeString('-');
          FFallbackServer_Password     := EncodeString('-');
          FFallbackServerBaseDirectory := EncodeString('-');
          FFallbackServer_Passive_Mode := True;
          FFallbackServer_List_File    := EncodeString('!lomcn_mir3_fallback.fbs.gz');
          FFallbackServer_As_Update    := False;
          { Option System }
          FUse_Update_Service          := True;
          FUse_Fallback_Service        := True;
          FUse_HomePage_Btn            := True;
          FUse_Account_Btn             := True;
          FUse_ChangePassword_Btn      := True;
          FUse_Option_Btn              := True;
          FUse_News_Page               := True;
          { Page Set System }
          FPageSetCount                := 0;
        end;
        FTempMem.WriteBuffer(FGameSystemConfig, SizeOf(TMir3_GameSystemConfig));
        FTempMem.Seek(0,0);
        FTempMem.SaveToFile(FLib_Path + 'Mir3.conf');
      end;

    begin
      FTempMem := TMemoryStream.Create;
      try
        if FileExists(FLib_Path + 'Mir3.conf') then
        begin
          ZeroMemory(@FGameSystemConfig       , SizeOf(TMir3_GameSystemConfig));
          ZeroMemory(@FGameSystemConfigVersion, SizeOf(TMir3_GameSystemConfigVersion));
          FTempMem.LoadFromFile(FLib_Path + 'Mir3.conf');
          FTempMem.Seek(0,0);
          FTempMem.ReadBuffer(FGameSystemConfigVersion, SizeOf(TMir3_GameSystemConfigVersion));
          if FGameSystemConfigVersion.FConfigFileVersion <> 1 then
          begin
            CreateDefaultFile;
          end;

          FTempMem.ReadBuffer(FGameSystemConfig, SizeOf(TMir3_GameSystemConfig));
          if FGameSystemConfig.FUse_Account_Btn then
          begin
            btnGameOption.Visible := False;
          end;
        end else begin
          CreateDefaultFile;
        end;
      finally
        FTempMem.Clear;
        FreeAndNil(FTempMem);
      end;
    end;
  {$ENDREGION}

  {$REGION ' - WebBrowser functions '}
    procedure WB_Set3DBorderStyle(Sender: TObject; bValue: Boolean);
    var
      FDocument       : IHTMLDocument2;
      FElement        : IHTMLElement;
      FStrBorderStyle : String;
    begin
      FDocument := TWebBrowser(Sender).Document as IHTMLDocument2;
      if Assigned(FDocument) then
      begin
        FElement := FDocument.Body;
        if FElement <> nil then
        begin
          case BValue of
            False : FStrBorderStyle := 'none';
            True  : FStrBorderStyle := '';
          end;
          FElement.Style.BorderStyle := FStrBorderStyle;
        end;
      end;
    end;

    procedure WB_LoadHTML(WebBrowser: TWebBrowser; HTMLCode: string);
    var
      sl: TStringList;
      ms: TMemoryStream;
    begin
      WebBrowser.Navigate('http://www.world-of-illusion.net/launch/LomCN/launcherpage.html');
      //WebBrowser.Navigate('http://www.mir3.co.kr/notice/client_frm_brdlist_ad_new.asp');
      WebBrowser.Left   := 3;
      WebBrowser.Top    := 22;
      WebBrowser.Width  := 794;
      WebBrowser.Height := 413;
      while WebBrowser.ReadyState < READYSTATE_INTERACTIVE do
        Application.ProcessMessages;
    end;

    procedure TfrmLauncherMain.wbGameServerNewsDocumentComplete(ASender: TObject; const pDisp: IDispatch; var URL: OleVariant);
    begin
      WB_Set3DBorderStyle(ASender, False);
    end;
  {$ENDREGION}

procedure TfrmLauncherMain.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmLauncherMain.btnGameOptionClick(Sender: TObject);
begin
  if plGameOption.Visible then
  begin
    plGameOption.Visible     := False;
    wbGameServerNews.Visible := True;
    //TODO : Save Option
  end else begin
    wbGameServerNews.Visible := False;
    plGameOption.Visible     := True;
  end;
end;

procedure TfrmLauncherMain.btnStartGameClick(Sender: TObject);
//var
  //FMModuleInfoNode : ProcessModuleInfo;//_ModuleInfoNode;
begin
  { Start Game }

// TODO : -Coly -Add LDR Hide via PEB system to prevent Script Cheat Kiddys... (Need Admin Rights...)
//               (Flip Double linked lists in LDR Header in user mode)

//  WinExec(PChar(ExtractFilePath(ParamStr(0)) + '\Mir3Client.exe'), SW_SHOW);
//  if not CreateProcess(nil, PChar(FCommandLine), nil, nil, True, 0, nil, PChar(FCurDirectory), FStartupInfo, AProgramInfo.prProcessInfo) then
//  begin
//    Result := GetLastError();
//  end;
end;

// Option Page
procedure TfrmLauncherMain.cbLanguageChange(Sender: TObject);
begin
  //TODO : Change Language
end;

  {$REGION ' - Form functions '}
    procedure TfrmLauncherMain.FormClose(Sender: TObject; var Action: TCloseAction);
    begin
      FreeAndNil(FLanguageEngine);
    end;

    procedure TfrmLauncherMain.FormCreate(Sender: TObject);
    begin
      FLib_Path := ExtractFilePath(ParamStr(0))+'lib\';

      if FileExists(FLib_Path + 'Mir3_Logo.bmp') then
      begin
        imgLogo.Picture.LoadFromFile(FLib_Path + 'Mir3_Logo.bmp');
      end;

      ProcessConfigFile;

      FLanguageEngine := TMir3_LauncherLanguageEngine.Create('English.lgu');
      cbLanguage.Items.Clear;
      FLanguageEngine.FindLanguageFile(FLib_Path, cbLanguage.Items, '.LGU', True);
      WB_LoadHTML(wbGameServerNews, '');
    end;

    procedure TfrmLauncherMain.imgBackgroundMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    const
      SC_DRAGMOVE = $F012;
    begin
      if Button = mbleft then
      begin
        ReleaseCapture;
        frmLauncherMain.Perform(WM_SYSCOMMAND, SC_DRAGMOVE, 0);
      end;
    end;
  {$ENDREGION}

end.
