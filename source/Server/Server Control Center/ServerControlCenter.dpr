program ServerControlCenter;

uses
  Forms,
  unMain in 'unMain.pas' {frmControlCenter},
  mir3_global_config in '..\..\Common\mir3_global_config.pas',
  mir3_server_global in '..\..\Common\mir3_server_global.pas',
  mir3_game_socket in '..\..\Common\mir3_game_socket.pas',
  unConfigEngine in 'unConfigEngine.pas';

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown    := True;
  NeverSleepOnMMThreadContention := True;

  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'LomCN Control Center';
  Application.CreateForm(TfrmControlCenter, frmControlCenter);
  Application.Run;
end.
