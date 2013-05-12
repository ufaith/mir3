(*****************************************************************************************
 *   LomCN Mir3 Select Server Scene File 2013                                            *
 *                                                                                       *
 *   Web       : http://www.lomcn.co.uk                                                  *
 *   Version   : 0.0.0.1                                                                 *
 *                                                                                       *
 *   - File Info -                                                                       *
 *                                                                                       *
 *                                                                                       *
 *****************************************************************************************
 * Change History                                                                        *
 *                                                                                       *
 *  - 0.0.0.1 [2013-05-10] Coly : first init                                             *
 *                                                                                       *
 *                                                                                       *
 *                                                                                       *
 *                                                                                       *
 *                                                                                       *
 *****************************************************************************************
 *  - TODO List for this *.pas file -                                                    *
 *---------------------------------------------------------------------------------------*
 *  if a todo finished, then delete it here...                                           *
 *  if you find a global TODO thats need to do, then add it here..                       *
 *---------------------------------------------------------------------------------------*
 *                                                                                       *
 *  - TODO : -all -fill *.pas header information                                         *
 *                 (how to need this file etc.)                                          *
 *                                                                                       *
 *****************************************************************************************)
unit mir3_game_scene_select_server;

interface

{$I DevelopmentDefinition.inc}

uses
{Delphi }  Windows, SysUtils, Classes,
{DirectX}  DXTypes, Direct3D9, D3DX9,
{Game   }  mir3_game_socket, mir3_game_en_decode, mir3_game_language_engine, mir3_global_config,
{Game   }  mir3_game_gui_definition_system, mir3_game_gui_definition_select_server, mir3_core_controls, 
{Game   }  mir3_game_file_manager, mir3_game_file_manager_const, mir3_game_engine, mir3_misc_utils,
{Game   }  mir3_game_sound_engine;

{ Callback Functions }
procedure SelectServerGUIEvent(AEventID: LongWord; AControlID: Cardinal; AControl: PMIR3_GUI_Default); stdcall;
procedure SelectServerGUIHotKeyEvent(AChar: LongWord); stdcall;


type
  TMir3GameSceneSelectServer = class(TMIR3_GUI_Manager)
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
    procedure Event_System_Ok;
    procedure Event_System_Yes;
    procedure Event_System_No;
    procedure EventSetServerCount(AServerCount: Integer);
    procedure Event_Select_Server_1;
    procedure Event_Select_Server_2;
    procedure Event_Select_Server_3;
    procedure Event_Select_Server_4;    
  end;

implementation

uses mir3_game_backend;

  {$REGION ' - TMir3GameSceneSelectServer :: constructor / destructor   '}
    constructor TMir3GameSceneSelectServer.Create;
    var
      FSystemForm       : TMIR3_GUI_Form;
      FSelectServerForm : TMIR3_GUI_Form;
    begin
      inherited Create;
      Self.DebugMode := False;
      Self.SetEventCallback(@SelectServerGUIEvent);
      Self.SetHotKeyEventCallback(@SelectServerGUIHotKeyEvent);

      { Create Logon Info Forms and Controls }
      with FGame_GUI_Definition_SelectServer do
      begin
        case FScreen_Width of
           800 : begin
             FSelectServerForm  := TMIR3_GUI_Form(Self.AddForm(FSelectServer_Background_800, True));
             Self.AddControl(FSelectServerForm, FSelectServer_Animation_1_800,  True);
             Self.AddControl(FSelectServerForm, FSelectServer_MIR3_Logo_1_800 , True);             
             Self.AddControl(FSelectServerForm, FSelectServer_Animation_2_800,  True);
             Self.AddControl(FSelectServerForm, FSelectServer_Back_Panel_1_800, True);
             Self.AddControl(FSelectServerForm, FSelectServer_Back_Panel_2_800, True);
             Self.AddControl(FSelectServerForm, FSelectServer_Back_Panel_3_800, True);
             Self.AddControl(FSelectServerForm, FSelectServer_Btn_Server_1_800, True);
             Self.AddControl(FSelectServerForm, FSelectServer_Btn_Server_2_800, True);
             Self.AddControl(FSelectServerForm, FSelectServer_Btn_Server_3_800, True);
             Self.AddControl(FSelectServerForm, FSelectServer_Btn_Server_4_800, True);
           end;
          1024 : begin
             FSelectServerForm  := TMIR3_GUI_Form(Self.AddForm(FSelectServer_Background_1024, True));
             Self.AddControl(FSelectServerForm, FSelectServer_Animation_1_1024,  True);
             Self.AddControl(FSelectServerForm, FSelectServer_MIR3_Logo_1_1024 , True);
             Self.AddControl(FSelectServerForm, FSelectServer_Animation_2_1024,  True);
             Self.AddControl(FSelectServerForm, FSelectServer_Back_Panel_1_1024, True);
             Self.AddControl(FSelectServerForm, FSelectServer_Back_Panel_2_1024, True);
             Self.AddControl(FSelectServerForm, FSelectServer_Back_Panel_3_1024, True);
             Self.AddControl(FSelectServerForm, FSelectServer_Btn_Server_1_1024, True);
             Self.AddControl(FSelectServerForm, FSelectServer_Btn_Server_2_1024, True);
             Self.AddControl(FSelectServerForm, FSelectServer_Btn_Server_3_1024, True);
             Self.AddControl(FSelectServerForm, FSelectServer_Btn_Server_4_1024, True);
           end;
        end;
      end;

      TMIR3_GUI_Button(GetComponentByID(GUI_ID_SEL_SERVER_BTN_SERVER_1)).Caption := 'Test Server 1';
      TMIR3_GUI_Button(GetComponentByID(GUI_ID_SEL_SERVER_BTN_SERVER_2)).Caption := 'Test Server 2';
      TMIR3_GUI_Button(GetComponentByID(GUI_ID_SEL_SERVER_BTN_SERVER_3)).Caption := 'Test Server 3';
      TMIR3_GUI_Button(GetComponentByID(GUI_ID_SEL_SERVER_BTN_SERVER_4)).Caption := 'Test Server 4';

      { Create System Forms and Controls }
      FSystemForm := TMIR3_GUI_Form(Self.AddForm(FGame_GUI_Definition_System.FSys_Dialog_Info, False));
      Self.AddControl(FSystemForm, FGame_GUI_Definition_System.FSys_Dialog_Text , True);
      Self.AddControl(FSystemForm, FGame_GUI_Definition_System.FSys_Button_Ok   , False);
      Self.AddControl(FSystemForm, FGame_GUI_Definition_System.FSys_Button_Yes  , False);
      Self.AddControl(FSystemForm, FGame_GUI_Definition_System.FSys_Button_No   , False);                                                                           ;
    end;
    
    destructor TMir3GameSceneSelectServer.Destroy;
    begin
    
      inherited;
    end;
    
    procedure TMir3GameSceneSelectServer.ResetScene;
    begin
      // Debug, later move to ServerSelection
      EventSetServerCount(1);
    end;
  {$ENDREGION}
  
  {$REGION ' - TMir3GameSceneSelectServer :: Select Server Message Decoder  '}
    procedure TMir3GameSceneSelectServer.ReceiveMessagePacket(AReceiveData: String);
    var
      //FNetPort       : String;
      //FNetHost       : String;
      //FTempBody      : String;
      //FTempString    : String;
      FMessageHead   : String;
      FMessageBody   : String;
      FMessage       : TDefaultMessage;
    begin
      FMessageHead := Copy(AReceiveData, 1, DEFBLOCKSIZE);
      FMessageBody := Copy(AReceiveData, DEFBLOCKSIZE + 1, Length(AReceiveData) - DEFBLOCKSIZE);
      FMessage     := DecodeMessage(FMessageHead);

      case FMessage.Ident of
        SM_STARTPLAY          : begin // Start Game
          //SendRunLogin;
        end;
        SM_STARTFAIL          : begin // Start Game Fail
          
        end;
      end;
    end;
  {$ENDREGION}  

  {$REGION ' - TMir3GameSceneSelectServer :: Scene Funtions                 '}
  procedure TMir3GameSceneSelectServer.SystemMessage(AMessage: String; AButtons: TMIR3_DLG_Buttons; AEventType: Integer);
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
    TMIR3_GUI_Form(GetFormByID(GUI_ID_SYSINFO_DIALOG)).Visible      := True;
  end;
  {$ENDREGION}

  {$REGION ' - TMir3GameSceneSelectServer :: Event Funktion                 '}

    procedure TMir3GameSceneSelectServer.Event_System_Ok;
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

    procedure TMir3GameSceneSelectServer.Event_System_Yes;
    begin
      case TMIR3_GUI_Form(GetFormByID(GUI_ID_SYSINFO_DIALOG)).EventTypeID of
        0:;
        1:;
        2: SendMessage(GRenderEngine.GetGameHWND, $0010, 0, 0);
      end;
      TMIR3_GUI_Form(GetFormByID(GUI_ID_SYSINFO_DIALOG)).Visible := False;
    end;

    procedure TMir3GameSceneSelectServer.Event_System_No;
    begin
      TMIR3_GUI_Form(GetFormByID(GUI_ID_SYSINFO_DIALOG)).Visible := False;
    end;

    procedure TMir3GameSceneSelectServer.EventSetServerCount(AServerCount: Integer);
    begin
      case AServerCount of
        0 ,
        1 : begin
          TMIR3_GUI_Button(GetComponentByID(GUI_ID_SEL_SERVER_BTN_SERVER_1)).Visible := True;
          TMIR3_GUI_Button(GetComponentByID(GUI_ID_SEL_SERVER_BTN_SERVER_2)).Visible := False;
          TMIR3_GUI_Button(GetComponentByID(GUI_ID_SEL_SERVER_BTN_SERVER_3)).Visible := False;
          TMIR3_GUI_Button(GetComponentByID(GUI_ID_SEL_SERVER_BTN_SERVER_4)).Visible := False;
          TMIR3_GUI_Panel(GetComponentByID(GUI_ID_SEL_SERVER_BACK_PANEL_PART_2)).FGUI_Definition.gui_Repeat_Count   := 3;
          if FScreen_Width <> 1024 then
          begin
            TMIR3_GUI_Panel(GetComponentByID(GUI_ID_SEL_SERVER_BACK_PANEL_PART_3)).FTop := 262;
          end else begin
            TMIR3_GUI_Panel(GetComponentByID(GUI_ID_SEL_SERVER_BACK_PANEL_PART_3)).FTop := 292;
          end;
        end;
        2 : begin
          TMIR3_GUI_Button(GetComponentByID(GUI_ID_SEL_SERVER_BTN_SERVER_1)).Visible := True;
          TMIR3_GUI_Button(GetComponentByID(GUI_ID_SEL_SERVER_BTN_SERVER_2)).Visible := True;
          TMIR3_GUI_Button(GetComponentByID(GUI_ID_SEL_SERVER_BTN_SERVER_3)).Visible := False;
          TMIR3_GUI_Button(GetComponentByID(GUI_ID_SEL_SERVER_BTN_SERVER_4)).Visible := False;
          TMIR3_GUI_Panel(GetComponentByID(GUI_ID_SEL_SERVER_BACK_PANEL_PART_2)).FGUI_Definition.gui_Repeat_Count   := 8;
          if FScreen_Width <> 1024 then
          begin
            TMIR3_GUI_Panel(GetComponentByID(GUI_ID_SEL_SERVER_BACK_PANEL_PART_3)).FTop := 302;
          end else begin
            TMIR3_GUI_Panel(GetComponentByID(GUI_ID_SEL_SERVER_BACK_PANEL_PART_3)).FTop := 332;
          end;
        end;
        3 : begin
          TMIR3_GUI_Button(GetComponentByID(GUI_ID_SEL_SERVER_BTN_SERVER_1)).Visible := True;
          TMIR3_GUI_Button(GetComponentByID(GUI_ID_SEL_SERVER_BTN_SERVER_2)).Visible := True;
          TMIR3_GUI_Button(GetComponentByID(GUI_ID_SEL_SERVER_BTN_SERVER_3)).Visible := True;
          TMIR3_GUI_Button(GetComponentByID(GUI_ID_SEL_SERVER_BTN_SERVER_4)).Visible := False;
          TMIR3_GUI_Panel(GetComponentByID(GUI_ID_SEL_SERVER_BACK_PANEL_PART_2)).FGUI_Definition.gui_Repeat_Count   := 12;
          if FScreen_Width <> 1024 then
          begin
            TMIR3_GUI_Panel(GetComponentByID(GUI_ID_SEL_SERVER_BACK_PANEL_PART_3)).FTop := 341;
          end else begin
            TMIR3_GUI_Panel(GetComponentByID(GUI_ID_SEL_SERVER_BACK_PANEL_PART_3)).FTop := 371;
          end;
        end;
        4 : begin
          TMIR3_GUI_Button(GetComponentByID(GUI_ID_SEL_SERVER_BTN_SERVER_1)).Visible := True;
          TMIR3_GUI_Button(GetComponentByID(GUI_ID_SEL_SERVER_BTN_SERVER_2)).Visible := True;
          TMIR3_GUI_Button(GetComponentByID(GUI_ID_SEL_SERVER_BTN_SERVER_3)).Visible := True;
          TMIR3_GUI_Button(GetComponentByID(GUI_ID_SEL_SERVER_BTN_SERVER_4)).Visible := True;
          TMIR3_GUI_Panel(GetComponentByID(GUI_ID_SEL_SERVER_BACK_PANEL_PART_2)).FGUI_Definition.gui_Repeat_Count   := 16;
          if FScreen_Width <> 1024 then
          begin
            TMIR3_GUI_Panel(GetComponentByID(GUI_ID_SEL_SERVER_BACK_PANEL_PART_3)).FTop := 380;
          end else begin
            TMIR3_GUI_Panel(GetComponentByID(GUI_ID_SEL_SERVER_BACK_PANEL_PART_3)).FTop := 409;
          end;
        end;
      end;
    end;

    procedure TMir3GameSceneSelectServer.Event_Select_Server_1;
    begin
      //add Server Select things
      GGameEngine.FGame_Scene_Step := gsScene_SelChar;
    end;

    procedure TMir3GameSceneSelectServer.Event_Select_Server_2;
    begin
      //add Server Select things
      GGameEngine.FGame_Scene_Step := gsScene_SelChar;
    end;

    procedure TMir3GameSceneSelectServer.Event_Select_Server_3;
    begin
      //add Server Select things
      GGameEngine.FGame_Scene_Step := gsScene_SelChar;
    end;

    procedure TMir3GameSceneSelectServer.Event_Select_Server_4;
    begin
      //add Server Select things
      GGameEngine.FGame_Scene_Step := gsScene_SelChar;
    end;     

  {$ENDREGION}

  
  {$REGION ' - Callback Event Function   '}
    procedure SelectServerGUIEvent(AEventID: LongWord; AControlID: Cardinal; AControl: PMIR3_GUI_Default); stdcall;
    begin
      case AEventID of
        EVENT_BUTTON_UP : begin
          {$REGION ' - EVENT_BUTTON_CLICKED '}
          case AControl.ControlIdentifier of
            (* System Buttons *)
            GUI_ID_SYSINFO_BUTTON_OK       : GGameEngine.SceneSelectServer.Event_System_Ok;
            GUI_ID_SYSINFO_BUTTON_YES      : GGameEngine.SceneSelectServer.Event_System_Yes;
            GUI_ID_SYSINFO_BUTTON_NO       : GGameEngine.SceneSelectServer.Event_System_No;
            // Server Selection Button
            GUI_ID_SEL_SERVER_BTN_SERVER_1 :GGameEngine.SceneSelectServer.Event_Select_Server_1;
            GUI_ID_SEL_SERVER_BTN_SERVER_2 :GGameEngine.SceneSelectServer.Event_Select_Server_2;
            GUI_ID_SEL_SERVER_BTN_SERVER_3 :GGameEngine.SceneSelectServer.Event_Select_Server_3;
            GUI_ID_SEL_SERVER_BTN_SERVER_4 :GGameEngine.SceneSelectServer.Event_Select_Server_4;
          end;
          {$ENDREGION}
        end;
	  end;
    end;

    procedure SelectServerGUIHotKeyEvent(AChar: LongWord); stdcall;
    begin
      //case Chr(AChar) of
        //'N' : BrowseURL(DeCodeString(GGameEngine.GameLauncherSetting.FRegister_URL));
      //end;
    end;
  {$ENDREGION}

end.
