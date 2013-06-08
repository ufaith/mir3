unit mir3_admin_main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, RzEdit, ComCtrls, RzListVw, RzRadChk, Mask, RzButton,
  RzTabs, RzLabel, ExtCtrls, RzPanel, RzBckgnd;

type
  TfrmAdminManager = class(TForm)
    RzPanel1: TRzPanel;
    RzLabel1: TRzLabel;
    RzPageControl1: TRzPageControl;
    tsGameClientConfig: TRzTabSheet;
    TabSheet2: TRzTabSheet;
    gbGameServer: TRzGroupBox;
    gbUpdateServer: TRzGroupBox;
    gbFallbackServer: TRzGroupBox;
    cbUseServer1: TRzCheckBox;
    meServer1Name: TRzMaskEdit;
    meServer1Caption: TRzMaskEdit;
    meServer1IP: TRzMaskEdit;
    laServer1Name: TLabel;
    laServer1Caption: TLabel;
    laServer1IP: TLabel;
    laServer1Port: TLabel;
    sepServer_1: TRzSeparator;
    plLine_s1_1: TPanel;
    plLine_s1_2: TPanel;
    plLine_s1_3: TPanel;
    plLine_s1_5: TPanel;
    plLine_s1_4: TPanel;
    cbUseServer2: TRzCheckBox;
    meServer2Name: TRzMaskEdit;
    meServer2Caption: TRzMaskEdit;
    meServer2IP: TRzMaskEdit;
    meServer2Port: TRzMaskEdit;
    laServer2Name: TLabel;
    laServer2Caption: TLabel;
    laServer2IP: TLabel;
    laServer2Port: TLabel;
    sepServer_2: TRzSeparator;
    plLine_s2_1: TPanel;
    plLine_s2_2: TPanel;
    plLine_s2_3: TPanel;
    plLine_s2_5: TPanel;
    plLine_s2_4: TPanel;
    cbUseServer3: TRzCheckBox;
    meServer3Name: TRzMaskEdit;
    meServer3Caption: TRzMaskEdit;
    meServer3IP: TRzMaskEdit;
    meServer3Port: TRzMaskEdit;
    laServer3Name: TLabel;
    laServer3Caption: TLabel;
    laServer3IP: TLabel;
    laServer3Port: TLabel;
    sepServer_3: TRzSeparator;
    plLine_s3_1: TPanel;
    plLine_s3_2: TPanel;
    plLine_s3_3: TPanel;
    plLine_s3_5: TPanel;
    plLine_s3_4: TPanel;
    cbUseServer4: TRzCheckBox;
    meServer4Name: TRzMaskEdit;
    meServer4Caption: TRzMaskEdit;
    meServer4IP: TRzMaskEdit;
    meServer4Port: TRzMaskEdit;
    laServer4Name: TLabel;
    laServer4Caption: TLabel;
    laServer4IP: TLabel;
    laServer4Port: TLabel;
    plLine_s4_1: TPanel;
    plLine_s4_2: TPanel;
    plLine_s4_3: TPanel;
    plLine_s4_5: TPanel;
    plLine_s4_4: TPanel;
    meServer1Port: TRzNumericEdit;
    cbUseUpdateServer: TRzCheckBox;
    meUpdateServerHost: TRzMaskEdit;
    meUpdateServerPassword: TRzMaskEdit;
    meUpdateServerUserID: TRzMaskEdit;
    laUpdateServerHost: TLabel;
    laUpdateServerBaseDir: TLabel;
    laUpdateServerUserID: TLabel;
    laUpdateServerPort: TLabel;
    plLine_us1_1: TPanel;
    plLine_us1_2: TPanel;
    plLine_us1_3: TPanel;
    plLine_us1_5: TPanel;
    plLine_us1_4: TPanel;
    meUpdateServerPort: TRzNumericEdit;
    cbUseFallbackServer: TRzCheckBox;
    meFallbackServerHost: TRzMaskEdit;
    laFallbackServerHost: TLabel;
    laFallbackServerPort: TLabel;
    plLine_fs1_2: TPanel;
    plLine_fs1_3: TPanel;
    plLine_fs1_5: TPanel;
    plLine_fs1_4: TPanel;
    meFallbackServerPort: TRzNumericEdit;
    rbUpdateUseFTP: TRzRadioButton;
    rbUpdateUseHTTP: TRzRadioButton;
    laUpdateServerUseProtocol: TLabel;
    laUpdateServerPassword: TLabel;
    meUpdateServerBaseDir: TRzMaskEdit;
    cbUpdateUsePassiveMode: TRzCheckBox;
    laUpdateServerListFile: TLabel;
    meUpdateServerListFile: TRzMaskEdit;
    plLine_us1_6: TPanel;
    plLine_us1_7: TPanel;
    plLine_fs1_1: TPanel;
    meFallbackServerPassword: TRzMaskEdit;
    meFallbackServerUserID: TRzMaskEdit;
    laFallbackServerBaseDir: TLabel;
    laFallbackServerUserID: TLabel;
    laFallbackServerPassword: TLabel;
    meFallbackServerBaseDir: TRzMaskEdit;
    laFallbackServerListFile: TLabel;
    meFallbackServerListFile: TRzMaskEdit;
    plLine_fs1_6: TPanel;
    plLine_fs1_7: TPanel;
    laFallbackServerUseProtocol: TLabel;
    cbFallbackUsePassiveMode: TRzCheckBox;
    rbFallbackUseFTP: TRzRadioButton;
    rbFallbackUseHTTP: TRzRadioButton;
    cbUseFallbackAsUpdateServer: TRzCheckBox;
    gbBaseURLAndButtonConfig: TRzGroupBox;
    cbShowHomePageBtn: TRzCheckBox;
    meShowHomePageURL: TRzMaskEdit;
    plLine_1: TPanel;
    plLine_2: TPanel;
    cbShowAccountPageBtn: TRzCheckBox;
    meShowAccountPageURL: TRzMaskEdit;
    plLine_3: TPanel;
    plLine_4: TPanel;
    cbShowChangePassWDPageBtn: TRzCheckBox;
    meShowChangePassWDPageURL: TRzMaskEdit;
    plLine_5: TPanel;
    plLine_6: TPanel;
    cbShowNewsPage: TRzCheckBox;
    meShowNewsPageURL: TRzMaskEdit;
    plLine_7: TPanel;
    plLine_8: TPanel;
    cbShowOptionBtn: TRzCheckBox;
    RzPanel3: TRzPanel;
    btnUpdateBGMItem: TRzBitBtn;
    RzBitBtn1: TRzBitBtn;
    RzGroupBox1: TRzGroupBox;
    RzCheckBox1: TRzCheckBox;
    RzMaskEdit1: TRzMaskEdit;
    Panel1: TPanel;
    Panel2: TPanel;
    RzCheckBox2: TRzCheckBox;
    RzMaskEdit2: TRzMaskEdit;
    Panel3: TPanel;
    Panel4: TPanel;
    RzCheckBox3: TRzCheckBox;
    RzMaskEdit3: TRzMaskEdit;
    Panel5: TPanel;
    Panel6: TPanel;
    RzCheckBox4: TRzCheckBox;
    RzMaskEdit4: TRzMaskEdit;
    Panel7: TPanel;
    Panel8: TPanel;
    RzCheckBox5: TRzCheckBox;
    procedure cbUseServer1Click(Sender: TObject);
    procedure cbUseServer2Click(Sender: TObject);
    procedure cbUseServer3Click(Sender: TObject);
    procedure cbUseServer4Click(Sender: TObject);
    procedure cbUseUpdateServerClick(Sender: TObject);
    procedure rbUpdateUseHTTPClick(Sender: TObject);
    procedure cbUseFallbackServerClick(Sender: TObject);
    procedure rbFallbackUseHTTPClick(Sender: TObject);
    procedure meServer1NameKeyPress(Sender: TObject; var Key: Char);
    procedure meServer1NameExit(Sender: TObject);
    procedure meServer1IPKeyPress(Sender: TObject; var Key: Char);
    procedure meServer1IPExit(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  frmAdminManager: TfrmAdminManager;

implementation

{$R *.dfm}

{$REGION ' - Client Server Config            '}
  procedure TfrmAdminManager.cbUseServer1Click(Sender: TObject);
  var
    FServerCount : Integer;
  begin
    FServerCount := 0;
    case cbUseServer1.Checked of
      True  : begin
        meServer1Name.Enabled    := True;
        meServer1Caption.Enabled := True;
        meServer1IP.Enabled      := True;
        meServer1Port.Enabled    := True;
        laServer1Name.Enabled    := True;
        laServer1Caption.Enabled := True;
        laServer1IP.Enabled      := True;
        laServer1Port.Enabled    := True;
      end;
      False : begin
        meServer1Name.Enabled    := False;
        meServer1Caption.Enabled := False;
        meServer1IP.Enabled      := False;
        meServer1Port.Enabled    := False;
        laServer1Name.Enabled    := False;
        laServer1Caption.Enabled := False;
        laServer1IP.Enabled      := False;
        laServer1Port.Enabled    := False;
      end;
    end;
    if cbUseServer1.Checked then  Inc(FServerCount);
    if cbUseServer2.Checked then  Inc(FServerCount);
    if cbUseServer3.Checked then  Inc(FServerCount);
    if cbUseServer4.Checked then  Inc(FServerCount);
    gbGameServer.Caption := ' Game Server ( Server Count : ' + IntToStr(FServerCount) + ' ) ';
  end;
  
  procedure TfrmAdminManager.cbUseServer2Click(Sender: TObject);
  var
    FServerCount : Integer;
  begin
    FServerCount := 0;
    case cbUseServer2.Checked of
      True  : begin
        meServer2Name.Enabled    := True;
        meServer2Caption.Enabled := True;
        meServer2IP.Enabled      := True;
        meServer2Port.Enabled    := True;
        laServer2Name.Enabled    := True;
        laServer2Caption.Enabled := True;
        laServer2IP.Enabled      := True;
        laServer2Port.Enabled    := True;
      end;
      False : begin
        meServer2Name.Enabled    := False;
        meServer2Caption.Enabled := False;
        meServer2IP.Enabled      := False;
        meServer2Port.Enabled    := False;
        laServer2Name.Enabled    := False;
        laServer2Caption.Enabled := False;
        laServer2IP.Enabled      := False;
        laServer2Port.Enabled    := False;
      end;
    end;
    if cbUseServer1.Checked then  Inc(FServerCount);
    if cbUseServer2.Checked then  Inc(FServerCount);
    if cbUseServer3.Checked then  Inc(FServerCount);
    if cbUseServer4.Checked then  Inc(FServerCount);
    gbGameServer.Caption := ' Game Server ( Server Count : ' + IntToStr(FServerCount) + ' ) ';
  end;
  
  procedure TfrmAdminManager.cbUseServer3Click(Sender: TObject);
  var
    FServerCount : Integer;
  begin
    FServerCount := 0;
    case cbUseServer3.Checked of
      True  : begin
        meServer3Name.Enabled    := True;
        meServer3Caption.Enabled := True;
        meServer3IP.Enabled      := True;
        meServer3Port.Enabled    := True;
        laServer3Name.Enabled    := True;
        laServer3Caption.Enabled := True;
        laServer3IP.Enabled      := True;
        laServer3Port.Enabled    := True;
      end;
      False : begin
        meServer3Name.Enabled    := False;
        meServer3Caption.Enabled := False;
        meServer3IP.Enabled      := False;
        meServer3Port.Enabled    := False;
        laServer3Name.Enabled    := False;
        laServer3Caption.Enabled := False;
        laServer3IP.Enabled      := False;
        laServer3Port.Enabled    := False;
      end;
    end;
    if cbUseServer1.Checked then  Inc(FServerCount);
    if cbUseServer2.Checked then  Inc(FServerCount);
    if cbUseServer3.Checked then  Inc(FServerCount);
    if cbUseServer4.Checked then  Inc(FServerCount);
    gbGameServer.Caption := ' Game Server ( Server Count : ' + IntToStr(FServerCount) + ' ) ';
  end;
  
  procedure TfrmAdminManager.cbUseServer4Click(Sender: TObject);
  var
    FServerCount : Integer;
  begin
    FServerCount := 0;
    case cbUseServer4.Checked of
      True  : begin
        meServer4Name.Enabled    := True;
        meServer4Caption.Enabled := True;
        meServer4IP.Enabled      := True;
        meServer4Port.Enabled    := True;
        laServer4Name.Enabled    := True;
        laServer4Caption.Enabled := True;
        laServer4IP.Enabled      := True;
        laServer4Port.Enabled    := True;
      end;
      False : begin
        meServer4Name.Enabled    := False;
        meServer4Caption.Enabled := False;
        meServer4IP.Enabled      := False;
        meServer4Port.Enabled    := False;
        laServer4Name.Enabled    := False;
        laServer4Caption.Enabled := False;
        laServer4IP.Enabled      := False;
        laServer4Port.Enabled    := False;
      end;
    end;
    if cbUseServer1.Checked then  Inc(FServerCount);
    if cbUseServer2.Checked then  Inc(FServerCount);
    if cbUseServer3.Checked then  Inc(FServerCount);
    if cbUseServer4.Checked then  Inc(FServerCount);
    gbGameServer.Caption := ' Game Server ( Server Count : ' + IntToStr(FServerCount) + ' ) ';
  end;

  procedure TfrmAdminManager.meServer1NameKeyPress(Sender: TObject; var Key: Char);
  const
    AllowedChars: string = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVW0123456789_.';
  var
    i: Integer;
    Ok: Boolean;
  begin
    i  := 0;
    Ok := False;
    if Key = #8 then Ok := True;
    repeat
      i := i + 1;
      if Key = AllowedChars[i] then Ok := True;
    until (Ok) or (i = Length(AllowedChars));
    if not Ok then Key := #0;
  end;

  procedure TfrmAdminManager.meServer1NameExit(Sender: TObject);
  begin
    if Trim(TRzMaskEdit(Sender).Text) = '' then
    begin
      TRzMaskEdit(Sender).Color := clRed;
    end else begin
      TRzMaskEdit(Sender).Color := clWindow;
    end;
  end;

  procedure TfrmAdminManager.meServer1IPKeyPress(Sender: TObject; var Key: Char);
  const
    AllowedChars: string = '0123456789.';
  var
    i: Integer;
    Ok: Boolean;
  begin
    i  := 0;
    Ok := False;
    if Key = #8 then Ok := True;
    repeat
      i := i + 1;
      if Key = AllowedChars[i] then Ok := True;
    until (Ok) or (i = Length(AllowedChars));
    if not Ok then Key := #0;
  end;

  procedure TfrmAdminManager.meServer1IPExit(Sender: TObject);

    function IsNotWrongIP(Ip: string): Boolean;
    const
      Z = ['0'..'9', '.'];
    var
      I, J, P: Integer;
      W: string;
    begin
      Result := False;
      if (Length(Ip) > 15) or (Ip[1] = '.') then Exit;
      I := 1; 
      J := 0; 
      P := 0; 
      W := '';
      repeat
        if (Ip[I] in Z) and (J < 4) then
        begin
          if Ip[I] = '.' then
          begin
            Inc(P);
            J := 0;
            try
              StrToInt(Ip[I + 1]);
            except
              Exit;
            end;
            W := '';
          end else begin
            W := W + Ip[I];
            if (StrToInt(W) > 255) or (Length(W) > 3) then Exit;
            Inc(J);
          end;
        end else Exit;
        Inc(I);
      until I > Length(Ip);
      if P < 3 then Exit;
      Result := True;
    end;

  begin
    if Trim(TRzMaskEdit(Sender).Text) = '' then
    begin
      TRzMaskEdit(Sender).Color := clRed;
    end else begin
      if IsNotWrongIP(TRzMaskEdit(Sender).Text) then
        TRzMaskEdit(Sender).Color := clWindow
      else TRzMaskEdit(Sender).Color := clRed;
    end;
  end;

{$ENDREGION}

{$REGION ' - Client Update Server Config     '}
  procedure TfrmAdminManager.cbUseUpdateServerClick(Sender: TObject);
  begin
    case cbUseUpdateServer.Checked of
      True  : begin
        meUpdateServerHost.Enabled        := True;
        meUpdateServerPort.Enabled        := True;
        meUpdateServerBaseDir.Enabled     := True;
        meUpdateServerListFile.Enabled    := True;
        laUpdateServerHost.Enabled        := True;
        laUpdateServerPort.Enabled        := True;
        laUpdateServerBaseDir.Enabled     := True;
        laUpdateServerListFile.Enabled    := True;
        laUpdateServerUseProtocol.Enabled := True;
        rbUpdateUseFTP.Enabled            := True;
        rbUpdateUseHTTP.Enabled           := True;

        if rbUpdateUseFTP.Checked then
        begin
         meUpdateServerUserID.Enabled     := True;
         meUpdateServerPassword.Enabled   := True;
         laUpdateServerUserID.Enabled     := True;
         laUpdateServerPassword.Enabled   := True;
         cbUpdateUsePassiveMode.Enabled   := True;
        end else begin
         meUpdateServerUserID.Enabled     := False;
         meUpdateServerPassword.Enabled   := False;
         laUpdateServerUserID.Enabled     := False;
         laUpdateServerPassword.Enabled   := False;
         cbUpdateUsePassiveMode.Enabled   := False;
        end;
        gbUpdateServer.Caption   := ' Update Server ( On ) ';
      end;
      False : begin
        meUpdateServerHost.Enabled        := False;
        meUpdateServerPort.Enabled        := False;
        meUpdateServerUserID.Enabled      := False;
        meUpdateServerPassword.Enabled    := False;
        meUpdateServerBaseDir.Enabled     := False;
        meUpdateServerListFile.Enabled    := False;
        laUpdateServerHost.Enabled        := False;
        laUpdateServerPort.Enabled        := False;
        laUpdateServerUserID.Enabled      := False;
        laUpdateServerPassword.Enabled    := False;
        laUpdateServerBaseDir.Enabled     := False;
        laUpdateServerListFile.Enabled    := False;
        laUpdateServerUseProtocol.Enabled := False;
        rbUpdateUseFTP.Enabled            := False;
        rbUpdateUseHTTP.Enabled           := False;
        cbUpdateUsePassiveMode.Enabled    := False;
        gbUpdateServer.Caption            := ' Update Server ( Off ) ';
      end;
    end;
  end;

  procedure TfrmAdminManager.rbUpdateUseHTTPClick(Sender: TObject);
  begin
    if rbUpdateUseFTP.Checked then
    begin
     meUpdateServerUserID.Enabled     := True;
     meUpdateServerPassword.Enabled   := True;
     laUpdateServerUserID.Enabled     := True;
     laUpdateServerPassword.Enabled   := True;
     cbUpdateUsePassiveMode.Enabled   := True;
    end else begin
     meUpdateServerUserID.Enabled     := False;
     meUpdateServerPassword.Enabled   := False;
     laUpdateServerUserID.Enabled     := False;
     laUpdateServerPassword.Enabled   := False;
     cbUpdateUsePassiveMode.Enabled   := False;
    end;
  end;
{$ENDREGION}

{$REGION ' - Client Fallback Server Config   '}
  procedure TfrmAdminManager.cbUseFallbackServerClick(Sender: TObject);
  begin
    case cbUseFallbackServer.Checked of
      True  : begin
        meFallbackServerHost.Enabled        := True;
        meFallbackServerPort.Enabled        := True;
        meFallbackServerBaseDir.Enabled     := True;
        meFallbackServerListFile.Enabled    := True;
        laFallbackServerHost.Enabled        := True;
        laFallbackServerPort.Enabled        := True;
        laFallbackServerBaseDir.Enabled     := True;
        laFallbackServerListFile.Enabled    := True;
        laFallbackServerUseProtocol.Enabled := True;
        rbFallbackUseFTP.Enabled            := True;
        rbFallbackUseHTTP.Enabled           := True;
        cbUseFallbackAsUpdateServer.Enabled := True;

        if rbFallbackUseFTP.Checked then
        begin
         meFallbackServerUserID.Enabled     := True;
         meFallbackServerPassword.Enabled   := True;
         laFallbackServerUserID.Enabled     := True;
         laFallbackServerPassword.Enabled   := True;
         cbFallbackUsePassiveMode.Enabled   := True;
        end else begin
         meFallbackServerUserID.Enabled     := False;
         meFallbackServerPassword.Enabled   := False;
         laFallbackServerUserID.Enabled     := False;
         laFallbackServerPassword.Enabled   := False;
         cbFallbackUsePassiveMode.Enabled   := False;
        end;
        gbFallbackServer.Caption            := ' Fallback Server ( On ) ';
      end;
      False : begin
        meFallbackServerHost.Enabled        := False;
        meFallbackServerPort.Enabled        := False;
        meFallbackServerBaseDir.Enabled     := False;
        meFallbackServerListFile.Enabled    := False;
        laFallbackServerHost.Enabled        := False;
        laFallbackServerPort.Enabled        := False;
        laFallbackServerBaseDir.Enabled     := False;
        laFallbackServerListFile.Enabled    := False;
        laFallbackServerUseProtocol.Enabled := False;
        rbFallbackUseFTP.Enabled            := False;
        rbFallbackUseHTTP.Enabled           := False;
        meFallbackServerUserID.Enabled      := False;
        meFallbackServerPassword.Enabled    := False;
        laFallbackServerUserID.Enabled      := False;
        laFallbackServerPassword.Enabled    := False;
        cbFallbackUsePassiveMode.Enabled    := False;
        cbUseFallbackAsUpdateServer.Enabled := False;
        gbUpdateServer.Caption              := ' Update Server ( Off ) ';
      end;
    end;
  end;

  procedure TfrmAdminManager.rbFallbackUseHTTPClick(Sender: TObject);
  begin
    if rbFallbackUseFTP.Checked then
    begin
     meFallbackServerUserID.Enabled     := True;
     meFallbackServerPassword.Enabled   := True;
     laFallbackServerUserID.Enabled     := True;
     laFallbackServerPassword.Enabled   := True;
     cbFallbackUsePassiveMode.Enabled   := True;
    end else begin
     meFallbackServerUserID.Enabled     := False;
     meFallbackServerPassword.Enabled   := False;
     laFallbackServerUserID.Enabled     := False;
     laFallbackServerPassword.Enabled   := False;
     cbFallbackUsePassiveMode.Enabled   := False;
    end;
  end;

{$ENDREGION}




end.
