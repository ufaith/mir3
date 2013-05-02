unit mir3_launcher_main;

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
  StdCtrls,
  ExtCtrls,
  { Raize }
  RzCmboBx,
  RzButton,
  RzTabs,
  RzStatus,
  RzRadChk;

type
  PMir3_GameClientSetting = ^TMir3_GameClientSetting;
  TMir3_GameClientSetting = record
    { Server Part }
    FServer_1_Name : String[30];
    FServer_1_IP   : String[15];
    FServer_1_Port : Integer;
    FServer_2_Name : String[30];
    FServer_2_IP   : String[15];
    FServer_2_Port : Integer;
    { Client Part }
    FFull_Screen   : Boolean;
    FUseStartVideo : Boolean;
    FVideoVolume   : Integer;
    FLanguageId    : Integer;
  end;

  { TfrmLauncherMain }
  TfrmLauncherMain = class(TForm)
    Panel1: TPanel;
    RzPageControl1: TRzPageControl;
    laVerInfo: TRzVersionInfoStatus;
    verInfo: TRzVersionInfo;
    TabSheet1: TRzTabSheet;
    TabSheet2: TRzTabSheet;
    TabSheet3: TRzTabSheet;
    TabSheet4: TRzTabSheet;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    btnStartGame: TRzBitBtn;
    btnAccountManager: TRzBitBtn;
    btnExitGame: TRzBitBtn;
    btnGameOptions: TRzBitBtn;
    RzComboBox1: TRzComboBox;
    RzCheckBox1: TRzCheckBox;
    RzCheckBox2: TRzCheckBox;
    procedure btnExitGameClick(Sender: TObject);
    procedure btnStartGameClick(Sender: TObject);
  private
    { Private - Declarations }
  public
    { Public - Declarations }
  end;

var
  frmLauncherMain: TfrmLauncherMain;

implementation

{$R *.dfm}

procedure TfrmLauncherMain.btnExitGameClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmLauncherMain.btnStartGameClick(Sender: TObject);
begin
  { Start Game }
end;

end.
