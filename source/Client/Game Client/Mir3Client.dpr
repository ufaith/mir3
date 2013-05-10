program Mir3Client;

uses
  Windows,
  SysUtils,
  mir3_misc_utils in 'GameCommon\mir3_misc_utils.pas',
  mir3_core_controls in 'GameControls\mir3_core_controls.pas',
  mir3_game_gui_definition_system in 'GameControls\mir3_game_gui_definition_system.pas',
  mir3_game_backend in 'GameEngine\mir3_game_backend.pas',
  mir3_game_engine in 'GameEngine\mir3_game_engine.pas',
  mir3_game_engine_def in 'GameEngine\mir3_game_engine_def.pas',
  mir3_game_file_manager in 'GameEngine\mir3_game_file_manager.pas',
  mir3_game_file_manager_const in 'GameEngine\mir3_game_file_manager_const.pas',
  mir3_game_actor in 'GameInternal\mir3_game_actor.pas',
  mir3_game_actor_action in 'GameInternal\mir3_game_actor_action.pas',
  mir3_game_language_engine in 'GameInternal\mir3_game_language_engine.pas',
  mir3_game_scene_ingame in 'GameScene\mir3_game_scene_ingame.pas',
  mir3_game_font_engine in 'GameEngine\mir3_game_font_engine.pas',
  mir3_game_socket in '..\..\Common\mir3_game_socket.pas',
  mir3_game_en_decode in '..\..\Common\mir3_game_en_decode.pas',
  mir3_global_config in '..\..\Common\mir3_global_config.pas',
  mir3_game_map_framework in 'GameInternal\mir3_game_map_framework.pas',
  mir3_misc_ingame in 'GameCommon\mir3_misc_ingame.pas',
  mir3_game_scene_logon_info in 'GameScene\mir3_game_scene_logon_info.pas',
  mir3_game_sound_engine in 'GameEngine\mir3_game_sound_engine.pas',
  mir3_game_gui_definition_end_game in 'GameControls\mir3_game_gui_definition_end_game.pas',
  mir3_game_gui_definition_in_game in 'GameControls\mir3_game_gui_definition_in_game.pas',
  mir3_game_gui_definition_login in 'GameControls\mir3_game_gui_definition_login.pas',
  mir3_game_gui_definition_logon_info in 'GameControls\mir3_game_gui_definition_logon_info.pas',
  mir3_game_gui_definition_select_create_char in 'GameControls\mir3_game_gui_definition_select_create_char.pas',
  mir3_game_gui_definition_select_server in 'GameControls\mir3_game_gui_definition_select_server.pas',
  mir3_game_scene_select_server in 'GameScene\mir3_game_scene_select_server.pas',
  mir3_game_scene_end_game in 'GameScene\mir3_game_scene_end_game.pas',
  mir3_game_scene_login in 'GameScene\mir3_game_scene_login.pas',
  mir3_game_scene_select_create_char in 'GameScene\mir3_game_scene_select_create_char.pas';

{$R Mir3Client.res}

begin
  ReportMemoryLeaksOnShutdown    := True;
  NeverSleepOnMMThreadContention := True;

  { Test if start from launcher, Hier noch eine Prüfung ob Launcher Process da ist. }
// Check if the launcher process running or not...
//  if ParamStr(1) <> 'launcher' then
//    Exit;

  if GGameEngine.CreateGameClient then
  begin
	  GRenderEngine.System_SetConstantFrameTime(True);
    GSystemActive := True;
    GRenderEngine.System_Loop;
	  { Finish Game }
    GGameEngineFree;
    GRenderEngine.System_Shutdown;
  end;
end.
