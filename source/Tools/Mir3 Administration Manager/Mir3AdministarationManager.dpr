program Mir3AdministarationManager;

uses
  Forms,
  mir3_admin_main in 'mir3_admin_main.pas' {frmAdminManager};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmAdminManager, frmAdminManager);
  Application.Run;
end.
