(******************************************************************************
 *   LomCN Mir3 LMT Texture Manager 2013                                      *
 *                                                                            *
 *   Web       : http://www.lomcn.org                                         *
 *   Version   : 0.0.0.1                                                      *
 *                                                                            *
 *   - File Info -                                                            *
 *                                                                            *
 *   It holds the new library form information                                *
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
 *                                                                            *
 ******************************************************************************)
unit mir3_lmt_new_library;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, RzLabel, Mask, RzEdit, RzButton, ExtCtrls, RzPanel;

type
  TfrmNewLibrary = class(TForm)
    plBackground: TRzPanel;
    btnOK: TRzBitBtn;
    btnCancel: TRzBitBtn;
    meNewFileName: TRzMaskEdit;
    laInfoText: TRzLabel;
    plInfoBackground: TRzPanel;
    procedure btnOKClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  frmNewLibrary: TfrmNewLibrary;

implementation

{$R *.dfm}

uses mir3_lmt_main;

procedure TfrmNewLibrary.btnCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmNewLibrary.btnOKClick(Sender: TObject);
begin
  fmtTextureManagerMain.FNewFileName := Trim(meNewFileName.Text);
  Close;
end;

procedure TfrmNewLibrary.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrmNewLibrary.FormShow(Sender: TObject);
begin
  meNewFileName.Text := '';
end;

end.
