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

unit mir3_game_gui_definition_logon_info;

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
  (* Logon Info Control IDs *)
  {$REGION ' - Logon Info Control IDs                  '}
  (*0..99 only for System Controls*)
  GUI_ID_LOGON_BACKGROUND                         =  100;
  GUI_ID_LOGON_PANEL_INFO                         =  101;
  GUI_ID_LOGON_TIMER                              =  102;
  {$ENDREGION}
  
type
  TMir3_GUI_Definition_LogonInfo = record
    {$REGION ' - Logon Info Dialog                            '}
    (* LogonInfo Scene *)
    ///////////////////////////         
          (* 800x600 *) 
    ///////////////////////////
    FLogonInfo_Background_800       : TMir3_GUI_Ground_Info;  //basic Dialog Info Window
      FLogon_Information_Field_800  : TMir3_GUI_Ground_Info;  //used for Text Information
    ///////////////////////////     
            (* 1024 *) 
    ///////////////////////////
    FLogonInfo_Background_1024      : TMir3_GUI_Ground_Info;  //basic Dialog Info Window
      FLogon_Information_Field_1024 : TMir3_GUI_Ground_Info;  //used for Text Information
    ///////////////////////////     
       (* Timer Support *) 
    ///////////////////////////
      FLogon_Info_Timer             : TMir3_GUI_Ground_Info;  // Wait Timer (Auto move to login scene)
    {$ENDREGION}
  end;
  
var
  ////////////////////////////////////////////////////////////////////////////////
  // Game Logon Info Control Definition
  //..............................................................................
  FGame_GUI_Definition_LogonInfo : TMir3_GUI_Definition_LogonInfo   =(

    {$REGION ' - Logon Info Scene      '}
    ///////////////////////////         
          (* 800x600 *) 
    ///////////////////////////     
    FLogonInfo_Background_800        : ({$REGION ' - FLogonInfo_Background_800             '}
                                     gui_Unique_Control_Number  : GUI_ID_LOGON_BACKGROUND;
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
                                                                   gui_Background_Texture_ID : 4);
                                     gui_Use_Strech_Texture     : True;
                                     gui_Enabled                : True;
                                     gui_Visible                : True 
                                     {$ENDREGION}
              );
    FLogon_Information_Field_800     : ({$REGION ' - FLogon_Information_Field_800          '}
                                     gui_Unique_Control_Number  : GUI_ID_LOGON_PANEL_INFO;
                                     gui_Type                   : ctPanel;
                                     gui_Form_Type              : ftNone;
                                     gui_Top                    : 100;
                                     gui_Left                   : 40;
                                     gui_Height                 : 245;
                                     gui_Width                  : 780;
                                     gui_Blend_Size             : 255;
                                     gui_Font                   : (gui_Font_Size        : 21;
                                                                   gui_Font_Color       : $FFF2F2F2;
                                                                   gui_Font_Text_HAlign : alCenter;
                                                                   gui_Font_Text_VAlign : avTop;
                                                                   gui_Font_Setting     : [fsBold]);
                                     gui_Enabled                : True;
                                     gui_Visible                : True                                   
                                     {$ENDREGION}
              );
    ///////////////////////////         
            (* 1024 *) 
    /////////////////////////// 
    FLogonInfo_Background_1024       : ({$REGION ' - FLogonInfo_Background_1024            '}
                                     gui_Unique_Control_Number  : GUI_ID_LOGON_BACKGROUND;
                                     gui_Type                   : ctForm;
                                     gui_Form_Type              : ftBackground;
                                     gui_WorkField              : (Left:0; Top:0; Right:1024; Bottom:768);
                                     gui_Top                    : 0;
                                     gui_Left                   : 0;
                                     gui_Height                 : 768;
                                     gui_Width                  : 1024;
                                     gui_Blend_Size             : 255;
                                     gui_Control_Texture        : (gui_Texture_File_ID       : GAME_TEXTURE_INTERFACE1C_INT;
                                                                   gui_Background_Texture_ID : 4);
                                     gui_Enabled                : True;
                                     gui_Visible                : True 
                                     {$ENDREGION}
              );
    FLogon_Information_Field_1024    : ({$REGION ' - FLogon_Information_Field_1024         '}
                                     gui_Unique_Control_Number  : GUI_ID_LOGON_PANEL_INFO;
                                     gui_Type                   : ctPanel;
                                     gui_Form_Type              : ftNone;
                                     gui_Top                    : 375;
                                     gui_Left                   : 120;
                                     gui_Height                 : 245;
                                     gui_Width                  : 780;
                                     gui_Blend_Size             : 255;
                                     gui_Font                   : (gui_Font_Size        : 21;
                                                                   gui_Font_Color       : $FFF2F2F2;
                                                                   gui_Font_Text_HAlign : alCenter;
                                                                   gui_Font_Text_VAlign : avTop;
                                                                   gui_Font_Setting     : [fsBold]);
                                     gui_Enabled                : True;
                                     gui_Visible                : True                                   
                                     {$ENDREGION}
              );
    ///////////////////////////         
           (* Timer *) 
    ///////////////////////////
    FLogon_Info_Timer                : ({$REGION ' - FLogon_Info_Timer                     '}
                                     gui_Unique_Control_Number  : GUI_ID_LOGON_TIMER;
                                     gui_Type                   : ctTimer;
                                     gui_Form_Type              : ftNone;
                                     gui_Top                    : 0;
                                     gui_Left                   : 0;
                                     gui_Height                 : 1;
                                     gui_Width                  : 1;
                                     gui_Timer_Intervall        : 1000;//5000;
                                     gui_Enabled                : True;
                                     gui_Visible                : True                                   
                                     {$ENDREGION}
              );
    {$ENDREGION}
  );    
  
  
implementation
  
end.