program Mir3MusicListEditor;

uses
  Forms,
  unMain in 'unMain.pas' {frmEditorMain};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'LomCN Music List Editor';
  Application.CreateForm(TfrmEditorMain, frmEditorMain);
  Application.Run;
end.
