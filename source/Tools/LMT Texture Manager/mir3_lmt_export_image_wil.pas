unit mir3_lmt_export_image_wil;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RzButton, RzRadChk, RzPanel, RzRadGrp, ExtCtrls;

type
  TfmtExportImageWil = class(TForm)
    plInfoBackground: TRzPanel;
    RzPanel1: TRzPanel;
    RzRadioGroup1: TRzRadioGroup;
    RzRadioButton1: TRzRadioButton;
    RzRadioButton2: TRzRadioButton;
    RzRadioButton3: TRzRadioButton;
    RzRadioButton4: TRzRadioButton;
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  fmtExportImageWil: TfmtExportImageWil;

implementation

{$R *.dfm}

end.
