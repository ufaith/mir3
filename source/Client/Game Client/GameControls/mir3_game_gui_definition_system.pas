(*****************************************************************************************
 *   LomCN Mir3 GUI Definition control File 2012                                         *
 *                                                                                       *
 *   Web       : http://www.lomcn.org                                                    *
 *   Version   : 0.0.0.10                                                                *
 *                                                                                       *
 *   - File Info -                                                                       *
 *                                                                                       *
 *   Hold all GUI Definitions                                                            *
 *                                                                                       *
 *****************************************************************************************
 * Change History                                                                        *
 *                                                                                       *
 *  - 0.0.0.1  [2012-10-08] Coly : fist init                                             *
 *  - 0.0.0.2  [2013-02-27] Coly : change the Control Config                             *
 *  - 0.0.0.3  [2013-03-02] Coly : add more GUI Definitions                              *
 *  - 0.0.0.4  [2013-03-04] Coly : add more GUI Definitions                              *
 *  - 0.0.0.5  [2013-03-07] Coly : add Edit Option Fiels                                 *
 *  - 0.0.0.6  [2013-03-12] Coly : add Exit Win and other                                *
 *  - 0.0.0.7  [2013-03-14] Coly : add Body Window                                       *
 *  - 0.0.0.8  [2013-03-24] Coly : add Group Window                                      *  
 *  - 0.0.0.9  [2013-03-25] Coly : add Magic Window                                      * 
 *  - 0.0.0.10 [2013-03-25] Coly : rework select char scene                              *  
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

unit mir3_game_gui_definition_system;

interface

uses
  { Delphi }
  Windows,
  Classes,
  SysUtils,
  { DirectX }
  Direct3D9,
  D3DX9,
  { Mir3 Game }
  mir3_core_controls,
  mir3_global_config,
  mir3_game_file_manager_const,
  mir3_game_font_engine,
  mir3_game_engine;

const
  //Unique Control Numbers

  (* System Info Control IDs *)
  {$REGION ' - System Dialog  Global Use (10-49) '}
  GUI_ID_SYSINFO_DIALOG                           = 10;   // Base Info Window
  GUI_ID_SYSINFO_PANEL                            = 11;   // Static Text Field
  GUI_ID_SYSINFO_EDIT_FIELD                       = 12;   // For Input like PW on Char Deletion
  GUI_ID_SYSINFO_BUTTON_OK                        = 13;   // OK Button
  GUI_ID_SYSINFO_BUTTON_YES                       = 14;   // Yes Button
  GUI_ID_SYSINFO_BUTTON_NO                        = 15;   // No Button
  GUI_ID_SYSINFO_BUTTON_FREE_CENTER               = 16;   // Free Center Buttons
  GUI_ID_SYSINFO_BUTTON_FREE_LEFT                 = 17;   // Free Left Buttons
  GUI_ID_SYSINFO_BUTTON_FREE_RIGHT                = 18;   // Free Right Buttons
  {$ENDREGION}

type
  TMir3_GUI_Definition_System    = record
    (* System Info Dialoge *)
    {$REGION ' - System Dialog                                 '}
    FSys_Dialog_Info                     : TMir3_GUI_Ground_Info;  //basic Dialog Info Window
      FSys_Dialog_Text                   : TMir3_GUI_Ground_Info;  //Static Text field
      FSys_Dialog_Edit_Field             : TMir3_GUI_Ground_Info;  //Edit Field for some things 
      FSys_Button_Ok                     : TMir3_GUI_Ground_Info;  //Dialog OK Button
      FSys_Button_Yes                    : TMir3_GUI_Ground_Info;  //Dialog Yes Button
      FSys_Button_No                     : TMir3_GUI_Ground_Info;  //Dialog No Button
      FSys_Button_Free_Center            : TMir3_GUI_Ground_Info;  //Dialog Free Center Button
      FSys_Button_Free_Left              : TMir3_GUI_Ground_Info;  //Dialog Free Left Button
      FSys_Button_Free_Right             : TMir3_GUI_Ground_Info;  //Dialog Free Right Button
    {$ENDREGION}
  end;


(* Definition *)
var
  ////////////////////////////////////////////////////////////////////////////////
  // Global System Controls (used by all Scenes)
  //..............................................................................
  FGame_GUI_Definition_System  : TMir3_GUI_Definition_System  =(

    {$REGION ' - System Info Controls   '}
    ///////////////////////////         
          (* 800x600 *) 
    ///////////////////////////     
    FSys_Dialog_Info                 : ({$REGION ' - FSys_Dialog_Info                 '}
                                     //gui_DragMode               : Boolean;              
                                     gui_Unique_Control_Number  : GUI_ID_SYSINFO_DIALOG;
                                     gui_Type                   : ctForm;       
                                     gui_Form_Type              : ftMoving;
                                     gui_WorkField              : (Left:0; Top:0; Right:306; Bottom:226);
                                     gui_Top                    : 105;
                                     gui_Left                   : 246;
                                     gui_Height                 : 226;
                                     gui_Width                  : 308;
                                     gui_Blend_Size             : 245;
                                     gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_GAMEINTER_INT;
                                                                   gui_Background_Texture_ID : 421);
                                     gui_Modal_Event            : True;
                                     gui_Enabled                : True;
                                     gui_Visible                : True
                                     {$ENDREGION}
              );
    FSys_Dialog_Text                 : ({$REGION ' - FSys_Dialog_Text                 '}
                                     //gui_DragMode               : Boolean;              
                                     gui_Unique_Control_Number  : GUI_ID_SYSINFO_PANEL;
                                     gui_Type                   : ctPanel;       
                                     gui_Form_Type              : ftNone;               
                                     gui_Top                    : 27;
                                     gui_Left                   : 22;
                                     gui_Height                 : 108;
                                     gui_Width                  : 263;
                                     gui_Blend_Size             : 255;
                                     gui_Font                   : (gui_Font_Size        : 16;
                                                                   gui_Font_Color       : $FFF2F2F2;
                                                                   gui_Font_Use_Kerning : False;
                                                                   gui_Font_Text_HAlign : alCenter;
                                                                   gui_Font_Text_VAlign : avCenter);
                                     gui_Enabled                : True;
                                     gui_Visible                : True
                                     {$ENDREGION}
              );
    FSys_Dialog_Edit_Field           : ({$REGION ' - FSys_Dialog_Edit_Field           '}
                                     gui_Unique_Control_Number  : GUI_ID_SYSINFO_EDIT_FIELD;
                                     gui_Type                   : ctEdit;
                                     gui_Form_Type              : ftNone;
                                     gui_WorkField              : (Left:2; Top:0; Right:262; Bottom:21);
                                     gui_Top                    : 177;
                                     gui_Left                   : 22;
                                     gui_Height                 : 21;
                                     gui_Width                  : 264;
                                     gui_Blend_Size             : 245;
                                     gui_Font                   : (gui_Font_Use_ID      : 15;
                                                                   gui_Font_Size        : 21;
                                                                   gui_Font_Color       : $FFF0F0F0;
                                                                   gui_Font_Use_Kerning : False;
                                                                   gui_Font_Text_VAlign : avCenter);
                                     gui_Password_Char          : '*';
                                     gui_Edit_Max_Length        : 25;
                                     gui_Edit_Using_ASCII       : [#8..#9, #13, #46, 'a'..'z','A'..'Z', '0'..'9'];
                                     gui_Color                  : (gui_ControlColor : $F5050505;
                                                                   gui_BorderColor  : $FF717171);
                                     gui_ShowPanel              : True;
                                     gui_Enabled                : True;
                                     gui_Visible                : True                                   
                                     {$ENDREGION}
              );
    FSys_Button_Ok                   : ({$REGION ' - FSys_Button_Ok                   '}
                                     gui_Unique_Control_Number  : GUI_ID_SYSINFO_BUTTON_OK;
                                     gui_Type                   : ctButton;
                                     gui_Form_Type              : ftNone;
                                     gui_WorkField              : (Left:0; Top:0; Right:80; Bottom:26);
                                     gui_Top                    : 145;
                                     gui_Left                   : 113;
                                     gui_Height                 : 26;
                                     gui_Width                  : 80;
                                     gui_Blend_Size             : 255;
                                     gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_GAMEINTER_INT;
                                                                   gui_Background_Texture_ID : 424;
                                                                   gui_Mouse_Over_Texture_ID : 424;
                                                                   gui_Mouse_Down_Texture_ID : 425);
                                     gui_Enabled                : True;
                                     gui_Visible                : True 
                                     {$ENDREGION}
              );
    FSys_Button_Yes                  : ({$REGION ' - FSys_Button_Yes                  '}
                                     gui_Unique_Control_Number  : GUI_ID_SYSINFO_BUTTON_YES;
                                     gui_Type                   : ctButton;
                                     gui_Form_Type              : ftNone;
                                     gui_WorkField              : (Left:0; Top:0; Right:80; Bottom:26);
                                     gui_Top                    : 145;
                                     gui_Left                   : 47;
                                     gui_Height                 : 26;
                                     gui_Width                  : 80;
                                     gui_Blend_Size             : 255;
                                     gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_GAMEINTER_INT;
                                                                   gui_Background_Texture_ID : 422;
                                                                   gui_Mouse_Over_Texture_ID : 422;
                                                                   gui_Mouse_Down_Texture_ID : 423);
                                     gui_Enabled                : True;
                                     gui_Visible                : True 
                                     {$ENDREGION}
              );
    FSys_Button_No                   : ({$REGION ' - FSys_Button_No                   '}
                                     gui_Unique_Control_Number  : GUI_ID_SYSINFO_BUTTON_NO;
                                     gui_Type                   : ctButton;
                                     gui_Form_Type              : ftNone;
                                     gui_WorkField              : (Left:0; Top:0; Right:80; Bottom:26);
                                     gui_Top                    : 145;
                                     gui_Left                   : 180;
                                     gui_Height                 : 26;
                                     gui_Width                  : 80;
                                     gui_Blend_Size             : 255;
                                     gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_GAMEINTER_INT;
                                                                   gui_Background_Texture_ID : 426;
                                                                   gui_Mouse_Over_Texture_ID : 426;
                                                                   gui_Mouse_Down_Texture_ID : 427);
                                     gui_Enabled                : True;
                                     gui_Visible                : True 
                                     {$ENDREGION}
              );
    FSys_Button_Free_Center          : ({$REGION ' - FSys_Button_Free_Center          '}
                                     gui_Unique_Control_Number  : GUI_ID_SYSINFO_BUTTON_FREE_CENTER;
                                     gui_Type                   : ctButton;
                                     gui_Form_Type              : ftNone;
                                     gui_WorkField              : (Left:0; Top:0; Right:80; Bottom:26);
                                     gui_Top                    : 145;
                                     gui_Left                   : 113;
                                     gui_Height                 : 26;
                                     gui_Width                  : 80;
                                     gui_Blend_Size             : 255;
                                     gui_Font                   : (gui_Font_Size        : 18;
                                                                   gui_Font_Color       : $FFF0F0F0;
                                                                   gui_Font_Use_Kerning : False;
                                                                   gui_Font_Text_HAlign : alCenter;
                                                                   gui_Font_Text_VAlign : avCenter);
                                     gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_GAMEINTER_INT;
                                                                   gui_Background_Texture_ID : 3612;
                                                                   gui_Mouse_Over_Texture_ID : 3612;
                                                                   gui_Mouse_Down_Texture_ID : 3613);
                                     gui_Btn_Font_Color         : (gui_ColorSelect      : $FFFFFFFF;
                                                                   gui_ColorPress       : $FFA0A0A0;
                                                                   gui_ColorDisabled    : $FF808080);
                                     gui_Enabled                : True;
                                     gui_Visible                : False 
                                     {$ENDREGION}
              );
    FSys_Button_Free_Left            : ({$REGION ' - FSys_Button_Free_Left            '}
                                     gui_Unique_Control_Number  : GUI_ID_SYSINFO_BUTTON_FREE_LEFT;
                                     gui_Type                   : ctButton;
                                     gui_Form_Type              : ftNone;
                                     gui_WorkField              : (Left:0; Top:0; Right:80; Bottom:26);
                                     gui_Top                    : 145;
                                     gui_Left                   : 47;
                                     gui_Height                 : 26;
                                     gui_Width                  : 80;
                                     gui_Blend_Size             : 255;
                                     gui_Font                   : (gui_Font_Size        : 18;
                                                                   gui_Font_Color       : $FFF0F0F0;
                                                                   gui_Font_Use_Kerning : False;
                                                                   gui_Font_Text_HAlign : alCenter;
                                                                   gui_Font_Text_VAlign : avCenter);
                                     gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_GAMEINTER_INT;
                                                                   gui_Background_Texture_ID : 3612;
                                                                   gui_Mouse_Over_Texture_ID : 3612;
                                                                   gui_Mouse_Down_Texture_ID : 3613);
                                     gui_Btn_Font_Color         : (gui_ColorSelect      : $FFFFFFFF;
                                                                   gui_ColorPress       : $FFA0A0A0;
                                                                   gui_ColorDisabled    : $FF808080);
                                     gui_Enabled                : True;
                                     gui_Visible                : False 
                                     {$ENDREGION}
              );
    FSys_Button_Free_Right           : ({$REGION ' - FSys_Button_Free_Right           '}
                                     gui_Unique_Control_Number  : GUI_ID_SYSINFO_BUTTON_FREE_RIGHT;
                                     gui_Type                   : ctButton;
                                     gui_Form_Type              : ftNone;
                                     gui_WorkField              : (Left:0; Top:0; Right:80; Bottom:26);
                                     gui_Top                    : 145;
                                     gui_Left                   : 180;
                                     gui_Height                 : 26;
                                     gui_Width                  : 80;
                                     gui_Blend_Size             : 255;
                                     gui_Font                   : (gui_Font_Size        : 18;
                                                                   gui_Font_Color       : $FFF0F0F0;
                                                                   gui_Font_Use_Kerning : False;
                                                                   gui_Font_Text_HAlign : alCenter;
                                                                   gui_Font_Text_VAlign : avCenter);
                                     gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_GAMEINTER_INT;
                                                                   gui_Background_Texture_ID : 3612;
                                                                   gui_Mouse_Over_Texture_ID : 3612;
                                                                   gui_Mouse_Down_Texture_ID : 3613);
                                     gui_Btn_Font_Color         : (gui_ColorSelect      : $FFFFFFFF;
                                                                   gui_ColorPress       : $FFA0A0A0;
                                                                   gui_ColorDisabled    : $FF808080);
                                     gui_Enabled                : True;
                                     gui_Visible                : False 
                                   {$ENDREGION}
              );                
    {$ENDREGION}

  );

  
implementation

end.






