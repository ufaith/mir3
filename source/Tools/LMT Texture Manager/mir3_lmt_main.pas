(******************************************************************************
 *   LomCN Mir3 LMT Texture Manager 2013                                      *
 *                                                                            *
 *   Web       : http://www.lomcn.org                                         *
 *   Version   : 0.0.0.1                                                      *
 *                                                                            *
 *   - File Info -                                                            *
 *                                                                            *
 *   It holds the Texture Manager main information                            *
 *                                                                            *
 ******************************************************************************
 * Change History                                                             *
 *                                                                            *
 *  - 0.0.0.1 [2013-04-18] Coly : first init                                  *
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
 *                                                                            *
 *  - TODO : -all -add other function like : Export / Import LMT / WIL        *
 *  - TODO : -all -add other function like : Move / Delete  etc.              *
 *                                                                            *
 ******************************************************************************)
unit mir3_lmt_main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, mir3_lmt_format,
  Dialogs, RzButton, RzStatus, ExtCtrls, ActnList, ToolWin, ActnMan, ActnCtrls,
  ActnMenus, ActnColorMaps, XPStyleActnCtrls, StdCtrls, RzLstBox, RzPanel, PsAPI,
  RzSplit, mir3_lmt_new_library, mir3_lmt_import_wil, RzLabel, Mask, RzEdit,
  RzShellDialogs;


type
  TfmtTextureManagerMain = class(TForm)
    OpenDialog1: TOpenDialog;
    odOpenLMTFile: TOpenDialog;
    RzSplitter1: TRzSplitter;
    btnChangeDir: TRzButton;
    RzPanel2: TRzPanel;
    plInfoBackground: TRzPanel;
    RzPanel4: TRzPanel;
    Image2: TImage;
    plFileInfo: TRzPanel;
    ActionManager1: TActionManager;
    XPColorMap1: TXPColorMap;
    ActionMainMenuBar1: TActionMainMenuBar;
    acExit: TAction;
    acNewLibrary: TAction;
    acCloseLibrary: TAction;
    acSaveRebuildLibrary: TAction;
    acOpenLibrary: TAction;
    RzPanel5: TRzPanel;
    lbLibraryList: TRzListBox;
    RzPanel7: TRzPanel;
    RzPanel8: TRzPanel;
    sbBackground: TScrollBox;
    acBackgroundColor: TAction;
    ColorDialog1: TColorDialog;
    plBackgroundHelper: TPanel;
    imgTextureDevice: TImage;
    acShowImageBevel: TAction;
    plImageInfo: TRzPanel;
    plStatus: TRzPanel;
    RzPanel3: TRzPanel;
    RzPanel1: TRzPanel;
    laZoomFactor: TRzLabel;
    btnZoomIn: TRzBitBtn;
    btnZoomOut: TRzBitBtn;
    btnPrivRealImage: TRzBitBtn;
    btnNextRealImage: TRzBitBtn;
    btnPrivOneStep: TRzBitBtn;
    btnNextOneStep: TRzBitBtn;
    RzPanel6: TRzPanel;
    meIndexBox: TRzMaskEdit;
    acStartWith0: TAction;
    laVersionInfo: TRzVersionInfoStatus;
    RzVersionInfo1: TRzVersionInfo;
    acImportFromWIL: TAction;
    sfdFolderDialog: TRzSelectFolderDialog;
    procedure FormDestroy(Sender: TObject);
    procedure acExitExecute(Sender: TObject);
    procedure acNewLibraryExecute(Sender: TObject);
    procedure acCloseLibraryExecute(Sender: TObject);
    procedure acSaveRebuildLibraryExecute(Sender: TObject);
    procedure acOpenLibraryExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure acBackgroundColorExecute(Sender: TObject);
    procedure acShowImageBevelExecute(Sender: TObject);
    procedure lbLibraryListDblClick(Sender: TObject);
    procedure btnNextRealImageClick(Sender: TObject);
    procedure btnPrivRealImageClick(Sender: TObject);
    procedure btnPrivOneStepClick(Sender: TObject);
    procedure btnNextOneStepClick(Sender: TObject);
    procedure acStartWith0Execute(Sender: TObject);
    procedure meIndexBoxKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnZoomOutClick(Sender: TObject);
    procedure btnZoomInClick(Sender: TObject);
    procedure acImportFromWILExecute(Sender: TObject);
    procedure btnChangeDirClick(Sender: TObject);
  private
    FBitmap     : TBitmap;
    FZoomFactor : Integer;
    FLastZoom   : Integer; // Last working Zoom Factor
  private
    procedure ListFileDir(Path: string; FileList: TStrings);
    function ScalePercentBmp(var ABitmap: TBitmap; APercent: Integer): Boolean;
    procedure SetBitmap;
    procedure SetButtonState;
    function GetNextZoomFaktor(AZoomOut: Boolean): Integer;
  public
    FLMTLibrary   : TMIR3_LMTFile;
    FNewFileName  : String;
    FFileIndex    : Integer;
    FFileIndexMax : Integer;
    FFileDirectory: String;
  end;

var
  fmtTextureManagerMain : TfmtTextureManagerMain;

implementation

{$R *.dfm}

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

procedure TfmtTextureManagerMain.ListFileDir(Path: string; FileList: TStrings);
var
  SR: TSearchRec;
begin
  FileList.Clear;
  if FindFirst(Path + '*.*', faAnyFile, SR) = 0 then
  begin
    repeat
      if (SR.Attr <> faDirectory) and (UpperCase(ExtractFileExt(SR.Name)) = '.LMT') then
      begin
        FileList.Add(SR.Name);
      end;
    until FindNext(SR) <> 0;
    FindClose(SR);
  end;
end;

function TfmtTextureManagerMain.ScalePercentBmp(var ABitmap: TBitmap; APercent: Integer): Boolean;
var
  FTempBmp : TBitmap;
  FRect    : TRect;
  h, w     : Integer;
begin
  Result := False;
  try
    FTempBmp := TBitmap.Create;
    try
      h := Round(ABitmap.Height * (APercent / 100));
      w := Round(ABitmap.Width  * (APercent / 100));
      if (w < 4400) and (h < 4400) then
      begin
        FLastZoom       := APercent;
        FTempBmp.Width  := w;
        FTempBmp.Height := h;
        FRect := Rect(0, 0, w, h);
        FTempBmp.Canvas.StretchDraw(FRect, ABitmap);
        ABitmap.Assign(FTempBmp);
      end else begin
        h := Round(ABitmap.Height * (FLastZoom / 100));
        w := Round(ABitmap.Width  * (FLastZoom / 100));
        FTempBmp.Width  := w;
        FTempBmp.Height := h;
        FRect := Rect(0, 0, w, h);
        FTempBmp.Canvas.StretchDraw(FRect, ABitmap);
        ABitmap.Assign(FTempBmp);
      end;
      plStatus.Caption := ' Status : Zoom Size ' + IntToStr(w) + 'x' + IntToStr(h);
    finally
      FTempBmp.FreeImage;
      FreeAndNil(FTempBmp);
    end;
    Result := True;
  except
    Result := False;
  end;
end;

procedure TfmtTextureManagerMain.SetBitmap;
begin
  if FLMTLibrary.GetBMPFromIndex(FFileIndex, FBitmap) then
  begin
    ScalePercentBmp(FBitmap, FZoomFactor);
    plBackgroundHelper.Width  := FBitmap.Width +3;
    plBackgroundHelper.Height := FBitmap.Height+3;
    imgTextureDevice.Picture.Assign(FBitmap);
    meIndexBox.Text     := IntToStr(FFileIndex);
    plImageInfo.Caption := ' Image Info : Dimension ' + IntToStr(FLMTLibrary.ImageHeader.imgWidth) +'x'+ IntToStr(FLMTLibrary.ImageHeader.imgHeight) + ', Offset X' +
                           IntToStr(FLMTLibrary.ImageHeader.imgOffset_X) +' Y'+ IntToStr(FLMTLibrary.ImageHeader.imgOffset_Y) + ', Shadow Type ' + IntToStr(FLMTLibrary.ImageHeader.imgShadow_type) +
                           ', Shadow Offset X ' + IntToStr(FLMTLibrary.ImageHeader.imgShadow_Offset_X) +' Y '+ IntToStr(FLMTLibrary.ImageHeader.imgShadow_Offset_Y) + ', Location ' + IntToStr(FLMTLibrary.GetIndexPosition(FFileIndex));

  end else begin
    ScalePercentBmp(FBitmap, FZoomFactor);
    plBackgroundHelper.Width  := FBitmap.Width +3;
    plBackgroundHelper.Height := FBitmap.Height+3;
    imgTextureDevice.Picture.Assign(FBitmap);
    meIndexBox.Text     := IntToStr(FFileIndex);
    plImageInfo.Caption := ' Image Info : No Image';
    plStatus.Caption    := ' Status : - ';
  end;
end;

procedure TfmtTextureManagerMain.SetButtonState;
begin
  if Assigned(FLMTLibrary) and not (FLMTLibrary.LibOpenState) then
  begin
    btnZoomIn.Enabled        := False;
    btnZoomOut.Enabled       := False;
    btnPrivRealImage.Enabled := False;
    btnPrivOneStep.Enabled   := False;
    btnNextRealImage.Enabled := False;
    btnNextOneStep.Enabled   := False;
    meIndexBox.Enabled       := False;
  end else begin
    if not Assigned(FLMTLibrary) then
    begin
      btnZoomIn.Enabled        := False;
      btnZoomOut.Enabled       := False;
      btnPrivRealImage.Enabled := False;
      btnPrivOneStep.Enabled   := False;
      btnNextRealImage.Enabled := False;
      btnNextOneStep.Enabled   := False;
      meIndexBox.Enabled       := False;
    end else if FLMTLibrary.LibOpenState then
             begin
               //if True then

               btnZoomIn.Enabled  := True;
               btnZoomOut.Enabled := True;
               meIndexBox.Enabled := True;
               case FFileIndex of
                 0: begin
                   btnPrivRealImage.Enabled := False;
                   btnPrivOneStep.Enabled   := False;
                   btnNextRealImage.Enabled := True;
                   btnNextOneStep.Enabled   := True;
                 end;
                 else begin
                   if FFileIndex = FFileIndexMax-1 then
                   begin
                     btnPrivRealImage.Enabled := True;
                     btnPrivOneStep.Enabled   := True;
                     btnNextRealImage.Enabled := False;
                     btnNextOneStep.Enabled   := False;
                   end else begin
                     if FFileIndex >= FLMTLibrary.GetLastImage then
                     begin
                       btnPrivRealImage.Enabled := True;
                       btnPrivOneStep.Enabled   := True;
                       btnNextRealImage.Enabled := False;
                       btnNextOneStep.Enabled   := True;
                     end else begin
                       btnPrivRealImage.Enabled := True;
                       btnPrivOneStep.Enabled   := True;
                       btnNextRealImage.Enabled := True;
                       btnNextOneStep.Enabled   := True;
                     end;
                   end;
                   if FFileIndex <= FLMTLibrary.GetFirstImage then
                     btnPrivRealImage.Enabled := False;
                 end;
               end;
               if (FLMTLibrary.GetTotalImage = 0) then
               begin
                 btnZoomIn.Enabled        := False;
                 btnZoomOut.Enabled       := False;
                 btnPrivRealImage.Enabled := False;
                 btnPrivOneStep.Enabled   := False;
                 btnNextRealImage.Enabled := False;
                 btnNextOneStep.Enabled   := False;
                 meIndexBox.Enabled       := True;
               end;
             end;
  end;
end;

function TfmtTextureManagerMain.GetNextZoomFaktor(AZoomOut: Boolean): Integer;
begin
  case AZoomOut of
    True  : begin
      case FZoomFactor of
         0..19   : Result := FZoomFactor;
        20..190  : Result := FZoomFactor + 10;
       200..380  : Result := FZoomFactor + 20;
       400..560  : Result := FZoomFactor + 40;
       600..840  : Result := FZoomFactor + 60;
       900..1220 : Result := FZoomFactor + 80;
      1300..1500 : Result := FZoomFactor + 100;
      else Result := FZoomFactor;
      end;
    end;
    False : begin
      case FZoomFactor of
         0..20   : Result := FZoomFactor;
        30..190  : Result := FZoomFactor - 10;
       200..380  : Result := FZoomFactor - 20;
       400..560  : Result := FZoomFactor - 40;
       600..840  : Result := FZoomFactor - 60;
       900..1220 : Result := FZoomFactor - 80;
      1300..1600 : Result := FZoomFactor - 100;
      else Result := FZoomFactor-10;
      end;
    end;
  end;
  laZoomFactor.Caption := IntToStr(Result) + ' %';
end;

{$REGION ' - Menue "File"  '}
  procedure TfmtTextureManagerMain.acNewLibraryExecute(Sender: TObject);
  var
    I : Integer;
    FNewLibrary : TfrmNewLibrary;
  begin
    //Create a new LMT library
    if Assigned(FLMTLibrary) then
    begin
      acCloseLibraryExecute(self);
      FreeAndNil(FLMTLibrary);
    end;
    FLMTLibrary := TMIR3_LMTFile.Create;
    FNewLibrary := TfrmNewLibrary.Create(Application);
    FNewLibrary.ShowModal;
    if Trim(FNewFileName) > '' then
    begin
      FLMTLibrary.CreateLMTFile(FFileDirectory + FNewFileName,1);
      if DirectoryExists(FFileDirectory) then
      begin
        ListFileDir(FFileDirectory, lbLibraryList.Items);
      end;
    end;
    SetButtonState;
  end;

  procedure TfmtTextureManagerMain.acOpenLibraryExecute(Sender: TObject);
  begin
    // Opens LMT library of different paths.
    acCloseLibraryExecute(Self);
    if odOpenLMTFile.Execute then
    begin
      if Assigned(FBitmap) then
        FreeAndNil(FBitmap);
      if Assigned(FLMTLibrary) then
        FreeAndNil(FLMTLibrary);
      FBitmap     := TBitmap.Create;
      FLMTLibrary := TMIR3_LMTFile.Create;
      FZoomFactor          := 100;
      laZoomFactor.Caption := IntToStr(FZoomFactor) + ' %';
      FNewFileName         := odOpenLMTFile.FileName;
      FLMTLibrary.LoadFromFile(FNewFileName);
      if acStartWith0.Checked then
      begin
        plFileInfo.Caption := ' File Info : ' + lbLibraryList.SelectedItem + ', Mir 3, Lib Type 4, Total Index ' + IntToStr(FLMTLibrary.GetTotalIndex) +
                              ', Total Image ' + IntToStr(FLMTLibrary.GetTotalImage) + ', First Image ' + IntToStr(FLMTLibrary.GetFirstImage) + ', Last Image ' + IntToStr(FLMTLibrary.GetLastImage);
      end else begin
        plFileInfo.Caption := ' File Info : ' + lbLibraryList.SelectedItem + ', Mir 3, Lib Type 4, Total Index ' + IntToStr(FLMTLibrary.GetTotalIndex) +
                              ', Total Image ' + IntToStr(FLMTLibrary.GetTotalImage) + ', First Image ' + IntToStr(FLMTLibrary.GetFirstImage+1) + ', Last Image ' + IntToStr(FLMTLibrary.GetLastImage+1);
      end;
      FFileIndexMax := FLMTLibrary.GetTotalIndex;
      FFileIndex    := 0;
      SetButtonState;
      SetBitmap;
    end;
  end;
  
  procedure TfmtTextureManagerMain.acSaveRebuildLibraryExecute(Sender: TObject);
  begin
    // Save or and Rebuild the last useded LMT library
    if Assigned(FLMTLibrary) then
    begin
      // TODO : Close File then Open it in MemoryStream then Save / Rebuild
      // or better Ignore working with MMF (mean use only Memory stream in editor)

      //FLMTLibrary.SaveLMTFile(FFileDirectory+FNewFileName);

      plStatus.Caption    := ' Status : File ' + FNewFileName + ' saved..';
    end;
  end;

  procedure TfmtTextureManagerMain.acCloseLibraryExecute(Sender: TObject);
  begin
    //Close the last used LMT library
    if Assigned(FLMTLibrary) then
    begin
      imgTextureDevice.Picture.Bitmap := nil;
      btnZoomIn.Enabled        := False;
      btnZoomOut.Enabled       := False;
      btnPrivRealImage.Enabled := False;
      btnPrivOneStep.Enabled   := False;
      btnNextRealImage.Enabled := False;
      btnNextOneStep.Enabled   := False;
      plFileInfo.Caption  := ' File Info : No Library';
      plImageInfo.Caption := ' Image Info : No Image';
      plStatus.Caption    := ' Status : waiting';
      FLMTLibrary.Close;
      SetButtonState;
    end;
  end;
  
  procedure TfmtTextureManagerMain.acExitExecute(Sender: TObject);
  begin
    //Close Texture Manager
    Close;
  end;

{$ENDREGION}

{$REGION ' - Menue "Image" '}
  procedure TfmtTextureManagerMain.acBackgroundColorExecute(Sender: TObject);
  begin
    //Change Background Color
    if ColorDialog1.Execute then
    begin
      sbBackground.Color       := ColorDialog1.Color;
      plBackgroundHelper.Color := ColorDialog1.Color;
      if Assigned(FLMTLibrary) then
        FLMTLibrary.BackgroundColor := ColorDialog1.Color;
    end;
  end;
  
  procedure TfmtTextureManagerMain.acShowImageBevelExecute(Sender: TObject);
  begin
    //Show/Hide Image Bevel
    if plBackgroundHelper.BevelOuter = bvLowered then
      plBackgroundHelper.BevelOuter := bvNone
    else plBackgroundHelper.BevelOuter := bvLowered;
  end;

  procedure TfmtTextureManagerMain.acStartWith0Execute(Sender: TObject);
  begin
    if acStartWith0.Checked then
    begin
      acStartWith0.Checked := False;
    end else begin
      acStartWith0.Checked := True;
    end;
  end;

{$ENDREGION}

procedure TfmtTextureManagerMain.acImportFromWILExecute(Sender: TObject);
var
  FImportLibrary : TfrmImportWIL;
begin
  // Import from WIL / WIX
  acCloseLibraryExecute(self);
  FImportLibrary := TfrmImportWIL.Create(Application);
  FImportLibrary.ShowModal;
  if DirectoryExists(FFileDirectory) then
  begin
    ListFileDir(FFileDirectory, lbLibraryList.Items);
  end;
end;

procedure TfmtTextureManagerMain.FormCreate(Sender: TObject);
begin
  FZoomFactor := 100;
  laZoomFactor.Caption := IntToStr(FZoomFactor) + ' %';
  FFileDirectory       := ExtractFilePath(ParamStr(0))+ 'data\';
  if DirectoryExists(FFileDirectory) then
  begin
    ListFileDir(FFileDirectory, lbLibraryList.Items);
  end;
  SetButtonState;
end;

procedure TfmtTextureManagerMain.FormDestroy(Sender: TObject);
begin
  if Assigned(FBitmap) then
    FreeAndNil(FBitmap);
  if Assigned(FLMTLibrary) then
    FreeAndNil(FLMTLibrary);
end;

procedure TfmtTextureManagerMain.lbLibraryListDblClick(Sender: TObject);
begin
  // DBClick to Open Selected File
  if Assigned(FBitmap) then
    FreeAndNil(FBitmap);
  if Assigned(FLMTLibrary) then
    FreeAndNil(FLMTLibrary);
  FBitmap     := TBitmap.Create;
  FLMTLibrary := TMIR3_LMTFile.Create;
  FZoomFactor          := 100;
  laZoomFactor.Caption := IntToStr(FZoomFactor) + ' %';
  FNewFileName         := lbLibraryList.SelectedItem;
  FLMTLibrary.LoadFromFile(FFileDirectory+lbLibraryList.SelectedItem);
  if acStartWith0.Checked then
  begin
    plFileInfo.Caption := ' File Info : ' + lbLibraryList.SelectedItem + ', Mir 3, Lib Type 4, Total Index ' + IntToStr(FLMTLibrary.GetTotalIndex) +
                          ', Total Image ' + IntToStr(FLMTLibrary.GetTotalImage) + ', First Image ' + IntToStr(FLMTLibrary.GetFirstImage) + ', Last Image ' + IntToStr(FLMTLibrary.GetLastImage);
  end else begin
    plFileInfo.Caption := ' File Info : ' + lbLibraryList.SelectedItem + ', Mir 3, Lib Type 4, Total Index ' + IntToStr(FLMTLibrary.GetTotalIndex) +
                          ', Total Image ' + IntToStr(FLMTLibrary.GetTotalImage) + ', First Image ' + IntToStr(FLMTLibrary.GetFirstImage+1) + ', Last Image ' + IntToStr(FLMTLibrary.GetLastImage+1);
  end;
  FFileIndexMax := FLMTLibrary.GetTotalIndex;
  FFileIndex    := 0;
  SetButtonState;
  SetBitmap;
end;

procedure TfmtTextureManagerMain.meIndexBoxKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  Mgs: TMsg;
begin
  if (Char(Key) in [#13]) then
  begin
    // Change Index in Indexbox
    if (StrToIntDef(Trim(meIndexBox.Text), 0) > 0)               and
       (StrToIntDef(Trim(meIndexBox.Text), 0) < FFileIndexMax-1) then
    begin
      FFileIndex := StrToIntDef(Trim(meIndexBox.Text), 0);
      SetBitmap;
      SetButtonState;
    end else if Trim(meIndexBox.Text) = '' then
             begin
               meIndexBox.Text := IntToStr(FFileIndex);
               SetButtonState;
             end else if (StrToIntDef(Trim(meIndexBox.Text), 0) > FFileIndexMax-1) then
                        meIndexBox.Text := IntToStr(FFileIndex);

  end else if not (Char(Key) in [#8, #46, #48..#57,#96..#105]) then
             PeekMessage(Mgs, 0, WM_CHAR, WM_CHAR, PM_REMOVE);
end;

procedure TfmtTextureManagerMain.btnChangeDirClick(Sender: TObject);
begin
  if sfdFolderDialog.Execute then
  begin
    FFileDirectory := sfdFolderDialog.SelectedPathName;
    if DirectoryExists(FFileDirectory) then
    begin
      ListFileDir(FFileDirectory, lbLibraryList.Items);
    end;
  end;
end;

procedure TfmtTextureManagerMain.btnPrivRealImageClick(Sender: TObject);
begin
  //Move to prev. Real Image in Imagelib
  if FFileIndex > 0 then
    Dec(FFileIndex);
  FFileIndex := FLMTLibrary.GetPrivRealImage(FFileIndex);
  SetButtonState;
  SetBitmap;
end;

procedure TfmtTextureManagerMain.btnNextRealImageClick(Sender: TObject);
begin
  //Move to next Real Image in Imagelib
 if FFileIndex < FFileIndexMax-1  then
   Inc(FFileIndex);

  FFileIndex := FLMTLibrary.GetNextRealImage(FFileIndex);
  SetButtonState;
  SetBitmap;
end;

procedure TfmtTextureManagerMain.btnPrivOneStepClick(Sender: TObject);
begin
  //Priv. One Step
  if FFileIndex > 0 then
    Dec(FFileIndex);
  SetButtonState;
  SetBitmap;
end;

procedure TfmtTextureManagerMain.btnNextOneStepClick(Sender: TObject);
begin
  // Next One Step
 if FFileIndex < FFileIndexMax-1  then
   Inc(FFileIndex);
  SetButtonState;
  SetBitmap;
end;

procedure TfmtTextureManagerMain.btnZoomInClick(Sender: TObject);
begin
  // Change ZoomFaktor
  FZoomFactor := GetNextZoomFaktor(False);
  SetBitmap;
end;

procedure TfmtTextureManagerMain.btnZoomOutClick(Sender: TObject);
begin
  // Change ZoomFaktor
  FZoomFactor := GetNextZoomFaktor(True);
  SetBitmap;
end;

end.
