program Mir3Launcher;

uses
  Forms,
  mir3_launcher_main in 'mir3_launcher_main.pas' {frmLauncherMain},
  mir3_launcher_language in 'mir3_launcher_language.pas',
  mir3_game_en_decode in '..\..\Common\mir3_game_en_decode.pas',
  mir3_global_config in '..\..\Common\mir3_global_config.pas',
  mir3_game_socket in '..\..\Common\mir3_game_socket.pas',
  mir3_game_config_definition in '..\..\Common\mir3_game_config_definition.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'LomCN Game Launcher';
  Application.CreateForm(TfrmLauncherMain, frmLauncherMain);
  Application.Run;
end.
