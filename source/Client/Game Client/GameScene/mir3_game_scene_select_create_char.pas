(*****************************************************************************************
 *   LomCN Mir3 Select and Create Scene File 2013                                        *
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

unit mir3_game_scene_select_create_char;

interface

{$I DevelopmentDefinition.inc}

uses
{Delphi }  Windows, SysUtils, Classes, Math,
{DirectX}  DXTypes, Direct3D9, D3DX9,
{Game   }  mir3_game_socket, mir3_game_en_decode, mir3_game_language_engine, mir3_global_config,
{Game   }  mir3_game_gui_definition_system, mir3_game_gui_definition_select_create_char, mir3_core_controls, 
{Game   }  mir3_game_file_manager, mir3_game_file_manager_const, mir3_game_engine, mir3_misc_utils,
{Game   }  mir3_game_sound_engine;

{ Callback Functions }
procedure SelectCharGUIEvent(AEventID: LongWord; AControlID: Cardinal; AControl: PMIR3_GUI_Default); stdcall;
procedure SelectCharGUIHotKeyEvent(AChar: LongWord); stdcall;

type
  TMir3GameSceneSelectChar = class(TMIR3_GUI_Manager)
  strict private
    FCharacterList    : array [0..3] of TMir3Character;
    FCharacterInfo    : TMir3Character;
    FLastMessageError : Integer;
  public
    constructor Create;
    destructor Destroy; override;
  public
    procedure ResetScene;
    procedure ReceiveMessagePacket(AReceiveData: String);
    procedure SystemMessage(AMessage: String; AButtons: TMIR3_DLG_Buttons; AEventType: Integer; AButtonTextID1: Integer = 0; AButtonTextID2: Integer = 0);
    procedure ResetCreateCharScene;
    procedure TestAndSetNewSelection;
    function GetCharacterCount: Integer;
    function GetSelectedCharacterID(ATestWithDelete : Boolean = True): Integer;
    procedure UpdateSelectCharacter(ASelectedChar: Integer);
    {Event Function}
    procedure Event_Start_Game;
    procedure Event_Create_New_Char;
    procedure Event_Delete_Char;
    procedure Event_System_Ok;
    procedure Event_System_Yes;
    procedure Event_System_No;
    procedure Event_Select(ASelect : Integer);
    procedure Event_CreateChar_Ok;
    procedure Event_CreateChar_Cancel;
  end;

implementation

uses mir3_game_backend;

  {$REGION ' - TMir3GameSceneSelectChar :: constructor / destructor     '}
    constructor TMir3GameSceneSelectChar.Create;
    var
      FSystemForm : TMIR3_GUI_Form;
      FSelectForm : TMIR3_GUI_Form;
      FCrateForm  : TMIR3_GUI_Form;
      FCharControl: TMIR3_GUI_SelectChar;
      FCharInfo   : TMir3Character;
    begin
      inherited Create;
      Self.DebugMode := False;
      Self.SetEventCallback(@SelectCharGUIEvent);
      Self.SetHotKeyEventCallback(@SelectCharGUIHotKeyEvent);

//      {$REGION ' - Create Char Forms and Controls   '}
//      FCrateForm   := TMIR3_GUI_Form(Self.AddForm(FGame_GUI_Definition_SelChar.FCreateChar_Background, False));
//      Self.AddControl(FCrateForm,  FGame_GUI_Definition_SelChar.FCreateChar_Information_Field   , True);
//      FCharControl := TMIR3_GUI_SelectChar(Self.AddControl(FCrateForm,  FGame_GUI_Definition_SelChar.FCreateChar_Character_Male  , True));
//      FCharControl.Selected        := True;
//      FCharControl.CharacterSystem := csCreateChar;
//      FCharInfo.Char_Job           := C_WARRIOR;
//      FCharInfo.Char_Gender        := C_MALE;
//      FCharControl.CharacterInfo   := FCharInfo;
//      FCharControl  := TMIR3_GUI_SelectChar(Self.AddControl(FCrateForm,  FGame_GUI_Definition_SelChar.FCreateChar_Character_Female , True));
//      FCharControl.CharacterSystem := csCreateChar;
//      FCharInfo.Char_Job           := C_WARRIOR;
//      FCharInfo.Char_Gender        := C_FEMALE;
//      FCharControl.CharacterInfo   := FCharInfo;
//      with GGameEngine.GameLanguage do
//        TMIR3_GUI_Panel(GetComponentByID(GUI_ID_CREATECHAR_INFO)).Caption := PWideChar(Format(GetTextFromLangSystem(61), [GetTextFromLangSystem(55)]));
//      Self.AddControl(FCrateForm,  FGame_GUI_Definition_SelChar.FCreateChar_Panel_Stone_Shadow  , True);
//      Self.AddControl(FCrateForm,  FGame_GUI_Definition_SelChar.FCreateChar_Panel_Stone         , True);
//      Self.AddControl(FCrateForm,  FGame_GUI_Definition_SelChar.FCreateChar_Button_Warrior      , True);
//      Self.AddControl(FCrateForm,  FGame_GUI_Definition_SelChar.FCreateChar_Button_Wizzard      , True);
//      Self.AddControl(FCrateForm,  FGame_GUI_Definition_SelChar.FCreateChar_Button_Taoist       , True);
//      Self.AddControl(FCrateForm,  FGame_GUI_Definition_SelChar.FCreateChar_Button_Assassin     , True);
//      Self.AddControl(FCrateForm,  FGame_GUI_Definition_SelChar.FCreateChar_Button_Ok           , True);
//      Self.AddControl(FCrateForm,  FGame_GUI_Definition_SelChar.FCreateChar_Button_Cancel       , True);
//      Self.AddControl(FCrateForm,  FGame_GUI_Definition_SelChar.FCreateChar_Edit_Char_Name      , True);
//      {$ENDREGION}

      {$REGION ' - Select Char Forms and Controls   '}
      { Create Select Char / Create Char Forms and Controls }
      with FGame_GUI_Definition_SelChar do
      begin
        case FScreen_Width of
           800 : begin
             FSelectForm  := TMIR3_GUI_Form(Self.AddForm(FSelectChar_Background_800,  True));
             Self.AddControl(FSelectForm, FSelectChar_Animation_1_800  , True);
             Self.AddControl(FSelectForm, FSelectChar_Animation_2_800  , True);
             Self.AddControl(FSelectForm, FSelectChar_Character_1_800  , True);
             Self.AddControl(FSelectForm, FSelectChar_Character_2_800  , True);
             Self.AddControl(FSelectForm, FSelectChar_Character_3_800  , True);
             Self.AddControl(FSelectForm, FSelectChar_Character_4_800  , True);

             Self.AddControl(FSelectForm, FSelectChar_Panel_Top_800    , True);
             Self.AddControl(FSelectForm, FSelectChar_Panel_Bottom_800 , True);

             Self.AddControl(FSelectForm, FSelectChar_Btn_Start_800       , True);
             Self.AddControl(FSelectForm, FSelectChar_Btn_Exit_800        , True);
             Self.AddControl(FSelectForm, FSelectChar_Btn_Delete_Char_800 , True);
             Self.AddControl(FSelectForm, FSelectChar_Btn_New_Char_800    , True);
             Self.AddControl(FSelectForm, FSelectChar_Btn_Set2ndPassword_800, True);

             Self.AddControl(FSelectForm, FSelectChar_Panel_Char_1_800 , True);
             Self.AddControl(FSelectForm, FSelectChar_Panel_Char_2_800 , True);
             Self.AddControl(FSelectForm, FSelectChar_Panel_Char_3_800 , True);
             Self.AddControl(FSelectForm, FSelectChar_Panel_Char_4_800 , True);


             Self.AddControl(FSelectForm, FSelectChar_Dialog_Name_1_800 , True);
             Self.AddControl(FSelectForm, FSelectChar_Dialog_Name_2_800 , True);
             Self.AddControl(FSelectForm, FSelectChar_Dialog_Name_3_800 , True);
             Self.AddControl(FSelectForm, FSelectChar_Dialog_Name_4_800 , True);

             Self.AddControl(FSelectForm, FSelectChar_Dialog_Level_1_800 , True);
             Self.AddControl(FSelectForm, FSelectChar_Dialog_Level_2_800 , True);
             Self.AddControl(FSelectForm, FSelectChar_Dialog_Level_3_800 , True);
             Self.AddControl(FSelectForm, FSelectChar_Dialog_Level_4_800 , True);

             Self.AddControl(FSelectForm, FSelectChar_Dialog_Class_1_800 , True);
             Self.AddControl(FSelectForm, FSelectChar_Dialog_Class_2_800 , True);
             Self.AddControl(FSelectForm, FSelectChar_Dialog_Class_3_800 , True);
             Self.AddControl(FSelectForm, FSelectChar_Dialog_Class_4_800 , True);


             TMIR3_GUI_TextLabel(GetComponentByID(GUI_ID_SELECTCHAR_INFO_NAME_1)).Caption := 'Kaito';
             TMIR3_GUI_TextLabel(GetComponentByID(GUI_ID_SELECTCHAR_INFO_NAME_2)).Caption := 'Clementina';
             TMIR3_GUI_TextLabel(GetComponentByID(GUI_ID_SELECTCHAR_INFO_NAME_3)).Caption := 'Coly';
             TMIR3_GUI_TextLabel(GetComponentByID(GUI_ID_SELECTCHAR_INFO_NAME_4)).Caption := 'Tester';

             TMIR3_GUI_TextLabel(GetComponentByID(GUI_ID_SELECTCHAR_INFO_LEVEL_1)).Caption := 'Level : 1000';
             TMIR3_GUI_TextLabel(GetComponentByID(GUI_ID_SELECTCHAR_INFO_LEVEL_2)).Caption := 'Level : 100';
             TMIR3_GUI_TextLabel(GetComponentByID(GUI_ID_SELECTCHAR_INFO_LEVEL_3)).Caption := 'Level : 9';
             TMIR3_GUI_TextLabel(GetComponentByID(GUI_ID_SELECTCHAR_INFO_LEVEL_4)).Caption := 'Level : 10000';

             TMIR3_GUI_TextLabel(GetComponentByID(GUI_ID_SELECTCHAR_INFO_CLASS_1)).Caption := 'Class : Taoist';
             TMIR3_GUI_TextLabel(GetComponentByID(GUI_ID_SELECTCHAR_INFO_CLASS_2)).Caption := 'Class : Warrior';
             TMIR3_GUI_TextLabel(GetComponentByID(GUI_ID_SELECTCHAR_INFO_CLASS_3)).Caption := 'Class : Wizzard';
             TMIR3_GUI_TextLabel(GetComponentByID(GUI_ID_SELECTCHAR_INFO_CLASS_4)).Caption := 'Class : Assassin';

             TMIR3_GUI_SelectChar(GetComponentByID(GUI_ID_SELECTCHAR_CHARACTER_1)).Selected := True;

             FCharacterList[0].Char_Job    := 2;
             FCharacterList[0].Char_Gender := 0;
             TMIR3_GUI_SelectChar(GetComponentByID(GUI_ID_SELECTCHAR_CHARACTER_1)).CharacterInfo := FCharacterList[0];
             FCharacterList[1].Char_Job    := 0;
             FCharacterList[1].Char_Gender := 1;
             TMIR3_GUI_SelectChar(GetComponentByID(GUI_ID_SELECTCHAR_CHARACTER_2)).CharacterInfo := FCharacterList[1];
             FCharacterList[2].Char_Job    := 1;
             FCharacterList[2].Char_Gender := 0;
             TMIR3_GUI_SelectChar(GetComponentByID(GUI_ID_SELECTCHAR_CHARACTER_3)).CharacterInfo := FCharacterList[2];
             FCharacterList[3].Char_Job    := 3;
             FCharacterList[3].Char_Gender := 0;
             TMIR3_GUI_SelectChar(GetComponentByID(GUI_ID_SELECTCHAR_CHARACTER_4)).CharacterInfo := FCharacterList[3];
           end;
          1024 : begin
             FSelectForm  := TMIR3_GUI_Form(Self.AddForm(FSelectChar_Background_1024, True));
             Self.AddControl(FSelectForm, FSelectChar_Animation_1_1024 , True);
             Self.AddControl(FSelectForm, FSelectChar_Animation_2_1024 , True);
             Self.AddControl(FSelectForm, FSelectChar_Character_1_1024 , True);
             Self.AddControl(FSelectForm, FSelectChar_Character_2_1024 , True);
             Self.AddControl(FSelectForm, FSelectChar_Character_3_1024 , True);
             Self.AddControl(FSelectForm, FSelectChar_Character_4_1024 , True);

             Self.AddControl(FSelectForm, FSelectChar_Panel_Top_1024   , True);
             Self.AddControl(FSelectForm, FSelectChar_Panel_Bottom_1024, True);

             Self.AddControl(FSelectForm, FSelectChar_Btn_Start_800, True);

           end;
        end;
      end;

//      FSelectForm := TMIR3_GUI_Form(Self.AddForm(FGame_GUI_Definition_SelChar.FSelectChar_Background,  True));
//      Self.AddControl(FSelectForm, FGame_GUI_Definition_SelChar.FSelectChar_Character_1         , False);
//      Self.AddControl(FSelectForm, FGame_GUI_Definition_SelChar.FSelectChar_Character_2         , False);
//      Self.AddControl(FSelectForm, FGame_GUI_Definition_SelChar.FSelectChar_Character_3         , False);
//      Self.AddControl(FSelectForm, FGame_GUI_Definition_SelChar.FSelectChar_Button_Start        , True);
//      Self.AddControl(FSelectForm, FGame_GUI_Definition_SelChar.FSelectChar_Button_Exit         , True);
//      Self.AddControl(FSelectForm, FGame_GUI_Definition_SelChar.FSelectChar_Button_Delete_Char  , True);
//      Self.AddControl(FSelectForm, FGame_GUI_Definition_SelChar.FSelectChar_Button_New_Char     , True);
//      Self.AddControl(FSelectForm, FGame_GUI_Definition_SelChar.FSelectChar_Dialog_Text         , True);
//      Self.AddControl(FSelectForm, FGame_GUI_Definition_SelChar.FSelectChar_Dialog_Name         , True);
//      Self.AddControl(FSelectForm, FGame_GUI_Definition_SelChar.FSelectChar_Dialog_Class        , True);
//      Self.AddControl(FSelectForm, FGame_GUI_Definition_SelChar.FSelectChar_Dialog_Level        , True);
//      Self.AddControl(FSelectForm, FGame_GUI_Definition_SelChar.FSelectChar_Dialog_Gold         , True);
//      Self.AddControl(FSelectForm, FGame_GUI_Definition_SelChar.FSelectChar_Dialog_Exp          , True);
//      Self.AddControl(FSelectForm, FGame_GUI_Definition_SelChar.FSelectChar_Dialog_Name_Info    , True);
//      Self.AddControl(FSelectForm, FGame_GUI_Definition_SelChar.FSelectChar_Dialog_Class_Info   , True);
//      Self.AddControl(FSelectForm, FGame_GUI_Definition_SelChar.FSelectChar_Dialog_Level_Info   , True);
//      Self.AddControl(FSelectForm, FGame_GUI_Definition_SelChar.FSelectChar_Dialog_Gold_Info    , True);
//      Self.AddControl(FSelectForm, FGame_GUI_Definition_SelChar.FSelectChar_Dialog_Exp_Info     , True);


//      TMIR3_GUI_TextLabel(GetComponentByID(GUI_ID_SELECTCHAR_INFO_NAME)).Caption  := ' Name';
//      TMIR3_GUI_TextLabel(GetComponentByID(GUI_ID_SELECTCHAR_INFO_CLASS)).Caption := ' Class';
//      TMIR3_GUI_TextLabel(GetComponentByID(GUI_ID_SELECTCHAR_INFO_LEVEL)).Caption := ' Level';
//      TMIR3_GUI_TextLabel(GetComponentByID(GUI_ID_SELECTCHAR_INFO_GOLD)).Caption  := ' Gold';
//      TMIR3_GUI_TextLabel(GetComponentByID(GUI_ID_SELECTCHAR_INFO_EXP)).Caption   := ' Exp';
      {$ENDREGION}

      {$REGION ' - System Forms and Controls        '}
      FSystemForm := TMIR3_GUI_Form(Self.AddForm(FGame_GUI_Definition_System.FSys_Dialog_Info, False));
      Self.AddControl(FSystemForm, FGame_GUI_Definition_System.FSys_Dialog_Text        , True);
      Self.AddControl(FSystemForm, FGame_GUI_Definition_System.FSys_Button_Ok          , False);
      Self.AddControl(FSystemForm, FGame_GUI_Definition_System.FSys_Button_Yes         , False);
      Self.AddControl(FSystemForm, FGame_GUI_Definition_System.FSys_Button_No          , False);
      Self.AddControl(FSystemForm, FGame_GUI_Definition_System.FSys_Button_Free_Center , False);
      Self.AddControl(FSystemForm, FGame_GUI_Definition_System.FSys_Button_Free_Left   , False);
      Self.AddControl(FSystemForm, FGame_GUI_Definition_System.FSys_Button_Free_Right  , False);
      Self.AddControl(FSystemForm, FGame_GUI_Definition_System.FSys_Dialog_Edit_Field  , False);
      {$ENDREGION}

    end;
    
    destructor TMir3GameSceneSelectChar.Destroy;
    begin

      inherited;
    end;

    procedure TMir3GameSceneSelectChar.ResetScene;
    begin
      GGameEngine.SoundManager.StopBackgroundMusic;
      // Reset all Game Vars
      GGameEngine.SoundManager.PlayBackgroundMusic('SelChr.wav', True);
      ZeroMemory(@FCharacterList, SizeOf(TMir3Character)*4);
    end;
  {$ENDREGION}

  {$REGION ' - TMir3GameSceneSelectChar :: Scene Funtions               '}
    procedure TMir3GameSceneSelectChar.SystemMessage(AMessage: String; AButtons: TMIR3_DLG_Buttons; AEventType: Integer; AButtonTextID1: Integer = 0; AButtonTextID2: Integer = 0);
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
      begin
        TMIR3_GUI_Edit(GetComponentByID(GUI_ID_SYSINFO_EDIT_FIELD)).Visible := True;
        TMIR3_GUI_Edit(GetComponentByID(GUI_ID_SYSINFO_EDIT_FIELD)).SetFocus;
      end else TMIR3_GUI_Edit(GetComponentByID(GUI_ID_SYSINFO_EDIT_FIELD)).Visible := False;

      if mbExtraText_C in AButtons then
      begin
        TMIR3_GUI_Edit(GetComponentByID(GUI_ID_SYSINFO_BUTTON_FREE_CENTER)).FGUI_Definition.gui_CaptionID := AButtonTextID1;
        TMIR3_GUI_Edit(GetComponentByID(GUI_ID_SYSINFO_BUTTON_FREE_CENTER)).Visible                       := True;
      end else TMIR3_GUI_Edit(GetComponentByID(GUI_ID_SYSINFO_BUTTON_FREE_CENTER)).Visible := False;

      if mbExtraText_L in AButtons then
      begin
        TMIR3_GUI_Edit(GetComponentByID(GUI_ID_SYSINFO_BUTTON_FREE_LEFT)).FGUI_Definition.gui_CaptionID := AButtonTextID1;
        TMIR3_GUI_Edit(GetComponentByID(GUI_ID_SYSINFO_BUTTON_FREE_LEFT)).Visible                       := True;
      end else TMIR3_GUI_Edit(GetComponentByID(GUI_ID_SYSINFO_BUTTON_FREE_LEFT)).Visible := False;

      if mbExtraText_R in AButtons then
      begin
        TMIR3_GUI_Edit(GetComponentByID(GUI_ID_SYSINFO_BUTTON_FREE_RIGHT)).FGUI_Definition.gui_CaptionID := AButtonTextID2;
        TMIR3_GUI_Edit(GetComponentByID(GUI_ID_SYSINFO_BUTTON_FREE_RIGHT)).Visible                       := True;
      end else TMIR3_GUI_Edit(GetComponentByID(GUI_ID_SYSINFO_BUTTON_FREE_RIGHT)).Visible := False;

      TMIR3_GUI_Panel(GetComponentByID(GUI_ID_SYSINFO_PANEL)).Caption := PWideChar(AMessage);
      TMIR3_GUI_Form(GetFormByID(GUI_ID_SYSINFO_DIALOG)).EventTypeID  := AEventType;
      TMIR3_GUI_Form(GetFormByID(GUI_ID_SYSINFO_DIALOG)).Visible      := True;

    end;

    procedure TMir3GameSceneSelectChar.ResetCreateCharScene;
    var
      FCharInfo : TMir3Character;
    begin
      FCharacterInfo.Char_Job := C_WARRIOR;
      with TMIR3_GUI_SelectChar(GetComponentByID(GUI_ID_CREATECHAR_CHARACTER)) do
      begin
        FCharInfo.Char_Job    := C_WARRIOR;
        FCharInfo.Char_Gender := C_MALE;
        CharacterInfo         := FCharInfo;
        ResetSelection(True);
      end;
    end;

    procedure TMir3GameSceneSelectChar.TestAndSetNewSelection;
    begin
      if GetSelectedCharacterID = -1 then
      begin
        if GetCharacterCount > 0 then
          UpdateSelectCharacter(GetCharacterCount-1);
      end;
    end;

    function TMir3GameSceneSelectChar.GetCharacterCount: Integer;
    var
      I : Integer;
    begin
      Result := 0;
      for I := 0 to 3 do
      begin
        if Trim(FCharacterList[I].Char_Name) <> '' then
        begin
          Inc(Result);
        end;
      end;
    end;

    function TMir3GameSceneSelectChar.GetSelectedCharacterID(ATestWithDelete : Boolean = True): Integer;
    var
      I : Integer;
    begin
      Result := -1;
      for I := 0 to 3 do
      begin
        if ATestWithDelete then
        begin
          if (FCharacterList[I].Char_Select) and not (FCharacterList[I].Char_Delete) then
          begin
            Result := I;
            Break;
          end;
        end else begin
          if FCharacterList[I].Char_Select then
          begin
            Result := I;
            Break;
          end;
        end;
      end;
    end;

    procedure TMir3GameSceneSelectChar.UpdateSelectCharacter(ASelectedChar: Integer);
    var
      I : Integer;
    begin
      FCharacterList[0].Char_Select := False;
      FCharacterList[1].Char_Select := False;
      FCharacterList[2].Char_Select := False;
      FCharacterList[3].Char_Select := False;
      // Reset Selection Color
      for I := 0 to 3 do
        TMIR3_GUI_TextLabel(GetComponentByID(GUI_ID_SELECTCHAR_INFO_NAME_1+I)).FGUI_Definition.gui_Font.gui_Font_Color := $FF989898;
      for I := 0 to 3 do
        TMIR3_GUI_TextLabel(GetComponentByID(GUI_ID_SELECTCHAR_INFO_LEVEL_1+I)).FGUI_Definition.gui_Font.gui_Font_Color := $FF989898;
      for I := 0 to 3 do
        TMIR3_GUI_TextLabel(GetComponentByID(GUI_ID_SELECTCHAR_INFO_CLASS_1+I)).FGUI_Definition.gui_Font.gui_Font_Color := $FF989898;

      case ASelectedChar of
        0 : begin
          FCharacterList[0].Char_Select := True;
          TMIR3_GUI_TextLabel(GetComponentByID(GUI_ID_SELECTCHAR_INFO_NAME_1)).FGUI_Definition.gui_Font.gui_Font_Color  := $FFFFFFFF;
          TMIR3_GUI_TextLabel(GetComponentByID(GUI_ID_SELECTCHAR_INFO_LEVEL_1)).FGUI_Definition.gui_Font.gui_Font_Color := $FFFFFFFF;
          TMIR3_GUI_TextLabel(GetComponentByID(GUI_ID_SELECTCHAR_INFO_CLASS_1)).FGUI_Definition.gui_Font.gui_Font_Color := $FFFFFFFF;


//          TMIR3_GUI_TextLabel(GetComponentByID(GUI_ID_SELECTCHAR_INFO_NAME_INFO)).Caption  := PWideChar(String(FCharacterList[0].Char_Name));
//          TMIR3_GUI_TextLabel(GetComponentByID(GUI_ID_SELECTCHAR_INFO_CLASS_INFO)).Caption := PWideChar(GetClassAsString(FCharacterList[0].Char_Job));
//          TMIR3_GUI_TextLabel(GetComponentByID(GUI_ID_SELECTCHAR_INFO_LEVEL_INFO)).Caption := PWideChar(IntToStr(FCharacterList[0].Char_Level));
//          TMIR3_GUI_TextLabel(GetComponentByID(GUI_ID_SELECTCHAR_INFO_GOLD_INFO)).Caption  := PWideChar(IntToStr(FCharacterList[0].Char_Gold));
//          TMIR3_GUI_TextLabel(GetComponentByID(GUI_ID_SELECTCHAR_INFO_EXP_INFO)).Caption   := PWideChar(String(FCharacterList[0].Char_Exp + '%'));
          TMIR3_GUI_SelectChar(GetComponentByID(GUI_ID_SELECTCHAR_CHARACTER_1)).Selected   := True;
          case FCharacterList[0].Char_Job of
            C_WARRIOR  : case FCharacterList[0].Char_Gender of
                           C_MALE   : GGameEngine.SoundManager.PlaySound('JMMSel.wav');
                           C_FEMALE : GGameEngine.SoundManager.PlaySound('JWMSel.wav');
                         end;
            C_WIZZARD  : case FCharacterList[0].Char_Gender of
                           C_MALE   : GGameEngine.SoundManager.PlaySound('SMMSel.wav');
                           C_FEMALE : GGameEngine.SoundManager.PlaySound('SWMSel.wav');
                         end;
            C_TAOIST   : case FCharacterList[0].Char_Gender of
                           C_MALE   : GGameEngine.SoundManager.PlaySound('DMMSel.wav');
                           C_FEMALE : GGameEngine.SoundManager.PlaySound('DWMSel.wav');
                         end;
            C_ASSASSIN : case FCharacterList[0].Char_Gender of
                           C_MALE   : GGameEngine.SoundManager.PlaySound('as_168-m.wav');  //fix me with correct Sound
                           C_FEMALE : GGameEngine.SoundManager.PlaySound('as_168-f.wav');  //fix me with correct Sound
                         end;
          end;
        end;
        1 : begin
          FCharacterList[1].Char_Select := True;
          TMIR3_GUI_TextLabel(GetComponentByID(GUI_ID_SELECTCHAR_INFO_NAME_2)).FGUI_Definition.gui_Font.gui_Font_Color  := $FFFFFFFF;
          TMIR3_GUI_TextLabel(GetComponentByID(GUI_ID_SELECTCHAR_INFO_LEVEL_2)).FGUI_Definition.gui_Font.gui_Font_Color := $FFFFFFFF;
          TMIR3_GUI_TextLabel(GetComponentByID(GUI_ID_SELECTCHAR_INFO_CLASS_2)).FGUI_Definition.gui_Font.gui_Font_Color := $FFFFFFFF;
//          TMIR3_GUI_TextLabel(GetComponentByID(GUI_ID_SELECTCHAR_INFO_NAME_INFO)).Caption  := PWideChar(String(FCharacterList[1].Char_Name));
//          TMIR3_GUI_TextLabel(GetComponentByID(GUI_ID_SELECTCHAR_INFO_CLASS_INFO)).Caption := PWideChar(GetClassAsString(FCharacterList[1].Char_Job));
//          TMIR3_GUI_TextLabel(GetComponentByID(GUI_ID_SELECTCHAR_INFO_LEVEL_INFO)).Caption := PWideChar(IntToStr(FCharacterList[1].Char_Level));
//          TMIR3_GUI_TextLabel(GetComponentByID(GUI_ID_SELECTCHAR_INFO_GOLD_INFO)).Caption  := PWideChar(IntToStr(FCharacterList[1].Char_Gold));
//          TMIR3_GUI_TextLabel(GetComponentByID(GUI_ID_SELECTCHAR_INFO_EXP_INFO)).Caption   := PWideChar(String(FCharacterList[1].Char_Exp + '%'));
          TMIR3_GUI_SelectChar(GetComponentByID(GUI_ID_SELECTCHAR_CHARACTER_2)).Selected   := True;
          case FCharacterList[1].Char_Job of
            C_WARRIOR  : case FCharacterList[1].Char_Gender of
                           C_MALE   : GGameEngine.SoundManager.PlaySound('JMMSel.wav');
                           C_FEMALE : GGameEngine.SoundManager.PlaySound('JWMSel.wav');
                         end;
            C_WIZZARD  : case FCharacterList[1].Char_Gender of
                           C_MALE   : GGameEngine.SoundManager.PlaySound('SMMSel.wav');
                           C_FEMALE : GGameEngine.SoundManager.PlaySound('SWMSel.wav');
                         end;
            C_TAOIST   : case FCharacterList[1].Char_Gender of
                           C_MALE   : GGameEngine.SoundManager.PlaySound('DMMSel.wav');
                           C_FEMALE : GGameEngine.SoundManager.PlaySound('DWMSel.wav');
                         end;
            C_ASSASSIN : case FCharacterList[1].Char_Gender of
                           C_MALE   : GGameEngine.SoundManager.PlaySound('as_168-m.wav'); //fix me with correct Sound
                           C_FEMALE : GGameEngine.SoundManager.PlaySound('as_168-f.wav'); //fix me with correct Sound
                         end;
          end;
        end;
        2 : begin
          FCharacterList[2].Char_Select := True;
          TMIR3_GUI_TextLabel(GetComponentByID(GUI_ID_SELECTCHAR_INFO_NAME_3)).FGUI_Definition.gui_Font.gui_Font_Color  := $FFFFFFFF;
          TMIR3_GUI_TextLabel(GetComponentByID(GUI_ID_SELECTCHAR_INFO_LEVEL_3)).FGUI_Definition.gui_Font.gui_Font_Color := $FFFFFFFF;
          TMIR3_GUI_TextLabel(GetComponentByID(GUI_ID_SELECTCHAR_INFO_CLASS_3)).FGUI_Definition.gui_Font.gui_Font_Color := $FFFFFFFF;
//          TMIR3_GUI_TextLabel(GetComponentByID(GUI_ID_SELECTCHAR_INFO_NAME_INFO)).Caption  := PWideChar(String(FCharacterList[2].Char_Name));
//          TMIR3_GUI_TextLabel(GetComponentByID(GUI_ID_SELECTCHAR_INFO_CLASS_INFO)).Caption := PWideChar(GetClassAsString(FCharacterList[2].Char_Job));
//          TMIR3_GUI_TextLabel(GetComponentByID(GUI_ID_SELECTCHAR_INFO_LEVEL_INFO)).Caption := PWideChar(IntToStr(FCharacterList[2].Char_Level));
//          TMIR3_GUI_TextLabel(GetComponentByID(GUI_ID_SELECTCHAR_INFO_GOLD_INFO)).Caption  := PWideChar(IntToStr(FCharacterList[2].Char_Gold));
//          TMIR3_GUI_TextLabel(GetComponentByID(GUI_ID_SELECTCHAR_INFO_EXP_INFO)).Caption   := PWideChar(String(FCharacterList[2].Char_Exp + '%'));
          TMIR3_GUI_SelectChar(GetComponentByID(GUI_ID_SELECTCHAR_CHARACTER_3)).Selected   := True;
          case FCharacterList[2].Char_Job of
            C_WARRIOR  : case FCharacterList[2].Char_Gender of
                           C_MALE   : GGameEngine.SoundManager.PlaySound('JMMSel.wav');
                           C_FEMALE : GGameEngine.SoundManager.PlaySound('JWMSel.wav');
                         end;
            C_WIZZARD  : case FCharacterList[2].Char_Gender of
                           C_MALE   : GGameEngine.SoundManager.PlaySound('SMMSel.wav');
                           C_FEMALE : GGameEngine.SoundManager.PlaySound('SWMSel.wav');
                         end;
            C_TAOIST   : case FCharacterList[2].Char_Gender of
                           C_MALE   : GGameEngine.SoundManager.PlaySound('DMMSel.wav');
                           C_FEMALE : GGameEngine.SoundManager.PlaySound('DWMSel.wav');
                         end;
            C_ASSASSIN : case FCharacterList[2].Char_Gender of
                           C_MALE   : GGameEngine.SoundManager.PlaySound('as_168-m.wav'); //fix me with correct Sound
                           C_FEMALE : GGameEngine.SoundManager.PlaySound('as_168-f.wav'); //fix me with correct Sound
                         end;
          end;
        end;
        3 : begin
          FCharacterList[3].Char_Select := True;
          TMIR3_GUI_TextLabel(GetComponentByID(GUI_ID_SELECTCHAR_INFO_NAME_4)).FGUI_Definition.gui_Font.gui_Font_Color  := $FFFFFFFF;
          TMIR3_GUI_TextLabel(GetComponentByID(GUI_ID_SELECTCHAR_INFO_LEVEL_4)).FGUI_Definition.gui_Font.gui_Font_Color := $FFFFFFFF;
          TMIR3_GUI_TextLabel(GetComponentByID(GUI_ID_SELECTCHAR_INFO_CLASS_4)).FGUI_Definition.gui_Font.gui_Font_Color := $FFFFFFFF;

//          TMIR3_GUI_TextLabel(GetComponentByID(GUI_ID_SELECTCHAR_INFO_NAME_INFO)).Caption  := PWideChar(String(FCharacterList[2].Char_Name));
//          TMIR3_GUI_TextLabel(GetComponentByID(GUI_ID_SELECTCHAR_INFO_CLASS_INFO)).Caption := PWideChar(GetClassAsString(FCharacterList[2].Char_Job));
//          TMIR3_GUI_TextLabel(GetComponentByID(GUI_ID_SELECTCHAR_INFO_LEVEL_INFO)).Caption := PWideChar(IntToStr(FCharacterList[2].Char_Level));
//          TMIR3_GUI_TextLabel(GetComponentByID(GUI_ID_SELECTCHAR_INFO_GOLD_INFO)).Caption  := PWideChar(IntToStr(FCharacterList[2].Char_Gold));
//          TMIR3_GUI_TextLabel(GetComponentByID(GUI_ID_SELECTCHAR_INFO_EXP_INFO)).Caption   := PWideChar(String(FCharacterList[2].Char_Exp + '%'));
          TMIR3_GUI_SelectChar(GetComponentByID(GUI_ID_SELECTCHAR_CHARACTER_4)).Selected   := True;
          case FCharacterList[3].Char_Job of
            C_WARRIOR  : case FCharacterList[3].Char_Gender of
                           C_MALE   : GGameEngine.SoundManager.PlaySound('JMMSel.wav');
                           C_FEMALE : GGameEngine.SoundManager.PlaySound('JWMSel.wav');
                         end;
            C_WIZZARD  : case FCharacterList[3].Char_Gender of
                           C_MALE   : GGameEngine.SoundManager.PlaySound('SMMSel.wav');
                           C_FEMALE : GGameEngine.SoundManager.PlaySound('SWMSel.wav');
                         end;
            C_TAOIST   : case FCharacterList[3].Char_Gender of
                           C_MALE   : GGameEngine.SoundManager.PlaySound('DMMSel.wav');
                           C_FEMALE : GGameEngine.SoundManager.PlaySound('DWMSel.wav');
                         end;
            C_ASSASSIN : case FCharacterList[3].Char_Gender of
                           C_MALE   : GGameEngine.SoundManager.PlaySound('as_168-m.wav'); //fix me with correct Sound
                           C_FEMALE : GGameEngine.SoundManager.PlaySound('as_168-f.wav'); //fix me with correct Sound
                         end;
          end;
        end;
      end;
    end;

  {$ENDREGION}

  {$REGION ' - TMir3GameSceneSelectChar :: Select Char Message Decoder  '}
    procedure TMir3GameSceneSelectChar.ReceiveMessagePacket(AReceiveData: String);
    var
      I : Integer;
      //FNetPort       : String;
      //FNetHost       : String;
      FTempBody      : String;
      FTempString    : String;
      FMessageHead   : String;
      FMessageBody   : String;
      FMessage       : TDefaultMessage;
    begin
      FMessageHead := Copy(AReceiveData, 1, DEFBLOCKSIZE);
      FMessageBody := Copy(AReceiveData, DEFBLOCKSIZE + 1, Length(AReceiveData) - DEFBLOCKSIZE);
      FMessage     := DecodeMessage(FMessageHead);

      case FMessage.Ident of
        SM_OUTOFCONNECTION    : begin

          SystemMessage(GGameEngine.GameLanguage.GetTextFromLangSystem(50), [mbOK],0);
          //FrmDlg.DMessageDlg ('Server connection was forcefully terminated.\Connection time probably exceed limit or\a reconnection was requested from user.', [mbOk]);
        end;
        SM_QUERYCHR           : begin
          {$REGION ' -  SM_QUERYCHR  '}
          ZeroMemory(@FCharacterList, SizeOf(TMir3CharacterList));
          FTempBody := DecodeString(FMessageBody);

          if Trim(FTempBody) = '' then
          begin
            SystemMessage(GGameEngine.GameLanguage.GetTextFromLangSystem(68), [mbOK], 0);
            Exit;
          end;

          (* read the character from connection stream *)
          for I := 0 to 2 do
          begin
            //Result + FCharName + '/' + FJob + '/' + FGold + '/' + FLevel + '/' + FGender + '/' + FExp +'/';
            with FCharacterList[I] do
            begin
              FTempBody := GetValidStr3(FTempBody,  FTempString, ['/']);
              FCharacterList[I].Char_Name := FTempString;
              FTempBody := GetValidStr3(FTempBody, FTempString, ['/']);
              FCharacterList[I].Char_Job   := StrToIntDef(FTempString, 0);
              FTempBody := GetValidStr3(FTempBody, FTempString, ['/']);
              FCharacterList[I].Char_Gold  := StrToIntDef(FTempString, 0);
              FTempBody := GetValidStr3(FTempBody, FTempString, ['/']);
              FCharacterList[I].Char_Level := StrToIntDef(FTempString, 0);
              FTempBody := GetValidStr3(FTempBody, FTempString, ['/']);
              FCharacterList[I].Char_Gender := StrToIntDef(FTempString, 0);
              FTempBody := GetValidStr3(FTempBody, FTempString, ['/']);
              FCharacterList[I].Char_Exp := FTempString;              
            end;
          end;

          (* checks if the character exist and determines which of them was drawn first. *)
          for I := 0 to 2 do
          begin
            with FCharacterList[I], TMIR3_GUI_SelectChar(GetComponentByID(GUI_ID_SELECTCHAR_CHARACTER_1+I)) do
            begin
              if (Trim(Char_Name)       <> '') and
                 (IntToStr(Char_Level)  <> '') and
                 (IntToStr(Char_Gender) <> '') then
              begin
                if Char_Name[1] = '*' then
                begin
                  Char_Name := Copy(Char_Name, 2, Length(Char_Name) - 1);
                  UpdateSelectCharacter(I);
                  Selected      := True;
                  CharacterInfo := FCharacterList[I];
                  Visible       := True;
                end else begin
                  Selected      := False;
                  CharacterInfo := FCharacterList[I];
                  Visible       := True;
                end;
              end else begin
                Selected := False;
                Visible  := False;
              end;
            end;
          end;

          if Trim(FCharacterInfo.Char_Name) <> '' then
            ZeroMemory(@FCharacterInfo, SizeOf(TMir3Character));
            
          TestAndSetNewSelection;
          {$ENDREGION}
        end;
        SM_QUERYCHR_FAIL      : begin // Query Char Fail
          SystemMessage(GGameEngine.GameLanguage.GetTextFromLangSystem(69), [mbOK],0);
        end;       
        SM_NEWCHR_SUCCESS     : begin //Create Char
          FGameEngine.Send_Query_Player;
        end;
        SM_NEWCHR_FAIL        : begin //Create Char Fail
          case FMessage.Recog of
            2: SystemMessage(GGameEngine.GameLanguage.GetTextFromLangSystem(70), [mbOK],0);
            3: SystemMessage(GGameEngine.GameLanguage.GetTextFromLangSystem(71), [mbOK],0);
            4: SystemMessage(GGameEngine.GameLanguage.GetTextFromLangSystem(72), [mbOK],0);
            else SystemMessage(GGameEngine.GameLanguage.GetTextFromLangSystem(73), [mbOK],0);
          end;
        end;
        SM_DELCHR_SUCCESS     : begin //Delete Char Success
          FGameEngine.Send_Query_Player;
        end;
        SM_DELCHR_FAIL        : begin //Delete Char Fail
          SystemMessage(GGameEngine.GameLanguage.GetTextFromLangSystem(74), [mbOK],0);
        end;
        SM_STARTPLAY          : begin // Start Game

          //SendRunLogin;

        end;
        SM_STARTFAIL          : begin // Start Game Fail
          
        end;
      end;
    end;
  {$ENDREGION}

  {$REGION ' - TMir3GameSceneSelectChar :: Event Funktion               '}
    procedure TMir3GameSceneSelectChar.Event_Start_Game;
    begin
      if GetSelectedCharacterID(False) <> -1 then
      begin
        TMIR3_GUI_Form(GetFormByID(GUI_ID_SELECTCHAR_BACKGROUND)).Visible := False;
        GGameEngine.FGameFileManger.RenderVideo(2);
        GGameEngine.GameSceneStep := gsScene_PlayGame;
//        with GGameEngine.GameNetwork do
//        begin
//          Active  := False;
//          Address := FNetHost;
//          Port    := StrToIntDef(FNetPort, 0);
//          Active  := True;
//        end;
        // Add Step Info Sel/Notice/Play???
      end;
    end;

    procedure TMir3GameSceneSelectChar.Event_Create_New_Char;
    begin
      if GetCharacterCount < 3 then
      begin
        GGameEngine.SoundManager.StopBackgroundMusic;
        ZeroMemory(@FCharacterInfo, SizeOf(TMir3Character));
        TMIR3_GUI_Form(GetFormByID(GUI_ID_SELECTCHAR_BACKGROUND)).Visible := False;
        GGameEngine.FGameFileManger.RenderVideo(1);
        //TMIR3_GUI_Form(GetFormByID(GUI_ID_CREATECHAR_BACKGROUND)).Visible := True;
      end else begin
        SystemMessage(GGameEngine.GameLanguage.GetTextFromLangSystem(67), [mbOk], 0);
      end;
    end;

    procedure TMir3GameSceneSelectChar.Event_Delete_Char;
    begin
      if GetSelectedCharacterID > -1 then
      begin
        FCharacterList[GetSelectedCharacterID(False)].Char_Delete := True;
        SystemMessage(GGameEngine.GameLanguage.GetTextFromLangSystem(65) + ' ' + FCharacterList[GetSelectedCharacterID(False)].Char_Name + #10#13 +
                      GGameEngine.GameLanguage.GetTextFromLangSystem(66), [mbExtraText_L, mbExtraText_R, mbEditField], 1, 79, 80);
      end;
    end;

    procedure TMir3GameSceneSelectChar.Event_Select(ASelect : Integer);
    var
      FCharInfo : TMir3Character;
    begin
      case ASelect of
        GUI_ID_SELECTCHAR_CHARACTER_1 : begin
          with TMIR3_GUI_SelectChar(GetComponentByID(GUI_ID_SELECTCHAR_CHARACTER_1)) do
          begin
            ResetSelection(True);
          end;
          with TMIR3_GUI_SelectChar(GetComponentByID(GUI_ID_SELECTCHAR_CHARACTER_2)) do
          begin
            ResetSelection(False);
          end;
          with TMIR3_GUI_SelectChar(GetComponentByID(GUI_ID_SELECTCHAR_CHARACTER_3)) do
          begin
            ResetSelection(False);
          end;
          with TMIR3_GUI_SelectChar(GetComponentByID(GUI_ID_SELECTCHAR_CHARACTER_4)) do
          begin
            ResetSelection(False);
          end;
          UpdateSelectCharacter(0);
        end;
        GUI_ID_SELECTCHAR_CHARACTER_2 : begin
          with TMIR3_GUI_SelectChar(GetComponentByID(GUI_ID_SELECTCHAR_CHARACTER_1)) do
          begin
            ResetSelection(False);
          end;
          with TMIR3_GUI_SelectChar(GetComponentByID(GUI_ID_SELECTCHAR_CHARACTER_2)) do
          begin
            ResetSelection(True);
          end;
          with TMIR3_GUI_SelectChar(GetComponentByID(GUI_ID_SELECTCHAR_CHARACTER_3)) do
          begin
            ResetSelection(False);
          end;
          with TMIR3_GUI_SelectChar(GetComponentByID(GUI_ID_SELECTCHAR_CHARACTER_4)) do
          begin
            ResetSelection(False);
          end;
          UpdateSelectCharacter(1);
        end;
        GUI_ID_SELECTCHAR_CHARACTER_3 : begin
          with TMIR3_GUI_SelectChar(GetComponentByID(GUI_ID_SELECTCHAR_CHARACTER_1)) do
          begin
            ResetSelection(False);
          end;
          with TMIR3_GUI_SelectChar(GetComponentByID(GUI_ID_SELECTCHAR_CHARACTER_2)) do
          begin
            ResetSelection(False);
          end;
          with TMIR3_GUI_SelectChar(GetComponentByID(GUI_ID_SELECTCHAR_CHARACTER_3)) do
          begin
            ResetSelection(True);
          end;
          with TMIR3_GUI_SelectChar(GetComponentByID(GUI_ID_SELECTCHAR_CHARACTER_4)) do
          begin
            ResetSelection(False);
          end;
          UpdateSelectCharacter(2);
        end;
        GUI_ID_SELECTCHAR_CHARACTER_4 : begin
          with TMIR3_GUI_SelectChar(GetComponentByID(GUI_ID_SELECTCHAR_CHARACTER_1)) do
          begin
            ResetSelection(False);
          end;
          with TMIR3_GUI_SelectChar(GetComponentByID(GUI_ID_SELECTCHAR_CHARACTER_2)) do
          begin
            ResetSelection(False);
          end;
          with TMIR3_GUI_SelectChar(GetComponentByID(GUI_ID_SELECTCHAR_CHARACTER_3)) do
          begin
            ResetSelection(False);
          end;
          with TMIR3_GUI_SelectChar(GetComponentByID(GUI_ID_SELECTCHAR_CHARACTER_4)) do
          begin
            ResetSelection(True);
          end;
          UpdateSelectCharacter(3);
        end;
        ////////////  Create Char ////////////////////////////////////////////////
        GUI_ID_CREATECHAR_CHARACTER   : begin
          FCharacterInfo.Char_Gender := C_MALE;
          //with GGameEngine.GameLanguage do
            //TMIR3_GUI_Panel(GetComponentByID(GUI_ID_CREATECHAR_INFO)).Caption := PWideChar(Format(GetTextFromLangSystem(61 + FCharacterInfo.Char_Job), [GetTextFromLangSystem(55)]));
          with TMIR3_GUI_SelectChar(GetComponentByID(GUI_ID_CREATECHAR_CHARACTER)) do
          begin
            ResetSelection(True);
          end;
        end;
//        GUI_ID_CREATECHAR_CHARACTER_FEMALE : begin
//          FCharacterInfo.Char_Gender := C_FEMALE;
//          with GGameEngine.GameLanguage do
//             TMIR3_GUI_Panel(GetComponentByID(GUI_ID_CREATECHAR_INFO)).Caption := PWideChar(Format(GetTextFromLangSystem(61 + FCharacterInfo.Char_Job), [GetTextFromLangSystem(56)]));
//          with TMIR3_GUI_SelectChar(GetComponentByID(GUI_ID_CREATECHAR_CHARACTER_MALE)) do
//          begin
//            ResetSelection(False);
//          end;
//          with TMIR3_GUI_SelectChar(GetComponentByID(GUI_ID_CREATECHAR_CHARACTER_FEMALE)) do
//          begin
//            ResetSelection(True);
//          end;
//        end;
        GUI_ID_CREATECHAR_BUTTON_WARRIOR  : begin
          FCharacterInfo.Char_Job := C_WARRIOR;
          with TMIR3_GUI_SelectChar(GetComponentByID(GUI_ID_CREATECHAR_CHARACTER)) do
          begin
            FCharInfo.Char_Job    := C_WARRIOR;
            FCharInfo.Char_Gender := C_MALE;
            CharacterInfo         := FCharInfo;
            ResetSelection(Selected);
            //if Selected then
              //with GGameEngine.GameLanguage do
                //TMIR3_GUI_Panel(GetComponentByID(GUI_ID_CREATECHAR_INFO)).Caption := PWideChar(Format(GetTextFromLangSystem(61), [GetTextFromLangSystem(55)]));
          end;
//          with TMIR3_GUI_SelectChar(GetComponentByID(GUI_ID_CREATECHAR_CHARACTER_FEMALE)) do
//          begin
//            FCharInfo.Char_Job    := C_WARRIOR;
//            FCharInfo.Char_Gender := C_FEMALE;
//            CharacterInfo         := FCharInfo;
//            ResetSelection(Selected);
//            if Selected then
//              with GGameEngine.GameLanguage do
//                TMIR3_GUI_Panel(GetComponentByID(GUI_ID_CREATECHAR_INFO)).Caption := PWideChar(Format(GetTextFromLangSystem(61), [GetTextFromLangSystem(56)]));
//          end;
        end;
        GUI_ID_CREATECHAR_BUTTON_WIZZARD  : begin
          FCharacterInfo.Char_Job := C_WIZZARD;
          with TMIR3_GUI_SelectChar(GetComponentByID(GUI_ID_CREATECHAR_CHARACTER)) do
          begin
            FCharInfo.Char_Job    := C_WIZZARD;
            FCharInfo.Char_Gender := C_MALE;
            CharacterInfo         := FCharInfo;
            ResetSelection(Selected);
            //if Selected then
              //with GGameEngine.GameLanguage do
                //TMIR3_GUI_Panel(GetComponentByID(GUI_ID_CREATECHAR_INFO)).Caption := PWideChar(Format(GetTextFromLangSystem(62), [GetTextFromLangSystem(55)]));
          end;
//          with TMIR3_GUI_SelectChar(GetComponentByID(GUI_ID_CREATECHAR_CHARACTER_FEMALE)) do
//          begin
//            FCharInfo.Char_Job    := C_WIZZARD;
//            FCharInfo.Char_Gender := C_FEMALE;
//            CharacterInfo         := FCharInfo;
//            ResetSelection(Selected);
//            if Selected then
//              with GGameEngine.GameLanguage do
//                TMIR3_GUI_Panel(GetComponentByID(GUI_ID_CREATECHAR_INFO)).Caption := PWideChar(Format(GetTextFromLangSystem(62), [GetTextFromLangSystem(56)]));
//          end;
        end;
        GUI_ID_CREATECHAR_BUTTON_TAOIST  : begin
          FCharacterInfo.Char_Job := C_TAOIST;
          with TMIR3_GUI_SelectChar(GetComponentByID(GUI_ID_CREATECHAR_CHARACTER)) do
          begin
            FCharInfo.Char_Job    := C_TAOIST;
            FCharInfo.Char_Gender := C_MALE;
            CharacterInfo         := FCharInfo;
            ResetSelection(Selected);
            //if Selected then
              //with GGameEngine.GameLanguage do
                //TMIR3_GUI_Panel(GetComponentByID(GUI_ID_CREATECHAR_INFO)).Caption := PWideChar(Format(GetTextFromLangSystem(63), [GetTextFromLangSystem(55)]));
          end;
//          with TMIR3_GUI_SelectChar(GetComponentByID(GUI_ID_CREATECHAR_CHARACTER_FEMALE)) do
//          begin
//            FCharInfo.Char_Job    := C_TAOIST;
//            FCharInfo.Char_Gender := C_FEMALE;
//            CharacterInfo         := FCharInfo;
//            ResetSelection(Selected);
//            if Selected then
//              with GGameEngine.GameLanguage do
//                TMIR3_GUI_Panel(GetComponentByID(GUI_ID_CREATECHAR_INFO)).Caption := PWideChar(Format(GetTextFromLangSystem(63), [GetTextFromLangSystem(56)]));
//          end;
        end;
        GUI_ID_CREATECHAR_BUTTON_ASSASSIN  : begin
          FCharacterInfo.Char_Job := C_ASSASSIN;
          with TMIR3_GUI_SelectChar(GetComponentByID(GUI_ID_CREATECHAR_CHARACTER)) do
          begin
            FCharInfo.Char_Job    := C_ASSASSIN;
            FCharInfo.Char_Gender := C_MALE;
            CharacterInfo         := FCharInfo;
            ResetSelection(Selected);
            //if Selected then
              //with GGameEngine.GameLanguage do
                //TMIR3_GUI_Panel(GetComponentByID(GUI_ID_CREATECHAR_INFO)).Caption := PWideChar(Format(GetTextFromLangSystem(64), [GetTextFromLangSystem(55)]));
          end;
//          with TMIR3_GUI_SelectChar(GetComponentByID(GUI_ID_CREATECHAR_CHARACTER_FEMALE)) do
//          begin
//            FCharInfo.Char_Job    := C_ASSASSIN;
//            FCharInfo.Char_Gender := C_FEMALE;
//            CharacterInfo         := FCharInfo;
//            ResetSelection(Selected);
//            if Selected then
//              with GGameEngine.GameLanguage do
//                TMIR3_GUI_Panel(GetComponentByID(GUI_ID_CREATECHAR_INFO)).Caption := PWideChar(Format(GetTextFromLangSystem(64), [GetTextFromLangSystem(56)]));
//          end;
        end;
      end;
    end;

    procedure TMir3GameSceneSelectChar.Event_CreateChar_Ok;
    begin
      FCharacterInfo.Char_Name := Trim(TMIR3_GUI_Edit(GetComponentByID(GUI_ID_CREATECHAR_EDIT_CHAR_NAME)).Text);
      FCharacterInfo.Char_Hair := RandomRange(0,3);
      FGameEngine.Send_New_Player(FCharacterInfo);
      { Close Create Char Scene and open Select Char Scene }
      //TMIR3_GUI_Form(GetFormByID(GUI_ID_CREATECHAR_BACKGROUND)).Visible := False;
      TMIR3_GUI_Edit(GetComponentByID(GUI_ID_CREATECHAR_EDIT_CHAR_NAME)).ClearText;
      ResetCreateCharScene;
      ResetScene;
      TMIR3_GUI_Form(GetFormByID(GUI_ID_SELECTCHAR_BACKGROUND)).Visible := True;
    end;

    procedure TMir3GameSceneSelectChar.Event_CreateChar_Cancel;
    begin
      //TMIR3_GUI_Form(GetFormByID(GUI_ID_CREATECHAR_BACKGROUND)).Visible := False;
      TMIR3_GUI_Edit(GetComponentByID(GUI_ID_CREATECHAR_EDIT_CHAR_NAME)).ClearText;
      ResetCreateCharScene;
      ResetScene;
      TMIR3_GUI_Form(GetFormByID(GUI_ID_SELECTCHAR_BACKGROUND)).Visible := True;
    end;

    procedure TMir3GameSceneSelectChar.Event_System_Ok;
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

    procedure TMir3GameSceneSelectChar.Event_System_Yes;
    var
      FPassword : String;
    begin
      case TMIR3_GUI_Form(GetFormByID(GUI_ID_SYSINFO_DIALOG)).EventTypeID of
        0:;
        1: begin
          { Delete Selected Character OK }
          FPassword := TMIR3_GUI_Edit(GetComponentByID(GUI_ID_SYSINFO_EDIT_FIELD)).Text;
          FGameEngine.Send_Delete_Player(FCharacterList[GetSelectedCharacterID(False)].Char_Name);
        end;
        2: SendMessage(GRenderEngine.GetGameHWND, $0010, 0, 0);
      end;
      TMIR3_GUI_Form(GetFormByID(GUI_ID_SYSINFO_DIALOG)).Visible := False;
    end;

    procedure TMir3GameSceneSelectChar.Event_System_No;
    begin
      case TMIR3_GUI_Form(GetFormByID(GUI_ID_SYSINFO_DIALOG)).EventTypeID of
        0:;
        1: begin
          FCharacterList[0].Char_Delete := False;
          FCharacterList[1].Char_Delete := False;
          FCharacterList[2].Char_Delete := False;
        end;
      end;
      TMIR3_GUI_Form(GetFormByID(GUI_ID_SYSINFO_DIALOG)).Visible := False;
    end;
  {$ENDREGION}


  {$REGION ' - Callback Event Function   '}
    procedure SelectCharGUIEvent(AEventID: LongWord; AControlID: Cardinal; AControl: PMIR3_GUI_Default); stdcall;
    begin
      case AEventID of
        EVENT_BUTTON_UP : begin
          {$REGION ' - EVENT_BUTTON_CLICKED '}
          case AControl.ControlIdentifier of
            {$REGION ' - Select Char   - EVENT_BUTTON_CLICKED '}
            GUI_ID_SELECTCHAR_BUTTON_EXIT        : GGameEngine.SceneSelectChar.SystemMessage(GGameEngine.GameLanguage.GetTextFromLangSystem(13),[mbYes, mbNo], 2);
            GUI_ID_SELECTCHAR_BUTTON_START       : GGameEngine.SceneSelectChar.Event_Start_Game;
            GUI_ID_SELECTCHAR_BUTTON_DELETE_CHAR : GGameEngine.SceneSelectChar.Event_Delete_Char;
            GUI_ID_SELECTCHAR_BUTTON_NEW_CHAR    : GGameEngine.SceneSelectChar.Event_Create_New_Char;
            GUI_ID_SELECTCHAR_CHARACTER_1        : GGameEngine.SceneSelectChar.Event_Select(GUI_ID_SELECTCHAR_CHARACTER_1);
            GUI_ID_SELECTCHAR_CHARACTER_2        : GGameEngine.SceneSelectChar.Event_Select(GUI_ID_SELECTCHAR_CHARACTER_2);
            GUI_ID_SELECTCHAR_CHARACTER_3        : GGameEngine.SceneSelectChar.Event_Select(GUI_ID_SELECTCHAR_CHARACTER_3);
            GUI_ID_SELECTCHAR_CHARACTER_4        : GGameEngine.SceneSelectChar.Event_Select(GUI_ID_SELECTCHAR_CHARACTER_4);
            {$ENDREGION}
            {$REGION ' - Create Char   - EVENT_BUTTON_CLICKED '}
            GUI_ID_CREATECHAR_CHARACTER          : GGameEngine.SceneSelectChar.Event_Select(GUI_ID_CREATECHAR_CHARACTER);
            //GUI_ID_CREATECHAR_CHARACTER_FEMALE   : GGameEngine.SceneSelectChar.Event_Select(GUI_ID_CREATECHAR_CHARACTER_FEMALE);
            GUI_ID_CREATECHAR_BUTTON_WARRIOR     : GGameEngine.SceneSelectChar.Event_Select(GUI_ID_CREATECHAR_BUTTON_WARRIOR);
            GUI_ID_CREATECHAR_BUTTON_WIZZARD     : GGameEngine.SceneSelectChar.Event_Select(GUI_ID_CREATECHAR_BUTTON_WIZZARD);
            GUI_ID_CREATECHAR_BUTTON_TAOIST      : GGameEngine.SceneSelectChar.Event_Select(GUI_ID_CREATECHAR_BUTTON_TAOIST);
            GUI_ID_CREATECHAR_BUTTON_ASSASSIN    : GGameEngine.SceneSelectChar.Event_Select(GUI_ID_CREATECHAR_BUTTON_ASSASSIN);
            GUI_ID_CREATECHAR_BUTTON_OK          : GGameEngine.SceneSelectChar.Event_CreateChar_Ok;
            GUI_ID_CREATECHAR_BUTTON_CANCEL      : GGameEngine.SceneSelectChar.Event_CreateChar_Cancel;
            {$ENDREGION}
            {$REGION ' - System Button - EVENT_BUTTON_CLICKED '}
            GUI_ID_SYSINFO_BUTTON_OK             : GGameEngine.SceneSelectChar.Event_System_Ok;
            GUI_ID_SYSINFO_BUTTON_YES            : GGameEngine.SceneSelectChar.Event_System_Yes;
            GUI_ID_SYSINFO_BUTTON_NO             : GGameEngine.SceneSelectChar.Event_System_No;
            GUI_ID_SYSINFO_BUTTON_FREE_LEFT      : GGameEngine.SceneSelectChar.Event_System_Yes;
            GUI_ID_SYSINFO_BUTTON_FREE_RIGHT     : GGameEngine.SceneSelectChar.Event_System_No;
            {$ENDREGION}
          end;
          {$ENDREGION}
        end;
      end;
    end;

    procedure SelectCharGUIHotKeyEvent(AChar: LongWord); stdcall;
    begin
      case Chr(AChar) of
        ' ':;
//        'N' : BrowseURL(DeCodeString(GGameEngine.GameLauncherSetting.FRegister_URL));
//        'P' : BrowseURL(DeCodeString(GGameEngine.GameLauncherSetting.FAccount_URL));
//        'L' : GGameEngine.SceneLogon.Event_Logon_Check_Login_Data;
//        'X' : SendMessage(GRenderEngine.GetGameHWND, $0010, 0, 0);
      end;
    end;
  {$ENDREGION}

end.