(******************************************************************************
 *   LomCN Mir3 LMT Texture Manager 2013                                      *
 *                                                                            *
 *   Web       : http://www.lomcn.org                                         *
 *   Version   : 0.0.0.1                                                      *
 *                                                                            *
 *   - File Info -                                                            *
 *                                                                            *
 *   It holds the converter / Importer main information                       *
 *                                                                            *
 ******************************************************************************
 * Change History                                                             *
 *                                                                            *
 *  - 0.0.0.1 [2013-04-21] Coly : first init                                  *
 *                                                                            *
 *                                                                            *
 *                                                                            *
 ******************************************************************************
 *  - TODO List for this *.pas file -                                         *
 *----------------------------------------------------------------------------*
 *  if a todo finished, then delete it here...                                *
 *  if you find a global TODO thats need to do, then add it here..            *
 *----------------------------------------------------------------------------*
 *                                                                            *
 *  - TODO : -all -fill *.pas header information                              *
 *                 (how to need this file etc.)                               *
 *  - TODO : -Coly -Full CleanUp (CleanUp and Optimization needed)            *
 *                                                                            *
 ******************************************************************************)
unit mir3_lmt_import_wil;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RzButton, StdCtrls, RzLabel, RzPrgres, ExtCtrls, RzPanel, mir3_lmt_format,
  Mask, RzEdit, RzBckgnd, RzCmboBx, PsAPI;

type
  TfrmImportWIL = class(TForm)
    plInfoBackground: TRzPanel;
    RzPanel1: TRzPanel;
    pbLibraryParts: TRzProgressBar;
    laLibraryName: TRzLabel;
    odImportLibWil: TOpenDialog;
    RzLabel2: TRzLabel;
    pbImageParts: TRzProgressBar;
    btnCancelClose: TRzBitBtn;
    btnImport: TRzBitBtn;
    cbCompressLevel: TRzComboBox;
    RzLabel1: TRzLabel;
    RzSeparator1: TRzSeparator;
    RzSeparator2: TRzSeparator;
    RzLabel3: TRzLabel;
    meLibProtection: TRzMaskEdit;
    laMemoryUsage: TRzLabel;
    RzSeparator3: TRzSeparator;
    procedure btnImportClick(Sender: TObject);
    procedure btnCancelCloseClick(Sender: TObject);
    procedure meLibProtectionKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  frmImportWIL: TfrmImportWIL;

implementation

{$R *.dfm}

uses mir3_lmt_main;

function CurrentMemoryUsage: Cardinal;
var
  pmc: TProcessMemoryCounters;
begin
  pmc.cb := SizeOf(pmc) ;
  if GetProcessMemoryInfo(GetCurrentProcess, @pmc, SizeOf(pmc)) then
    Result := pmc.WorkingSetSize
  else RaiseLastOSError;
end;

procedure TrimAppMemorySize;
var
  MainHandle : THandle;
begin
  try
    MainHandle := OpenProcess(PROCESS_ALL_ACCESS, false, GetCurrentProcessID) ;
    SetProcessWorkingSetSize(MainHandle, $FFFFFFFF, $FFFFFFFF) ;
    CloseHandle(MainHandle) ;
  except
  end;
  Application.ProcessMessages;
end;

procedure TfrmImportWIL.btnCancelCloseClick(Sender: TObject);
begin
  TrimAppMemorySize;
  Close;
end;

procedure TfrmImportWIL.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrmImportWIL.meLibProtectionKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  Mgs: TMsg;
begin
  if not (Char(Key) in [#8, #13, #46, #48..#57,#96..#105]) then
    PeekMessage(Mgs, 0, WM_CHAR, WM_CHAR, PM_REMOVE);
end;

procedure TfrmImportWIL.btnImportClick(Sender: TObject);
var
  I, I1       : Integer;
  FImageIndex : Integer;
  FFileName   : String;
begin
  with fmtTextureManagerMain do
  begin
    if Assigned(FLMTLibrary) then  FreeAndNil(FLMTLibrary);
    FLMTLibrary := TMIR3_LMTFile.Create;
    if odImportLibWil.Execute then
    begin
      cbCompressLevel.Enabled := False;
      meLibProtection.Enabled := False;
      btnImport.Enabled       := False;
      btnCancelClose.Enabled  := False;

      pbLibraryParts.TotalParts    := odImportLibWil.Files.Count-1;
      pbLibraryParts.PartsComplete := 0;
      Application.ProcessMessages;
      for I := 0 to odImportLibWil.Files.Count - 1 do
      begin
        laLibraryName.Caption := ExtractFileName(odImportLibWil.Files[I]) + ' - Images in File : ' + IntToStr(FLMTLibrary.GetTotalImageWIL);
        FLMTLibrary.OpenWIL(odImportLibWil.Files[I]);
        FImageIndex := FLMTLibrary.GetTotalIndexWIL;
        FFileName   := odImportLibWil.Files[I];
        FFileName   := Copy(FFileName,0,Length(FFileName)-4);
        pbImageParts.TotalParts    := FImageIndex;
        pbImageParts.PartsComplete := 0;
        FLMTLibrary.CreateLMTFile(FFileName, FImageIndex);
        laMemoryUsage.Caption := FormatFloat('Memory used : ,.# K', CurrentMemoryUsage / 1024);
        Application.ProcessMessages;
        for I1 := 0 to FImageIndex-1 do
        begin
          FLMTLibrary.AddFilePNG('', I1, StrToIntDef(meLibProtection.Text, 0), StrToIntDef(cbCompressLevel.Text, 5));
          laMemoryUsage.Caption := FormatFloat('Memory used : ,.# K', CurrentMemoryUsage / 1024);
          Application.ProcessMessages;
          pbImageParts.IncPartsByOne;
        end;
        FLMTLibrary.SaveLMTFile(FFileName);
        FLMTLibrary.CloseWIL;
        FLMTLibrary.Close;
        pbLibraryParts.IncPartsByOne;
      end;

      pbLibraryParts.TotalParts    := 0;
      pbImageParts.TotalParts      := 0;
      pbImageParts.PartsComplete   := 0;
      pbLibraryParts.PartsComplete := 0;
      cbCompressLevel.Enabled      := True;
      meLibProtection.Enabled      := True;
      btnImport.Enabled            := True;
      btnCancelClose.Enabled       := True;
      laMemoryUsage.Caption := FormatFloat('Memory used : ,.# K', CurrentMemoryUsage / 1024);
      Application.ProcessMessages;
    end;
  end;
  laLibraryName.Caption := 'Finish Import..';
end;

end.
