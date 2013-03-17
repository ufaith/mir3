program SelectCharGate;

uses
  Forms,
  unSelectCharMain in 'unSelectCharMain.pas' {frmSelectCharGate},
  mir3_server_global in '..\..\..\Common\mir3_server_global.pas',
  mir3_global_config in '..\..\..\Common\mir3_global_config.pas',
  unGateConfig in 'unGateConfig.pas' {frmGateConfig},
  unConfigEngine in 'unConfigEngine.pas';

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown    := True;
  NeverSleepOnMMThreadContention := True;

  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'Select Character Gate';
  Application.CreateForm(TfrmSelectCharGate, frmSelectCharGate);
  Application.CreateForm(TfrmGateConfig, frmGateConfig);
  Application.Run;
end.
