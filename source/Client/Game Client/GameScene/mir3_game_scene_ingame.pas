unit mir3_game_scene_ingame;

interface

uses
{Delphi }  Windows, SysUtils, Classes, JSocket,
{DirectX}  DXTypes, Direct3D9, D3DX9,
{Game   }  mir3_game_en_decode, mir3_game_language_engine,
{Game   }  mir3_game_gui_defination, mir3_core_controls, mir3_global_config, mir3_game_sound,
{Game   }  mir3_game_file_manager, mir3_game_file_manager_const, mir3_game_engine, mir3_misc_utils;

{ Callback Functions }
    procedure InGameGUIEvent(AEventID: LongWord; AControlID: Cardinal; AControl: TMIR3_GUI_Default); stdcall;
    function GamePreProcessing(AD3DDevice: IDirect3DDevice9; AElapsedTime: Single; ADebugMode: Boolean): HRESULT; stdcall;
    function GamePostProcessing(AD3DDevice: IDirect3DDevice9; AElapsedTime: Single; ADebugMode: Boolean): HRESULT; stdcall;

(*
  C_MODE_ALL      :
  C_MODE_PEACE    :
  C_MODE_DEAR     :
  C_MODE_MASTER   :
  C_MODE_GROUP    :
  C_MODE_GUILD    :
  C_MODE_PKATTACK :
*)


type
  TMir3GameSceneInGame = class(TMIR3_GUI_Manager)
  strict private  
	{ .... }
    FTextureListNPC     : TList;   // 
    FTextureListBag     : TList;   // 
    FTextureListGround  : TList;   // 
    FTextureListEquip   : TList;   // 
    FTextureListWeapon  : TList;   // 
    FTextureListHuman   : TList;   //
    FLastMessageError   : Integer;  
  strict private
    procedure Create_ExitWindow_UI_Interface;
    procedure Create_Bottm_UI_Interface;
    procedure Create_MenueBar_UI_Interface;
    procedure Create_Belt_UI_Interface;
    procedure Create_Body_UI_Interface;
    procedure Create_Body_Show_UI_Interface;
    procedure Create_Minimap_UI_Interface;
    procedure Create_GameSetting_UI_Interface;
    procedure Create_Trade_UI_Interface;
    procedure Create_Group_UI_Interface;
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
    procedure EventExitWindow(AEventType: Integer; AEventControl: Integer);
    procedure EventBottomWindow(AEventType: Integer; AEventControl: Integer);
    procedure EventBeltWindow(AEventType: Integer; AEventControl: Integer);
    procedure EventMiniMapWindow(AEventType: Integer; AEventControl: Integer);
    procedure EventMenueBarWindow(AEventType: Integer; AEventControl: Integer);
    procedure EventGameSettingWindow(AEventType: Integer; AEventControl: Integer);
    procedure EventBodyWindow(AEventType: Integer; AEventControl: Integer);
    procedure EventBodyShowWindow(AEventType: Integer; AEventControl: Integer);
    procedure EventMagicWindowWindow(AEventType: Integer; AEventControl: Integer);
  end;

implementation

uses mir3_game_backend;


  {$REGION ' - TMir3GameSceneInGame :: InGame Forms and Controls Constructor '}
    procedure TMir3GameSceneInGame.Create_ExitWindow_UI_Interface;
    var
      FExitWindow  : TMIR3_GUI_Form;
    begin
      with FGame_GUI_Defination_InGame do
      begin
        { Create Ingame Static Base UI Forms and Controls }
        FExitWindow  := TMIR3_GUI_Form(Self.AddForm(FInGame_UI_ExitWindow_Background, False));
        Self.AddControl(FExitWindow, FInGame_UI_Exit_Text_Info  , True);
        Self.AddControl(FExitWindow, FInGame_UI_Exit_Btn_Exit   , True);
        Self.AddControl(FExitWindow, FInGame_UI_Exit_Btn_Logout , True);
        Self.AddControl(FExitWindow, FInGame_UI_Exit_Btn_Close  , True);
      end;
    end;

    procedure TMir3GameSceneInGame.Create_Bottm_UI_Interface;
    var
      FBottomForm       : TMIR3_GUI_Form;
      FBottomAvatarForm : TMIR3_GUI_Form;
    begin
      with FGame_GUI_Defination_InGame do
      begin
        { Create Ingame Static Base UI Forms and Controls }
        FBottomAvatarForm := TMIR3_GUI_Form(Self.AddForm(FInGame_UI_Bottom_Avatar_Background, True));
        Self.AddControl(FBottomAvatarForm, FInGame_UI_Bottom_Panel_Avatar_LowB  , True);
        Self.AddControl(FBottomAvatarForm, FInGame_UI_Bottom_Panel_Avatar_Low   , True);
        Self.AddControl(FBottomAvatarForm, FInGame_UI_Bottom_Panel_Avatar_HighB , False);
        Self.AddControl(FBottomAvatarForm, FInGame_UI_Bottom_Panel_Avatar_High  , False);

        { Create Ingame Static Base UI Forms and Controls }
        FBottomForm  := TMIR3_GUI_Form(Self.AddForm(FInGame_UI_Bottom_Background, True));
        // Rigth Button Menue
        Self.AddControl(FBottomForm, FInGame_UI_Bottom_Button_1_Body    , True);
        Self.AddControl(FBottomForm, FInGame_UI_Bottom_Button_2_Bag     , True);
        Self.AddControl(FBottomForm, FInGame_UI_Bottom_Button_3_Magic   , True);
        Self.AddControl(FBottomForm, FInGame_UI_Bottom_Button_4_Trade   , True);
        Self.AddControl(FBottomForm, FInGame_UI_Bottom_Button_5_Belt    , True);
        Self.AddControl(FBottomForm, FInGame_UI_Bottom_Button_6_MiniMap , True);
        Self.AddControl(FBottomForm, FInGame_UI_Bottom_Button_7_Quest   , True);
        Self.AddControl(FBottomForm, FInGame_UI_Bottom_Button_8_Setting , True);

        //Textbutton = SC DC MC BC Switch the Power types
        Self.AddControl(FBottomForm, FInGame_UI_Bottom_Button_Power    , True);
        Self.AddControl(FBottomForm, FInGame_UI_Bottom_Button_Power    , True);
        Self.AddControl(FBottomForm, FInGame_UI_Bottom_Button_BA       , True);
        Self.AddControl(FBottomForm, FInGame_UI_Bottom_TextField_Class , True);
        Self.AddControl(FBottomForm, FInGame_UI_Bottom_TextField_Level , True);
        Self.AddControl(FBottomForm, FInGame_UI_Bottom_TextField_FP    , True);
        Self.AddControl(FBottomForm, FInGame_UI_Bottom_TextField_Power , True); //DC SC MC BC
        Self.AddControl(FBottomForm, FInGame_UI_Bottom_TextField_AC    , True);
        Self.AddControl(FBottomForm, FInGame_UI_Bottom_TextField_MA    , True);

        // HP / MP / Exp / BagW Gauge
        Self.AddControl(FBottomForm, FInGame_UI_Bottom_Gauge_HP        , True);
        Self.AddControl(FBottomForm, FInGame_UI_Bottom_Gauge_MP        , True);
        Self.AddControl(FBottomForm, FInGame_UI_Bottom_Gauge_Exp       , True);
        Self.AddControl(FBottomForm, FInGame_UI_Bottom_Gauge_Bag_Size  , True);
      end;
    end;
    
    procedure TMir3GameSceneInGame.Create_MenueBar_UI_Interface;
    var
      FMenueBar : TMIR3_GUI_Form;
    begin
      with FGame_GUI_Defination_InGame do
      begin
        { Create Ingame Movable Base Menue Bar UI Forms and Controls }
        FMenueBar  := TMIR3_GUI_Form(Self.AddForm(FGame_GUI_Defination_InGame.FInGame_UI_Menue_Bar_Background, False));
        Self.AddControl(FMenueBar, FInGame_UI_Menue_Bar_Btn_Setting  , True);
        Self.AddControl(FMenueBar, FInGame_UI_Menue_Bar_Btn_Chat     , True);
        Self.AddControl(FMenueBar, FInGame_UI_Menue_Bar_Btn_Mail     , True);
        Self.AddControl(FMenueBar, FInGame_UI_Menue_Bar_Btn_Group    , True);
        Self.AddControl(FMenueBar, FInGame_UI_Menue_Bar_Btn_Guild    , True);
        Self.AddControl(FMenueBar, FInGame_UI_Menue_Bar_Btn_Avatar   , True);
        Self.AddControl(FMenueBar, FInGame_UI_Menue_Bar_Btn_Siege    , True);
        Self.AddControl(FMenueBar, FInGame_UI_Menue_Bar_Btn_Exit     , True);
        Self.AddControl(FMenueBar, FInGame_UI_Menue_Bar_Btn_Features , True);
        Self.AddControl(FMenueBar, FInGame_UI_Menue_Bar_Btn_Close    , True);
      end;
    end;     
    
    procedure TMir3GameSceneInGame.Create_Belt_UI_Interface;
    var
      FBeldForm : TMIR3_GUI_Form;
    begin
      with FGame_GUI_Defination_InGame do
      begin
        { Create Ingame Movable Base Belt UI Forms and Controls }
        FBeldForm  := TMIR3_GUI_Form(Self.AddForm(FGame_GUI_Defination_InGame.FInGame_UI_Belt_Background_H, False));
        Self.AddControl(FBeldForm, FInGame_UI_Belt_Btn_Close_H    , True);
        Self.AddControl(FBeldForm, FInGame_UI_Belt_Btn_Rotate_H   , True);
        Self.AddControl(FBeldForm, FInGame_UI_Belt_Item_Field_H_1 , True);
        Self.AddControl(FBeldForm, FInGame_UI_Belt_Item_Field_H_2 , True);
        Self.AddControl(FBeldForm, FInGame_UI_Belt_Item_Field_H_3 , True);
        Self.AddControl(FBeldForm, FInGame_UI_Belt_Item_Field_H_4 , True);
        Self.AddControl(FBeldForm, FInGame_UI_Belt_Item_Field_H_5 , True);
        Self.AddControl(FBeldForm, FInGame_UI_Belt_Item_Field_H_6 , True);
      end;
    end;    

    procedure TMir3GameSceneInGame.Create_Body_UI_Interface;
    var
      FBodyForm  : TMIR3_GUI_Form;
    begin
      with FGame_GUI_Defination_InGame do
      begin
        { Create Ingame Static Base UI Forms and Controls }
        FBodyForm  := TMIR3_GUI_Form(Self.AddForm(FInGame_UI_Body_Window, False));
        Self.AddControl(FBodyForm, FInGame_UI_Body_Btn_Close , True);
        //Self.AddControl(FBodyForm, FGame_GUI_Defination_InGame.FInGame_UI_MiniMap_ , True);
        //Self.AddControl(FBodyForm, FGame_GUI_Defination_InGame.FInGame_UI_MiniMap_ , True);
      end;
    end;

    procedure TMir3GameSceneInGame.Create_Body_Show_UI_Interface;
    var
      FBodyShowForm  : TMIR3_GUI_Form;
    begin
      with FGame_GUI_Defination_InGame do
      begin
        { Create Ingame Static Base UI Forms and Controls }
        FBodyShowForm  := TMIR3_GUI_Form(Self.AddForm(FInGame_UI_Body_Show_Window, False));
        Self.AddControl(FBodyShowForm, FInGame_UI_Body_Show_Btn_Close , True);
        //Self.AddControl(FBodyShowForm, FInGame_UI_ , True);
        //Self.AddControl(FBodyShowForm, FInGame_UI_ , True);
      end;
    end;

    procedure TMir3GameSceneInGame.Create_Minimap_UI_Interface;
    //var
      //FMiniMapFormOpen  : TMIR3_GUI_Form;
      //FMiniMapFormClose : TMIR3_GUI_Form;
    begin
       // MiniMap Control Bauen?
      with FGame_GUI_Defination_InGame do
      begin
        { Create Ingame Static Base UI Forms and Controls }
        //FMiniMapFormClose  := TMIR3_GUI_Form(Self.AddForm(FGame_GUI_Defination_InGame.FInGame_UI_MiniMap_Background, True));
        //Self.AddControl(FSystemForm, FGame_GUI_Defination_InGame.FInGame_UI_MiniMap_ , True);
        //Self.AddControl(FSystemForm, FGame_GUI_Defination_InGame.FInGame_UI_MiniMap_ , True);
        //Self.AddControl(FSystemForm, FGame_GUI_Defination_InGame.FInGame_UI_MiniMap_ , True);
      end;
    end;

    procedure TMir3GameSceneInGame.Create_GameSetting_UI_Interface;
    var
      FGameSetting  : TMIR3_GUI_Form;
    begin
      with FGame_GUI_Defination_InGame do
      begin
        { Create Ingame Static Base UI Forms and Controls }
        FGameSetting  := TMIR3_GUI_Form(Self.AddForm(FInGame_UI_GameSetting_Background, False));

        Self.AddControl(FGameSetting, FInGame_UI_GameSetting_Btn_Basic        , True);
        Self.AddControl(FGameSetting, FInGame_UI_GameSetting_Btn_Permit       , True);
        Self.AddControl(FGameSetting, FInGame_UI_GameSetting_Btn_Chatting     , True);
        Self.AddControl(FGameSetting, FInGame_UI_GameSetting_Btn_Visual       , True);
        {Slider}
        Self.AddControl(FGameSetting, FInGame_UI_GameSetting_Volume_BGM       , True);
        Self.AddControl(FGameSetting, FInGame_UI_GameSetting_Volume_SFX       , True);
        (* Page 1 (Basic) *)
        Self.AddControl(FGameSetting, FInGame_UI_GameSetting_Btn_1_P1         , True);
        Self.AddControl(FGameSetting, FInGame_UI_GameSetting_TextField_1_P1   , True);
        Self.AddControl(FGameSetting, FInGame_UI_GameSetting_Btn_2_P1         , True);
        Self.AddControl(FGameSetting, FInGame_UI_GameSetting_TextField_2_P1   , True);
        Self.AddControl(FGameSetting, FInGame_UI_GameSetting_Btn_3_P1         , True);
        Self.AddControl(FGameSetting, FInGame_UI_GameSetting_TextField_3_P1   , True);
        Self.AddControl(FGameSetting, FInGame_UI_GameSetting_Btn_4_P1         , True);
        Self.AddControl(FGameSetting, FInGame_UI_GameSetting_TextField_4_P1   , True);
        Self.AddControl(FGameSetting, FInGame_UI_GameSetting_Btn_5_P1         , True);
        Self.AddControl(FGameSetting, FInGame_UI_GameSetting_TextField_5_P1   , True);
        Self.AddControl(FGameSetting, FInGame_UI_GameSetting_Btn_6_P1         , True);
        Self.AddControl(FGameSetting, FInGame_UI_GameSetting_TextField_6_P1   , True);
        Self.AddControl(FGameSetting, FInGame_UI_GameSetting_Btn_7_P1         , True);
        Self.AddControl(FGameSetting, FInGame_UI_GameSetting_TextField_7_P1   , True);
        (* Page 2 (Permit) *)
        Self.AddControl(FGameSetting, FInGame_UI_GameSetting_Btn_1_P2         , False);
        Self.AddControl(FGameSetting, FInGame_UI_GameSetting_TextField_1_P2   , False);
        Self.AddControl(FGameSetting, FInGame_UI_GameSetting_Btn_2_P2         , False);
        Self.AddControl(FGameSetting, FInGame_UI_GameSetting_TextField_2_P2   , False);
        Self.AddControl(FGameSetting, FInGame_UI_GameSetting_Btn_3_P2         , False);
        Self.AddControl(FGameSetting, FInGame_UI_GameSetting_TextField_3_P2   , False);
        Self.AddControl(FGameSetting, FInGame_UI_GameSetting_Btn_4_P2         , False);
        Self.AddControl(FGameSetting, FInGame_UI_GameSetting_TextField_4_P2   , False);
        Self.AddControl(FGameSetting, FInGame_UI_GameSetting_Btn_5_P2         , False);
        Self.AddControl(FGameSetting, FInGame_UI_GameSetting_TextField_5_P2   , False);
        (* Page 3 (Chatting) *)
        Self.AddControl(FGameSetting, FInGame_UI_GameSetting_Btn_1_P3         , False);
        Self.AddControl(FGameSetting, FInGame_UI_GameSetting_TextField_1_P3   , False);
        Self.AddControl(FGameSetting, FInGame_UI_GameSetting_Btn_2_P3         , False);
        Self.AddControl(FGameSetting, FInGame_UI_GameSetting_TextField_2_P3   , False);

        Self.AddControl(FGameSetting, FInGame_UI_GameSetting_Btn_4_P3         , False);
        Self.AddControl(FGameSetting, FInGame_UI_GameSetting_TextField_4_P3   , False);
        Self.AddControl(FGameSetting, FInGame_UI_GameSetting_Btn_5_P3         , False);
        Self.AddControl(FGameSetting, FInGame_UI_GameSetting_TextField_5_P3   , False);
        (* Page 4 (Visual) *)
        Self.AddControl(FGameSetting, FInGame_UI_GameSetting_Btn_1_P4         , False);
        Self.AddControl(FGameSetting, FInGame_UI_GameSetting_TextField_1_P4   , False);
        Self.AddControl(FGameSetting, FInGame_UI_GameSetting_Btn_2_P4         , False);
        Self.AddControl(FGameSetting, FInGame_UI_GameSetting_TextField_2_P4   , False);
        Self.AddControl(FGameSetting, FInGame_UI_GameSetting_Btn_3_P4         , False);
        Self.AddControl(FGameSetting, FInGame_UI_GameSetting_TextField_3_P4   , False);
        Self.AddControl(FGameSetting, FInGame_UI_GameSetting_Btn_4_P4         , False);
        Self.AddControl(FGameSetting, FInGame_UI_GameSetting_TextField_4_P4   , False);
        Self.AddControl(FGameSetting, FInGame_UI_GameSetting_Btn_5_P4         , False);
        Self.AddControl(FGameSetting, FInGame_UI_GameSetting_TextField_5_P4   , False);
        Self.AddControl(FGameSetting, FInGame_UI_GameSetting_Btn_6_P4         , False);
        Self.AddControl(FGameSetting, FInGame_UI_GameSetting_TextField_6_P4   , False);
        Self.AddControl(FGameSetting, FInGame_UI_GameSetting_Btn_7_P4         , False);
        Self.AddControl(FGameSetting, FInGame_UI_GameSetting_TextField_7_P4   , False);
        Self.AddControl(FGameSetting, FInGame_UI_GameSetting_Btn_8_P4         , False);
        Self.AddControl(FGameSetting, FInGame_UI_GameSetting_TextField_8_P4   , False);
        Self.AddControl(FGameSetting, FInGame_UI_GameSetting_Btn_9_P4         , False);
        Self.AddControl(FGameSetting, FInGame_UI_GameSetting_TextField_9_P4   , False);
        Self.AddControl(FGameSetting, FInGame_UI_GameSetting_Btn_10_P4        , False);
        Self.AddControl(FGameSetting, FInGame_UI_GameSetting_TextField_10_P4  , False);
        Self.AddControl(FGameSetting, FInGame_UI_GameSetting_Btn_Close        , True);
      end;
    end;

    procedure TMir3GameSceneInGame.Create_Trade_UI_Interface;
    //var
      //FTradeForm  : TMIR3_GUI_Form;
    begin
      with FGame_GUI_Defination_InGame do
      begin
        { Create Ingame Static Base UI Forms and Controls }
        //FTradeForm  := TMIR3_GUI_Form(Self.AddForm(FInGame_UI_Trade_Window, False));
        //Self.AddControl(FTradeForm, FInGame_UI_ , True);
        //Self.AddControl(FTradeForm, FInGame_UI_ , True);
        //Self.AddControl(FTradeForm, FInGame_UI_ , True);
      end;
    end;

    procedure TMir3GameSceneInGame.Create_Group_UI_Interface;
    //var
      //FGroupForm  : TMIR3_GUI_Form;
    begin
      with FGame_GUI_Defination_InGame do
      begin
        { Create Ingame Static Base UI Forms and Controls }
        //FGroupForm  := TMIR3_GUI_Form(Self.AddForm(FInGame_UI_Group_Window, False));
        //Self.AddControl(FGroupForm, FInGame_UI_ , True);
        //Self.AddControl(FGroupForm, FInGame_UI_ , True);
        //Self.AddControl(FGroupForm, FInGame_UI_ , True);
      end;
    end;




  {$ENDREGION}

  {$REGION ' - TMir3GameSceneInGame :: Scene Funtions             '}
  procedure TMir3GameSceneInGame.SystemMessage(AMessage: String; AButtons: TMIR3_DLG_Buttons; AEventType: Integer);
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

    if mbEditField in AButtons then
      TMIR3_GUI_Edit(GetComponentByID(GUI_ID_SYSINFO_EDIT_FIELD)).Visible := True
    else TMIR3_GUI_Edit(GetComponentByID(GUI_ID_SYSINFO_EDIT_FIELD)).Visible := False;

    TMIR3_GUI_Panel(GetComponentByID(GUI_ID_SYSINFO_PANEL)).Caption := AMessage;
    TMIR3_GUI_Form(GetFormByID(GUI_ID_SYSINFO_DIALOG)).EventTypeID  := AEventType;
    TMIR3_GUI_Form(GetFormByID(GUI_ID_SYSINFO_DIALOG)).Visible      := True;
  end;
  {$ENDREGION}
  
  {$REGION ' - TMir3GameSceneInGame :: constructor / destructor   '}
    constructor TMir3GameSceneInGame.Create;
    var
      FSystemForm : TMIR3_GUI_Form;    
    begin
      inherited Create;
      Self.DebugMode := False;
      Self.SetEventCallback(@InGameGUIEvent);
      Self.SetPreProcessingCallback(@GamePreProcessing);
      Self.SetPostProcessingCallback(@GamePostProcessing);
      
	  {Declare Game Lists}
      FTextureListNPC           := TList.Create;   // 
      FTextureListBag           := TList.Create;   // 
      FTextureListGround        := TList.Create;   // 
      FTextureListEquip         := TList.Create;   // 
      FTextureListWeapon        := TList.Create;   // 
      FTextureListHuman         := TList.Create;   //        
      
      (* Begin Ingame Controls *)
       // Only ADD here all GUI Forms thats is not a UI elemend
      Create_Belt_UI_Interface;
      Create_Body_UI_Interface;
      Create_Body_Show_UI_Interface;
      Create_GameSetting_UI_Interface;
      Create_Trade_UI_Interface;
      Create_Group_UI_Interface;
      (* End Ingame Controls *)

      // Static Elements
      Create_Bottm_UI_Interface;      
      Create_Minimap_UI_Interface;
      Create_MenueBar_UI_Interface;
      Create_ExitWindow_UI_Interface;

      { Create System Forms and Controls }
      with FGame_GUI_Defination_System do
      begin
        FSystemForm := TMIR3_GUI_Form(Self.AddForm(FSys_Dialog_Info, False));
        Self.AddControl(FSystemForm, FSys_Dialog_Text       , True);
        Self.AddControl(FSystemForm, FSys_Dialog_Edit_Field , False);
        Self.AddControl(FSystemForm, FSys_Button_Ok         , False);
        Self.AddControl(FSystemForm, FSys_Button_Yes        , False);
        Self.AddControl(FSystemForm, FSys_Button_No         , False);
      end;
    end;
    
    destructor TMir3GameSceneInGame.Destroy;
    begin
      (* TODO -all List Items , check if  clean*)
      if Assigned(FTextureListNPC) then
	      FreeAndNil(FTextureListNPC);

      if Assigned(FTextureListBag) then
	      FreeAndNil(FTextureListBag);

      if Assigned(FTextureListGround) then
	      FreeAndNil(FTextureListGround);

      if Assigned(FTextureListEquip) then
	      FreeAndNil(FTextureListEquip);

      if Assigned(FTextureListWeapon) then
	      FreeAndNil(FTextureListWeapon);

      if Assigned(FTextureListHuman) then
	      FreeAndNil(FTextureListHuman);    
      inherited;
    end;

    procedure TMir3GameSceneInGame.ResetScene;
    begin
      GGameEngine.SoundManager.StopBackgroundMusic;
      // Reset all Game Vars
      // Notice / Load Scene?
    end;
  {$ENDREGION}

  {$REGION ' - TMir3GameSceneInGame :: Login Message Decoder      '}
    procedure TMir3GameSceneInGame.ReceiveMessagePacket(AReceiveData: String);
    var
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
        0:;
      end;
    end;
  {$ENDREGION}

  {$REGION ' - TMir3GameSceneInGame :: Event Funktion             '}
    procedure TMir3GameSceneInGame.Event_System_Ok;
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

    procedure TMir3GameSceneInGame.Event_System_Yes;
    begin
      case TMIR3_GUI_Form(GetFormByID(GUI_ID_SYSINFO_DIALOG)).EventTypeID of
        0:;
        1:;
      end;
      TMIR3_GUI_Form(GetFormByID(GUI_ID_SYSINFO_DIALOG)).Visible := False;
    end;

    procedure TMir3GameSceneInGame.Event_System_No;
    begin
      case TMIR3_GUI_Form(GetFormByID(GUI_ID_SYSINFO_DIALOG)).EventTypeID of
        0:;
        1:;
      end;
      TMIR3_GUI_Form(GetFormByID(GUI_ID_SYSINFO_DIALOG)).Visible := False;
    end;

    procedure TMir3GameSceneInGame.EventExitWindow(AEventType: Integer; AEventControl: Integer);
    begin
      case AEventType of
        EVENT_BUTTON_UP   : begin
          case AEventControl of
            GUI_ID_INGAME_EXIT_BTN_UI_EXIT    : SendMessage(GRenderEngine.GetGameHWND, $0010, 0, 0);
            GUI_ID_INGAME_EXIT_BTN_UI_LOGOUT  :;
            GUI_ID_INGAME_EXIT_BTN_UI_CLOSE   : begin
              TMIR3_GUI_Form(GetFormByID(GUI_ID_INGAME_EXIT_WINDOW_UI_WINDOW)).Visible := False;
            end;
          end;
        end;
      end;
    end;

    procedure TMir3GameSceneInGame.EventBottomWindow(AEventType: Integer; AEventControl: Integer);

      procedure ShowHideAvatarWindow;
      begin
        if TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_BOTTOM_UI_AVATAR_LOW_PANEL)).Visible then
        begin
          TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_BOTTOM_UI_AVATAR_LOW_PANEL)).Visible       := False;
          TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_BOTTOM_UI_AVATAR_LOW_PANEL_BACK)).Visible  := False;
          TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_BOTTOM_UI_AVATAR_HIGH_PANEL)).Visible      := True;
          TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_BOTTOM_UI_AVATAR_HIGH_PANEL_BACK)).Visible := True;
        end else begin
          TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_BOTTOM_UI_AVATAR_LOW_PANEL)).Visible       := True;
          TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_BOTTOM_UI_AVATAR_LOW_PANEL_BACK)).Visible  := True;
          TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_BOTTOM_UI_AVATAR_HIGH_PANEL)).Visible      := False;
          TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_BOTTOM_UI_AVATAR_HIGH_PANEL_BACK)).Visible := False;
        end;
      end;

    begin
      case AEventType of
        EVENT_BUTTON_UP   : begin
          case AEventControl of
            0:; //411..420
            GUI_ID_INGAME_BOTTOM_UI_BUTTON_1_BODY       : begin
              //Open Own Body View
              TMIR3_GUI_Form(GetFormByID(GUI_ID_INGAME_BODY_UI_WINDOW)).Visible :=
              not (TMIR3_GUI_Form(GetFormByID(GUI_ID_INGAME_BODY_UI_WINDOW)).Visible);
            end;
            GUI_ID_INGAME_BOTTOM_UI_BUTTON_2_BAG        : begin
              //Open Own Bag (Base bag)
              //TMIR3_GUI_Form(GetFormByID(GUI_ID_INGAME_BAG_BASE_UI_WINDOW)).Visible := True;
            end;
            GUI_ID_INGAME_BOTTOM_UI_BUTTON_3_MAGIC      : begin
              // Open Magic Window (Look if WAR/WIZ/TAO or Assassin)
              (*
              case job of
                C_WARRIOR  ,
                C_WIZZARD  ,
                C_TAOIST   : begin
                  TMIR3_GUI_Form(GetFormByID(GUI_ID_INGAME_MAGIC_UI_BASE_WINDOW)).Visible := True;
                end;
                C_ASSASSIN : begin
                  TMIR3_GUI_Form(GetFormByID(GUI_ID_INGAME_MAGIC_UI_ASSASSIN_WINDOW)).Visible := True;
                end;
              end; 
              *)
            end;
            GUI_ID_INGAME_BOTTOM_UI_BUTTON_4_TRADE      : begin
             //TMIR3_GUI_Form(GetFormByID(GUI_ID_INGAME_TRADE_UI_WINDOW)).Visible := True;

             {Only for test }
             TMIR3_GUI_Form(GetFormByID(GUI_ID_INGAME_BODY_SHOW_UI_WINDOW)).Visible := not
             (TMIR3_GUI_Form(GetFormByID(GUI_ID_INGAME_BODY_SHOW_UI_WINDOW)).Visible);

            end;
            GUI_ID_INGAME_BOTTOM_UI_BUTTON_5_BELT       : begin
              TMIR3_GUI_Form(GetFormByID(GUI_ID_INGAME_BELT_UI_BACKGROUND)).Visible :=
              not (TMIR3_GUI_Form(GetFormByID(GUI_ID_INGAME_BELT_UI_BACKGROUND)).Visible);
            end;
            GUI_ID_INGAME_BOTTOM_UI_BUTTON_6_MINIMAP    : begin
            //TMIR3_GUI_Form(GetFormByID(GUI_ID_INGAME_MINIMAP_UI_WINDOW)).Visible := True;
            end;
            GUI_ID_INGAME_BOTTOM_UI_BUTTON_7_QUEST      : begin
            //TMIR3_GUI_Form(GetFormByID(GUI_ID_INGAME_QUEST_UI_WINDOW)).Visible := True;
            end;
            GUI_ID_INGAME_BOTTOM_UI_BUTTON_8_SETTING    : begin
              TMIR3_GUI_Form(GetFormByID(GUI_ID_INGAME_MENUEBAR_UI_WINDOW)).Visible :=
              not(TMIR3_GUI_Form(GetFormByID(GUI_ID_INGAME_MENUEBAR_UI_WINDOW)).Visible);
            end;   
            GUI_ID_INGAME_BOTTOM_UI_BUTTON_POWER        : begin

            end;
            GUI_ID_INGAME_BOTTOM_UI_BUTTON_BC           : begin

            end;
            GUI_ID_INGAME_BOTTOM_UI_AVATAR_BACKGROUND      ,
            GUI_ID_INGAME_BOTTOM_UI_AVATAR_LOW_PANEL       ,
            GUI_ID_INGAME_BOTTOM_UI_AVATAR_LOW_PANEL_BACK  ,
            GUI_ID_INGAME_BOTTOM_UI_AVATAR_HIGH_PANEL      ,
            GUI_ID_INGAME_BOTTOM_UI_AVATAR_HIGH_PANEL_BACK : begin
              // TODO : add User Avarta or change Pic to Mob or Class...
              ShowHideAvatarWindow;
            end;
          end;          
        end;
        EVENT_BUTTON_DOWN : begin
          case AEventControl of
            0:;
          end;
        end;
      end;
    end;
    
    procedure TMir3GameSceneInGame.EventBeltWindow(AEventType: Integer; AEventControl: Integer);

      procedure Flip_H_V_Defination;
      var
        FTempX : Integer;
        FTempY : Integer;
      begin
        with FGame_GUI_Defination_InGame do
        begin
          if TMIR3_GUI_Form(GetFormByID(GUI_ID_INGAME_BELT_UI_BACKGROUND)).FGUI_Defination.gui_Width = 512 then
          begin
            { Save Left and Top Position }
            FTempX := TMIR3_GUI_Form(GetFormByID(GUI_ID_INGAME_BELT_UI_BACKGROUND)).Left;
            FTempY := TMIR3_GUI_Form(GetFormByID(GUI_ID_INGAME_BELT_UI_BACKGROUND)).Top;
            { Set new Defination Horizontal }
            TMIR3_GUI_Form(GetFormByID(GUI_ID_INGAME_BELT_UI_BACKGROUND)).Add_GUI_Defination(@FInGame_UI_Belt_Background_V);
            TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_BELT_UI_BTN_ROTATE)).Add_GUI_Defination(@FInGame_UI_Belt_Btn_Rotate_V);
            TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_BELT_UI_BTN_CLOSE)).Add_GUI_Defination(@FInGame_UI_Belt_Btn_Close_V);
            TMIR3_GUI_Panel(GetComponentByID(GUI_ID_INGAME_BELT_UI_ITEM_FIELD_1)).Add_GUI_Defination(@FInGame_UI_Belt_Item_Field_V_1);
            TMIR3_GUI_Panel(GetComponentByID(GUI_ID_INGAME_BELT_UI_ITEM_FIELD_2)).Add_GUI_Defination(@FInGame_UI_Belt_Item_Field_V_2);
            TMIR3_GUI_Panel(GetComponentByID(GUI_ID_INGAME_BELT_UI_ITEM_FIELD_3)).Add_GUI_Defination(@FInGame_UI_Belt_Item_Field_V_3);
            TMIR3_GUI_Panel(GetComponentByID(GUI_ID_INGAME_BELT_UI_ITEM_FIELD_4)).Add_GUI_Defination(@FInGame_UI_Belt_Item_Field_V_4);
            TMIR3_GUI_Panel(GetComponentByID(GUI_ID_INGAME_BELT_UI_ITEM_FIELD_5)).Add_GUI_Defination(@FInGame_UI_Belt_Item_Field_V_5);
            TMIR3_GUI_Panel(GetComponentByID(GUI_ID_INGAME_BELT_UI_ITEM_FIELD_6)).Add_GUI_Defination(@FInGame_UI_Belt_Item_Field_V_6);
            { Calculate new Position }
            TMIR3_GUI_Form(GetFormByID(GUI_ID_INGAME_BELT_UI_BACKGROUND)).Left := (FTempX + FInGame_UI_Belt_Background_H.gui_WorkField.Left);
            TMIR3_GUI_Form(GetFormByID(GUI_ID_INGAME_BELT_UI_BACKGROUND)).Top  := (FTempY - FInGame_UI_Belt_Background_V.gui_WorkField.Top)+8;
          end else begin
            { Save Left and Top Position Vertical }
            FTempX := TMIR3_GUI_Form(GetFormByID(GUI_ID_INGAME_BELT_UI_BACKGROUND)).Left;
            FTempY := TMIR3_GUI_Form(GetFormByID(GUI_ID_INGAME_BELT_UI_BACKGROUND)).Top;
            { Set new Defination }
            TMIR3_GUI_Form(GetFormByID(GUI_ID_INGAME_BELT_UI_BACKGROUND)).Add_GUI_Defination(@FInGame_UI_Belt_Background_H);
            TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_BELT_UI_BTN_ROTATE)).Add_GUI_Defination(@FInGame_UI_Belt_Btn_Rotate_H);
            TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_BELT_UI_BTN_CLOSE)).Add_GUI_Defination(@FInGame_UI_Belt_Btn_Close_H);
            TMIR3_GUI_Panel(GetComponentByID(GUI_ID_INGAME_BELT_UI_ITEM_FIELD_1)).Add_GUI_Defination(@FInGame_UI_Belt_Item_Field_H_1);
            TMIR3_GUI_Panel(GetComponentByID(GUI_ID_INGAME_BELT_UI_ITEM_FIELD_2)).Add_GUI_Defination(@FInGame_UI_Belt_Item_Field_H_2);
            TMIR3_GUI_Panel(GetComponentByID(GUI_ID_INGAME_BELT_UI_ITEM_FIELD_3)).Add_GUI_Defination(@FInGame_UI_Belt_Item_Field_H_3);
            TMIR3_GUI_Panel(GetComponentByID(GUI_ID_INGAME_BELT_UI_ITEM_FIELD_4)).Add_GUI_Defination(@FInGame_UI_Belt_Item_Field_H_4);
            TMIR3_GUI_Panel(GetComponentByID(GUI_ID_INGAME_BELT_UI_ITEM_FIELD_5)).Add_GUI_Defination(@FInGame_UI_Belt_Item_Field_H_5);
            TMIR3_GUI_Panel(GetComponentByID(GUI_ID_INGAME_BELT_UI_ITEM_FIELD_6)).Add_GUI_Defination(@FInGame_UI_Belt_Item_Field_H_6);
            { Calculate new Position }
            TMIR3_GUI_Form(GetFormByID(GUI_ID_INGAME_BELT_UI_BACKGROUND)).Left := (FTempX - FInGame_UI_Belt_Background_H.gui_WorkField.Left);
            TMIR3_GUI_Form(GetFormByID(GUI_ID_INGAME_BELT_UI_BACKGROUND)).Top  := (FTempY - FInGame_UI_Belt_Background_H.gui_WorkField.Top)+1;
          end;
        end;
      end;

    begin
      case AEventType of
        EVENT_BUTTON_UP   : begin
          case AEventControl of
            GUI_ID_INGAME_BELT_UI_BTN_CLOSE    : TMIR3_GUI_Form(GetFormByID(GUI_ID_INGAME_BELT_UI_BACKGROUND)).Visible := False;
            GUI_ID_INGAME_BELT_UI_BTN_ROTATE   : Flip_H_V_Defination;
            { Item Field Events }
            GUI_ID_INGAME_BELT_UI_ITEM_FIELD_1 : ;
            GUI_ID_INGAME_BELT_UI_ITEM_FIELD_2 : ;
            GUI_ID_INGAME_BELT_UI_ITEM_FIELD_3 : ;
            GUI_ID_INGAME_BELT_UI_ITEM_FIELD_4 : ;
            GUI_ID_INGAME_BELT_UI_ITEM_FIELD_5 : ;
            GUI_ID_INGAME_BELT_UI_ITEM_FIELD_6 : ;
          end;          
        end;
        EVENT_BUTTON_DOWN : begin
          case AEventControl of
            0:;
          end;
        end;
      end;
    end;
    
    procedure TMir3GameSceneInGame.EventMiniMapWindow(AEventType: Integer; AEventControl: Integer);
    begin
      case AEventType of
        EVENT_BUTTON_UP   : begin
          case AEventControl of
            0:;
          end;          
        end;
        EVENT_BUTTON_DOWN : begin
          case AEventControl of
            0:;
          end;
        end;
      end;
    end;
    
    procedure TMir3GameSceneInGame.EventMenueBarWindow(AEventType: Integer; AEventControl: Integer);
    begin
      case AEventType of
        EVENT_BUTTON_UP   : begin
          case AEventControl of
            GUI_ID_INGAME_MENUEBAR_UI_BTN_SETTING : begin
              {Setup Game Setting Window}
              EventGameSettingWindow(EVENT_BUTTON_UP, GUI_ID_INGAME_GAME_SETTING_UI_BTN_BASIC);
              TMIR3_GUI_Form(GetFormByID(GUI_ID_INGAME_GAME_SETTING_UI_WINDOW)).Visible := True;
              TMIR3_GUI_Form(GetFormByID(GUI_ID_INGAME_MENUEBAR_UI_WINDOW)).Visible     := False;
            end;
            GUI_ID_INGAME_MENUEBAR_UI_BTN_CHAT    :;
            GUI_ID_INGAME_MENUEBAR_UI_BTN_MAIL    :;
            GUI_ID_INGAME_MENUEBAR_UI_BTN_GROUP   :;
            GUI_ID_INGAME_MENUEBAR_UI_BTN_GUILD   :;
            GUI_ID_INGAME_MENUEBAR_UI_BTN_AVATAR  :;
            GUI_ID_INGAME_MENUEBAR_UI_BTN_SIEGE   :;
            GUI_ID_INGAME_MENUEBAR_UI_BTN_EXIT    : begin
               TMIR3_GUI_Form(GetFormByID(GUI_ID_INGAME_EXIT_WINDOW_UI_WINDOW)).Visible := True;
               TMIR3_GUI_Form(GetFormByID(GUI_ID_INGAME_MENUEBAR_UI_WINDOW)).Visible    := False;
            end;
            GUI_ID_INGAME_MENUEBAR_UI_BTN_FEATURE :;
            GUI_ID_INGAME_MENUEBAR_UI_BTN_CLOSE   : TMIR3_GUI_Form(GetFormByID(GUI_ID_INGAME_MENUEBAR_UI_WINDOW)).Visible := False;
          end;
        end;
        EVENT_BUTTON_DOWN : begin
          case AEventControl of
            0:;
          end;
        end;
      end;
    end;
    
    procedure TMir3GameSceneInGame.EventGameSettingWindow(AEventType: Integer; AEventControl: Integer);

      procedure ChangeVisiblePage1(APageVisible: Boolean);
      begin
        TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_GAME_SETTING_UI_BTN_1_P1)).Visible := APageVisible;
        TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_GAME_SETTING_UI_BTN_2_P1)).Visible := APageVisible;
        TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_GAME_SETTING_UI_BTN_3_P1)).Visible := APageVisible;
        TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_GAME_SETTING_UI_BTN_4_P1)).Visible := APageVisible;
        TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_GAME_SETTING_UI_BTN_5_P1)).Visible := APageVisible;
        TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_GAME_SETTING_UI_BTN_6_P1)).Visible := APageVisible;
        TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_GAME_SETTING_UI_BTN_7_P1)).Visible := APageVisible;

        TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_GAME_SETTING_UI_TEXT_FIELD_1_P1)).Visible := APageVisible;
        TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_GAME_SETTING_UI_TEXT_FIELD_2_P1)).Visible := APageVisible;
        TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_GAME_SETTING_UI_TEXT_FIELD_3_P1)).Visible := APageVisible;
        TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_GAME_SETTING_UI_TEXT_FIELD_4_P1)).Visible := APageVisible;
        TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_GAME_SETTING_UI_TEXT_FIELD_5_P1)).Visible := APageVisible;
        TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_GAME_SETTING_UI_TEXT_FIELD_6_P1)).Visible := APageVisible;
        TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_GAME_SETTING_UI_TEXT_FIELD_7_P1)).Visible := APageVisible;

        TMIR3_GUI_Slider(GetComponentByID(GUI_ID_INGAME_GAME_SETTING_UI_SLIDER_BGM)).Visible := APageVisible;
        TMIR3_GUI_Slider(GetComponentByID(GUI_ID_INGAME_GAME_SETTING_UI_SLIDER_SFX)).Visible := APageVisible;

        TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_GAME_SETTING_UI_BTN_BASIC)).Selected := APageVisible;
      end;

      procedure ChangeVisiblePage2(APageVisible: Boolean);
      begin
        TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_GAME_SETTING_UI_BTN_1_P2)).Visible := APageVisible;
        TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_GAME_SETTING_UI_BTN_2_P2)).Visible := APageVisible;
        TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_GAME_SETTING_UI_BTN_3_P2)).Visible := APageVisible;
        TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_GAME_SETTING_UI_BTN_4_P2)).Visible := APageVisible;
        TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_GAME_SETTING_UI_BTN_5_P2)).Visible := APageVisible;

        TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_GAME_SETTING_UI_TEXT_FIELD_1_P2)).Visible := APageVisible;
        TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_GAME_SETTING_UI_TEXT_FIELD_2_P2)).Visible := APageVisible;
        TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_GAME_SETTING_UI_TEXT_FIELD_3_P2)).Visible := APageVisible;
        TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_GAME_SETTING_UI_TEXT_FIELD_4_P2)).Visible := APageVisible;
        TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_GAME_SETTING_UI_TEXT_FIELD_5_P2)).Visible := APageVisible;

        TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_GAME_SETTING_UI_BTN_PERMIT)).Selected := APageVisible;
      end;

      procedure ChangeVisiblePage3(APageVisible: Boolean);
      begin
        TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_GAME_SETTING_UI_BTN_1_P3)).Visible := APageVisible;
        TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_GAME_SETTING_UI_BTN_2_P3)).Visible := APageVisible;

        TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_GAME_SETTING_UI_BTN_4_P3)).Visible := APageVisible;
        TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_GAME_SETTING_UI_BTN_5_P3)).Visible := APageVisible;

        TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_GAME_SETTING_UI_TEXT_FIELD_1_P3)).Visible := APageVisible;
        TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_GAME_SETTING_UI_TEXT_FIELD_2_P3)).Visible := APageVisible;

        TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_GAME_SETTING_UI_TEXT_FIELD_4_P3)).Visible := APageVisible;
        TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_GAME_SETTING_UI_TEXT_FIELD_5_P3)).Visible := APageVisible;

        TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_GAME_SETTING_UI_BTN_CHATTING)).Selected   := APageVisible;
      end;

      procedure ChangeVisiblePage4(APageVisible: Boolean);
      begin
        TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_GAME_SETTING_UI_BTN_1_P4)).Visible  := APageVisible;
        TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_GAME_SETTING_UI_BTN_2_P4)).Visible  := APageVisible;
        TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_GAME_SETTING_UI_BTN_3_P4)).Visible  := APageVisible;
        TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_GAME_SETTING_UI_BTN_4_P4)).Visible  := APageVisible;
        TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_GAME_SETTING_UI_BTN_5_P4)).Visible  := APageVisible;
        TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_GAME_SETTING_UI_BTN_6_P4)).Visible  := APageVisible;
        TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_GAME_SETTING_UI_BTN_7_P4)).Visible  := APageVisible;
        TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_GAME_SETTING_UI_BTN_8_P4)).Visible  := APageVisible;
        TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_GAME_SETTING_UI_BTN_9_P4)).Visible  := APageVisible;
        TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_GAME_SETTING_UI_BTN_10_P4)).Visible := APageVisible;

        TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_GAME_SETTING_UI_TEXT_FIELD_1_P4)).Visible  := APageVisible;
        TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_GAME_SETTING_UI_TEXT_FIELD_2_P4)).Visible  := APageVisible;
        TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_GAME_SETTING_UI_TEXT_FIELD_3_P4)).Visible  := APageVisible;
        TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_GAME_SETTING_UI_TEXT_FIELD_4_P4)).Visible  := APageVisible;
        TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_GAME_SETTING_UI_TEXT_FIELD_5_P4)).Visible  := APageVisible;
        TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_GAME_SETTING_UI_TEXT_FIELD_6_P4)).Visible  := APageVisible;
        TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_GAME_SETTING_UI_TEXT_FIELD_7_P4)).Visible  := APageVisible;
        TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_GAME_SETTING_UI_TEXT_FIELD_8_P4)).Visible  := APageVisible;
        TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_GAME_SETTING_UI_TEXT_FIELD_9_P4)).Visible  := APageVisible;
        TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_GAME_SETTING_UI_TEXT_FIELD_10_P4)).Visible := APageVisible;

        TMIR3_GUI_Button(GetComponentByID(GUI_ID_INGAME_GAME_SETTING_UI_BTN_VISUAL)).Selected      := APageVisible;
      end;

    begin
      case AEventType of
        EVENT_BUTTON_UP   : begin
          case AEventControl of
            GUI_ID_INGAME_GAME_SETTING_UI_BTN_CLOSE    : TMIR3_GUI_Form(GetFormByID(GUI_ID_INGAME_GAME_SETTING_UI_WINDOW)).Visible := False;
            GUI_ID_INGAME_GAME_SETTING_UI_BTN_BASIC    : begin
              // Show Page 1  -- Hide Page 2-4
              TMIR3_GUI_Form(GetFormByID(GUI_ID_INGAME_GAME_SETTING_UI_WINDOW)).SetTextureID(290);
              ChangeVisiblePage2(False);
              ChangeVisiblePage3(False);
              ChangeVisiblePage4(False);
              ChangeVisiblePage1(True);
            end;
            GUI_ID_INGAME_GAME_SETTING_UI_BTN_PERMIT   : begin
              // Show Page 2  -- Hide Page 1,3-4
              TMIR3_GUI_Form(GetFormByID(GUI_ID_INGAME_GAME_SETTING_UI_WINDOW)).SetTextureID(291);
              ChangeVisiblePage1(False);
              ChangeVisiblePage3(False);
              ChangeVisiblePage4(False);
              ChangeVisiblePage2(True);
            end;
            GUI_ID_INGAME_GAME_SETTING_UI_BTN_CHATTING : begin
              // Show Page 3  -- Hide Page 1-2,4
              TMIR3_GUI_Form(GetFormByID(GUI_ID_INGAME_GAME_SETTING_UI_WINDOW)).SetTextureID(292);
              ChangeVisiblePage1(False);
              ChangeVisiblePage2(False);
              ChangeVisiblePage4(False);
              ChangeVisiblePage3(True);
            end;
            GUI_ID_INGAME_GAME_SETTING_UI_BTN_VISUAL   : begin
              // Show Page 4  -- Hide Page 1-3
              TMIR3_GUI_Form(GetFormByID(GUI_ID_INGAME_GAME_SETTING_UI_WINDOW)).SetTextureID(293);
              ChangeVisiblePage1(False);
              ChangeVisiblePage2(False);
              ChangeVisiblePage3(False);
              ChangeVisiblePage4(True);
            end;
          end;          
        end;
        EVENT_BUTTON_DOWN : begin
          case AEventControl of
            0:;
          end;
        end;
      end;
    end;

    procedure TMir3GameSceneInGame.EventBodyWindow(AEventType: Integer; AEventControl: Integer);
    begin
      case AEventType of
        EVENT_BUTTON_UP   : begin
          case AEventControl of
            GUI_ID_INGAME_BODY_UI_BTN_CLOSE : TMIR3_GUI_Form(GetFormByID(GUI_ID_INGAME_BODY_UI_WINDOW)).Visible := False;
            
          end;
        end;
        EVENT_BUTTON_DOWN : begin
          case AEventControl of
            0:;
          end;
        end;
      end;
    end;
    
    procedure TMir3GameSceneInGame.EventBodyShowWindow(AEventType: Integer; AEventControl: Integer);
    begin
      case AEventType of
        EVENT_BUTTON_UP   : begin
          case AEventControl of
            GUI_ID_INGAME_BODY_SHOW_UI_BTN_CLOSE : TMIR3_GUI_Form(GetFormByID(GUI_ID_INGAME_BODY_SHOW_UI_WINDOW)).Visible := False;
          end;          
        end;
        EVENT_BUTTON_DOWN : begin
          case AEventControl of
            0:;
          end;
        end;
      end;
    end;
    
    procedure TMir3GameSceneInGame.EventMagicWindowWindow(AEventType: Integer; AEventControl: Integer);
    begin
      case AEventType of
        EVENT_BUTTON_UP   : begin
          case AEventControl of
            0:;
          end;          
        end;
        EVENT_BUTTON_DOWN : begin
          case AEventControl of
            0:;
          end;
        end;
      end;
    end;
  {$ENDREGION}


  {$REGION ' - Callback Event Function   '}
    ////////////////////////////////////////////////////////////////////////////////
    // Events coming from inside the Control System, we move the Event to a own sys
    //..............................................................................
    procedure InGameGUIEvent(AEventID: LongWord; AControlID: Cardinal; AControl: TMIR3_GUI_Default); stdcall;
    begin
      case AEventID of
        EVENT_BUTTON_UP   : begin
          with GGameEngine.SceneInGame do
          begin                                    
            case AControl.ControlIdentifier of
              402..404   : EventExitWindow(AEventID, AControl.ControlIdentifier);
              { Bottom UI Events }
              411..458   : EventBottomWindow(AEventID, AControl.ControlIdentifier);
              { Menue Bar UI Events }
              460..470   : EventMenueBarWindow(AEventID, AControl.ControlIdentifier);
              { Belt UI Events }
              481..488   : EventBeltWindow(AEventID, AControl.ControlIdentifier);
              { Game Setting UI Events }
              601..647   : EventGameSettingWindow(AEventID, AControl.ControlIdentifier);
              { Body UI Events }
              901..902   : EventBodyWindow(AEventID, AControl.ControlIdentifier);
              { Body Show UI Events }
              1000..1010 : EventBodyShowWindow(AEventID, AControl.ControlIdentifier);
              (* System Buttons *)
              GUI_ID_SYSINFO_BUTTON_OK   : GGameEngine.SceneInGame.Event_System_Ok;
              GUI_ID_SYSINFO_BUTTON_YES  : GGameEngine.SceneInGame.Event_System_Yes;
              GUI_ID_SYSINFO_BUTTON_NO   : GGameEngine.SceneInGame.Event_System_No;
            end;
          end;
        end;
        EVENT_BUTTON_DOWN : begin
          case AControl.ControlIdentifier of
            0:;
          end;
        end;
	     end;
    end;

    ////////////////////////////////////////////////////////////////////////////////
    // It is for Pre Processing things / Map, Item, Magic, Ators things etc.
    //..............................................................................
    function GamePreProcessing(AD3DDevice: IDirect3DDevice9; AElapsedTime: Single; ADebugMode: Boolean): HRESULT; stdcall;
    begin
      Result := S_OK;
      //Render Ingame things before Controls rendered
      //Render Tile Map
      //Render Object Map and all other ingame things
    end;

    ////////////////////////////////////////////////////////////////////////////////
    // It can be use to add Overlay Text or Out / In Blending
    //..............................................................................
    function GamePostProcessing(AD3DDevice: IDirect3DDevice9; AElapsedTime: Single; ADebugMode: Boolean): HRESULT; stdcall;
    begin
      Result := S_OK;
      //Render Ingame things after Controls rendered
      //like Text or Outblend (Mapchange) or other things
    end;      
  {$ENDREGION}
  
end.