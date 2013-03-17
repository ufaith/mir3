program LoginGate;

uses
  Forms,
  unLoginMain in 'unLoginMain.pas' {frmLoginGate},
  mir3_server_global in '..\..\..\Common\mir3_server_global.pas',
  mir3_global_config in '..\..\..\Common\mir3_global_config.pas',
  unConfigEngine in 'unConfigEngine.pas',
  unGateConfig in 'unGateConfig.pas' {frmGateConfig};

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown    := True;
  NeverSleepOnMMThreadContention := True;

  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'Login Gate';
  Application.CreateForm(TfrmLoginGate, frmLoginGate);
  Application.CreateForm(TfrmGateConfig, frmGateConfig);
  Application.Run;
end.
