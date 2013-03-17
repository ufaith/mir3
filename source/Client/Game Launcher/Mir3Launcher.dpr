program Mir3Launcher;

uses
  Forms,
  mir3_launcher_main in 'mir3_launcher_main.pas' {frmLauncherMain},
  mir3_launcher_language in 'mir3_launcher_language.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'LomCN Game Launcher';
  Application.CreateForm(TfrmLauncherMain, frmLauncherMain);
  Application.Run;
end.
