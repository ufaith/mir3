{ *********************************************************************** }
{                                                                         }
{  LomCN BGMList.wwl and SoundList.wwl Editor System                      }
{                                                                         }
{  Copyright (c) Coly by Illusion Server Team                             }
{                                                                         }
{  Author            : Coly                                               }
{  Last Change Date  : 31.01.2013                                         }
{                                                                         }
{ *********************************************************************** }


unit unMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,ExtCtrls, Mask, ComCtrls,
  RzLabel, RzStatus, RzDBStat, RzPanel, RzTabs, RzListVw, RzEdit, RzButton,
  RzRadChk;

type
  TBGMListEditor   = class;
  TSoundListEditor = class;

  (*
     Base File Header
     Useded for both : BGMList and SoundList File
  *)
  TFileHeader    = packed record
    Titel        : array [0..39] of char;
    TargetDir    : array [0..9]  of char;
    FieldCount   : Cardinal;
    ListCount    : Cardinal;
  end;

  (*
     BGM List Item Header
  *)
  TBGMListPart   = packed record
    Start        : array [0..0] of char;
    MapName      : array [0..8] of char;
    FileName     : array [0..13] of char;
  end;

  (*
     Sound List Item Header
  *)
  TSoundListPart = packed record
    SoundID      : Word;
    SoundFile    : array [0..13] of char;
  end;

  TfrmEditorMain = class(TForm)
    odBGMList: TOpenDialog;
    RzPageControl1: TRzPageControl;
    tsBGMEditor: TRzTabSheet;
    TabSheet2: TRzTabSheet;
    RzPanel1: TRzPanel;
    RzStatusBar1: TRzStatusBar;
    RzLabel1: TRzLabel;
    odSoundList: TOpenDialog;
    RzPanel2: TRzPanel;
    RzPanel3: TRzPanel;
    RzPanel4: TRzPanel;
    plButtonBar: TRzPanel;
    btnSaveBGMList: TRzBitBtn;
    btnLoadBGMList: TRzBitBtn;
    btnSaveSoundList: TRzBitBtn;
    btnLoadSoundList: TRzBitBtn;
    maMapName: TRzMaskEdit;
    maBGMFile: TRzMaskEdit;
    btnAddBGMItem: TRzBitBtn;
    RzLabel2: TRzLabel;
    RzLabel3: TRzLabel;
    btnDeleteBGMItem: TRzBitBtn;
    sptSectiontemCount: TRzDBStatusPane;
    btnUpdateBGMItem: TRzBitBtn;
    btnNewBGMList: TRzBitBtn;
    sdBGMList: TSaveDialog;
    sptLastInfo: TRzDBStatusPane;
    TabSheet3: TRzTabSheet;
    RzMemo1: TRzMemo;
    sptToolVersion: TRzVersionInfoStatus;
    RzVersionInfo1: TRzVersionInfo;
    RzLabel5: TRzLabel;
    maSoundID: TRzMaskEdit;
    RzLabel6: TRzLabel;
    maSoundFile: TRzMaskEdit;
    btnUpdateSoundItem: TRzBitBtn;
    btnAddSoundItem: TRzBitBtn;
    btnDeleteSoundItem: TRzBitBtn;
    btnNewSoundList: TRzBitBtn;
    cbShowSectionHeader: TRzCheckBox;
    sdSoundList: TSaveDialog;
    RzPanel7: TRzPanel;
    RzPanel6: TRzPanel;
    lvSoundList: TRzListView;
    btnMoveItemUp: TRzBitBtn;
    btnMoveItemDown: TRzBitBtn;
    sptListItemCount: TRzDBStatusPane;
    RzPanel5: TRzPanel;
    RzPanel8: TRzPanel;
    btnBGMMoveItemUp: TRzBitBtn;
    btnBGMMoveItemDown: TRzBitBtn;
    lvBGMList: TRzListView;
    procedure btnLoadBGMListClick(Sender: TObject);
    procedure lvBGMListClick(Sender: TObject);
    procedure btnSaveBGMListClick(Sender: TObject);
    procedure btnAddBGMItemClick(Sender: TObject);
    procedure btnDeleteBGMItemClick(Sender: TObject);
    procedure btnLoadSoundListClick(Sender: TObject);
    procedure btnNewBGMListClick(Sender: TObject);
    procedure btnUpdateBGMItemClick(Sender: TObject);
    procedure maMapNameChange(Sender: TObject);
    procedure lvSoundListClick(Sender: TObject);
    procedure maSoundIDChange(Sender: TObject);
    procedure btnNewSoundListClick(Sender: TObject);
    procedure btnSaveSoundListClick(Sender: TObject);
    procedure btnDeleteSoundItemClick(Sender: TObject);
    procedure btnAddSoundItemClick(Sender: TObject);
    procedure btnUpdateSoundItemClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure cbShowSectionHeaderClick(Sender: TObject);
    procedure RzPageControl1Change(Sender: TObject);
    procedure btnMoveItemUpClick(Sender: TObject);
    procedure btnMoveItemDownClick(Sender: TObject);
    procedure btnBGMMoveItemUpClick(Sender: TObject);
    procedure btnBGMMoveItemDownClick(Sender: TObject);
  private
    FSoundListEditor : TSoundListEditor;
    FBGMListEditor   : TBGMListEditor;

    FBGMListHeader : TFileHeader;
    FBGMListPart   : array of TBGMListPart;
    FBGMFileName   : String;
    FSoundListItem : array of TSoundListPart;
  public
    procedure FillBGMListView;
    procedure FillSoundListView;
  end;

  TBGMListEditor = class
  private
    FFileName   : String;
    FModify     : Boolean;
    FFileHeader : TFileHeader;
    FListItem   : array of TBGMListPart;
    FFieldCount : Cardinal;
    FListCount  : Cardinal;
    FFileSize   : Cardinal;
  private
    procedure AutoCorrectFile;
    procedure ReOrderList;
    function FindItem(AMapName, ABGMSound: String): Integer;
    function FindDoubleItem(AMapName, ABGMSound: String): Boolean;
  public
    destructor Destroy; override;
    function SaveListFile(AFileName: String): Boolean;
    function LoadListFile(AFileName: String): Boolean;
    function UpdateItem(AMapName, ABGMSound, AUpdateMapName, AUpdateBGMSound: String): Integer;
    function DeleteItem(AMapName, ABGMSound: String): Boolean;
    function AddItem(AMapName, ABGMSound: String): Integer;
    procedure MoveItemUP(AMapName, ABGMSound: String);
    procedure MoveItemDown(AMapName, ABGMSound: String);
    property FileName : String  read FFileName write FFileName;
    property Modify   : Boolean read FModify   write FModify;
    property FieldCount : Cardinal read FFieldCount;
    property ListCount  : Cardinal read FListCount;
  end;

  TSoundListEditor = class
  private
    FFileName      : String;
    FModify        : Boolean;
    FHasInfoHeader : Boolean;
    FFileHeader    : TFileHeader;
    FListItem      : array of TSoundListPart;
    FFieldCount    : Cardinal;
    FListCount     : Cardinal;
    FFileSize      : Cardinal;
  private
    procedure AutoCorrectFile(ATestPoint: Integer);
    procedure ReOrderList;
    function FindItem(ASoundID, ASoundFile: String): Integer;
    function FindDoubleItem(ASoundID, ASoundFile: String): Boolean;
  public
    destructor Destroy; override;
    function SaveListFile(AFileName: String): Boolean;
    function LoadListFile(AFileName: String): Boolean;
    function UpdateItem(ASoundID, ASoundFile, AUpdateSoundID, AUpdateSoundFile: String): Integer;
    function DeleteItem(ASoundID, ASoundFile: String): Boolean;
    function AddItem(ASoundID, ASoundFile: String): Integer;
    procedure MoveItemUP(ASoundID, ASoundFile: String);
    procedure MoveItemDown(ASoundID, ASoundFile: String);
    property FileName : String  read FFileName write FFileName;
    property Modify   : Boolean read FModify   write FModify;
    property FieldCount : Cardinal read FFieldCount;
    property ListCount  : Cardinal read FListCount;
  end;

var
  frmEditorMain: TfrmEditorMain;

implementation

{$R *.dfm}

  { TBGMListEditor }

destructor TBGMListEditor.Destroy;
begin
  ZeroMemory(@FFileHeader, sizeOf(TFileHeader));
  SetLength(FListItem, 0);
  FListItem := nil;
  inherited;
end;

(* pivate *)

procedure TBGMListEditor.AutoCorrectFile;
var
  FFileItems : Cardinal;
begin
  // Test and Correct the List Count Information
  FFileItems             := Round(FFileSize / SizeOf(TBGMListPart));
  FFileHeader.ListCount  := FFileItems;
  FFileHeader.FieldCount := FFileItems;
end;

procedure TBGMListEditor.ReOrderList;
var
  I, FCount : Integer;
  FTempList : array of TBGMListPart;
begin
  try
    FCount := 0;
    for I := 0 to FFileHeader.ListCount - 1 do
    begin
      if (FListItem[I].MapName <> '') and (FListItem[I].FileName <> '') then
      begin
        Inc(FCount);
        SetLength(FTempList, FCount);
        FTempList[FCount-1].Start    := '[';
        FTempList[FCount-1].MapName  := FListItem[I].MapName;
        FTempList[FCount-1].FileName := FListItem[I].FileName;
      end;
    end;
    SetLength(FListItem, 0);
    SetLength(FListItem, FCount);
    CopyMemory(@FListItem[0], @FTempList[0], FCount * sizeOf(TBGMListPart));
    SetLength(FTempList, 0);
    FFileHeader.ListCount  := FCount;
    FFileHeader.FieldCount := FCount;
  except
  end;
end;

function TBGMListEditor.FindItem(AMapName, ABGMSound: String): Integer;
var
  I : Integer;
begin
  Result := 0;
  for I := 0 to FFileHeader.ListCount - 1 do
  begin
    if (Trim(FListItem[I].MapName) = Trim(AMapName)) and (FListItem[I].FileName = Trim(ABGMSound)) then
    begin
      Result := I;
      Exit;
    end;
  end;
end;

function TBGMListEditor.FindDoubleItem(AMapName, ABGMSound: String): Boolean;
var
  I : Integer;
begin
  Result := False;
  for I := 0 to FFileHeader.ListCount - 1 do
  begin
    if (Trim(FListItem[I].MapName) = Trim(AMapName)) and (FListItem[I].FileName = Trim(ABGMSound)) then
    begin
      Result := True;
      Exit;
    end;
  end;
end;

(* public *)

function TBGMListEditor.SaveListFile(AFileName: String): Boolean;
var
  I         : Integer;
  FTempName : String;
  FMemory   : TMemoryStream;
begin
  Result  := True;
  FMemory := TMemoryStream.Create;
  if FFileName <> AFileName then
    FFileName := AFileName;
  try
    FFileHeader.Titel      := ' LomCN wwl Editor';
    FFileHeader.TargetDir  := '';

    FMemory.Write(FFileHeader, sizeof(TFileHeader));
    FMemory.Write(FListItem[0], FFileHeader.ListCount * sizeof(TBGMListPart)-1);

    FMemory.SaveToFile(AFileName);
    FreeAndNil(FMemory);
    Modify := False;
  except
    FreeAndNil(FMemory);
    Result := False;
  end;
end;

function TBGMListEditor.LoadListFile(AFileName: String): Boolean;
var
  FBool       : Boolean;
  FFileHandle : Cardinal;
  FReadSize   : Cardinal;
  FMemFile    : TMemoryStream;
begin
  Result := True;
  try
    // Create BGM List File Backup -----------------------
    if FileExists(AFileName + '.bac') then
    begin
      FBool := True;
      if Application.MessageBox('Override existing backup file?',
        'Mir3 Music List Editor', MB_YESNO + MB_ICONQUESTION) = IDYES then
      begin
        FBool := False;
      end;
    end else FBool := False;

    if not (FBool) then
    begin
      FMemFile := TMemoryStream.Create;
      FMemFile.LoadFromFile(AFileName);
      FMemFile.SaveToFile(AFileName + '.bac');
      FMemFile.Clear;
      FreeAndNil(FMemFile);
    end;

    // Read Sound List File --------------------------------
    FFileHandle := CreateFile(PChar(AFileName), GENERIC_READ, FILE_SHARE_READ, nil, OPEN_EXISTING,FILE_ATTRIBUTE_NORMAL, 0);
    if FFileHandle <> 0 then
    begin
      FFileSize := GetFileSize(FFileHandle, nil) - sizeOf(TFileHeader);
      // Read File Header ----------------------------
      ZeroMemory(@FFileHeader, sizeOf(TFileHeader));
	    ReadFile(FFileHandle, FFileHeader, SizeOf(TFileHeader), FReadSize, nil);

      // Automatic check and correct List and field Count information -
      AutoCorrectFile;

      // Read File Items -----------------------------
      SetLength(FListItem, FFileHeader.FieldCount);
      ZeroMemory(@FListItem[0], FFileHeader.FieldCount * SizeOf(TBGMListPart)-1);
      ReadFile(FFileHandle, FListItem[0], FFileHeader.FieldCount * SizeOf(TBGMListPart)-1, FReadSize, nil);

      FFieldCount := FFileHeader.FieldCount;
      FListCount  := FFileHeader.ListCount;

      CloseHandle(FFileHandle);
    end;
    ReOrderList;
  except
    Result := False;
  end;
end;

function TBGMListEditor.UpdateItem(AMapName, ABGMSound, AUpdateMapName, AUpdateBGMSound: String): Integer;
var
  FID : Integer;
begin
  Result := 0;
  try
    if FindDoubleItem(AUpdateMapName, AUpdateBGMSound) then
    begin
      Result := 1;
      Exit;
    end;
    
    FID := FindItem(AMapName, ABGMSound);
    CopyMemory(@FListItem[FID].MapName[0] , @AUpdateMapName[1] , Length(AUpdateMapName));
    CopyMemory(@FListItem[FID].FileName[0], @AUpdateBGMSound[1], Length(AUpdateBGMSound));
  except
    Result := -1;
  end;
end;

function TBGMListEditor.DeleteItem(AMapName, ABGMSound: String): Boolean;
var
  I : Integer;
begin
  Result := False;
  for I := 0 to FFileHeader.ListCount - 1 do
  begin
    if (Trim(FListItem[I].MapName) = Trim(AMapName)) and (FListItem[I].FileName = Trim(ABGMSound)) then
    begin
      FListItem[I].MapName  := #0;
      FListItem[I].FileName := #0;
      ReOrderList;
      Dec(FFileHeader.ListCount);
      Dec(FFileHeader.FieldCount);
      Result := True;
      Exit;
    end;
  end;
end;

function TBGMListEditor.AddItem(AMapName, ABGMSound: String): Integer;
begin
  Result := 0;
  try
    if FindDoubleItem(AMapName, ABGMSound) then
    begin
      Result := 1;
      Exit;
    end;
    Inc(FFileHeader.ListCount);
    Inc(FFileHeader.FieldCount);
    SetLength(FListItem, FFileHeader.ListCount);
    CopyMemory(@FListItem[High(FListItem)].MapName[0] , @AMapName[1] , Length(AMapName));
    CopyMemory(@FListItem[High(FListItem)].FileName[0], @ABGMSound[1], Length(ABGMSound));
  except
    Result := -1;
  end;
end;

procedure TBGMListEditor.MoveItemUP(AMapName, ABGMSound: String);
var
  FID       : Integer;
  FTempItem : array [0..0] of TBGMListPart;
begin
  FID := FindItem(AMapName, ABGMSound);

  FTempItem[0].MapName      := FListItem[FID].MapName;
  FTempItem[0].FileName     := FListItem[FID].FileName;

  FListItem[FID].MapName    := FListItem[FID-1].MapName;
  FListItem[FID].FileName   := FListItem[FID-1].FileName;

  FListItem[FID-1].MapName  := FTempItem[0].MapName;
  FListItem[FID-1].FileName := FTempItem[0].FileName;
end;

procedure TBGMListEditor.MoveItemDown(AMapName, ABGMSound: String);
var
  FID       : Integer;
  FTempItem : array [0..0] of TBGMListPart;
begin
  FID := FindItem(AMapName, ABGMSound);

  FTempItem[0].MapName      := FListItem[FID].MapName;
  FTempItem[0].FileName     := FListItem[FID].FileName;

  FListItem[FID].MapName    := FListItem[FID+1].MapName;
  FListItem[FID].FileName   := FListItem[FID+1].FileName;

  FListItem[FID+1].MapName  := FTempItem[0].MapName;
  FListItem[FID+1].FileName := FTempItem[0].FileName;
end;


  { TSoundListEditor }

destructor TSoundListEditor.Destroy;
begin
  ZeroMemory(@FFileHeader, sizeOf(TFileHeader));
  SetLength(FListItem, 0);
  FListItem := nil;
  inherited;
end;

(* pivate *)

procedure TSoundListEditor.AutoCorrectFile(ATestPoint: Integer);
var
  I          : Integer;
  FFileItems : Cardinal;
begin
  case ATestPoint of
    0 : begin
      // Test and Correct the List Count Information
      FFileItems            := Round(FFileSize / SizeOf(TSoundListPart));
      FFileHeader.ListCount := FFileItems;
    end;
    1 : begin
      // Test and Correct the Sound List Information Count
      FFileItems := 0;
      for I := 0 to FFileHeader.ListCount - 1 do
      begin
        if FListItem[I].SoundID = 0 then
        begin
          Inc(FFileItems);
        end;
      end;
      if FFileItems = 0 then
      begin
        FFileHeader.FieldCount := 0;
        FHasInfoHeader         := False;
      end else begin
        FFileHeader.FieldCount := FFileItems;
        FHasInfoHeader         := True;
      end;
    end;
  end;
end;

procedure TSoundListEditor.ReOrderList;
var
  I, FCount : Integer;
  FTempList : array of TSoundListPart;
begin
  try
    FCount := 0;
    for I := 0 to FFileHeader.ListCount - 1 do
    begin
      if (FListItem[I].SoundFile <> '') then
      begin
        Inc(FCount);
        SetLength(FTempList, FCount);
        FTempList[FCount-1].SoundID   := FListItem[I].SoundID;
        FTempList[FCount-1].SoundFile := FListItem[I].SoundFile;
      end;
    end;
    SetLength(FListItem, 0);
    SetLength(FListItem, FCount);
    CopyMemory(@FListItem[0], @FTempList[0], FCount * sizeOf(TSoundListPart));
    SetLength(FTempList, 0);
    FFileHeader.ListCount  := FCount;
  except
  end;
end;

function TSoundListEditor.FindItem(ASoundID, ASoundFile: String): Integer;
var
  I : Integer;
begin
  Result := 0;
  for I := 0 to FFileHeader.ListCount - 1 do
  begin
    if (FListItem[I].SoundID = StrToIntDef(Trim(ASoundID),0)) and (FListItem[I].SoundFile = Trim(ASoundFile)) then
    begin
      Result := I;
      Exit;
    end;
  end;
end;

function TSoundListEditor.FindDoubleItem(ASoundID, ASoundFile: String): Boolean;
var
  I : Integer;
begin
  Result := False;
  for I := 0 to FFileHeader.ListCount - 1 do
  begin
    if (FListItem[I].SoundID = StrToIntDef(Trim(ASoundID),0)) and (FListItem[I].SoundFile = Trim(ASoundFile)) then
    begin
      Result := True;
      Exit;
    end;
  end;
end;

(* public *)

function TSoundListEditor.SaveListFile(AFileName: String): Boolean;
var
  I          : Integer;
  FTempName  : String;
  FMemory    : TMemoryStream;
  FFieldCount: Integer;
  FListCount : Integer;
begin
  Result  := True;
  FMemory := TMemoryStream.Create;
  if FFileName <> AFileName then
    FFileName := AFileName;
  try
    FFileHeader.Titel      := ' LomCN wwl Editor';
    FFileHeader.TargetDir  := '';
    FFileHeader.FieldCount := FFileHeader.ListCount;

    FMemory.Write(FFileHeader, sizeof(TFileHeader));
    FMemory.Write(FListItem[0], FFileHeader.ListCount * sizeof(TSoundListPart)-1);

    FMemory.SaveToFile(AFileName);
    FreeAndNil(FMemory);
    Modify := False;
  except
    FreeAndNil(FMemory);
    Result := False;
  end;
end;

function TSoundListEditor.LoadListFile(AFileName: String): Boolean;
var
  FBool       : Boolean;
  FFileHandle : Cardinal;
  FReadSize   : Cardinal;
  FMemFile    : TMemoryStream;
begin
  Result := True;
  try
    // Create Sound List File Backup -----------------------
    if FileExists(AFileName + '.bac') then
    begin
      FBool := True;
      if Application.MessageBox('Override existing backup file?',
        'Mir3 Music List Editor', MB_YESNO + MB_ICONQUESTION) = IDYES then
      begin
        FBool := False;
      end;
    end else FBool := False;

    if not (FBool) then
    begin
      FMemFile := TMemoryStream.Create;
      FMemFile.LoadFromFile(AFileName);
      FMemFile.SaveToFile(AFileName + '.bac');
      FMemFile.Clear;
      FreeAndNil(FMemFile);
    end;

    // Read Sound List File --------------------------------
    FFileHandle := CreateFile(PChar(AFileName), GENERIC_READ, FILE_SHARE_READ, nil, OPEN_EXISTING,FILE_ATTRIBUTE_NORMAL, 0);
    if FFileHandle <> 0 then
    begin
      FFileSize := GetFileSize(FFileHandle, nil) - sizeOf(TFileHeader);
      // Read File Header ----------------------------
      ZeroMemory(@FFileHeader, sizeOf(TFileHeader));
	    ReadFile(FFileHandle, FFileHeader, SizeOf(TFileHeader), FReadSize, nil);

      // Automatic check and correct List Count information -
      AutoCorrectFile(0);

      // Read File Items -----------------------------
      SetLength(FListItem, FFileHeader.ListCount);
      ZeroMemory(@FListItem[0], FFileHeader.ListCount * SizeOf(TSoundListPart)-1);
      ReadFile(FFileHandle, FListItem[0], FFileHeader.ListCount * SizeOf(TSoundListPart)-1, FReadSize, nil);

      // Automatic check and correct Info Count information -
      AutoCorrectFile(1);

      FFieldCount := FFileHeader.FieldCount;
      FListCount  := FFileHeader.ListCount;

      CloseHandle(FFileHandle);
    end;
    ReOrderList;
  except
    Result := False;
  end;
end;

function TSoundListEditor.UpdateItem(ASoundID, ASoundFile, AUpdateSoundID, AUpdateSoundFile: String): Integer;
var
  FID : Integer;
begin
  Result := 0;
  try
    if FindDoubleItem(AUpdateSoundID, AUpdateSoundFile) then
    begin
      Result := 1;
      Exit;
    end;
    FID := FindItem(ASoundID, ASoundFile);
    FListItem[FID].SoundID := StrToIntDef(AUpdateSoundID, 0);
    ZeroMemory(@FListItem[FID].SoundFile[0], 14);
    CopyMemory(@FListItem[FID].SoundFile[0], @AUpdateSoundFile[1], Length(AUpdateSoundFile));
    if (Trim(ASoundID) <> '0') and (Trim(AUpdateSoundID) = '0') then
    begin
      Inc(FFileHeader.FieldCount);
    end;
    if (Trim(ASoundID) = '0') and (Trim(AUpdateSoundID) <> '0') then
    begin
      Dec(FFileHeader.FieldCount);
    end;
  except
    Result := -1;
  end;
end;

function TSoundListEditor.DeleteItem(ASoundID, ASoundFile: String): Boolean;
var
  I : Integer;
begin
  Result := False;
  for I := 0 to FFileHeader.ListCount - 1 do
  begin
    if (FListItem[I].SoundID = StrToIntDef(Trim(ASoundID),0)) and (FListItem[I].SoundFile = Trim(ASoundFile)) then
    begin

      FListItem[I].SoundID   := 0;
      FListItem[I].SoundFile := #0;
      ReOrderList;
      if Trim(ASoundID) = '0' then
      begin
        Dec(FFileHeader.ListCount);
        Dec(FFileHeader.FieldCount);
      end else Dec(FFileHeader.ListCount);
      Result := True;
      Exit;
    end;
  end;
end;

function TSoundListEditor.AddItem(ASoundID, ASoundFile: String): Integer;
begin
  Result := 0;
  try
    if FindDoubleItem(ASoundID, ASoundFile) then
    begin
      Result := 1;
      Exit;
    end;
    if Trim(ASoundID) = '0' then
    begin
      Inc(FFileHeader.ListCount);
      Inc(FFileHeader.FieldCount);
    end else begin
      Inc(FFileHeader.ListCount);
    end;
    SetLength(FListItem, FFileHeader.ListCount);
    FListItem[High(FListItem)].SoundID := StrToIntDef(ASoundID,0);
    CopyMemory(@FListItem[High(FListItem)].SoundFile[0], @ASoundFile[1], Length(ASoundFile));
  except
    Result := -1;
  end;
end;

procedure TSoundListEditor.MoveItemUP(ASoundID, ASoundFile: String);
var
  FID       : Integer;
  FTempItem : array [0..0] of TSoundListPart;
begin
  FID := FindItem(ASoundID, ASoundFile);

  FTempItem[0].SoundID   := FListItem[FID].SoundID;
  FTempItem[0].SoundFile := FListItem[FID].SoundFile;

  FListItem[FID].SoundID     := FListItem[FID-1].SoundID;
  FListItem[FID].SoundFile   := FListItem[FID-1].SoundFile;

  FListItem[FID-1].SoundID   := FTempItem[0].SoundID;
  FListItem[FID-1].SoundFile := FTempItem[0].SoundFile;
end;

procedure TSoundListEditor.MoveItemDown(ASoundID, ASoundFile: String);
var
  FID       : Integer;
  FTempItem : array [0..0] of TSoundListPart;
begin
  FID := FindItem(ASoundID, ASoundFile);

  FTempItem[0].SoundID   := FListItem[FID].SoundID;
  FTempItem[0].SoundFile := FListItem[FID].SoundFile;

  FListItem[FID].SoundID     := FListItem[FID+1].SoundID;
  FListItem[FID].SoundFile   := FListItem[FID+1].SoundFile;

  FListItem[FID+1].SoundID   := FTempItem[0].SoundID;
  FListItem[FID+1].SoundFile := FTempItem[0].SoundFile;
end;


///////////////////////////////////////////////

procedure TfrmEditorMain.FormCreate(Sender: TObject);
begin
  FSoundListEditor := TSoundListEditor.Create;
  FBGMListEditor   := TBGMListEditor.Create;
end;

procedure TfrmEditorMain.FormDestroy(Sender: TObject);
begin
  FreeAndNil(FSoundListEditor);
  FreeAndNil(FBGMListEditor);
end;

///////////////////////////////////////////////

procedure TfrmEditorMain.lvBGMListClick(Sender: TObject);
begin
  try
    if not Assigned(lvBGMList.Selected) then Exit;

    maMapName.Text := lvBGMList.Selected.Caption;
    maBGMFile.Text := lvBGMList.Selected.SubItems[0];
    if (Trim(maBGMFile.Text) <> '') or (Trim(maMapName.Text) <> '') then
    begin
      btnDeleteBGMItem.Enabled := True;
      btnUpdateBGMItem.Enabled := True;
    end;
    sptLastInfo.FieldLabel := '';
  except
  end;
end;

procedure TfrmEditorMain.maMapNameChange(Sender: TObject);
begin
  if (Trim(maMapName.Text) <> '') or (Trim(maBGMFile.Text) <> '') then
  begin
    btnAddBGMItem.Enabled    := True;
  end else begin
    btnAddBGMItem.Enabled    := False;
    btnUpdateBGMItem.Enabled := False;
  end;
  sptLastInfo.FieldLabel := '';
end;

// Create New BGM List
procedure TfrmEditorMain.btnNewBGMListClick(Sender: TObject);
begin
  // TODO : add Modify or has old list check  
  lvBGMList.Items.Clear;
  if Assigned(FBGMListEditor) then
  begin
    FreeAndNil(FBGMListEditor);
    FBGMListEditor := TBGMListEditor.Create;
    sptListItemCount.FieldLabel := 'Items in List : ' + IntToStr(lvBGMList.items.count);
    sptLastInfo.FieldLabel := '';
  end;
end;

procedure TfrmEditorMain.FillBGMListView;
var
  I         : Integer;
  FListItem : TListItem;
begin
  if FBGMListEditor.FFileHeader.ListCount > 0 then
  begin
    lvBGMList.Items.Clear;
    for I := 0 to FBGMListEditor.FFileHeader.ListCount - 1 do
    begin
      if (Trim(FBGMListEditor.FListItem[I].MapName)  <> '') and
         (Trim(FBGMListEditor.FListItem[I].FileName) <> '') then
      begin
        FListItem         := lvBGMList.Items.Add;
        FListItem.Caption := Trim(FBGMListEditor.FListItem[I].MapName);
        FListItem.SubItems.Add(Trim(FBGMListEditor.FListItem[I].FileName));
      end;
    end;
  end;
  sptListItemCount.FieldLabel := 'Items in List : ' + IntToStr(FBGMListEditor.FFileHeader.ListCount);
  sptSectiontemCount.FieldLabel := 'Section info : -';
  sptLastInfo.FieldLabel := ' - Load BGM File Done : ' + FBGMFileName;
end;

// Load BGM List
procedure TfrmEditorMain.btnLoadBGMListClick(Sender: TObject);
begin
  if odBGMList.Execute then
  begin
    lvBGMList.Clear;
    maMapName.Text := '';
    maBGMFile.Text := '';
    // Read BGM List File --------------------------------
    if FBGMListEditor.LoadListFile(odBGMList.FileName) then
    begin
      FillBGMListView;
    end;
  end;
end;

// Save BGM List
procedure TfrmEditorMain.btnSaveBGMListClick(Sender: TObject);
begin
  if sdBGMList.Execute then
  begin
    if FBGMListEditor.SaveListFile(sdBGMList.FileName) then
    begin
      btnSaveBGMList.Enabled := False;
      sptLastInfo.FieldLabel := ' - Saved Done : ' + FBGMListEditor.FFileName;
    end;
  end;

end;

// Update BGM List
procedure TfrmEditorMain.btnUpdateBGMItemClick(Sender: TObject);
begin
  try
    if not Assigned(lvBGMList.Selected) then Exit;

    case FBGMListEditor.UpdateItem(lvBGMList.Selected.Caption, lvBGMList.Selected.SubItems[0], Trim(maMapName.Text), Trim(maBGMFile.Text)) of
      0: begin
        lvBGMList.Selected.Caption     := Trim(maMapName.Text);
        lvBGMList.Selected.SubItems[0] := Trim(maBGMFile.Text);
        btnSaveBGMList.Enabled         := True;
      end;
      1: Application.MessageBox('Item is allready in list.', 'Mir3 Music List Editor', MB_OK + MB_ICONWARNING);
    end;
    sptLastInfo.FieldLabel := '';
  except
  end;
end;

// Add BGM Item
procedure TfrmEditorMain.btnAddBGMItemClick(Sender: TObject);
var
  FListItem : TListItem;
begin
  try
    case FBGMListEditor.AddItem(Trim(maMapName.Text), Trim(maBGMFile.Text)) of
      0: begin
        FListItem         := lvBGMList.Items.Add;
        FListItem.Caption := Trim(maMapName.Text);
        FListItem.SubItems.Add(Trim(maBGMFile.Text));
        btnSaveBGMList.Enabled := True;
      end;
      1: Application.MessageBox('Item is allready in list.', 'Mir3 Music List Editor', MB_OK + MB_ICONWARNING);
    end;
    sptListItemCount.FieldLabel := 'Items in List : ' + IntToStr(FBGMListEditor.FFileHeader.ListCount);
  except
  end;
end;

// Delete BGM Item
procedure TfrmEditorMain.btnDeleteBGMItemClick(Sender: TObject);
begin
  try
    if FBGMListEditor.DeleteItem(lvBGMList.Selected.Caption, lvBGMList.Selected.SubItems[0]) then
    begin
      lvBGMList.Selected.Delete;
      lvBGMList.Repaint;
      btnDeleteBGMItem.Enabled := False;
      btnUpdateBGMItem.Enabled := False;
      maMapName.Text := '';
      maBGMFile.Text := '';
    end;
    sptListItemCount.FieldLabel := 'Items in List : ' + IntToStr(FBGMListEditor.FFileHeader.ListCount);
  except
  end;
end;

procedure TfrmEditorMain.btnBGMMoveItemUpClick(Sender: TObject);
var
  FTempMap  : String;
  FTempFile : String;
begin
  // Up Item :: BGM List Editor
  if Assigned(lvBGMList.Selected) and (lvBGMList.Selected.Index > 0) then
  begin
    FBGMListEditor.MoveItemUP(lvBGMList.Selected.Caption, lvBGMList.Selected.SubItems[0]);
    FTempMap  := lvBGMList.Selected.Caption;
    FTempFile := lvBGMList.Selected.SubItems[0];
    lvBGMList.Selected.Caption     := lvBGMList.Items[lvBGMList.Selected.Index-1].Caption;
    lvBGMList.Selected.SubItems[0] := lvBGMList.Items[lvBGMList.Selected.Index-1].SubItems[0];
    lvBGMList.Items[lvBGMList.Selected.Index-1].Caption     := FTempMap;
    lvBGMList.Items[lvBGMList.Selected.Index-1].SubItems[0] := FTempFile;
    lvBGMList.Selected := lvBGMList.Items[lvBGMList.Selected.Index-1];
    lvBGMList.SetFocus;
    btnSaveBGMList.Enabled := True;
  end else lvBGMList.SetFocus;
end;

procedure TfrmEditorMain.btnBGMMoveItemDownClick(Sender: TObject);
var
  FTempMap  : String;
  FTempFile : String;
begin
  // Down Item :: BGM List Editor
  if Assigned(lvBGMList.Selected) and (lvBGMList.Selected.Index < lvBGMList.Items.Count-1) then
  begin
    FBGMListEditor.MoveItemDown(lvBGMList.Selected.Caption, lvBGMList.Selected.SubItems[0]);
    FTempMap  := lvBGMList.Selected.Caption;
    FTempFile := lvBGMList.Selected.SubItems[0];
    lvBGMList.Selected.Caption     := lvBGMList.Items[lvBGMList.Selected.Index+1].Caption;
    lvBGMList.Selected.SubItems[0] := lvBGMList.Items[lvBGMList.Selected.Index+1].SubItems[0];
    lvBGMList.Items[lvBGMList.Selected.Index+1].Caption     := FTempMap;
    lvBGMList.Items[lvBGMList.Selected.Index+1].SubItems[0] := FTempFile;
    lvBGMList.Selected := lvBGMList.Items[lvBGMList.Selected.Index+1];
    lvBGMList.SetFocus;
    btnSaveBGMList.Enabled := True;
  end else lvBGMList.SetFocus;
end;



//////
///


procedure TfrmEditorMain.lvSoundListClick(Sender: TObject);
begin
  try
    if not Assigned(lvSoundList.Selected) then Exit;
    
    maSoundID.Text   := lvSoundList.Selected.Caption;
    maSoundFile.Text := lvSoundList.Selected.SubItems[0];
    if (Trim(maSoundFile.Text) <> '') or (Trim(maSoundID.Text) <> '') then
    begin
      btnDeleteSoundItem.Enabled := True;
      btnUpdateSoundItem.Enabled := True;
    end;
    sptLastInfo.FieldLabel := '';
  except
  end;
end;

procedure TfrmEditorMain.maSoundIDChange(Sender: TObject);
begin
  if (Trim(maSoundFile.Text) <> '') or (Trim(maSoundID.Text) <> '') then
  begin
    btnAddSoundItem.Enabled    := True;
  end else begin
    btnAddSoundItem.Enabled    := False;
    btnUpdateSoundItem.Enabled := False;
  end;
  sptLastInfo.FieldLabel := '';
end;

procedure TfrmEditorMain.RzPageControl1Change(Sender: TObject);
begin
  case RzPageControl1.ActivePageIndex of
    0 : begin
      sptListItemCount.FieldLabel   := 'Items in List : ' + IntToStr(FBGMListEditor.FFileHeader.ListCount);
      sptSectiontemCount.FieldLabel := 'Section info : -';
    end;
    1 : begin
      sptListItemCount.FieldLabel   := 'Items in List : ' + IntToStr(FSoundListEditor.FFileHeader.ListCount);
      sptSectiontemCount.FieldLabel := 'Section info : '  + IntToStr(FSoundListEditor.FFileHeader.FieldCount);
    end;
    2 : begin
     sptListItemCount.FieldLabel   := 'Items in List : - ';
     sptSectiontemCount.FieldLabel := 'Section info : -';
    end;
  end;
end;

// New Sound List
procedure TfrmEditorMain.btnNewSoundListClick(Sender: TObject);
begin
  // TODO : add Modify or has old list check  
  lvSoundList.Items.Clear;
  if Assigned(FSoundListEditor) then
  begin
    FreeAndNil(FSoundListEditor);
    FSoundListEditor := TSoundListEditor.Create;
    sptListItemCount.FieldLabel := 'Items in List : ' + IntToStr(lvSoundList.items.count);
    sptSectiontemCount.FieldLabel := 'Section info : '  + IntToStr(lvSoundList.items.count);
    sptLastInfo.FieldLabel := '';
  end;
end;

procedure TfrmEditorMain.FillSoundListView;
var
  I         : Integer;
  FListItem : TListItem;
begin
  if FSoundListEditor.FFileHeader.ListCount > 0 then
  begin
    lvSoundList.Items.Clear;
    for I := 0 to FSoundListEditor.FFileHeader.ListCount - 1 do
    begin
      if (Trim(FSoundListEditor.FListItem[I].SoundFile) <> '') then
      begin
        if (FSoundListEditor.FListItem[I].SoundID = 0) then
        begin
          if (cbShowSectionHeader.Checked) then
          begin
            FListItem         := lvSoundList.Items.Add;
            FListItem.Caption := IntToStr(FSoundListEditor.FListItem[I].SoundID);
            FListItem.SubItems.Add(Trim(FSoundListEditor.FListItem[I].SoundFile));
          end;
        end else begin
          FListItem         := lvSoundList.Items.Add;
          FListItem.Caption := IntToStr(FSoundListEditor.FListItem[I].SoundID);
          FListItem.SubItems.Add(Trim(FSoundListEditor.FListItem[I].SoundFile));
        end;
      end;
    end;
  end;

  btnSaveSoundList.Enabled := False;
  sptListItemCount.FieldLabel := 'Items in List : ' + IntToStr(FSoundListEditor.FFileHeader.ListCount);
  sptSectiontemCount.FieldLabel := 'Section info : '  + IntToStr(FSoundListEditor.FFileHeader.FieldCount);
  sptLastInfo.FieldLabel      := ' - Load Sound File Done : ' + FSoundListEditor.FFileName;
end;

// Load Sound List
procedure TfrmEditorMain.btnLoadSoundListClick(Sender: TObject);
begin
  if odSoundList.Execute then
  begin
    lvSoundList.Clear;
    maSoundID.Text   := '';
    maSoundFile.Text := '';
    // Read Sound List File --------------------------------
    if FSoundListEditor.LoadListFile(odSoundList.FileName) then
    begin
      FillSoundListView;
    end;
  end;
end;

// Save Sound List
procedure TfrmEditorMain.btnSaveSoundListClick(Sender: TObject);
begin
  if sdSoundList.Execute then
  begin
    if FSoundListEditor.SaveListFile(sdSoundList.FileName) then
    begin
      btnSaveSoundList.Enabled := False;
      sptLastInfo.FieldLabel   := ' - Saved Done : ' + FSoundListEditor.FFileName;
    end;
  end;
end;

procedure TfrmEditorMain.btnUpdateSoundItemClick(Sender: TObject);
begin
  try
    if not Assigned(lvSoundList.Selected) then Exit;
    if StrToIntDef(Trim(maSoundID.Text),0) > 65534 then
    begin
      Application.MessageBox('You can only use Sound ID''s < 65534',
        'Mir3 Music List Editor', MB_OK + MB_ICONSTOP);
      Exit;
    end;

    case FSoundListEditor.UpdateItem(lvSoundList.Selected.Caption, lvSoundList.Selected.SubItems[0], Trim(maSoundID.Text), Trim(maSoundFile.Text)) of
      0: begin
        lvSoundList.Selected.Caption     := Trim(maSoundID.Text);
        lvSoundList.Selected.SubItems[0] := Trim(maSoundFile.Text);
        btnSaveSoundList.Enabled         := True;
      end;
      1: Application.MessageBox('Item is allready in list.', 'Mir3 Music List Editor', MB_OK + MB_ICONWARNING);
    end;
    sptLastInfo.FieldLabel := '';
  except
  end;
end;

procedure TfrmEditorMain.btnAddSoundItemClick(Sender: TObject);
var
  FListItem : TListItem;
begin
  try
    if StrToIntDef(Trim(maSoundID.Text),0) > 65534 then
    begin
      Application.MessageBox('You can only use Sound ID''s < 65534',
        'Mir3 Music List Editor', MB_OK + MB_ICONSTOP);
      Exit;
    end;
    case FSoundListEditor.AddItem(Trim(maSoundID.Text), Trim(maSoundFile.Text)) of
      0: begin
        FListItem         := lvSoundList.Items.Add;
        FListItem.Caption := Trim(maSoundID.Text);
        FListItem.SubItems.Add(Trim(maSoundFile.Text));
        btnSaveSoundList.Enabled := True;
      end;
      1: Application.MessageBox('Item is allready in list.', 'Mir3 Music List Editor', MB_OK + MB_ICONWARNING);
    end;
    sptListItemCount.FieldLabel := 'Items in List : ' + IntToStr(FSoundListEditor.FFileHeader.ListCount);
    sptSectiontemCount.FieldLabel := 'Section info : '  + IntToStr(FSoundListEditor.FFileHeader.FieldCount);
  except
  end;
end;

procedure TfrmEditorMain.btnDeleteSoundItemClick(Sender: TObject);
begin
  try
    if FSoundListEditor.DeleteItem(lvSoundList.Selected.Caption, lvSoundList.Selected.SubItems[0]) then
    begin
      lvSoundList.Selected.Delete;
      lvSoundList.Repaint;
      btnDeleteSoundItem.Enabled := False;
      btnUpdateSoundItem.Enabled := False;
      btnSaveSoundList.Enabled := True;
      maSoundID.Text   := '';
      maSoundFile.Text := '';
    end;
    sptListItemCount.FieldLabel := 'Items in List : ' + IntToStr(FSoundListEditor.FFileHeader.ListCount);
  except
  end;
end;

procedure TfrmEditorMain.btnMoveItemUpClick(Sender: TObject);
var
  FTempID   : String;
  FTempFile : String;
begin
  // Up Item :: Sound List Editor
  if Assigned(lvSoundList.Selected) and (lvSoundList.Selected.Index > 0) then
  begin
    FSoundListEditor.MoveItemUP(lvSoundList.Selected.Caption, lvSoundList.Selected.SubItems[0]);
    FTempID   := lvSoundList.Selected.Caption;
    FTempFile := lvSoundList.Selected.SubItems[0];
    lvSoundList.Selected.Caption     := lvSoundList.Items[lvSoundList.Selected.Index-1].Caption;
    lvSoundList.Selected.SubItems[0] := lvSoundList.Items[lvSoundList.Selected.Index-1].SubItems[0];
    lvSoundList.Items[lvSoundList.Selected.Index-1].Caption     := FTempID;
    lvSoundList.Items[lvSoundList.Selected.Index-1].SubItems[0] := FTempFile;
    lvSoundList.Selected := lvSoundList.Items[lvSoundList.Selected.Index-1];
    lvSoundList.SetFocus;
    btnSaveSoundList.Enabled := True;
  end else lvSoundList.SetFocus;
end;

procedure TfrmEditorMain.btnMoveItemDownClick(Sender: TObject);
var
  FTempID   : String;
  FTempFile : String;
begin
  // Down Item :: Sound List Editor
  if Assigned(lvSoundList.Selected) and (lvSoundList.Selected.Index < lvSoundList.Items.Count-1) then
  begin
    FSoundListEditor.MoveItemDown(lvSoundList.Selected.Caption, lvSoundList.Selected.SubItems[0]);
    FTempID   := lvSoundList.Selected.Caption;
    FTempFile := lvSoundList.Selected.SubItems[0];
    lvSoundList.Selected.Caption     := lvSoundList.Items[lvSoundList.Selected.Index+1].Caption;
    lvSoundList.Selected.SubItems[0] := lvSoundList.Items[lvSoundList.Selected.Index+1].SubItems[0];
    lvSoundList.Items[lvSoundList.Selected.Index+1].Caption     := FTempID;
    lvSoundList.Items[lvSoundList.Selected.Index+1].SubItems[0] := FTempFile;
    lvSoundList.Selected := lvSoundList.Items[lvSoundList.Selected.Index+1];
    lvSoundList.SetFocus;
    btnSaveSoundList.Enabled := True;
  end else lvSoundList.SetFocus;
end;

procedure TfrmEditorMain.cbShowSectionHeaderClick(Sender: TObject);
begin
  FillSoundListView;
end;


end.
