program LMTTextureManager;

uses
  Forms,
  mir3_lmt_main in 'mir3_lmt_main.pas' {fmtTextureManagerMain},
  mir3_lmt_format in 'mir3_lmt_format.pas',
  mir3_misc_utils in '..\..\Client\Game Client\GameCommon\mir3_misc_utils.pas',
  mir3_lmt_new_library in 'mir3_lmt_new_library.pas' {frmNewLibrary},
  mir3_lmt_import_wil in 'mir3_lmt_import_wil.pas' {frmImportWIL},
  mir3_lmt_export_image_wil in 'mir3_lmt_export_image_wil.pas' {fmtExportImageWil};

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := True;
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfmtTextureManagerMain, fmtTextureManagerMain);
  Application.CreateForm(TfrmNewLibrary, frmNewLibrary);
  Application.CreateForm(TfrmImportWIL, frmImportWIL);
  Application.CreateForm(TfmtExportImageWil, fmtExportImageWil);
  Application.Run;
end.
