(*****************************************************************************************
 *   LomCN Mir3 GUI Definition control File 2013                                         *
 *                                                                                       *
 *   Web       : http://www.lomcn.org                                                    *
 *   Version   : 0.0.0.1                                                                 *
 *                                                                                       *
 *   - File Info -                                                                       *
 *                                                                                       *
 *   Hold all GUI Definitions                                                            *
 *                                                                                       *
 *****************************************************************************************
 * Change History                                                                        *
 *                                                                                       *
 *  - 0.0.0.1  [2012-05-10] Coly : fist init (Splitt the old one)                        * 
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
 *  - TODO : -all -Check if Frame timing correct at MonActions                           *
 *                                                                                       *
 *****************************************************************************************)

unit mir3_game_gui_definition_select_create_char;

interface

uses
  { Delphi    } Windows, Classes, SysUtils,
  { DirectX   } Direct3D9, D3DX9,
  { Mir3 Game } mir3_core_controls,
                mir3_global_config,
                mir3_game_file_manager_const,
                mir3_game_font_engine,
                mir3_game_engine;

const
  //Unique Control Numbers

  (* SelectChar Control IDs *)
  {$REGION ' - SelectChar Control IDs             '}
  (*0..99 only for System Controls*)  
  GUI_ID_SELECTCHAR_BACKGROUND                    = 100;
  GUI_ID_SELECTCHAR_CHARACTER_1                   = 101;
  GUI_ID_SELECTCHAR_CHARACTER_2                   = 102;
  GUI_ID_SELECTCHAR_CHARACTER_3                   = 103;
  GUI_ID_SELECTCHAR_CHARACTER_4                   = 104;
  GUI_ID_SELECTCHAR_ANIMATION                     = 105;
  GUI_ID_SELECTCHAR_BUTTON_START                  = 106;
  GUI_ID_SELECTCHAR_BUTTON_EXIT                   = 107;
  GUI_ID_SELECTCHAR_BUTTON_DELETE_CHAR            = 108;
  GUI_ID_SELECTCHAR_BUTTON_NEW_CHAR               = 109;
  GUI_ID_SELECTCHAR_BUTTON_SET_2ND_PASSWORD       = 110;
  GUI_ID_SELECTCHAR_INFO_PANEL_1                  = 111;
  GUI_ID_SELECTCHAR_INFO_PANEL_2                  = 112;
  GUI_ID_SELECTCHAR_INFO_PANEL_3                  = 113;
  GUI_ID_SELECTCHAR_INFO_PANEL_4                  = 114;
  GUI_ID_SELECTCHAR_INFO_PANEL_TOP                = 115;
  GUI_ID_SELECTCHAR_INFO_PANEL_BOTTOM             = 116;
  GUI_ID_SELECTCHAR_INFO_NAME_1                   = 117;
  GUI_ID_SELECTCHAR_INFO_NAME_2                   = 118; 
  GUI_ID_SELECTCHAR_INFO_NAME_3                   = 119; 
  GUI_ID_SELECTCHAR_INFO_NAME_4                   = 120; 
  GUI_ID_SELECTCHAR_INFO_CLASS_1                  = 121;
  GUI_ID_SELECTCHAR_INFO_CLASS_2                  = 122;
  GUI_ID_SELECTCHAR_INFO_CLASS_3                  = 123;
  GUI_ID_SELECTCHAR_INFO_CLASS_4                  = 124;
  GUI_ID_SELECTCHAR_INFO_LEVEL_1                  = 125;
  GUI_ID_SELECTCHAR_INFO_LEVEL_2                  = 126;
  GUI_ID_SELECTCHAR_INFO_LEVEL_3                  = 127;
  GUI_ID_SELECTCHAR_INFO_LEVEL_4                  = 128; 
  {$ENDREGION}

  (* CreateChar Control IDs *)
  {$REGION ' - CreateChar Control IDs             '}
  GUI_ID_CREATECHAR_CHARACTER                     = 150;
  GUI_ID_CREATECHAR_INFO_PANEL                    = 151; //( kann für beides genutzt werden Image und Test Controls)
  GUI_ID_CREATECHAR_CLASS_FLAG                    = 152;
  GUI_ID_CREATECHAR_OPTION_PANEL                  = 153;
  GUI_ID_CREATECHAR_BUTTON_WARRIOR                = 155;
  GUI_ID_CREATECHAR_BUTTON_WIZZARD                = 156;
  GUI_ID_CREATECHAR_BUTTON_TAOIST                 = 157;
  GUI_ID_CREATECHAR_BUTTON_ASSASSIN               = 158;
  GUI_ID_CREATECHAR_BUTTON_GENDER_MEN             = 159;
  GUI_ID_CREATECHAR_BUTTON_GENDER_WOMEN           = 160; 
  GUI_ID_CREATECHAR_BUTTON_OK                     = 161;
  GUI_ID_CREATECHAR_BUTTON_CANCEL                 = 162;  
  GUI_ID_CREATECHAR_EDIT_CHAR_NAME                = 163;
  {$ENDREGION}


type
  TMir3_GUI_Definition_SelChar   = record
    (* Select Char Scene *)
    {$REGION ' - Select Char and Create Char Scene             '}
    ///////////////////////////         
          (* 800x600 *) 
    ///////////////////////////    
    FSelectChar_Background_800           : TMir3_GUI_Ground_Info;  // used for Select Char background texture and Contols Placeholder
      FSelectChar_Animation_1_800        : TMir3_GUI_Ground_Info;  // Fire Animation
      FSelectChar_Animation_2_800        : TMir3_GUI_Ground_Info;  // Ambient Animation
      FSelectChar_Character_1_800        : TMir3_GUI_Ground_Info;  // Character View 1
      FSelectChar_Character_2_800        : TMir3_GUI_Ground_Info;  // Character View 2
      FSelectChar_Character_3_800        : TMir3_GUI_Ground_Info;  // Character View 3
      FSelectChar_Character_4_800        : TMir3_GUI_Ground_Info;  // Character View 4
      FSelectChar_Panel_Top_800          : TMir3_GUI_Ground_Info;  //
      FSelectChar_Panel_Bottom_800       : TMir3_GUI_Ground_Info;  //
      FSelectChar_Btn_Start_800          : TMir3_GUI_Ground_Info;  // Start Game
      FSelectChar_Btn_Exit_800           : TMir3_GUI_Ground_Info;  // Exit Game
      FSelectChar_Btn_Delete_Char_800    : TMir3_GUI_Ground_Info;  // Delete old Char
      FSelectChar_Btn_New_Char_800       : TMir3_GUI_Ground_Info;  // Create new Char
      FSelectChar_Btn_Set2ndPassword_800 : TMir3_GUI_Ground_Info;  // Create new Char
      FSelectChar_Panel_Char_1_800       : TMir3_GUI_Ground_Info;  // Info
      FSelectChar_Panel_Char_2_800       : TMir3_GUI_Ground_Info;  // Info
      FSelectChar_Panel_Char_3_800       : TMir3_GUI_Ground_Info;  // Info
      FSelectChar_Panel_Char_4_800       : TMir3_GUI_Ground_Info;  // Info
      ///////////////////////////     
         (* Character Info *) 
      ///////////////////////////
      // Name for Char 1 - 4
      FSelectChar_Dialog_Name_1_800      : TMir3_GUI_Ground_Info;  // Character Name Info
      FSelectChar_Dialog_Name_2_800      : TMir3_GUI_Ground_Info;  // Character Name Info
      FSelectChar_Dialog_Name_3_800      : TMir3_GUI_Ground_Info;  // Character Name Info
      FSelectChar_Dialog_Name_4_800      : TMir3_GUI_Ground_Info;  // Character Name Info
      // Level for Char 1 - 4
      FSelectChar_Dialog_Level_1_800     : TMir3_GUI_Ground_Info;  // Character Level Info
      FSelectChar_Dialog_Level_2_800     : TMir3_GUI_Ground_Info;  // Character Level Info
      FSelectChar_Dialog_Level_3_800     : TMir3_GUI_Ground_Info;  // Character Level Info
      FSelectChar_Dialog_Level_4_800     : TMir3_GUI_Ground_Info;  // Character Level Info
      // Class for Char 1 - 4
      FSelectChar_Dialog_Class_1_800     : TMir3_GUI_Ground_Info;  // Character Class Info
      FSelectChar_Dialog_Class_2_800     : TMir3_GUI_Ground_Info;  // Character Class Info
      FSelectChar_Dialog_Class_3_800     : TMir3_GUI_Ground_Info;  // Character Class Info
      FSelectChar_Dialog_Class_4_800     : TMir3_GUI_Ground_Info;  // Character Class Info

    ///////////////////////////     
            (* 1024 *) 
    ///////////////////////////
    FSelectChar_Background_1024          : TMir3_GUI_Ground_Info;  //used for Select Char background texture and Contols Placeholder
      FSelectChar_Animation_1_1024       : TMir3_GUI_Ground_Info;  // Fire Animation
      FSelectChar_Animation_2_1024       : TMir3_GUI_Ground_Info;  // Fire Animation
      FSelectChar_Character_1_1024       : TMir3_GUI_Ground_Info;  // Character View 1
      FSelectChar_Character_2_1024       : TMir3_GUI_Ground_Info;  // Character View 2
      FSelectChar_Character_3_1024       : TMir3_GUI_Ground_Info;  // Character View 3
      FSelectChar_Character_4_1024       : TMir3_GUI_Ground_Info;  // Character View 4
      FSelectChar_Panel_Top_1024         : TMir3_GUI_Ground_Info;  // 
      FSelectChar_Panel_Bottom_1024      : TMir3_GUI_Ground_Info;  //
      FSelectChar_Btn_Start_1024         : TMir3_GUI_Ground_Info;  // Start Game
      FSelectChar_Btn_Exit_1024          : TMir3_GUI_Ground_Info;  // Exit Game
      FSelectChar_Btn_Delete_Char_1024   : TMir3_GUI_Ground_Info;  // Delete old Char
      FSelectChar_Btn_New_Char_1024      : TMir3_GUI_Ground_Info;  // Create new Char
      FSelectChar_Btn_Set2ndPassword_1024: TMir3_GUI_Ground_Info;  // Create new Char
      FSelectChar_Panel_Char_1_1024      : TMir3_GUI_Ground_Info;  // Info
      FSelectChar_Panel_Char_2_1024      : TMir3_GUI_Ground_Info;  // Info
      FSelectChar_Panel_Char_3_1024      : TMir3_GUI_Ground_Info;  // Info
      FSelectChar_Panel_Char_4_1024      : TMir3_GUI_Ground_Info;  // Info
      ///////////////////////////     
         (* Character Info *) 
      ///////////////////////////
      // Name for Char 1 - 4
      FSelectChar_Dialog_Name_1_1024     : TMir3_GUI_Ground_Info;  // Character Name Info
      FSelectChar_Dialog_Name_2_1024     : TMir3_GUI_Ground_Info;  // Character Name Info
      FSelectChar_Dialog_Name_3_1024     : TMir3_GUI_Ground_Info;  // Character Name Info
      FSelectChar_Dialog_Name_4_1024     : TMir3_GUI_Ground_Info;  // Character Name Info
      // Level for Char 1 - 4
      FSelectChar_Dialog_Level_1_1024    : TMir3_GUI_Ground_Info;  // Character Level Info
      FSelectChar_Dialog_Level_2_1024    : TMir3_GUI_Ground_Info;  // Character Level Info
      FSelectChar_Dialog_Level_3_1024    : TMir3_GUI_Ground_Info;  // Character Level Info
      FSelectChar_Dialog_Level_4_1024    : TMir3_GUI_Ground_Info;  // Character Level Info
      // Class for Char 1 - 4
      FSelectChar_Dialog_Class_1_1024    : TMir3_GUI_Ground_Info;  // Character Class Info
      FSelectChar_Dialog_Class_2_1024    : TMir3_GUI_Ground_Info;  // Character Class Info
      FSelectChar_Dialog_Class_3_1024    : TMir3_GUI_Ground_Info;  // Character Class Info
      FSelectChar_Dialog_Class_4_1024    : TMir3_GUI_Ground_Info;  // Character Class Info
      
      
    (* Create Char Scene *)
    ///////////////////////////         
          (* 800x600 *)
    ///////////////////////////
      FCreateChar_Character              : TMir3_GUI_Ground_Info;  // Character View Male
      FCreateChar_Character_Female       : TMir3_GUI_Ground_Info;  // Character View Female
      FCreateChar_Panel_Stone_Shadow     : TMir3_GUI_Ground_Info;  // Stone Shadow
      FCreateChar_Panel_Stone            : TMir3_GUI_Ground_Info;  // Button Stone
      FCreateChar_Button_Warrior         : TMir3_GUI_Ground_Info;  // Button to Select Warrior Class
      FCreateChar_Button_Wizzard         : TMir3_GUI_Ground_Info;  // Button to Select Wizzard Class
      FCreateChar_Button_Taoist          : TMir3_GUI_Ground_Info;  // Button to Select Taoist Class
      FCreateChar_Button_Assassin        : TMir3_GUI_Ground_Info;  // Button to Select Assassin Class
      FCreateChar_Button_Ok              : TMir3_GUI_Ground_Info;  // Button to Create the Character
      FCreateChar_Button_Cancel          : TMir3_GUI_Ground_Info;  // Button to Cancel Character Creation
      FCreateChar_Edit_Char_Name         : TMir3_GUI_Ground_Info;  // Edit field for the Character Name
      FCreateChar_Information_Field      : TMir3_GUI_Ground_Info;  // View Class Info
    ///////////////////////////     
            (* 1024 *) 
    ///////////////////////////      
    {$ENDREGION}
  end;

  
var
  ////////////////////////////////////////////////////////////////////////////////
  // Game Select Character and Create Character Control Definition
  //..............................................................................
  FGame_GUI_Definition_SelChar : TMir3_GUI_Definition_SelChar =(

    {$REGION ' - SelectChar Scene       '}
    ///////////////////////////         
          (* 800x600 *) 
    ///////////////////////////    
    FSelectChar_Background_800          : ({$REGION ' - FSelectChar_Background_800             '}
                                     gui_Unique_Control_Number  : GUI_ID_SELECTCHAR_BACKGROUND;
                                     gui_Type                   : ctForm;
                                     gui_Form_Type              : ftBackground;
                                     gui_WorkField              : (Left:0; Top:0; Right:800; Bottom:600);
                                     gui_Top                    : 0;
                                     gui_Left                   : 0;
                                     gui_Height                 : 600;
                                     gui_Width                  : 800;
                                     gui_Strech_Rate_X          : 0.79;
                                     gui_Strech_Rate_Y          : 0.79;
                                     gui_Blend_Size             : 255;
                                     gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_INTERFACE1C_INT;
                                                                   gui_Background_Texture_ID : 49);
                                     gui_Use_Strech_Texture     : True;
                                     gui_Enabled                : True;
                                     gui_Visible                : True                                   
                                     {$ENDREGION}
              );
    FSelectChar_Animation_1_800         : ({$REGION ' - FSelectChar_Animation_800              '}
                                     gui_Unique_Control_Number  : GUI_ID_SELECTCHAR_ANIMATION;
                                     gui_Type                   : ctPanel;
                                     gui_Form_Type              : ftNone;
                                     gui_Top                    : -30;
                                     gui_Left                   : -18;
                                     gui_Height                 : 600;
                                     gui_Width                  : 800;
                                     gui_Strech_Rate_X          : 0.79;
                                     gui_Strech_Rate_Y          : 0.79;
                                     gui_Blend_Size             : 255;
                                     gui_Control_Texture        : (gui_Texture_File_ID           : GAME_TEXTURE_INTERFACE1C_INT;
                                                                   gui_Background_Texture_ID     : 0);
                                     gui_Animation              : (
                                                                   gui_Animation_Texture_File_ID : GAME_TEXTURE_INTERFACE1C_INT;
                                                                   gui_Animation_Texture_From    : 2899;
                                                                   gui_Animation_Texture_To      : 2914;
                                                                   gui_Animation_Blend_Mode      : Blend_Add;
                                                                   gui_Animation_Interval        : 100;
                                                                  );
                                     gui_Use_Animation_Texture  : True;
                                     gui_Use_Strech_Texture     : True;
                                     gui_Use_Offset_Calc        : True;
                                     gui_Enabled                : True;
                                     gui_Visible                : True
                                     {$ENDREGION}
              );
    FSelectChar_Animation_2_800         : ({$REGION ' - FSelectChar_Animation_800              '}
                                     gui_Unique_Control_Number  : GUI_ID_SELECTCHAR_ANIMATION;
                                     gui_Type                   : ctPanel;
                                     gui_Form_Type              : ftNone;
                                     gui_Top                    : 20;
                                     gui_Left                   : 0;
                                     gui_Height                 : 600;
                                     gui_Width                  : 800;
                                     gui_Strech_Rate_X          : 0.79;
                                     gui_Strech_Rate_Y          : 0.79;
                                     gui_Blend_Size             : 255;
                                     gui_Control_Texture        : (gui_Texture_File_ID           : GAME_TEXTURE_INTERFACE1C_INT;
                                                                   gui_Background_Texture_ID     : 0);
                                     gui_Animation              : (
                                                                   gui_Animation_Texture_File_ID : GAME_TEXTURE_INTERFACE1C_INT;
                                                                   gui_Animation_Texture_From    : 2799;
                                                                   gui_Animation_Texture_To      : 2815;
                                                                   gui_Animation_Blend_Mode      : Blend_Add;
                                                                   gui_Animation_Interval        : 100;
                                                                  );
                                     gui_Use_Animation_Texture  : True;
                                     gui_Use_Strech_Texture     : True;
                                     gui_Use_Offset_Calc        : True;
                                     gui_Enabled                : True;
                                     gui_Visible                : True
                                     {$ENDREGION}
              );
    FSelectChar_Character_1_800         : ({$REGION ' - FSelectChar_Character_1                '}
                                     gui_Unique_Control_Number  : GUI_ID_SELECTCHAR_CHARACTER_1;
                                     gui_Type                   : ctSelectChar;
                                     gui_Form_Type              : ftNone;
                                     gui_WorkField              : (Left:0; Top:0; Right:120; Bottom:200);
                                     gui_Top                    : 200;
                                     gui_Left                   : -45;
                                     gui_Height                 : 250;
                                     gui_Width                  : 120;
                                     gui_Strech_Rate_X          : 0.79;
                                     gui_Strech_Rate_Y          : 0.79;
                                     gui_Blend_Size             : 255;
                                     gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_INTERFACE1C_INT;
                                                                   gui_Background_Texture_ID : 201);
                                     gui_Color                  : (gui_ControlColor : $FFFF0000;
                                                                   gui_BorderColor  : $FFFF0000);
                                     gui_Use_Strech_Texture     : True;
                                     gui_ShowBorder             : True;
                                     gui_Enabled                : True;
                                     gui_Visible                : True
                                     {$ENDREGION}
              );
    FSelectChar_Character_2_800         : ({$REGION ' - FSelectChar_Character_3_800            '}
                                     gui_Unique_Control_Number  : GUI_ID_SELECTCHAR_CHARACTER_2;
                                     gui_Type                   : ctSelectChar;
                                     gui_Form_Type              : ftNone;
                                     gui_WorkField              : (Left:0; Top:0; Right:120; Bottom:200);
                                     gui_Top                    : 210;
                                     gui_Left                   : 120;
                                     gui_Height                 : 250;
                                     gui_Width                  : 120;
                                     gui_Strech_Rate_X          : 0.79;
                                     gui_Strech_Rate_Y          : 0.79;
                                     gui_Blend_Size             : 255;
                                     gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_INTERFACE1C_INT;
                                                                   gui_Background_Texture_ID : 201);
                                     gui_Color                  : (gui_ControlColor : $FFFF0000;
                                                                   gui_BorderColor  : $FFFF00FF);
                                     gui_Use_Strech_Texture     : True;
                                     gui_ShowBorder             : True;
                                     gui_Enabled                : True;
                                     gui_Visible                : False 
                                     {$ENDREGION}
              );
    FSelectChar_Character_3_800         : ({$REGION ' - FSelectChar_Character_3_800            '}
                                     gui_Unique_Control_Number  : GUI_ID_SELECTCHAR_CHARACTER_3;
                                     gui_Type                   : ctSelectChar;
                                     gui_Form_Type              : ftNone;
                                     gui_WorkField              : (Left:0; Top:0; Right:120; Bottom:200);
                                     gui_Top                    : 210;
                                     gui_Left                   : 265;
                                     gui_Height                 : 260;
                                     gui_Width                  : 120;
                                     gui_Strech_Rate_X          : 0.79;
                                     gui_Strech_Rate_Y          : 0.79;
                                     gui_Blend_Size             : 255;
                                     gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_INTERFACE1C_INT;
                                                                   gui_Background_Texture_ID : 201);
                                     gui_Color                  : (gui_ControlColor : $FFFF0000;
                                                                   gui_BorderColor  : $FFFF0000);
                                     gui_Use_Strech_Texture     : True;
                                     gui_ShowBorder             : True;
                                     gui_Enabled                : True;
                                     gui_Visible                : False 
                                     {$ENDREGION}
              );
    FSelectChar_Character_4_800         : ({$REGION ' - FSelectChar_Character_4_800            '}
                                     gui_Unique_Control_Number  : GUI_ID_SELECTCHAR_CHARACTER_4;
                                     gui_Type                   : ctSelectChar;
                                     gui_Form_Type              : ftNone;
                                     gui_WorkField              : (Left:0; Top:0; Right:120; Bottom:200);
                                     gui_Top                    : 210;
                                     gui_Left                   : 420;
                                     gui_Height                 : 260;
                                     gui_Width                  : 120;
                                     gui_Strech_Rate_X          : 0.79;
                                     gui_Strech_Rate_Y          : 0.79;
                                     gui_Blend_Size             : 255;
                                     gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_INTERFACE1C_INT;
                                                                   gui_Background_Texture_ID : 199);
                                     gui_Color                  : (gui_ControlColor : $FFFF0000;
                                                                   gui_BorderColor  : $FFFF00FF);
                                     gui_Use_Strech_Texture     : True;
                                     gui_ShowBorder             : True;
                                     gui_Enabled                : True;
                                     gui_Visible                : False 
                                     {$ENDREGION}
              );
    FSelectChar_Panel_Top_800           : ({$REGION ' - FSelectChar_Panel_Top_800              '}
                                     gui_Unique_Control_Number  : GUI_ID_SELECTCHAR_BACKGROUND;
                                     gui_Type                   : ctPanel;
                                     gui_Form_Type              : ftNone;
                                     gui_WorkField              : (Left:0; Top:0; Right:800; Bottom:80);
                                     gui_Top                    : 0;
                                     gui_Left                   : 0;
                                     gui_Height                 : 80;
                                     gui_Width                  : 800;
                                     gui_Strech_Rate_X          : 0.7809;
                                     gui_Strech_Rate_Y          : 0.7809;
                                     gui_Blend_Size             : 255;
                                     gui_Blend_Mode             : BLEND_DEFAULT;
                                     gui_CaptionID              : 92;                                     
                                     gui_Font                   : (gui_Font_Use_ID      : 2;
                                                                   gui_Font_Size        : 21;
                                                                   gui_Font_Color       : $FFBEA97A;
                                                                   gui_Font_Text_HAlign : alCenter;
                                                                   gui_Font_Text_VAlign : avTop;
                                                                   gui_Font_Setting     : [fsBold]);
                                     gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_INTERFACE1C_INT;
                                                                   gui_Background_Texture_ID : 50);
                                     gui_Caption_Extra          : (gui_Caption_Offset : 10);
                                     gui_Use_Strech_Texture     : True;
                                     gui_Enabled                : True;
                                     gui_Visible                : True
                                     {$ENDREGION}
              );
    FSelectChar_Panel_Bottom_800        : ({$REGION ' - FSelectChar_Panel_Bottom_800           '}
                                     gui_Unique_Control_Number  : GUI_ID_SELECTCHAR_BACKGROUND;
                                     gui_Type                   : ctPanel;
                                     gui_Form_Type              : ftNone;
                                     gui_WorkField              : (Left:0; Top:0; Right:800; Bottom:600);
                                     gui_Top                    : 554;
                                     gui_Left                   : 0;
                                     gui_Height                 : 62;
                                     gui_Width                  : 800;
                                     gui_Strech_Rate_X          : 0.79;
                                     gui_Strech_Rate_Y          : 0.79;
                                     gui_Blend_Size             : 255;
                                     gui_Blend_Mode             : BLEND_DEFAULT;
                                     gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_INTERFACE1C_INT;
                                                                   gui_Background_Texture_ID : 51);
                                     gui_Use_Strech_Texture     : True;
                                     gui_Enabled                : True;
                                     gui_Visible                : True
                                     {$ENDREGION}
              );
    FSelectChar_Btn_Start_800           : ({$REGION ' - FSelectChar_Button_Start               '}
                                     gui_Unique_Control_Number  : GUI_ID_SELECTCHAR_BUTTON_START;
                                     gui_Type                   : ctButton;
                                     gui_Form_Type              : ftNone;
                                     gui_WorkField              : (Left:0; Top:0; Right:100; Bottom:26);
                                     gui_Top                    : 520;
                                     gui_Left                   : 340;
                                     gui_Height                 : 26;
                                     gui_Width                  : 120;
                                     gui_Blend_Size             : 255;
                                     gui_CaptionID              : 75;
                                     gui_Font                   : (gui_Font_Use_ID      : 2;
                                                                   gui_Font_Size        : 18;
                                                                   gui_Font_Color       : $FFBEA97A;
                                                                   gui_Font_Text_HAlign : alCenter;
                                                                   gui_Font_Text_VAlign : avCenter;
                                                                   gui_Font_Script_MouseNormal   : '¦C14F4F4F¦¦C2EFEFEF¦';
                                                                   gui_Font_Script_MouseOver     : '¦C1A59222¦¦C2EFEFEF¦';
                                                                   gui_Font_Script_MouseDown     : '¦C14F4F4F¦¦C2EFEFEF¦');
                                     gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_INTERFACE1C_INT;
                                                                   gui_Background_Texture_ID : 56;
                                                                   gui_Mouse_Over_Texture_ID : 54;
                                                                   gui_Mouse_Down_Texture_ID : 55);
                                     gui_Enabled                : True;
                                     gui_Visible                : True
                                     {$ENDREGION}
              );
    FSelectChar_Btn_Exit_800            : ({$REGION ' - FSelectChar_Button_Exit_800            '}
                                     gui_Unique_Control_Number  : GUI_ID_SELECTCHAR_BUTTON_EXIT;
                                     gui_Type                   : ctButton;
                                     gui_Form_Type              : ftNone;
                                     gui_WorkField              : (Left:0; Top:0; Right:120; Bottom:26);
                                     gui_Top                    : 570;
                                     gui_Left                   : 12;
                                     gui_Height                 : 26;
                                     gui_Width                  : 120;
                                     gui_Blend_Size             : 255;
                                     gui_CaptionID              : 78;
                                     gui_Font                   : (gui_Font_Use_ID      : 2;
                                                                   gui_Font_Size        : 18;
                                                                   gui_Font_Color       : $FFBEA97A;
                                                                   gui_Font_Text_HAlign : alCenter;
                                                                   gui_Font_Text_VAlign : avCenter;
                                                                   gui_Font_Script_MouseNormal   : '¦C14F4F4F¦¦C2EFEFEF¦';
                                                                   gui_Font_Script_MouseOver     : '¦C1A59222¦¦C2EFEFEF¦';
                                                                   gui_Font_Script_MouseDown     : '¦C14F4F4F¦¦C2EFEFEF¦');
                                     gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_INTERFACE1C_INT;
                                                                   gui_Background_Texture_ID : 56;
                                                                   gui_Mouse_Over_Texture_ID : 54;
                                                                   gui_Mouse_Down_Texture_ID : 55);
                                     gui_Enabled                : True;
                                     gui_Visible                : True
                                     {$ENDREGION}
              );
    FSelectChar_Btn_Delete_Char_800     : ({$REGION ' - FSelectChar_Button_Delete_Char_800     '}
                                     gui_Unique_Control_Number  : GUI_ID_SELECTCHAR_BUTTON_DELETE_CHAR;
                                     gui_Type                   : ctButton;
                                     gui_Form_Type              : ftNone;
                                     gui_WorkField              : (Left:0; Top:0; Right:120; Bottom:26);
                                     gui_Top                    : 570;
                                     gui_Left                   : 410;
                                     gui_Height                 : 26;
                                     gui_Width                  : 120;
                                     gui_Blend_Size             : 255;
                                     gui_CaptionID              : 77;
                                     gui_Font                   : (gui_Font_Use_ID      : 2;
                                                                   gui_Font_Size        : 18;
                                                                   gui_Font_Color       : $FFBEA97A;
                                                                   gui_Font_Text_HAlign : alCenter;
                                                                   gui_Font_Text_VAlign : avCenter;
                                                                   gui_Font_Script_MouseNormal   : '¦C14F4F4F¦¦C2EFEFEF¦';
                                                                   gui_Font_Script_MouseOver     : '¦C1A59222¦¦C2EFEFEF¦';
                                                                   gui_Font_Script_MouseDown     : '¦C14F4F4F¦¦C2EFEFEF¦');
                                     gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_INTERFACE1C_INT;
                                                                   gui_Background_Texture_ID : 56;
                                                                   gui_Mouse_Over_Texture_ID : 54;
                                                                   gui_Mouse_Down_Texture_ID : 55);
                                     gui_Enabled                : True;
                                     gui_Visible                : True
                                     {$ENDREGION}
              );
    FSelectChar_Btn_New_Char_800        : ({$REGION ' - FSelectChar_Button_New_Char_800        '}
                                     gui_Unique_Control_Number  : GUI_ID_SELECTCHAR_BUTTON_DELETE_CHAR;
                                     gui_Type                   : ctButton;
                                     gui_Form_Type              : ftNone;
                                     gui_WorkField              : (Left:0; Top:0; Right:120; Bottom:26);
                                     gui_Top                    : 570;
                                     gui_Left                   : 270;
                                     gui_Height                 : 26;
                                     gui_Width                  : 120;
                                     gui_Blend_Size             : 255;
                                     gui_CaptionID              : 76;
                                     gui_Font                   : (gui_Font_Use_ID      : 2;
                                                                   gui_Font_Size        : 18;
                                                                   gui_Font_Color       : $FFBEA97A;
                                                                   gui_Font_Text_HAlign : alCenter;
                                                                   gui_Font_Text_VAlign : avCenter;
                                                                   gui_Font_Script_MouseNormal   : '¦C14F4F4F¦¦C2EFEFEF¦';
                                                                   gui_Font_Script_MouseOver     : '¦C1A59222¦¦C2EFEFEF¦';
                                                                   gui_Font_Script_MouseDown     : '¦C14F4F4F¦¦C2EFEFEF¦');
                                     gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_INTERFACE1C_INT;
                                                                   gui_Background_Texture_ID : 56;
                                                                   gui_Mouse_Over_Texture_ID : 54;
                                                                   gui_Mouse_Down_Texture_ID : 55);
                                     gui_Enabled                : True;
                                     gui_Visible                : True
                                     {$ENDREGION}
              );
    FSelectChar_Btn_Set2ndPassword_800  : ({$REGION ' - FSelectChar_Button_New_Char_800        '}
                                     gui_Unique_Control_Number  : GUI_ID_SELECTCHAR_BUTTON_SET_2ND_PASSWORD;
                                     gui_Type                   : ctButton;
                                     gui_Form_Type              : ftNone;
                                     gui_WorkField              : (Left:0; Top:0; Right:120; Bottom:26);
                                     gui_Top                    : 570;
                                     gui_Left                   : 668;
                                     gui_Height                 : 26;
                                     gui_Width                  : 120;
                                     gui_Blend_Size             : 255;
                                     gui_CaptionID              : 91;
                                     gui_Font                   : (gui_Font_Use_ID      : 2;
                                                                   gui_Font_Size        : 18;
                                                                   gui_Font_Color       : $FFBEA97A;
                                                                   gui_Font_Text_HAlign : alCenter;
                                                                   gui_Font_Text_VAlign : avCenter;
                                                                   gui_Font_Script_MouseNormal   : '¦C14F4F4F¦¦C2EFEFEF¦';
                                                                   gui_Font_Script_MouseOver     : '¦C1A59222¦¦C2EFEFEF¦';
                                                                   gui_Font_Script_MouseDown     : '¦C14F4F4F¦¦C2EFEFEF¦');
                                     gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_INTERFACE1C_INT;
                                                                   gui_Background_Texture_ID : 56;
                                                                   gui_Mouse_Over_Texture_ID : 54;
                                                                   gui_Mouse_Down_Texture_ID : 55);
                                     gui_Enabled                : True;
                                     gui_Visible                : True
                                     {$ENDREGION}
              );
    FSelectChar_Panel_Char_1_800        : ({$REGION ' - FSelectChar_Panel_Char_1_800           '}
                                     gui_Unique_Control_Number  : GUI_ID_SELECTCHAR_INFO_PANEL_1;
                                     gui_Type                   : ctPanel;
                                     gui_Form_Type              : ftNone;
                                     gui_Top                    : 160;
                                     gui_Left                   : 80;
                                     gui_Height                 : 74;
                                     gui_Width                  : 184;
                                     gui_Strech_Rate_X          : 0.79;
                                     gui_Strech_Rate_Y          : 0.79;
                                     gui_Blend_Size             : 255;
                                     gui_Blend_Mode             : BLEND_DEFAULT;
                                     gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_INTERFACE1C_INT;
                                                                   gui_Background_Texture_ID : 52);
                                     gui_Use_Strech_Texture     : True;
                                     gui_Enabled                : True;
                                     gui_Visible                : True                                   
                                     {$ENDREGION}
              ); 
    FSelectChar_Panel_Char_2_800        : ({$REGION ' - FSelectChar_Panel_Char_2_800           '}
                                     gui_Unique_Control_Number  : GUI_ID_SELECTCHAR_INFO_PANEL_2;
                                     gui_Type                   : ctPanel;
                                     gui_Form_Type              : ftNone;
                                     gui_Top                    : 160;
                                     gui_Left                   : 235;
                                     gui_Height                 : 74;
                                     gui_Width                  : 184;
                                     gui_Strech_Rate_X          : 0.79;
                                     gui_Strech_Rate_Y          : 0.79;
                                     gui_Blend_Size             : 255;
                                     gui_Blend_Mode             : BLEND_DEFAULT;
                                     gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_INTERFACE1C_INT;
                                                                   gui_Background_Texture_ID : 52);
                                     gui_Use_Strech_Texture     : True;
                                     gui_Enabled                : True;
                                     gui_Visible                : True
                                     {$ENDREGION}
              );
    FSelectChar_Panel_Char_3_800        : ({$REGION ' - FSelectChar_Panel_Char_3_800           '}
                                     gui_Unique_Control_Number  : GUI_ID_SELECTCHAR_INFO_PANEL_3;
                                     gui_Type                   : ctPanel;
                                     gui_Form_Type              : ftNone;
                                     gui_Top                    : 160;
                                     gui_Left                   : 390;
                                     gui_Height                 : 74;
                                     gui_Width                  : 184;
                                     gui_Strech_Rate_X          : 0.79;
                                     gui_Strech_Rate_Y          : 0.79;
                                     gui_Blend_Size             : 255;
                                     gui_Blend_Mode             : BLEND_DEFAULT;
                                     gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_INTERFACE1C_INT;
                                                                   gui_Background_Texture_ID : 52);
                                     gui_Use_Strech_Texture     : True;
                                     gui_Enabled                : True;
                                     gui_Visible                : True
                                     {$ENDREGION}
              );
    FSelectChar_Panel_Char_4_800        : ({$REGION ' - FSelectChar_Panel_Char_4_800           '}
                                     gui_Unique_Control_Number  : GUI_ID_SELECTCHAR_INFO_PANEL_4;
                                     gui_Type                   : ctPanel;
                                     gui_Form_Type              : ftNone;
                                     gui_Top                    : 160;
                                     gui_Left                   : 545;
                                     gui_Height                 : 74;
                                     gui_Width                  : 184;
                                     gui_Strech_Rate_X          : 0.79;
                                     gui_Strech_Rate_Y          : 0.79;
                                     gui_Blend_Size             : 255;
                                     gui_Blend_Mode             : BLEND_DEFAULT;
                                     gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_INTERFACE1C_INT;
                                                                   gui_Background_Texture_ID : 52);
                                     gui_Use_Strech_Texture     : True;
                                     gui_Enabled                : True;
                                     gui_Visible                : True
                                     {$ENDREGION}
              );
    FSelectChar_Dialog_Name_1_800       : ({$REGION ' - FSelectChar_Dialog_Name_1_800          '}
                                     gui_Unique_Control_Number  : GUI_ID_SELECTCHAR_INFO_NAME_1;
                                     gui_Type                   : ctTextLabel;
                                     gui_Form_Type              : ftNone;
                                     gui_Top                    : 162;
                                     gui_Left                   : 83;
                                     gui_Height                 : 24;
                                     gui_Width                  : 144;
                                     gui_Blend_Size             : 255;
                                     gui_Font                   : (gui_Font_Size        : 18;
                                                                   gui_Font_Color       : $FF989898;
                                                                   gui_Font_Text_HAlign : alCenter;
                                                                   gui_Font_Setting     : [fsBold]);
                                     gui_ShowBorder             : True;
                                     gui_ShowPanel              : True;
                                     gui_Enabled                : True;
                                     gui_Visible                : True  
                                     {$ENDREGION}
              );
    FSelectChar_Dialog_Name_2_800       : ({$REGION ' - FSelectChar_Dialog_Name_2_800          '}
                                     gui_Unique_Control_Number  : GUI_ID_SELECTCHAR_INFO_NAME_2;
                                     gui_Type                   : ctTextLabel;
                                     gui_Form_Type              : ftNone;
                                     gui_Top                    : 162;
                                     gui_Left                   : 238;
                                     gui_Height                 : 24;
                                     gui_Width                  : 144;
                                     gui_Blend_Size             : 255;
                                     gui_Font                   : (gui_Font_Size        : 18;
                                                                   gui_Font_Color       : $FF989898;
                                                                   gui_Font_Text_HAlign : alCenter;
                                                                   gui_Font_Setting     : [fsBold]);
                                     gui_ShowBorder             : True;
                                     gui_ShowPanel              : True;
                                     gui_Enabled                : True;
                                     gui_Visible                : False
                                     {$ENDREGION}
              );
    FSelectChar_Dialog_Name_3_800       : ({$REGION ' - FSelectChar_Dialog_Name_3_800          '}
                                     gui_Unique_Control_Number  : GUI_ID_SELECTCHAR_INFO_NAME_3;
                                     gui_Type                   : ctTextLabel;
                                     gui_Form_Type              : ftNone;
                                     gui_Top                    : 162;
                                     gui_Left                   : 393;
                                     gui_Height                 : 24;
                                     gui_Width                  : 144;
                                     gui_Blend_Size             : 255;
                                     gui_Font                   : (gui_Font_Size        : 18;
                                                                   gui_Font_Color       : $FF989898;
                                                                   gui_Font_Text_HAlign : alCenter;
                                                                   gui_Font_Setting     : [fsBold]);
                                     gui_ShowBorder             : True;
                                     gui_ShowPanel              : True;
                                     gui_Enabled                : True;
                                     gui_Visible                : False
                                     {$ENDREGION}
              );
    FSelectChar_Dialog_Name_4_800       : ({$REGION ' - FSelectChar_Dialog_Name_4_800          '}
                                     gui_Unique_Control_Number  : GUI_ID_SELECTCHAR_INFO_NAME_4;
                                     gui_Type                   : ctTextLabel;
                                     gui_Form_Type              : ftNone;
                                     gui_Top                    : 162;
                                     gui_Left                   : 548;
                                     gui_Height                 : 24;
                                     gui_Width                  : 144;
                                     gui_Blend_Size             : 255;
                                     gui_Font                   : (gui_Font_Size        : 18;
                                                                   gui_Font_Color       : $FF989898;
                                                                   gui_Font_Text_HAlign : alCenter;
                                                                   gui_Font_Setting     : [fsBold]);
                                     gui_ShowBorder             : True;
                                     gui_ShowPanel              : True;
                                     gui_Enabled                : True;
                                     gui_Visible                : False
                                     {$ENDREGION}
              );
    FSelectChar_Dialog_Level_1_800      : ({$REGION ' - FSelectChar_Dialog_Level_1_800         '}
                                     gui_Unique_Control_Number  : GUI_ID_SELECTCHAR_INFO_LEVEL_1;
                                     gui_Type                   : ctTextLabel;
                                     gui_Form_Type              : ftNone;
                                     gui_Top                    : 186;
                                     gui_Left                   : 80;
                                     gui_Height                 : 24;
                                     gui_Width                  : 144;
                                     gui_Blend_Size             : 255;
                                     gui_Font                   : (gui_Font_Size        : 18;
                                                                   gui_Font_Color       : $FF989898;
                                                                   gui_Font_Text_HAlign : alCenter;
                                                                   gui_Font_Setting     : [fsBold]);
                                     gui_ShowBorder             : True;
                                     gui_ShowPanel              : True;
                                     gui_Enabled                : True;
                                     gui_Visible                : True
                                     {$ENDREGION}
              );
    FSelectChar_Dialog_Level_2_800      : ({$REGION ' - FSelectChar_Dialog_Level_2_800         '}
                                     gui_Unique_Control_Number  : GUI_ID_SELECTCHAR_INFO_LEVEL_2;
                                     gui_Type                   : ctTextLabel;
                                     gui_Form_Type              : ftNone;
                                     gui_Top                    : 186;
                                     gui_Left                   : 235;
                                     gui_Height                 : 24;
                                     gui_Width                  : 144;
                                     gui_Blend_Size             : 255;
                                     gui_Font                   : (gui_Font_Size        : 18;
                                                                   gui_Font_Color       : $FF989898;
                                                                   gui_Font_Text_HAlign : alCenter;
                                                                   gui_Font_Setting     : [fsBold]);
                                     gui_ShowBorder             : True;
                                     gui_ShowPanel              : True;
                                     gui_Enabled                : True;
                                     gui_Visible                : True
                                     {$ENDREGION}
              ); 
    FSelectChar_Dialog_Level_3_800      : ({$REGION ' - FSelectChar_Dialog_Level_3_800         '}
                                     gui_Unique_Control_Number  : GUI_ID_SELECTCHAR_INFO_LEVEL_3;
                                     gui_Type                   : ctTextLabel;
                                     gui_Form_Type              : ftNone;
                                     gui_Top                    : 186;
                                     gui_Left                   : 390;
                                     gui_Height                 : 24;
                                     gui_Width                  : 144;
                                     gui_Blend_Size             : 255;
                                     gui_Font                   : (gui_Font_Size        : 18;
                                                                   gui_Font_Color       : $FF989898;
                                                                   gui_Font_Text_HAlign : alCenter;
                                                                   gui_Font_Setting     : [fsBold]);
                                     gui_ShowBorder             : True;
                                     gui_ShowPanel              : True;
                                     gui_Enabled                : True;
                                     gui_Visible                : True
                                     {$ENDREGION}
              );
    FSelectChar_Dialog_Level_4_800      : ({$REGION ' - FSelectChar_Dialog_Level_4_800         '}
                                     gui_Unique_Control_Number  : GUI_ID_SELECTCHAR_INFO_LEVEL_4;
                                     gui_Type                   : ctTextLabel;
                                     gui_Form_Type              : ftNone;
                                     gui_Top                    : 186;
                                     gui_Left                   : 545;
                                     gui_Height                 : 24;
                                     gui_Width                  : 144;
                                     gui_Blend_Size             : 255;
                                     gui_Font                   : (gui_Font_Size        : 18;
                                                                   gui_Font_Color       : $FF989898;
                                                                   gui_Font_Text_HAlign : alCenter;
                                                                   gui_Font_Setting     : [fsBold]);
                                     gui_ShowBorder             : True;
                                     gui_ShowPanel              : True;
                                     gui_Enabled                : True;
                                     gui_Visible                : True
                                     {$ENDREGION}
              );
    FSelectChar_Dialog_Class_1_800      : ({$REGION ' - FSelectChar_Dialog_Class_1_800         '}
                                     gui_Unique_Control_Number  : GUI_ID_SELECTCHAR_INFO_CLASS_1;
                                     gui_Type                   : ctTextLabel;
                                     gui_Form_Type              : ftNone;
                                     gui_Top                    : 200;
                                     gui_Left                   : 80;
                                     gui_Height                 : 24;
                                     gui_Width                  : 144;
                                     gui_Blend_Size             : 255;
                                     gui_Font                   : (gui_Font_Size        : 18;
                                                                   gui_Font_Color       : $FF989898;
                                                                   gui_Font_Text_HAlign : alCenter;
                                                                   gui_Font_Setting     : [fsBold]);
                                     gui_ShowBorder             : True;
                                     gui_ShowPanel              : True;
                                     gui_Enabled                : True;
                                     gui_Visible                : True
                                     {$ENDREGION}
              );
    FSelectChar_Dialog_Class_2_800      : ({$REGION ' - FSelectChar_Dialog_Class_2_800         '}
                                     gui_Unique_Control_Number  : GUI_ID_SELECTCHAR_INFO_CLASS_2;
                                     gui_Type                   : ctTextLabel;
                                     gui_Form_Type              : ftNone;
                                     gui_Top                    : 200;
                                     gui_Left                   : 235;
                                     gui_Height                 : 24;
                                     gui_Width                  : 144;
                                     gui_Blend_Size             : 255;
                                     gui_Font                   : (gui_Font_Size        : 18;
                                                                   gui_Font_Color       : $FF989898;
                                                                   gui_Font_Text_HAlign : alCenter;
                                                                   gui_Font_Setting     : [fsBold]);
                                     gui_ShowBorder             : True;
                                     gui_ShowPanel              : True;
                                     gui_Enabled                : True;
                                     gui_Visible                : True
                                     {$ENDREGION}
              );
    FSelectChar_Dialog_Class_3_800      : ({$REGION ' - FSelectChar_Dialog_Class_3_800         '}
                                     gui_Unique_Control_Number  : GUI_ID_SELECTCHAR_INFO_CLASS_3;
                                     gui_Type                   : ctTextLabel;
                                     gui_Form_Type              : ftNone;
                                     gui_Top                    : 200;
                                     gui_Left                   : 390;
                                     gui_Height                 : 24;
                                     gui_Width                  : 144;
                                     gui_Blend_Size             : 255;
                                     gui_Font                   : (gui_Font_Size        : 18;
                                                                   gui_Font_Color       : $FF989898;
                                                                   gui_Font_Text_HAlign : alCenter;
                                                                   gui_Font_Setting     : [fsBold]);
                                     gui_ShowBorder             : True;
                                     gui_ShowPanel              : True;
                                     gui_Enabled                : True;
                                     gui_Visible                : True
                                     {$ENDREGION}
              );
    FSelectChar_Dialog_Class_4_800      : ({$REGION ' - FSelectChar_Dialog_Class_4_800         '}
                                     gui_Unique_Control_Number  : GUI_ID_SELECTCHAR_INFO_CLASS_4;
                                     gui_Type                   : ctTextLabel;
                                     gui_Form_Type              : ftNone;
                                     gui_Top                    : 200;
                                     gui_Left                   : 545;
                                     gui_Height                 : 24;
                                     gui_Width                  : 144;
                                     gui_Blend_Size             : 255;
                                     gui_Font                   : (gui_Font_Size        : 18;
                                                                   gui_Font_Color       : $FF989898;
                                                                   gui_Font_Text_HAlign : alCenter;
                                                                   gui_Font_Setting     : [fsBold]);
                                     gui_ShowBorder             : True;
                                     gui_ShowPanel              : True;
                                     gui_Enabled                : True;
                                     gui_Visible                : True
                                     {$ENDREGION}
              );
    ///////////////////////////         
          (* 1024x768 *) 
    /////////////////////////// 
    FSelectChar_Background_1024         : ({$REGION ' - FSelectChar_Background_1024            '}
                                        gui_Unique_Control_Number  : GUI_ID_SELECTCHAR_BACKGROUND;
                                        gui_Type                   : ctForm;
                                        gui_Form_Type              : ftBackground;
                                        gui_WorkField              : (Left:0; Top:0; Right:1024; Bottom:768);
                                        gui_Top                    : 0;
                                        gui_Left                   : 0;
                                        gui_Height                 : 768;
                                        gui_Width                  : 1024;
                                        gui_Blend_Size             : 255;
                                        gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_INTERFACE1C_INT;
                                                                      gui_Background_Texture_ID : 49);
                                        gui_Enabled                : True;
                                        gui_Visible                : True                                   
                                        {$ENDREGION}
              );
    FSelectChar_Animation_1_1024        : ({$REGION ' - FSelectChar_Animation_1024             '}
                                        gui_Unique_Control_Number  : GUI_ID_SELECTCHAR_ANIMATION;
                                        gui_Type                   : ctPanel;
                                        gui_Form_Type              : ftNone;
                                        gui_Top                    : 22;
                                        gui_Left                   : 20;
                                        gui_Height                 : 768;
                                        gui_Width                  : 1024;
                                        gui_Blend_Size             : 255;
                                        gui_Control_Texture        : (gui_Texture_File_ID           : GAME_TEXTURE_INTERFACE1C_INT;
                                                                      gui_Background_Texture_ID     : 0);
                                        gui_Animation              : (
                                                                      gui_Animation_Texture_File_ID : GAME_TEXTURE_INTERFACE1C_INT;
                                                                      gui_Animation_Texture_From    : 2899;
                                                                      gui_Animation_Texture_To      : 2914;
                                                                      gui_Animation_Blend_Mode      : Blend_Add;
                                                                      gui_Animation_Interval        : 100;
                                                                     );
                                        gui_Use_Animation_Texture  : True;
                                        gui_Use_Offset_Calc        : True;
                                        gui_Enabled                : True;
                                        gui_Visible                : True
                                        {$ENDREGION}
              );
    FSelectChar_Animation_2_1024        : ({$REGION ' - FSelectChar_Animation_1024             '}
                                        gui_Unique_Control_Number  : GUI_ID_SELECTCHAR_ANIMATION;
                                        gui_Type                   : ctPanel;
                                        gui_Form_Type              : ftNone;
                                        gui_Top                    : 22;
                                        gui_Left                   : 0;
                                        gui_Height                 : 768;
                                        gui_Width                  : 1024;
                                        gui_Blend_Size             : 255;
                                        gui_Control_Texture        : (gui_Texture_File_ID           : GAME_TEXTURE_INTERFACE1C_INT;
                                                                      gui_Background_Texture_ID     : 0);
                                        gui_Animation              : (
                                                                      gui_Animation_Texture_File_ID : GAME_TEXTURE_INTERFACE1C_INT;
                                                                      gui_Animation_Texture_From    : 2799;
                                                                      gui_Animation_Texture_To      : 2815;
                                                                      gui_Animation_Blend_Mode      : Blend_Add;
                                                                      gui_Animation_Interval        : 100;
                                                                     );
                                        gui_Use_Animation_Texture  : True;
                                        gui_Use_Offset_Calc        : True;
                                        gui_Enabled                : True;
                                        gui_Visible                : True
                                        {$ENDREGION}
              );
    FSelectChar_Character_1_1024        : ({$REGION ' - FSelectChar_Character_1_1024           '}
                                        gui_Unique_Control_Number  : GUI_ID_SELECTCHAR_CHARACTER_1;
                                        gui_Type                   : ctSelectChar;
                                        gui_Form_Type              : ftNone;
                                        gui_WorkField              : (Left:0; Top:0; Right:100; Bottom:200);
                                        gui_Top                    : 150;
                                        gui_Left                   : -25;
                                        gui_Height                 : 200;
                                        gui_Width                  : 100;
                                        gui_Blend_Size             : 255;
                                        gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_INTERFACE1C_INT;
                                                                      gui_Background_Texture_ID : 201);
                                        gui_Enabled                : True;
                                        gui_Visible                : True
                                        {$ENDREGION}
              );
    FSelectChar_Character_2_1024        : ({$REGION ' - FSelectChar_Character_2_1024           '}
                                        gui_Unique_Control_Number  : GUI_ID_SELECTCHAR_CHARACTER_2;
                                        gui_Type                   : ctSelectChar;
                                        gui_Form_Type              : ftNone;
                                        gui_WorkField              : (Left:0; Top:0; Right:100; Bottom:200);
                                        gui_Top                    : 150;
                                        gui_Left                   : 80;
                                        gui_Height                 : 200;
                                        gui_Width                  : 100;
                                        gui_Blend_Size             : 255;
                                        gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_INTERFACE1C_INT;
                                                                      gui_Background_Texture_ID : 201);
                                        gui_Enabled                : True;
                                        gui_Visible                : False 
                                        {$ENDREGION}
              );
    FSelectChar_Character_3_1024        : ({$REGION ' - FSelectChar_Character_3_1024           '}
                                        gui_Unique_Control_Number  : GUI_ID_SELECTCHAR_CHARACTER_3;
                                        gui_Type                   : ctSelectChar;
                                        gui_Form_Type              : ftNone;
                                        gui_WorkField              : (Left:0; Top:0; Right:100; Bottom:200);
                                        gui_Top                    : 150;
                                        gui_Left                   : 100;
                                        gui_Height                 : 200;
                                        gui_Width                  : 100;
                                        gui_Blend_Size             : 255;
                                        gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_INTERFACE1C_INT;
                                                                      gui_Background_Texture_ID : 201);
                                        gui_Enabled                : True;
                                        gui_Visible                : False 
                                        {$ENDREGION}
              );
    FSelectChar_Character_4_1024        : ({$REGION ' - FSelectChar_Character_4_1024           '}
                                        gui_Unique_Control_Number  : GUI_ID_SELECTCHAR_CHARACTER_4;
                                        gui_Type                   : ctSelectChar;
                                        gui_Form_Type              : ftNone;
                                        gui_WorkField              : (Left:0; Top:0; Right:100; Bottom:200);
                                        gui_Top                    : 150;
                                        gui_Left                   : 300;
                                        gui_Height                 : 200;
                                        gui_Width                  : 100;
                                        gui_Blend_Size             : 255;
                                        gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_INTERFACE1C_INT;
                                                                      gui_Background_Texture_ID : 201);
                                        gui_Enabled                : True;
                                        gui_Visible                : False 
                                        {$ENDREGION}
              );
    FSelectChar_Panel_Top_1024          : ({$REGION ' - FSelectChar_Panel_Top_1024             '}
                                        gui_Unique_Control_Number  : GUI_ID_SELECTCHAR_BACKGROUND;
                                        gui_Type                   : ctPanel;
                                        gui_Form_Type              : ftNone;
                                        gui_WorkField              : (Left:0; Top:0; Right:1024; Bottom:80);
                                        gui_Top                    : 0;
                                        gui_Left                   : 0;
                                        gui_Height                 : 80;
                                        gui_Width                  : 1024;
                                        gui_Blend_Size             : 255;
                                        gui_Blend_Mode             : BLEND_DEFAULT;
                                        gui_CaptionID              : 92;                                     
                                        gui_Font                   : (gui_Font_Use_ID      : 2;
                                                                      gui_Font_Size        : 21;
                                                                      gui_Font_Color       : $FFBEA97A;
                                                                      gui_Font_Text_HAlign : alCenter;
                                                                      gui_Font_Text_VAlign : avCenter;
                                                                      gui_Font_Setting     : [fsBold]);
                                        gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_INTERFACE1C_INT;
                                                                      gui_Background_Texture_ID : 50);
                                        gui_Enabled                : True;
                                        gui_Visible                : True
                                        {$ENDREGION}
              );
    FSelectChar_Panel_Bottom_1024       : ({$REGION ' - FSelectChar_Panel_Bottom_1024          '}
                                        gui_Unique_Control_Number  : GUI_ID_SELECTCHAR_BACKGROUND;
                                        gui_Type                   : ctPanel;
                                        gui_Form_Type              : ftNone;
                                        gui_WorkField              : (Left:0; Top:0; Right:1024; Bottom:62);
                                        gui_Top                    : 554;
                                        gui_Left                   : 0;
                                        gui_Height                 : 62;
                                        gui_Width                  : 1024;
                                        gui_Blend_Size             : 255;
                                        gui_Blend_Mode             : BLEND_DEFAULT;
                                        gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_INTERFACE1C_INT;
                                                                      gui_Background_Texture_ID : 51);
                                        gui_Enabled                : True;
                                        gui_Visible                : True
                                        {$ENDREGION}
              );
    FSelectChar_Btn_Start_1024          : ({$REGION ' - FSelectChar_Btn_Start_1024             '}
                                        gui_Unique_Control_Number  : GUI_ID_SELECTCHAR_BUTTON_START;
                                        gui_Type                   : ctButton;
                                        gui_Form_Type              : ftNone;
                                        gui_WorkField              : (Left:0; Top:0; Right:120; Bottom:26);
                                        gui_Top                    : 520;
                                        gui_Left                   : 340;
                                        gui_Height                 : 26;
                                        gui_Width                  : 120;
                                        gui_Blend_Size             : 255;
                                        gui_CaptionID              : 75;
                                        gui_Font                   : (gui_Font_Use_ID      : 2;
                                                                      gui_Font_Size        : 18;
                                                                      gui_Font_Color       : $FFBEA97A;
                                                                      gui_Font_Text_HAlign : alCenter;
                                                                      gui_Font_Text_VAlign : avCenter;
                                                                      gui_Font_Script_MouseNormal   : '¦C14F4F4F¦¦C2EFEFEF¦';
                                                                      gui_Font_Script_MouseOver     : '¦C1A59222¦¦C2EFEFEF¦';
                                                                      gui_Font_Script_MouseDown     : '¦C14F4F4F¦¦C2EFEFEF¦');
                                        gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_INTERFACE1C_INT;
                                                                      gui_Background_Texture_ID : 56;
                                                                      gui_Mouse_Over_Texture_ID : 54;
                                                                      gui_Mouse_Down_Texture_ID : 55);
                                        gui_Enabled                : True;
                                        gui_Visible                : True
                                        {$ENDREGION}
              );
    FSelectChar_Btn_Exit_1024           : ({$REGION ' - FSelectChar_Btn_Exit_1024              '}
                                        gui_Unique_Control_Number  : GUI_ID_SELECTCHAR_BUTTON_EXIT;
                                        gui_Type                   : ctButton;
                                        gui_Form_Type              : ftNone;
                                        gui_WorkField              : (Left:0; Top:0; Right:120; Bottom:26);
                                        gui_Top                    : 570;
                                        gui_Left                   : 12;
                                        gui_Height                 : 26;
                                        gui_Width                  : 120;
                                        gui_Blend_Size             : 255;
                                        gui_CaptionID              : 78;
                                        gui_Font                   : (gui_Font_Use_ID      : 2;
                                                                      gui_Font_Size        : 18;
                                                                      gui_Font_Color       : $FFBEA97A;
                                                                      gui_Font_Text_HAlign : alCenter;
                                                                      gui_Font_Text_VAlign : avCenter;
                                                                      gui_Font_Script_MouseNormal   : '¦C14F4F4F¦¦C2EFEFEF¦';
                                                                      gui_Font_Script_MouseOver     : '¦C1A59222¦¦C2EFEFEF¦';
                                                                      gui_Font_Script_MouseDown     : '¦C14F4F4F¦¦C2EFEFEF¦');
                                        gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_INTERFACE1C_INT;
                                                                      gui_Background_Texture_ID : 56;
                                                                      gui_Mouse_Over_Texture_ID : 54;
                                                                      gui_Mouse_Down_Texture_ID : 55);
                                        gui_Enabled                : True;
                                        gui_Visible                : True
                                        {$ENDREGION}
              );
    FSelectChar_Btn_Delete_Char_1024    : ({$REGION ' - FSelectChar_Btn_Delete_Char_1024       '}
                                        gui_Unique_Control_Number  : GUI_ID_SELECTCHAR_BUTTON_DELETE_CHAR;
                                        gui_Type                   : ctButton;
                                        gui_Form_Type              : ftNone;
                                        gui_WorkField              : (Left:0; Top:0; Right:120; Bottom:26);
                                        gui_Top                    : 570;
                                        gui_Left                   : 410;
                                        gui_Height                 : 26;
                                        gui_Width                  : 120;
                                        gui_Blend_Size             : 255;
                                        gui_CaptionID              : 77;
                                        gui_Font                   : (gui_Font_Use_ID      : 2;
                                                                      gui_Font_Size        : 18;
                                                                      gui_Font_Color       : $FFBEA97A;
                                                                      gui_Font_Text_HAlign : alCenter;
                                                                      gui_Font_Text_VAlign : avCenter;
                                                                      gui_Font_Script_MouseNormal   : '¦C14F4F4F¦¦C2EFEFEF¦';
                                                                      gui_Font_Script_MouseOver     : '¦C1A59222¦¦C2EFEFEF¦';
                                                                      gui_Font_Script_MouseDown     : '¦C14F4F4F¦¦C2EFEFEF¦');
                                        gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_INTERFACE1C_INT;
                                                                      gui_Background_Texture_ID : 56;
                                                                      gui_Mouse_Over_Texture_ID : 54;
                                                                      gui_Mouse_Down_Texture_ID : 55);
                                        gui_Enabled                : True;
                                        gui_Visible                : True
                                        {$ENDREGION}
              );
    FSelectChar_Btn_New_Char_1024       : ({$REGION ' - FSelectChar_Btn_New_Char_1024          '}
                                        gui_Unique_Control_Number  : GUI_ID_SELECTCHAR_BUTTON_DELETE_CHAR;
                                        gui_Type                   : ctButton;
                                        gui_Form_Type              : ftNone;
                                        gui_WorkField              : (Left:0; Top:0; Right:120; Bottom:26);
                                        gui_Top                    : 570;
                                        gui_Left                   : 270;
                                        gui_Height                 : 26;
                                        gui_Width                  : 120;
                                        gui_Blend_Size             : 255;
                                        gui_CaptionID              : 76;
                                        gui_Font                   : (gui_Font_Use_ID      : 2;
                                                                      gui_Font_Size        : 18;
                                                                      gui_Font_Color       : $FFBEA97A;
                                                                      gui_Font_Text_HAlign : alCenter;
                                                                      gui_Font_Text_VAlign : avCenter;
                                                                      gui_Font_Script_MouseNormal   : '¦C14F4F4F¦¦C2EFEFEF¦';
                                                                      gui_Font_Script_MouseOver     : '¦C1A59222¦¦C2EFEFEF¦';
                                                                      gui_Font_Script_MouseDown     : '¦C14F4F4F¦¦C2EFEFEF¦');
                                        gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_INTERFACE1C_INT;
                                                                      gui_Background_Texture_ID : 56;
                                                                      gui_Mouse_Over_Texture_ID : 54;
                                                                      gui_Mouse_Down_Texture_ID : 55);
                                        gui_Enabled                : True;
                                        gui_Visible                : True
                                        {$ENDREGION}
              );
    FSelectChar_Btn_Set2ndPassword_1024 : ({$REGION ' - FSelectChar_Btn_Set2ndPassword_1024    '}
                                        gui_Unique_Control_Number  : GUI_ID_SELECTCHAR_BUTTON_SET_2ND_PASSWORD;
                                        gui_Type                   : ctButton;
                                        gui_Form_Type              : ftNone;
                                        gui_WorkField              : (Left:0; Top:0; Right:120; Bottom:26);
                                        gui_Top                    : 570;
                                        gui_Left                   : 668;
                                        gui_Height                 : 26;
                                        gui_Width                  : 120;
                                        gui_Blend_Size             : 255;
                                        gui_CaptionID              : 91;
                                        gui_Font                   : (gui_Font_Use_ID      : 2;
                                                                      gui_Font_Size        : 18;
                                                                      gui_Font_Color       : $FFBEA97A;
                                                                      gui_Font_Text_HAlign : alCenter;
                                                                      gui_Font_Text_VAlign : avCenter;
                                                                      gui_Font_Script_MouseNormal   : '¦C14F4F4F¦¦C2EFEFEF¦';
                                                                      gui_Font_Script_MouseOver     : '¦C1A59222¦¦C2EFEFEF¦';
                                                                      gui_Font_Script_MouseDown     : '¦C14F4F4F¦¦C2EFEFEF¦');
                                        gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_INTERFACE1C_INT;
                                                                      gui_Background_Texture_ID : 56;
                                                                      gui_Mouse_Over_Texture_ID : 54;
                                                                      gui_Mouse_Down_Texture_ID : 55);
                                        gui_Enabled                : True;
                                        gui_Visible                : True
                                        {$ENDREGION}
              );
    FSelectChar_Panel_Char_1_1024       : ({$REGION ' - FSelectChar_Panel_Char_1_1024          '}
                                        gui_Unique_Control_Number  : GUI_ID_SELECTCHAR_INFO_PANEL_1;
                                        gui_Type                   : ctPanel;
                                        gui_Form_Type              : ftNone;
                                        gui_Top                    : 160;
                                        gui_Left                   : 80;
                                        gui_Height                 : 74;
                                        gui_Width                  : 184;
                                        gui_Blend_Size             : 255;
                                        gui_Blend_Mode             : BLEND_DEFAULT;
                                        gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_INTERFACE1C_INT;
                                                                      gui_Background_Texture_ID : 52);
                                        gui_Enabled                : True;
                                        gui_Visible                : True                                   
                                        {$ENDREGION}
              ); 
    FSelectChar_Panel_Char_2_1024       : ({$REGION ' - FSelectChar_Panel_Char_2_1024          '}
                                        gui_Unique_Control_Number  : GUI_ID_SELECTCHAR_INFO_PANEL_2;
                                        gui_Type                   : ctPanel;
                                        gui_Form_Type              : ftNone;
                                        gui_Top                    : 160;
                                        gui_Left                   : 235;
                                        gui_Height                 : 74;
                                        gui_Width                  : 184;
                                        gui_Blend_Size             : 255;
                                        gui_Blend_Mode             : BLEND_DEFAULT;
                                        gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_INTERFACE1C_INT;
                                                                      gui_Background_Texture_ID : 52);
                                        gui_Enabled                : True;
                                        gui_Visible                : True
                                        {$ENDREGION}
              );
    FSelectChar_Panel_Char_3_1024       : ({$REGION ' - FSelectChar_Panel_Char_3_1024          '}
                                        gui_Unique_Control_Number  : GUI_ID_SELECTCHAR_INFO_PANEL_3;
                                        gui_Type                   : ctPanel;
                                        gui_Form_Type              : ftNone;
                                        gui_Top                    : 160;
                                        gui_Left                   : 390;
                                        gui_Height                 : 74;
                                        gui_Width                  : 184;
                                        gui_Blend_Size             : 255;
                                        gui_Blend_Mode             : BLEND_DEFAULT;
                                        gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_INTERFACE1C_INT;
                                                                      gui_Background_Texture_ID : 52);
                                        gui_Enabled                : True;
                                        gui_Visible                : True
                                        {$ENDREGION}
              );
    FSelectChar_Panel_Char_4_1024       : ({$REGION ' - FSelectChar_Panel_Char_4_1024          '}
                                        gui_Unique_Control_Number  : GUI_ID_SELECTCHAR_INFO_PANEL_4;
                                        gui_Type                   : ctPanel;
                                        gui_Form_Type              : ftNone;
                                        gui_Top                    : 160;
                                        gui_Left                   : 545;
                                        gui_Height                 : 74;
                                        gui_Width                  : 184;
                                        gui_Blend_Size             : 255;
                                        gui_Blend_Mode             : BLEND_DEFAULT;
                                        gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_INTERFACE1C_INT;
                                                                      gui_Background_Texture_ID : 52);
                                        gui_Enabled                : True;
                                        gui_Visible                : True
                                        {$ENDREGION}
              );
    FSelectChar_Dialog_Name_1_1024      : ({$REGION ' - FSelectChar_Dialog_Name_1_1024         '}
                                        gui_Unique_Control_Number  : GUI_ID_SELECTCHAR_INFO_NAME_1;
                                        gui_Type                   : ctTextLabel;
                                        gui_Form_Type              : ftNone;
                                        gui_Top                    : 162;
                                        gui_Left                   : 83;
                                        gui_Height                 : 24;
                                        gui_Width                  : 144;
                                        gui_Blend_Size             : 255;
                                        gui_Font                   : (gui_Font_Size        : 18;
                                                                      gui_Font_Color       : $FF989898;
                                                                      gui_Font_Text_HAlign : alCenter;
                                                                      gui_Font_Setting     : [fsBold]);
                                        gui_ShowBorder             : True;
                                        gui_ShowPanel              : True;
                                        gui_Enabled                : True;
                                        gui_Visible                : True  
                                        {$ENDREGION}
              );
    FSelectChar_Dialog_Name_2_1024      : ({$REGION ' - FSelectChar_Dialog_Name_2_1024         '}
                                        gui_Unique_Control_Number  : GUI_ID_SELECTCHAR_INFO_NAME_2;
                                        gui_Type                   : ctTextLabel;
                                        gui_Form_Type              : ftNone;
                                        gui_Top                    : 162;
                                        gui_Left                   : 238;
                                        gui_Height                 : 24;
                                        gui_Width                  : 144;
                                        gui_Blend_Size             : 255;
                                        gui_Font                   : (gui_Font_Size        : 18;
                                                                      gui_Font_Color       : $FF989898;
                                                                      gui_Font_Text_HAlign : alCenter;
                                                                      gui_Font_Setting     : [fsBold]);
                                        gui_ShowBorder             : True;
                                        gui_ShowPanel              : True;
                                        gui_Enabled                : True;
                                        gui_Visible                : False
                                        {$ENDREGION}
              );
    FSelectChar_Dialog_Name_3_1024      : ({$REGION ' - FSelectChar_Dialog_Name_3_1024         '}
                                        gui_Unique_Control_Number  : GUI_ID_SELECTCHAR_INFO_NAME_3;
                                        gui_Type                   : ctTextLabel;
                                        gui_Form_Type              : ftNone;
                                        gui_Top                    : 162;
                                        gui_Left                   : 393;
                                        gui_Height                 : 24;
                                        gui_Width                  : 144;
                                        gui_Blend_Size             : 255;
                                        gui_Font                   : (gui_Font_Size        : 18;
                                                                      gui_Font_Color       : $FF989898;
                                                                      gui_Font_Text_HAlign : alCenter;
                                                                      gui_Font_Setting     : [fsBold]);
                                        gui_ShowBorder             : True;
                                        gui_ShowPanel              : True;
                                        gui_Enabled                : True;
                                        gui_Visible                : False
                                        {$ENDREGION}
              );
    FSelectChar_Dialog_Name_4_1024      : ({$REGION ' - FSelectChar_Dialog_Name_4_1024         '}
                                        gui_Unique_Control_Number  : GUI_ID_SELECTCHAR_INFO_NAME_4;
                                        gui_Type                   : ctTextLabel;
                                        gui_Form_Type              : ftNone;
                                        gui_Top                    : 162;
                                        gui_Left                   : 548;
                                        gui_Height                 : 24;
                                        gui_Width                  : 144;
                                        gui_Blend_Size             : 255;
                                        gui_Font                   : (gui_Font_Size        : 18;
                                                                      gui_Font_Color       : $FF989898;
                                                                      gui_Font_Text_HAlign : alCenter;
                                                                      gui_Font_Setting     : [fsBold]);
                                        gui_ShowBorder             : True;
                                        gui_ShowPanel              : True;
                                        gui_Enabled                : True;
                                        gui_Visible                : False
                                        {$ENDREGION}
              );
    FSelectChar_Dialog_Level_1_1024     : ({$REGION ' - FSelectChar_Dialog_Level_1_1024        '}
                                        gui_Unique_Control_Number  : GUI_ID_SELECTCHAR_INFO_LEVEL_1;
                                        gui_Type                   : ctTextLabel;
                                        gui_Form_Type              : ftNone;
                                        gui_Top                    : 186;
                                        gui_Left                   : 80;
                                        gui_Height                 : 24;
                                        gui_Width                  : 144;
                                        gui_Blend_Size             : 255;
                                        gui_Font                   : (gui_Font_Size        : 18;
                                                                      gui_Font_Color       : $FF989898;
                                                                      gui_Font_Text_HAlign : alCenter;
                                                                      gui_Font_Setting     : [fsBold]);
                                        gui_ShowBorder             : True;
                                        gui_ShowPanel              : True;
                                        gui_Enabled                : True;
                                        gui_Visible                : True
                                        {$ENDREGION}
              );
    FSelectChar_Dialog_Level_2_1024     : ({$REGION ' - FSelectChar_Dialog_Level_2_1024        '}
                                        gui_Unique_Control_Number  : GUI_ID_SELECTCHAR_INFO_LEVEL_2;
                                        gui_Type                   : ctTextLabel;
                                        gui_Form_Type              : ftNone;
                                        gui_Top                    : 186;
                                        gui_Left                   : 235;
                                        gui_Height                 : 24;
                                        gui_Width                  : 144;
                                        gui_Blend_Size             : 255;
                                        gui_Font                   : (gui_Font_Size        : 18;
                                                                      gui_Font_Color       : $FF989898;
                                                                      gui_Font_Text_HAlign : alCenter;
                                                                      gui_Font_Setting     : [fsBold]);
                                        gui_ShowBorder             : True;
                                        gui_ShowPanel              : True;
                                        gui_Enabled                : True;
                                        gui_Visible                : True
                                        {$ENDREGION}
              ); 
    FSelectChar_Dialog_Level_3_1024     : ({$REGION ' - FSelectChar_Dialog_Level_3_1024        '}
                                        gui_Unique_Control_Number  : GUI_ID_SELECTCHAR_INFO_LEVEL_3;
                                        gui_Type                   : ctTextLabel;
                                        gui_Form_Type              : ftNone;
                                        gui_Top                    : 186;
                                        gui_Left                   : 390;
                                        gui_Height                 : 24;
                                        gui_Width                  : 144;
                                        gui_Blend_Size             : 255;
                                        gui_Font                   : (gui_Font_Size        : 18;
                                                                      gui_Font_Color       : $FF989898;
                                                                      gui_Font_Text_HAlign : alCenter;
                                                                      gui_Font_Setting     : [fsBold]);
                                        gui_ShowBorder             : True;
                                        gui_ShowPanel              : True;
                                        gui_Enabled                : True;
                                        gui_Visible                : True
                                        {$ENDREGION}
              );
    FSelectChar_Dialog_Level_4_1024     : ({$REGION ' - FSelectChar_Dialog_Level_4_1024        '}
                                        gui_Unique_Control_Number  : GUI_ID_SELECTCHAR_INFO_LEVEL_4;
                                        gui_Type                   : ctTextLabel;
                                        gui_Form_Type              : ftNone;
                                        gui_Top                    : 186;
                                        gui_Left                   : 545;
                                        gui_Height                 : 24;
                                        gui_Width                  : 144;
                                        gui_Blend_Size             : 255;
                                        gui_Font                   : (gui_Font_Size        : 18;
                                                                      gui_Font_Color       : $FF989898;
                                                                      gui_Font_Text_HAlign : alCenter;
                                                                      gui_Font_Setting     : [fsBold]);
                                        gui_ShowBorder             : True;
                                        gui_ShowPanel              : True;
                                        gui_Enabled                : True;
                                        gui_Visible                : True
                                        {$ENDREGION}
              );
    FSelectChar_Dialog_Class_1_1024     : ({$REGION ' - FSelectChar_Dialog_Class_1_1024        '}
                                        gui_Unique_Control_Number  : GUI_ID_SELECTCHAR_INFO_CLASS_1;
                                        gui_Type                   : ctTextLabel;
                                        gui_Form_Type              : ftNone;
                                        gui_Top                    : 200;
                                        gui_Left                   : 80;
                                        gui_Height                 : 24;
                                        gui_Width                  : 144;
                                        gui_Blend_Size             : 255;
                                        gui_Font                   : (gui_Font_Size        : 18;
                                                                      gui_Font_Color       : $FF989898;
                                                                      gui_Font_Text_HAlign : alCenter;
                                                                      gui_Font_Setting     : [fsBold]);
                                        gui_ShowBorder             : True;
                                        gui_ShowPanel              : True;
                                        gui_Enabled                : True;
                                        gui_Visible                : True
                                        {$ENDREGION}
              );
    FSelectChar_Dialog_Class_2_1024     : ({$REGION ' - FSelectChar_Dialog_Class_2_1024        '}
                                        gui_Unique_Control_Number  : GUI_ID_SELECTCHAR_INFO_CLASS_2;
                                        gui_Type                   : ctTextLabel;
                                        gui_Form_Type              : ftNone;
                                        gui_Top                    : 200;
                                        gui_Left                   : 235;
                                        gui_Height                 : 24;
                                        gui_Width                  : 144;
                                        gui_Blend_Size             : 255;
                                        gui_Font                   : (gui_Font_Size        : 18;
                                                                      gui_Font_Color       : $FF989898;
                                                                      gui_Font_Text_HAlign : alCenter;
                                                                      gui_Font_Setting     : [fsBold]);
                                        gui_ShowBorder             : True;
                                        gui_ShowPanel              : True;
                                        gui_Enabled                : True;
                                        gui_Visible                : True
                                        {$ENDREGION}
              );
    FSelectChar_Dialog_Class_3_1024     : ({$REGION ' - FSelectChar_Dialog_Class_3_1024        '}
                                        gui_Unique_Control_Number  : GUI_ID_SELECTCHAR_INFO_CLASS_3;
                                        gui_Type                   : ctTextLabel;
                                        gui_Form_Type              : ftNone;
                                        gui_Top                    : 200;
                                        gui_Left                   : 390;
                                        gui_Height                 : 24;
                                        gui_Width                  : 144;
                                        gui_Blend_Size             : 255;
                                        gui_Font                   : (gui_Font_Size        : 18;
                                                                      gui_Font_Color       : $FF989898;
                                                                      gui_Font_Text_HAlign : alCenter;
                                                                      gui_Font_Setting     : [fsBold]);
                                        gui_ShowBorder             : True;
                                        gui_ShowPanel              : True;
                                        gui_Enabled                : True;
                                        gui_Visible                : True
                                        {$ENDREGION}
              );
    FSelectChar_Dialog_Class_4_1024     : ({$REGION ' - FSelectChar_Dialog_Class_4_1024        '}
                                        gui_Unique_Control_Number  : GUI_ID_SELECTCHAR_INFO_CLASS_4;
                                        gui_Type                   : ctTextLabel;
                                        gui_Form_Type              : ftNone;
                                        gui_Top                    : 200;
                                        gui_Left                   : 545;
                                        gui_Height                 : 24;
                                        gui_Width                  : 144;
                                        gui_Blend_Size             : 255;
                                        gui_Font                   : (gui_Font_Size        : 18;
                                                                      gui_Font_Color       : $FF989898;
                                                                      gui_Font_Text_HAlign : alCenter;
                                                                      gui_Font_Setting     : [fsBold]);
                                        gui_ShowBorder             : True;
                                        gui_ShowPanel              : True;
                                        gui_Enabled                : True;
                                        gui_Visible                : True
                                        {$ENDREGION}
              );
    {$ENDREGION}

    {$REGION ' - CreateChar Scene       '}
    ///////////////////////////         
          (* 800x600 *) 
    ///////////////////////////    
    FCreateChar_Character            : ({$REGION ' - FCreateChar_Character         '}
                                     gui_Unique_Control_Number  : GUI_ID_CREATECHAR_CHARACTER;
                                     gui_Type                   : ctSelectChar;
                                     gui_Form_Type              : ftNone;
                                     gui_WorkField              : (Left:0; Top:0; Right:100; Bottom:260);
                                     gui_Top                    : 205;
                                     gui_Left                   : 185;
                                     gui_Height                 : 260;
                                     gui_Width                  : 100;
                                     gui_Blend_Size             : 255;
                                     gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_INTERFACE1C_INT;
                                                                   gui_Background_Texture_ID : 239);
                                     gui_Use_Strech_Texture     : True;
                                     gui_Enabled                : True;
                                     gui_Visible                : False                                      
                                     {$ENDREGION}
              );
    FCreateChar_Button_Warrior       : ({$REGION ' - FCreateChar_Button_Warrior       '}
                                     gui_Unique_Control_Number  : GUI_ID_CREATECHAR_BUTTON_WARRIOR;
                                     gui_Type                   : ctButton;
                                     gui_Form_Type              : ftNone;
                                     gui_WorkField              : (Left:0; Top:0; Right:36; Bottom:34);
                                     gui_Top                    : 543;
                                     gui_Left                   : 333;
                                     gui_Height                 : 34;
                                     gui_Width                  : 36;
                                     gui_Blend_Size             : 255;
                                     gui_HintID                 : 42;
                                     gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_INTERFACE1C_INT;
                                                                   gui_Background_Texture_ID : 92;
                                                                   gui_Mouse_Over_Texture_ID : 93;
                                                                   gui_Mouse_Down_Texture_ID : 94);
                                     gui_Enabled                : True;
                                     gui_Visible                : False
                                     {$ENDREGION}
              );
    FCreateChar_Button_Wizzard       : ({$REGION ' - FCreateChar_Button_Wizzard       '}
                                     gui_Unique_Control_Number  : GUI_ID_CREATECHAR_BUTTON_WIZZARD;
                                     gui_Type                   : ctButton;
                                     gui_Form_Type              : ftNone;
                                     gui_WorkField              : (Left:0; Top:0; Right:36; Bottom:34);
                                     gui_Top                    : 543;
                                     gui_Left                   : 369;
                                     gui_Height                 : 34;
                                     gui_Width                  : 36;
                                     gui_Blend_Size             : 255;
                                     gui_HintID                 : 43;
                                     gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_INTERFACE1C_INT;
                                                                   gui_Background_Texture_ID : 95;
                                                                   gui_Mouse_Over_Texture_ID : 96;
                                                                   gui_Mouse_Down_Texture_ID : 97);
                                     gui_Enabled                : True;
                                     gui_Visible                : False
                                     {$ENDREGION}
              );
    FCreateChar_Button_Taoist        : ({$REGION ' - FCreateChar_Button_Taoist        '}
                                     gui_Unique_Control_Number  : GUI_ID_CREATECHAR_BUTTON_TAOIST;
                                     gui_Type                   : ctButton;
                                     gui_Form_Type              : ftNone;
                                     gui_WorkField              : (Left:0; Top:0; Right:36; Bottom:34);
                                     gui_Top                    : 543;
                                     gui_Left                   : 406;
                                     gui_Height                 : 34;
                                     gui_Width                  : 36;
                                     gui_Blend_Size             : 255;
                                     gui_HintID                 : 44;
                                     gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_INTERFACE1C_INT;
                                                                   gui_Background_Texture_ID : 98;
                                                                   gui_Mouse_Over_Texture_ID : 99;
                                                                   gui_Mouse_Down_Texture_ID : 100);
                                     gui_Enabled                : True;
                                     gui_Visible                : False
                                     {$ENDREGION}
              );
    FCreateChar_Button_Assassin      : ({$REGION ' - FCreateChar_Button_Assassin      '}
                                     gui_Unique_Control_Number  : GUI_ID_CREATECHAR_BUTTON_ASSASSIN;
                                     gui_Type                   : ctButton;
                                     gui_Form_Type              : ftNone;
                                     gui_WorkField              : (Left:0; Top:0; Right:36; Bottom:34);
                                     gui_Top                    : 543;
                                     gui_Left                   : 442;
                                     gui_Height                 : 34;
                                     gui_Width                  : 36;
                                     gui_Blend_Size             : 255;
                                     gui_HintID                 : 45;
                                     gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_INTERFACE1C_INT;
                                                                   gui_Background_Texture_ID : 101;
                                                                   gui_Mouse_Over_Texture_ID : 102;
                                                                   gui_Mouse_Down_Texture_ID : 103);
                                     gui_Enabled                : True;
                                     gui_Visible                : False
                                     {$ENDREGION}
              );
    FCreateChar_Button_Ok            : ({$REGION ' - FCreateChar_Button_Ok            '}
                                     gui_Unique_Control_Number  : GUI_ID_CREATECHAR_BUTTON_OK;
                                     gui_Type                   : ctButton;
                                     gui_Form_Type              : ftNone;
                                     gui_WorkField              : (Left:0; Top:0; Right:28; Bottom:28);
                                     gui_Top                    : 557;
                                     gui_Left                   : 563;
                                     gui_Height                 : 28;
                                     gui_Width                  : 28;
                                     gui_Blend_Size             : 255;
                                     gui_HintID                 : 46;
                                     gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_INTERFACE1C_INT;
                                                                   gui_Background_Texture_ID : 86;
                                                                   gui_Mouse_Over_Texture_ID : 87;
                                                                   gui_Mouse_Down_Texture_ID : 88);
                                     gui_Enabled                : True;
                                     gui_Visible                : False
                                     {$ENDREGION}
              );
    FCreateChar_Button_Cancel        : ({$REGION ' - FCreateChar_Button_Cancel        '}
                                   gui_Unique_Control_Number  : GUI_ID_CREATECHAR_BUTTON_CANCEL;
                                   gui_Type                   : ctButton;
                                   gui_Form_Type              : ftNone;
                                   gui_WorkField              : (Left:0; Top:0; Right:28; Bottom:28);
                                   gui_Top                    : 557;
                                   gui_Left                   : 603;
                                   gui_Height                 : 28;
                                   gui_Width                  : 28;
                                   gui_Blend_Size             : 255;
                                   gui_HintID                 : 47;
                                   gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_INTERFACE1C_INT;
                                                                 gui_Background_Texture_ID : 89;
                                                                 gui_Mouse_Over_Texture_ID : 90;
                                                                 gui_Mouse_Down_Texture_ID : 91);
                                   gui_Enabled                : True;
                                   gui_Visible                : False
                                   {$ENDREGION}
              );
    FCreateChar_Edit_Char_Name       : ({$REGION ' - FCreateChar_Edit_Char_Name       '}
                                     gui_Unique_Control_Number  : GUI_ID_CREATECHAR_EDIT_CHAR_NAME;
                                     gui_Type                   : ctEdit;
                                     gui_Form_Type              : ftNone;
                                     gui_WorkField              : (Left:0; Top:0; Right:100; Bottom:16);
                                     gui_Top                    : 524;
                                     gui_Left                   : 355;
                                     gui_Height                 : 16;
                                     gui_Width                  : 100;
                                     gui_Blend_Size             : 240;
                                     gui_Font                   : (gui_Font_Use_ID      : 13;
                                                                   gui_Font_Size        : 16;
                                                                   gui_Font_Color       : $FFF0F0F0;
                                                                   gui_Font_Text_VAlign : avCenter);
                                     gui_Password_Char          : '';
                                     gui_Edit_Max_Length        : 14;
                                     gui_Edit_Using_ASCII       : [#8..#9, #13, #46, 'a'..'z','A'..'Z', '0'..'9'];
                                     gui_Color                  : (gui_ControlColor : $FF312C27;
                                                                   gui_BorderColor  : $FF946D45);
                                     gui_ShowBorder             : True;
                                     gui_ShowPanel              : True;
                                     gui_Enabled                : True;
                                     gui_Visible                : True                                   
                                     {$ENDREGION}
              );
    ///////////////////////////         
          (* 1024x768 *) 
    ///////////////////////////               
    {$ENDREGION}

  );
  
implementation
  
end.