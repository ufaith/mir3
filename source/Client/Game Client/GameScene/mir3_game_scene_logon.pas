(*******************************************************************
 *   LomCN Mir3 Login Scene File 2013                              *
 *                                                                 *
 *   Web       : http://www.lomcn.co.uk                            *
 *   Version   : 0.0.0.1                                           *
 *                                                                 *
 *   - File Info -                                                 *
 *                                                                 *
 *                                                                 *
 *******************************************************************
 * Change History                                                  *
 *                                                                 *
 *  - 0.0.0.1 [2013-01-01] Coly : first init                       *
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
 
unit mir3_game_scene_logon;

interface

{$I DevelopmentDefinition.inc}

uses
{Delphi }  Windows, SysUtils, Classes,
{DirectX}  DXTypes, Direct3D9, D3DX9,
{Game   }  mir3_game_socket, mir3_game_en_decode, mir3_game_language_engine,
{Game   }  mir3_game_gui_definition, mir3_core_controls, mir3_global_config, mir3_game_sound_engine,
{Game   }  mir3_game_file_manager, mir3_game_file_manager_const, mir3_game_engine, mir3_misc_utils;

{ Callback Functions }
procedure LoginGUIEvent(AEventID: LongWord; AControlID: Cardinal; AControl: PMIR3_GUI_Default); stdcall;
procedure LoginGUIHotKeyEvent(AChar: LongWord); stdcall;


type
  TMir3GameSceneLogon = class(TMIR3_GUI_Manager)
  strict private
    FLastMessageError : Integer;
  public
    constructor Create;
    destructor Destroy; override;
  public
    procedure ResetScene;
    procedure ReceiveMessagePacket(AReceiveData: String);
    procedure SystemMessage(AMessage: String; AButtons: TMIR3_DLG_Buttons; AEventType: Integer);
    {Event Function}
    procedure Event_Logon_Check_Login_Data;
    procedure Event_System_Ok;
    procedure Event_System_Yes;
    procedure Event_System_No;
  end;

implementation

uses mir3_game_backend;

  {$REGION ' - TMir3GameSceneLogon :: constructor / destructor   '}
    constructor TMir3GameSceneLogon.Create;
    var
      FSystemForm : TMIR3_GUI_Form;
      FLoginForm  : TMIR3_GUI_Form;
    begin
      inherited Create;
      Self.DebugMode := False;
      Self.SetEventCallback(@LoginGUIEvent);
      Self.SetHotKeyEventCallback(@LoginGUIHotKeyEvent);

      { Create Login Forms and Controls }
      with FGame_GUI_Definition_Login do
      begin
        case FScreen_Width of
           800 : begin
             FLoginForm  := TMIR3_GUI_Form(Self.AddForm(FLogin_Background_800, True));
             Self.AddControl(FLoginForm, FLogin_Animation_2_800       , True);
             Self.AddControl(FLoginForm, FLogin_Animation_1_800       , True);
             Self.AddControl(FLoginForm, FLogin_Animation_3_800       , True);
             Self.AddControl(FLoginForm, FLogin_Animation_4_800       , True);
             Self.AddControl(FLoginForm, FLogin_Mir3LogoPanel_800     , True);
             Self.AddControl(FLoginForm, FLogin_BackPanel_800         , True);
             Self.AddControl(FLoginForm, FLogin_EditField_User_800    , True);
             Self.AddControl(FLoginForm, FLogin_EditField_Password_800, True);
             Self.AddControl(FLoginForm, FLogin_Button_Exit_800       , True);
             Self.AddControl(FLoginForm, FLogin_Button_Login_800      , True);
             Self.AddControl(FLoginForm, FLogin_Button_URL_1_800      , True);
             Self.AddControl(FLoginForm, FLogin_Button_URL_2_800      , True);
           end;
          1024 : begin
             FLoginForm  := TMIR3_GUI_Form(Self.AddForm(FLogin_Background_1024, True));
             Self.AddControl(FLoginForm, FLogin_Animation_2_1024       , True);
             Self.AddControl(FLoginForm, FLogin_Animation_1_1024       , True);
             Self.AddControl(FLoginForm, FLogin_Animation_3_1024       , True);
             Self.AddControl(FLoginForm, FLogin_Animation_4_1024       , True);
             Self.AddControl(FLoginForm, FLogin_Mir3LogoPanel_1024     , True);
             Self.AddControl(FLoginForm, FLogin_BackPanel_1024         , True);
             Self.AddControl(FLoginForm, FLogin_EditField_User_1024    , True);
             Self.AddControl(FLoginForm, FLogin_EditField_Password_1024, True);
             Self.AddControl(FLoginForm, FLogin_Button_Exit_1024       , True);
             Self.AddControl(FLoginForm, FLogin_Button_Login_1024      , True);
             Self.AddControl(FLoginForm, FLogin_Button_URL_1_1024      , True);
             Self.AddControl(FLoginForm, FLogin_Button_URL_2_1024      , True);
           end;
        end;
      end;
      
      { Create System Forms and Controls }
      FSystemForm := TMIR3_GUI_Form(Self.AddForm(FGame_GUI_Definition_System.FSys_Dialog_Info, False));
      Self.AddControl(FSystemForm, FGame_GUI_Definition_System.FSys_Dialog_Text , True);
      Self.AddControl(FSystemForm, FGame_GUI_Definition_System.FSys_Button_Ok   , False);
      Self.AddControl(FSystemForm, FGame_GUI_Definition_System.FSys_Button_Yes  , False);
      Self.AddControl(FSystemForm, FGame_GUI_Definition_System.FSys_Button_No   , False);                                                                            ;
    end;
    
    destructor TMir3GameSceneLogon.Destroy;
    begin
    
      inherited;
    end;

    procedure TMir3GameSceneLogon.ResetScene;
    begin
      GGameEngine.SoundManager.StopBackgroundMusic;
      GGameEngine.SoundManager.PlayBackgroundMusic('Main.wes', True);
    end;
  {$ENDREGION}

  {$REGION ' - TMir3GameSceneLogon :: Scene Funtions             '}
  procedure TMir3GameSceneLogon.SystemMessage(AMessage: String; AButtons: TMIR3_DLG_Buttons; AEventType: Integer);
  begin
    if mbOK in AButtons then
      TMIR3_GUI_Button(GetComponentByID(GUI_ID_SYSINFO_BUTTON_OK)).Visible := True
    else TMIR3_GUI_Button(GetComponentByID(GUI_ID_SYSINFO_BUTTON_OK)).Visible := False;

    if mbYes in AButtons then
      TMIR3_GUI_Button(GetComponentByID(GUI_ID_SYSINFO_BUTTON_YES)).Visible := True
    else TMIR3_GUI_Button(GetComponentByID(GUI_ID_SYSINFO_BUTTON_YES)).Visible := False;

    if mbNo in AButtons then
      TMIR3_GUI_Button(GetComponentByID(GUI_ID_SYSINFO_BUTTON_NO)).Visible := True
    else TMIR3_GUI_Button(GetComponentByID(GUI_ID_SYSINFO_BUTTON_NO)).Visible := False;

    SetZOrder(TMIR3_GUI_Form(GetFormByID(GUI_ID_SYSINFO_DIALOG)));
    TMIR3_GUI_Panel(GetComponentByID(GUI_ID_SYSINFO_PANEL)).Caption := PWideChar(AMessage);
    TMIR3_GUI_Form(GetFormByID(GUI_ID_SYSINFO_DIALOG)).EventTypeID  := AEventType;
    TMIR3_GUI_Form(GetFormByID(GUI_ID_SYSINFO_DIALOG)).Visible := True;
  end;
  {$ENDREGION}

  {$REGION ' - TMir3GameSceneLogon :: Login Message Decoder      '}
    procedure TMir3GameSceneLogon.ReceiveMessagePacket(AReceiveData: String);
    var
      FAvailIDDay  : Word;
      FAvailIDHour : Word;
      FAvailIPDay  : Word;
      FAvailIPHour : Word;
      FNetPort     : String;
      FNetHost     : String;
      FUserCert    : String;
      FTempBody    : String;
      FMessageHead : String;
      FMessageBody : String;
      FMessage     : TDefaultMessage;
    begin
      FMessageHead := Copy(AReceiveData, 1, DEFBLOCKSIZE);
      FMessageBody := Copy(AReceiveData, DEFBLOCKSIZE + 1, Length(AReceiveData) - DEFBLOCKSIZE);
      FMessage     := DecodeMessage(FMessageHead);

      case FMessage.Ident of
        SM_OUTOFCONNECTION    : begin
          SystemMessage(GGameEngine.GameLanguage.GetTextFromLangSystem(50), [mbOK],0);
        end;
        SM_LOGIN_PASSWORD_FAIL: begin
          FLastMessageError := FMessage.Recog;
          case FLastMessageError of
            -1:  SystemMessage(GGameEngine.GameLanguage.GetTextFromLangSystem(16),[mbOK], 0);
            -2:  SystemMessage(GGameEngine.GameLanguage.GetTextFromLangSystem(17),[mbOK], 0);
            -3:  SystemMessage(GGameEngine.GameLanguage.GetTextFromLangSystem(18),[mbOK], 0);
            -4:  SystemMessage(GGameEngine.GameLanguage.GetTextFromLangSystem(19),[mbOK], 0);
            -5:  SystemMessage(GGameEngine.GameLanguage.GetTextFromLangSystem(20),[mbOK], 0);
            else SystemMessage(GGameEngine.GameLanguage.GetTextFromLangSystem(21),[mbOK], 0);
          end;
        end;
        SM_LOGIN_PASSWORD_OK  : begin
          FAvailIDDay  := Loword(FMessage.Recog);
          FAvailIDHour := Hiword(FMessage.Recog);
          FAvailIPDay  := FMessage.Param;
          FAvailIPHour := FMessage.Tag;

          if FAvailIDDay > 0 then
          begin
            if FAvailIDDay = 1 then
              SystemMessage(GGameEngine.GameLanguage.GetTextFromLangSystem(26),[mbOK], 0)
            else if FAvailIDDay <= 3 then
                   SystemMessage(Format(GGameEngine.GameLanguage.GetTextFromLangSystem(27), [IntToStr(FAvailIDDay)]),[mbOK], 0);
          end else if FAvailIPDay > 0 then
                   begin
                     if FAvailIPDay = 1 then
                        SystemMessage(GGameEngine.GameLanguage.GetTextFromLangSystem(29),[mbOK], 0)
                     else if FAvailIPDay <= 3 then
                            SystemMessage(Format(GGameEngine.GameLanguage.GetTextFromLangSystem(28), [IntToStr(FAvailIPDay)]),[mbOK], 0);
                   end else if FAvailIPHour > 0 then
                            begin
                              if FAvailIPHour <= 100 then
                                 SystemMessage(Format(GGameEngine.GameLanguage.GetTextFromLangSystem(30), [IntToStr(FAvailIPHour)]),[mbOK], 0);
                            end else if FAvailIDHour > 0 then
                                     begin
                                       SystemMessage(Format(GGameEngine.GameLanguage.GetTextFromLangSystem(31), [IntToStr(FAvailIDHour)]),[mbOK], 0);
                                     end;

          GGameEngine.Send_Select_Server(DeCodeString(GGameEngine.GameLauncherSetting.FServer_1_Name));
        end;
        SM_SELECTSERVER_OK    : begin
          Self.HideAllForms;
          { Hide Login Scene (later with fadeout) }
          FTempBody := DecodeString(FMessageBody);
          FTempBody := GetValidStr3(FTempBody, FNetHost , ['/']);
          FTempBody := GetValidStr3(FTempBody, FNetPort , ['/']);
          FTempBody := GetValidStr3(FTempBody, FUserCert, ['/']);
          GGameEngine.Certification := StrToIntDef(FUserCert, 0);
          GGameEngine.GameSceneStep := gsScene_SelChar;
          with GGameEngine.GameNetwork do
          begin
            Active  := False;
            Address := FNetHost;
            Port    := StrToIntDef(FNetPort, 0);
            Active  := True;
          end;
        end;
        SM_VERSION_FAIL       : begin // Client Version Fail
         //      LoginScene.HideLoginBox;
         //      FrmDlg.DMessageDlg ('Wrong version. Please download latest version. (http://www.....)', [mbOk]);
         //      FrmMain.Close
        end;        
      end;
    end;
  {$ENDREGION}

  {$REGION ' - TMir3GameSceneLogon :: Event Funktion             '}
    procedure TMir3GameSceneLogon.Event_Logon_Check_Login_Data;
    var
      FUserName : String;
      FPassword : String;
    begin
      FUserName := 'Test'; //TMIR3_GUI_Edit(GetComponentByID(GUI_ID_LOGIN_EDIT_USER)).Text;
      FPassword := 'Test';//TMIR3_GUI_Edit(GetComponentByID(GUI_ID_LOGIN_EDIT_PASSWORD)).Text;
      if (Trim(FUserName) <> '') and (Trim(FPassword) <> '') then
      begin
        GGameEngine.Send_Login(FUserName, FPassword);
      end else if (Trim(FUserName) = '') then
               begin
                 TMIR3_GUI_Edit(GetComponentByID(GUI_ID_LOGIN_EDIT_USER)).SetFocus;
               end else if (Trim(FPassword) = '') then
                        begin
                          TMIR3_GUI_Edit(GetComponentByID(GUI_ID_LOGIN_EDIT_PASSWORD)).SetFocus;
                        end;
    end;

    procedure TMir3GameSceneLogon.Event_System_Ok;
    begin
      case TMIR3_GUI_Form(GetFormByID(GUI_ID_SYSINFO_DIALOG)).EventTypeID of
        0:;
        1: SendMessage(GRenderEngine.GetGameHWND, $0010, 0, 0);
      end;
      case FLastMessageError of
        0:; // TODO : we can handle error better here
      end;
      TMIR3_GUI_Form(GetFormByID(GUI_ID_SYSINFO_DIALOG)).Visible := False;
    end;

    procedure TMir3GameSceneLogon.Event_System_Yes;
    begin
      case TMIR3_GUI_Form(GetFormByID(GUI_ID_SYSINFO_DIALOG)).EventTypeID of
        0:;
        1:;
        2: SendMessage(GRenderEngine.GetGameHWND, $0010, 0, 0);
      end;
      TMIR3_GUI_Form(GetFormByID(GUI_ID_SYSINFO_DIALOG)).Visible := False;
    end;

    procedure TMir3GameSceneLogon.Event_System_No;
    begin
      TMIR3_GUI_Form(GetFormByID(GUI_ID_SYSINFO_DIALOG)).Visible := False;
    end;

  {$ENDREGION}


  {$REGION ' - Callback Event Function   '}
    procedure LoginGUIEvent(AEventID: LongWord; AControlID: Cardinal; AControl: PMIR3_GUI_Default); stdcall;
    begin
      case AEventID of
        EVENT_BUTTON_UP : begin
          {$REGION ' - EVENT_BUTTON_CLICKED '}
          case AControl.ControlIdentifier of
            GUI_ID_LOGIN_BUTTON_EXIT   : GGameEngine.SceneLogon.SystemMessage(GGameEngine.GameLanguage.GetTextFromLangSystem(13),[mbYes, mbNo], 2);
            GUI_ID_LOGIN_BUTTON_LOGIN  : GGameEngine.SceneLogon.Event_Logon_Check_Login_Data;
            GUI_ID_LOGIN_BUTTON_URL_1  : BrowseURL(DeCodeString(GGameEngine.GameLauncherSetting.FRegister_URL));
            GUI_ID_LOGIN_BUTTON_URL_2  : BrowseURL(DeCodeString(GGameEngine.GameLauncherSetting.FAccount_URL));
            (* System Buttons *)
            GUI_ID_SYSINFO_BUTTON_OK   : GGameEngine.SceneLogon.Event_System_Ok;
            GUI_ID_SYSINFO_BUTTON_YES  : GGameEngine.SceneLogon.Event_System_Yes;
            GUI_ID_SYSINFO_BUTTON_NO   : GGameEngine.SceneLogon.Event_System_No;
          end;

          {$ENDREGION}           
        end;
        EVENT_EDITBOX_RETURN  : begin
          {$REGION ' - EVENT_EDITBOX_RETURN '}
           GGameEngine.SceneLogon.Event_Logon_Check_Login_Data;
          {$ENDREGION}
        end;
	  end;
    end;

    procedure LoginGUIHotKeyEvent(AChar: LongWord); stdcall;
    begin
      case Chr(AChar) of
        'N' : BrowseURL(DeCodeString(GGameEngine.GameLauncherSetting.FRegister_URL));
        'P' : BrowseURL(DeCodeString(GGameEngine.GameLauncherSetting.FAccount_URL));
        'L' : GGameEngine.SceneLogon.Event_Logon_Check_Login_Data;
        'X' : GGameEngine.SceneLogon.SystemMessage(GGameEngine.GameLanguage.GetTextFromLangSystem(13),[mbYes, mbNo], 2);
      end;
    end;
  {$ENDREGION}
  
end.