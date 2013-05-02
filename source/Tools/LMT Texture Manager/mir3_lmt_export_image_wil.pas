unit mir3_lmt_export_image_wil;

interface

uses
  { Delphi }
  Windows,
  Messages,
  SysUtils,
  Variants,
  Classes,
  Graphics,
  Controls,
  Forms,
  Dialogs,
  ExtCtrls,
  { Raize }
  RzButton,
  RzRadChk,
  RzPanel,
  RzRadGrp;

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
    { Private - Declarations }
  public
    { Public - Declarations }
  end;

var
  fmtExportImageWil: TfmtExportImageWil;

implementation

{$R *.dfm}

end.
