unit unGateConfig;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, ExtCtrls,
  Dialogs, StdCtrls, ComCtrls, IniFiles, RzTrkBar, Mask, RzEdit, RzPanel;

type
  TfrmGateConfig = class(TForm)
    RzPanel1: TRzPanel;
    Image2: TImage;
    plInfoBackground: TRzPanel;
    RzGroupBox1: TRzGroupBox;
    RzGroupBox2: TRzGroupBox;
    meGateIP: TRzMaskEdit;
    meServerIP: TRzMaskEdit;
    meServerPort: TRzMaskEdit;
    meGatePort: TRzMaskEdit;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    meServerName: TRzMaskEdit;
    Label1: TLabel;
    Label6: TLabel;
    cbMinimizeApp: TCheckBox;
    Button1: TButton;
    ButtonOK: TButton;
    tbLogLevel: TRzTrackBar;
    Label7: TLabel;
    meKeepConTimeOut: TRzMaskEdit;
    Label8: TLabel;
    Label9: TLabel;
    meMaxMessageLen: TRzMaskEdit;
    Label10: TLabel;
    meMaxConIP: TRzMaskEdit;
    laLogLevel: TLabel;
    procedure ButtonOKClick(Sender: TObject);
    procedure cbMinimizeAppClick(Sender: TObject);
    procedure tbLogLevelChange(Sender: TObject);
  end;

var
  frmGateConfig: TfrmGateConfig;

implementation

{$R *.dfm}

uses mir3_server_global;

procedure TfrmGateConfig.ButtonOKClick(Sender: TObject);
var
  FGateIPaddr      : String;
  FServerIPaddr    : String;
  FServerName      : String;
  FMaxMegLen       : Integer;
  FKeepTimeOut     : Integer;
  FGatePort        : Integer;
  FServerPort      : Integer;
  FShowLogLevel    : Integer;
  FMaxConIP        : Integer;
  FMaxMessageLen   : Integer;
  FMaxConnOfIPaddr : Integer;
  FIniConf         : TIniFile;
begin
  FGateIPaddr   := Trim(meGateIP.Text);
  FGatePort     := StrToIntDef(Trim(meGatePort.Text), -1);
  FServerIPaddr := Trim(meServerIP.Text);
  FServerPort   := StrToIntDef(Trim(meServerPort.Text), -1);
  FServerName   := Trim(meServerName.Text);
  FKeepTimeOut  := StrToIntDef(Trim(meKeepConTimeOut.Text), -1);
  FMaxMegLen    := StrToIntDef(Trim(meMaxMessageLen.Text), -1);
  FMaxConIP     := StrToIntDef(Trim(meMaxConIP.Text), -1);
  FShowLogLevel := tbLogLevel.Position;

  if not TestIPAddr(FGateIPaddr) then
  begin
    Application.MessageBox('The Gate IP is not valid', 'Error', MB_OK + MB_ICONERROR);
    meGateIP.SetFocus;
    Exit;
  end;

  if (FGatePort < 0) or (FGatePort > 65535) then
  begin
    Application.MessageBox('The Gate Port is not valid','Error', MB_OK + MB_ICONERROR);
    meGatePort.SetFocus;
    Exit;
  end;

  if not TestIPAddr(FServerIPaddr) then
  begin
    Application.MessageBox('The Server IP is not valid', 'Error', MB_OK + MB_ICONERROR);
    meServerIP.SetFocus;
    Exit;
  end;

  if (FServerPort < 0) or (FServerPort > 65535) then
  begin
    Application.MessageBox('The Server Port is not valid', 'Error', MB_OK + MB_ICONERROR);
    meServerPort.SetFocus;
    Exit;
  end;

  if FServerName = '' then
  begin
    Application.MessageBox('The Server Name is not valid', 'Error', MB_OK + MB_ICONERROR);
    meServerName.SetFocus;
    Exit;
  end;

  if FKeepTimeOut <= 0 then
  begin
    Application.MessageBox('The Keep Connect Time Out is not valid', 'Error', MB_OK + MB_ICONERROR);
    meKeepConTimeOut.SetFocus;
    Exit;
  end;

  if FMaxMegLen <= 300 then
  begin
    Application.MessageBox('The Max Message Len is not valid (min 300)', 'Error', MB_OK + MB_ICONERROR);
    meMaxMessageLen.SetFocus;
    Exit;
  end;

  if FMaxConIP <= 0 then
  begin
    Application.MessageBox('The Max Connection of IPs not valid', 'Error', MB_OK + MB_ICONERROR);
    meServerName.SetFocus;
    Exit;
  end;

  GShowLogLevel       := FShowLogLevel;
  GServerName         := FServerName;
  GServerAddr         := FServerIPaddr;
  GServerPort         := FServerPort;
  GGateAddr           := FGateIPaddr;
  GGatePort           := FGatePort;
  GKeepConnectTimeOut := FKeepTimeOut;
  GMaxConnOfIPaddr    := FMaxConIP;
  GMaxMessageLen      := FMaxMegLen;
  GMinimize           := cbMinimizeApp.Checked;

  FIniConf := TIniFile.Create(GATE_CONFIG_PATH+'.\Mir3SelectCharGateConfig.ini');
  FIniConf.WriteString( 'Gate_Network', 'ServerIP'          , FServerIPaddr);
  FIniConf.WriteInteger('Gate_Network', 'ServerPort'        , FServerPort);
  FIniConf.WriteString( 'Gate_Network', 'GateIP'            , FGateIPaddr);
  FIniConf.WriteInteger('Gate_Network', 'GatePort'          , FGatePort);
  FIniConf.WriteString( 'Gate_Option' , 'ServerName'        , FServerName);
  FIniConf.WriteInteger('Gate_Option' , 'ShowLogLevel'      , GShowLogLevel);
  FIniConf.WriteBool(   'Gate_Option' , 'Minimize'          , GMinimize);
  FIniConf.WriteInteger('Gate_Option' , 'KeepConnectTimeOut', GKeepConnectTimeOut);
  FIniConf.WriteInteger('Gate_Option' , 'MaxConnectOfIPAddr', GMaxConnOfIPaddr);
  FIniConf.WriteInteger('Gate_Option' , 'MaxMessageLen'     , GMaxMessageLen);
  FIniConf.Free;

  Close;
end;

procedure TfrmGateConfig.cbMinimizeAppClick(Sender: TObject);
begin
  GMinimize := cbMinimizeApp.Checked;
end;

procedure TfrmGateConfig.tbLogLevelChange(Sender: TObject);
begin
  laLogLevel.Caption := IntToStr(tbLogLevel.Position);
end;

end.
