(******************************************************************************
 *   LomCN Mir3 LMT Format Information 2013                                   *
 *                                                                            *
 *   Web       : http://www.lomcn.org                                         *
 *   Version   : 0.0.0.2                                                      *
 *                                                                            *
 *   - File Info -                                                            *
 *                                                                            *
 *   It holds the LMT format information (LMT = LomCN Mir3 Texture)           *
 *                                                                            *
 ******************************************************************************
 * Change History                                                             *
 *                                                                            *
 *  - 0.0.0.1 [2013-04-18] Coly : first init                                  *
 *  - 0.0.0.2 [2013-05-02] 1PKRyan : code clean-up                            *
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
 *  - TODO : -Coly -Full CleanUp (CleanUp and Optimization needed)            *
 *                                                                            *
 ******************************************************************************)

unit mir3_lmt_format;

interface

uses
  { Delphi }
  Windows,
  SysUtils,
  Classes,
  Graphics,
  { Mir3 Game }
  mir3_misc_utils,
  mir3_pngimage;

const
  HEADER_INFORMATION  = 'LMT v1.0-LomCN';

type
  {$REGION ' - LomCN Texture Format Header (For Import LMT) '}
   (*****************************************************************************
    * TLMT_Header LMT (LomCN Mir3 Texture) File Header
    *
    ****************************************************************************)
    PLMT_Header =^TLMT_Header;
    TLMT_Header = packed record  (*29*)
      lhValid            : Byte;                          // 1
      lhLib_Info         : array [0..20] of AnsiChar;     // LMT v1.0-LomCN HEADER_INFORMATION
      lhLib_Type         : Word;                          // 9000=Type4
      lhTotal_Index      : Word;                          // Total Indexes in this File
      lhTotal_Image      : Word;                          // Total Image in this File
      lhSecuredImage     : Byte;                          // 0: No  |  1:Yes (Type 1 Crypt) |  2:Yes (Type 2 Crypt) ...
    end;
    {$EXTERNALSYM TLMT_Header}        //3 223 999 479

   (*****************************************************************************
    * TLMT_Img_Header LMT_IMG (LomCN Texture) Image Header
    *
    ****************************************************************************)
    PLMT_Img_Header = ^TLMT_Img_Header;                   // LMT-File Image Offset Header
    TLMT_Img_Header = packed record (*17*)
      imgWidth           : Word;                          // Image Width
      imgHeight          : Word;                          // Image Height
      imgOffset_X        : Smallint;                      // Image Offset X
      imgOffset_Y        : Smallint;                      // Image Offset Y
      imgShadow_type     : Byte;                          // Image Shadow Type
      imgShadow_Offset_X : Smallint;                      // Image Shadow Offset X
      imgShadow_Offset_Y : Smallint;                      // Image Shadow Offset Y
      imgFileSize        : Cardinal;                      // FileSize
    end;
    {$EXTERNALSYM TLMT_Img_Header}
  {$ENDREGION}

  {$REGION ' - Wemade Orginal Header (For Import WIL/WIX) '}
     (*****************************************************************************
      * TWIL_Header WIL (Wemade Orginal) File Header
      *
      ****************************************************************************)
      PWIL_Header =^TWIL_Header;
      TWIL_Header = packed record (*26*)
        whValid            : Byte;                          // 1
        whLib_Info         : array [0..20] of AnsiChar;     // ILIB v1.0-WEMADE
        whLib_Type         : Word;                          // 6000=Type3 | 5000=Type2 | 17=Type1
        whTotal_Index      : Word;                          // Total Image in this File
      end;

     (*****************************************************************************
      * PWIX_Header WIX (Wemade Orginal) File Index Header
      *
      ****************************************************************************)
      PWIX_Header = ^TWIX_Header;
      TWIX_Header = packed record (*22*)
        whLib_Info         : array [0..19] of AnsiChar;
        whTotal_Index      : Word;
      end;

     (*****************************************************************************
      * TWIL_Img_Header WIL_IMG (Wemade Orginal) Image Header
      *
      ****************************************************************************)
      PWIL_Img_Header = ^TWIL_Img_Header;         // WIL-File Image Offset Header
      TWIL_Img_Header = packed record (*17*)
        imgWidth           : Word;                          // Image Width
        imgHeight          : Word;                          // Image Height
        imgOffset_X        : Smallint;                      // Image Offset X
        imgOffset_Y        : Smallint;                      // Image Offset Y
        imgShadow_type     : Byte;                          // Image Shadow Type
        imgShadow_Offset_X : Smallint;                      // Image Shadow Offset X
        imgShadow_Offset_Y : Smallint;                      // Image Shadow Offset Y
        imgFileSize        : Cardinal;                      // FileSize Only in Type2
      end;
  {$ENDREGION}

  (* Classes *)
  TChunkIHDRHackLMT = class(TChunkIHDR);

  TMIR3_LMTFile = class(TObject)
  private
    FFileName        : string;
    FImageIndex      : Integer;
    FTotalImage      : Integer;
    FTotalIndex      : Integer;
    FHeaderLMTInfo   : TLMT_Header;
    FHeaderWILInfo   : TWIL_Header;
    FHeaderWIXInfo   : TWIX_Header;
    FHeaderLMTImage  : TLMT_Img_Header;
    FHeaderWILImage  : TWIL_Img_Header;
    FLMT             : PByte;
    FWIL             : PByte;
    FWIX             : PByte;
    FLastImage       : Integer;
    FBackgroundColor : TColor;
    FLMTMemory       : TMemoryStream;
    FIndexMemory     : array of Cardinal;
    FLibOpenState    : Boolean;
  private
    procedure CreateFilesMMF(FFileName: String);
    procedure CreateWILFilesMMF(FFileName: String);
    procedure FlushMMF;
  strict private
    procedure InternalRebuild;
    function ConvertWILtoPNG(AIndex: Integer; var AStream: TMemoryStream; APassword: Cardinal; ACompress: Integer = 9): Boolean;
  public
    constructor Create;
    destructor Destroy; override;

    function Open(FileName: String): Boolean;
    function OpenWIL(FileName: string): Boolean;
    procedure Close;
    procedure CloseWIL;

    function GetBMPFromIndex(AIndex: Integer; var ABitmap: TBitmap): Boolean;
    procedure CreateLMTFile(AFileName: String; ATotalIndex: Integer);
    procedure SaveLMTFile(AFileName: String);
    procedure LoadFromFile(AFileName: String);

    function AddFilePNG(AFileName: String; AIndex: Integer; APassword: Cardinal; ACompress: Integer = 9): HRESULT;
   (* Help Function *)
    function GetTotalIndex: Integer;
    function GetTotalIndexWIL: Integer;
    function GetTotalImage: Integer;
    function GetTotalImageWIL: Integer;
    function GetFirstImage: Integer;
    function GetLastImage: Integer;
    function GetPrivRealImage(AIndex: Integer): Integer;
    function GetNextRealImage(AIndex: Integer): Integer;
    function GetIndexPosition(AIndex: Integer): Integer;
    function GetSecureInformation: Boolean;
    function GetLibTypeOffset(LibType: Integer): Integer;
    function GetLibTypeIndexOffset(LibType: Integer): Integer;
    property LibOpenState : Boolean read FLibOpenState;
    property ImageHeader : TLMT_Img_Header read FHeaderLMTImage;
    property BackgroundColor : TColor read FBackgroundColor write FBackgroundColor;
  end;

var
  FNull_Info : Integer = 0;

implementation

  {$REGION ' - Constructor / Destructor / Open / Close '}
    constructor TMIR3_LMTFile.Create;
    begin
      inherited;

    end;
    
    destructor TMIR3_LMTFile.Destroy;
    begin
      try
        Self.Close;
      except
        //TODO : add exception handler
      end;
      inherited;
    end;

    procedure TMIR3_LMTFile.FlushMMF;
    begin
      CloseMMF(Pointer(FLMT));
      Sleep(20);
      CreateFilesMMF(FFileName);
    end;

    function TMIR3_LMTFile.Open(FileName: String): Boolean;
    begin
      Close;
      Result    := False;
      try
        CreateFilesMMF(FileName);
        if FLMT = nil then Exit;
        // Read LMT File Header
        CopyMemory(@FHeaderLMTInfo, FLMT  , sizeof(TLMT_Header));
        FTotalImage := FHeaderLMTInfo.lhTotal_Image;
        FTotalIndex := FHeaderLMTInfo.lhTotal_Index;
        FFileName   := FileName;
        Result      := True;
        FLastImage  := GetLastImage;
        FLibOpenState := True;
      finally
        if not Result then
        begin
          FLibOpenState := False;
          Close;
        end;
      end;
    end;

    function TMIR3_LMTFile.OpenWIL(FileName: string): Boolean;
    begin
      CloseWIL;
      Result := False;
      try
        CreateWILFilesMMF(FileName);
        if FWIL = nil then Exit;
        // Read Wil and Wix File Header
        CopyMemory(@FHeaderWILInfo, FWIL  , sizeof(TWIL_Header));
        CopyMemory(@FHeaderWIXInfo, FWIX  , sizeof(TWIX_Header));
        Result      := True;
      finally
        if not Result then CloseWIL;
      end;
    end;

    procedure TMIR3_LMTFile.Close;
    begin
      CloseMMF(Pointer(FLMT));
      FillChar(FHeaderLMTInfo , SizeOf(TLMT_Header)    , 0);
      FillChar(FHeaderLMTImage, SizeOf(TLMT_Img_Header), 0);
      FTotalImage := -1;
      FImageIndex := -1;
      FFileName   := '';
      FLibOpenState := False;
      if FLMTMemory <> nil then
      begin
        FLMTMemory.Clear;
        FreeAndNil(FLMTMemory);
      end;
    end;

    procedure TMIR3_LMTFile.CloseWIL;
    begin
      CloseMMF(Pointer(FWIL));
      CloseMMF(Pointer(FWIX));
      FillChar(FHeaderWILInfo , SizeOf(TWIL_Header)    , 0);
      FillChar(FHeaderWIXInfo , SizeOf(TWIX_Header)    , 0);
      FillChar(FHeaderWILImage, SizeOf(TWIL_Img_Header), 0);
    end;

    procedure TMIR3_LMTFile.CreateFilesMMF(FFileName: String);
    var
      Size  : Cardinal;
      Error : Integer;
    begin
      if FileExists(FFileName) then
      begin
        FLMT := CreateMMF(FFileName, True, Size, Error);
        if Error <> 0 then FLMT := nil;
      end else begin
                 FLMT := nil;
               end;
    end;

    procedure TMIR3_LMTFile.CreateWILFilesMMF(FFileName: String);
    var
      Size     : Cardinal;
      Error    : Integer;
      FFileWix : String;
      FFileWil : String;
    begin
      if UpperCase(ExtractFileExt(FFileName)) = '.WIL'  then
      begin
        FFileWil :=  FFileName;
        FFileWix :=  Copy(FFileName, 0, Length(FFileName)-4) + '.wix';
      end else begin
        FFileWix :=  FFileName;
        FFileWil :=  Copy(FFileName, 0, Length(FFileName)-4) + '.wil';
      end;

      if (FileExists(FFileWil)) and (FileExists(FFileWix)) then
      begin
        FWIL := CreateMMF(FFileWil, True, Size, Error);
        if Error <> 0 then Exit;
        FWIX := CreateMMF(FFileWix, True, Size, Error);
        if Error <> 0 then Exit;
      end else begin
                  FWIL := nil;
                  FWIX := nil;
                end;
    end;
  {$ENDREGION}

  {$REGION ' - Get Functions '}
    function TMIR3_LMTFile.GetTotalIndex: Integer;
    begin
      if FLMT <> nil then
      begin
        Result := FHeaderLMTInfo.lhTotal_Index;
      end else Result := 0;
    end;

    function TMIR3_LMTFile.GetTotalIndexWIL: Integer;
    begin
      if FWIL <> nil then
      begin
        Result := FHeaderWILInfo.whTotal_Index;
      end else Result := 0;
    end;

    function TMIR3_LMTFile.GetTotalImage: Integer;
    begin
      if FLMT <> nil then
      begin
        Result := FHeaderLMTInfo.lhTotal_Image;
      end else Result := 0;
    end;

    function TMIR3_LMTFile.GetTotalImageWIL: Integer;
    var
      FPosition, I : Integer;
    begin
      if FWIX <> nil then
      begin
        Result := 0;
        for I := 0 to GetTotalIndexWIL-1 do
        begin
          CopyMemory(@FPosition, PInteger(Integer(FWIX) + ((I * 4) + GetLibTypeIndexOffset(FHeaderWILInfo.whLib_Type))), sizeof(FPosition));
          if FPosition <> 0 then
            Inc(Result);
        end;
      end else Result := 0;
    end;

    function TMIR3_LMTFile.GetFirstImage: Integer;
    var
      FPosition, I : Integer;
    begin
      if FHeaderLMTInfo.lhTotal_Image = 0 then
      begin
        Result := 0;
        Exit;
      end;
      if FLMT <> nil then
      begin
        for I := 0 to FHeaderLMTInfo.lhTotal_Index-1 do
        begin
          CopyMemory(@FPosition, PInteger(Integer(FLMT) + ((I * 4) + GetLibTypeIndexOffset(FHeaderLMTInfo.lhLib_Type))), sizeof(FPosition));
          if FPosition <> 0 then
          begin
            Result := I;
            Break;
          end;
        end;
      end;
    end;

    function TMIR3_LMTFile.GetLastImage: Integer;
    var
      FPosition, I : Integer;
    begin
      if FHeaderLMTInfo.lhTotal_Image = 0 then
      begin
        Result := 0;
        Exit;
      end;
      if FLMT <> nil then
      begin
        for I := FHeaderLMTInfo.lhTotal_Index-1 downto 0 do
        begin
          CopyMemory(@FPosition, PInteger(Integer(FLMT) + ((I * 4) + GetLibTypeIndexOffset(FHeaderLMTInfo.lhLib_Type))), sizeof(FPosition));
          if FPosition <> 0 then
          begin
            Result := I;
            Break;
          end;
        end;
      end;
    end;

    function TMIR3_LMTFile.GetPrivRealImage(AIndex: Integer): Integer;
    var
      FPosition, I : Integer;
    begin
      Result := AIndex+1;
      for I := AIndex downto 0 do
      begin
        CopyMemory(@FPosition, PInteger(Integer(FLMT) + ((I * 4) + GetLibTypeIndexOffset(FHeaderLMTInfo.lhLib_Type))), sizeof(FPosition));
        if FPosition <> 0 then
        begin
          Result := I;
          Break;
        end;
      end;
    end;

    function TMIR3_LMTFile.GetNextRealImage(AIndex: Integer): Integer;
    var
      FPosition, I : Integer;
    begin
      Result := AIndex-1;
      for I := AIndex to FHeaderLMTInfo.lhTotal_Index-1 do
      begin
        CopyMemory(@FPosition, PInteger(Integer(FLMT) + ((I * 4) + GetLibTypeIndexOffset(FHeaderLMTInfo.lhLib_Type))), sizeof(FPosition));
        if FPosition <> 0 then
        begin
          Result := I;
          Break;
        end;
      end;
    end;

    function TMIR3_LMTFile.GetIndexPosition(AIndex: Integer): Integer;
    begin
      if (FLMT = nil) then Exit;
      CopyMemory(@Result, PInteger(Integer(FLMT) + ((AIndex * 4) + GetLibTypeIndexOffset(FHeaderLMTInfo.lhLib_Type))), sizeof(Integer));
      if Result <> 0 then
        Result := Result + 28 + (FHeaderLMTInfo.lhTotal_Index * SizeOf(Cardinal));
    end;

    function TMIR3_LMTFile.GetSecureInformation: Boolean;
    begin
      if FLMT <> nil then
      begin
        case FHeaderLMTInfo.lhSecuredImage of
          0 : Result := False;
          else Result := True;
        end;
      end else Result := False;
    end;

    function TMIR3_LMTFile.GetLibTypeOffset(LibType: Integer): Integer;
    begin
      Result := 0;
      case LibType of
        17   : Result := 17;
        5000 : Result := 21;
        6000 : Result := 17;
        9000 : Result := 17;
      end;
    end;

    function TMIR3_LMTFile.GetLibTypeIndexOffset(LibType: Integer): Integer;
    begin
      Result := 0;
      case LibType of
        17   : Result := 24;
        5000 : Result := 28;
        6000 : Result := 32;
        9000 : Result := SizeOf(TLMT_Header);
      end;
    end;

  {$ENDREGION}

// Create new basic Texture lib
procedure TMIR3_LMTFile.CreateLMTFile(AFileName: String; ATotalIndex: Integer);
begin
  if FLMTMemory = nil then
    FLMTMemory := TMemoryStream.Create
  else FLMTMemory.Clear;

  SetLength(FIndexMemory, 0); // Reset Index (cleanup)
  SetLength(FIndexMemory, ATotalIndex);
  ZeroMemory(@FHeaderLMTInfo, SizeOf(TLMT_Header));
  FHeaderLMTInfo.lhValid        := 1;
  FHeaderLMTInfo.lhLib_Info     := HEADER_INFORMATION;
  FHeaderLMTInfo.lhLib_Type     := 9000;
  FHeaderLMTInfo.lhTotal_Index  := ATotalIndex;
  FHeaderLMTInfo.lhTotal_Image  := 0;
  FHeaderLMTInfo.lhSecuredImage := 2;
  FLMTMemory.Write(FHeaderLMTInfo, SizeOf(TLMT_Header));
  FLMTMemory.Write(FNull_Info    , SizeOf(Integer));
  if UpperCase(ExtractFileExt(AFileName)) = '.LMT' then
  begin
    if not DirectoryExists(ExtractFilePath(AFileName)) then
    begin
      MkDir(ExtractFilePath(AFileName));
    end;
    FLMTMemory.SaveToFile(AFileName);
  end else begin
    if not DirectoryExists(ExtractFilePath(AFileName + '.lmt')) then
    begin
      MkDir(ExtractFilePath(AFileName + '.lmt'));
    end;
    FLMTMemory.SaveToFile(AFileName + '.lmt');
  end;
  FLMTMemory.Clear;
end;

// Sort Texture and clean up index
procedure TMIR3_LMTFile.InternalRebuild;
var
  I                : Integer;
  FTempMoveMem     : TMemoryStream;
  FTempIndexMemory : array of Cardinal;
begin
  FTempMoveMem := TMemoryStream.Create;
  try
    if (FLMTMemory <> nil) and (FTempMoveMem <> nil) then
      if (FLMTMemory.Size > 10) and (FIndexMemory <> nil) then
      begin
        FHeaderLMTInfo.lhTotal_Image := 0;
        SetLength(FTempIndexMemory, Length(FIndexMemory));
        for I := Low(FIndexMemory) to High(FIndexMemory) do
        begin
          if FIndexMemory[I] > 0 then
          begin
            FLMTMemory.Seek(FIndexMemory[I]-1, 0);                              // Set Position
            ZeroMemory(@FHeaderLMTImage, SizeOf(TLMT_Img_Header));              // Clean Header
            FLMTMemory.ReadBuffer(FHeaderLMTImage, sizeOf(TLMT_Img_Header));    // read Header
            FTempIndexMemory[I] := FTempMoveMem.Size+1;                         // set new index information
            FTempMoveMem.WriteBuffer(FHeaderLMTImage, sizeOf(TLMT_Img_Header)); // write Header
            FTempMoveMem.CopyFrom(FLMTMemory, FHeaderLMTImage.imgFileSize);     // Copy Image to temp Mem
            Inc(FHeaderLMTInfo.lhTotal_Image);
          end;//-if
        end;//-for
        for I := Low(FIndexMemory) to High(FIndexMemory) do
           FIndexMemory[I] := FTempIndexMemory[I];

        FLMTMemory.Clear;
        FLMTMemory.Position   := 0;
        FTempMoveMem.Position := 0;
        FLMTMemory.CopyFrom(FTempMoveMem, FTempMoveMem.Size);
        SetLength(FTempIndexMemory, 0);
        FTempIndexMemory := nil;
      end;
    FTempMoveMem.Clear;
    FreeAndNil(FTempMoveMem);
  except
    FreeAndNil(FTempMoveMem);
    //TODO: Add Exception handler
  end;
end;

// Save new basic Texture lib
procedure TMIR3_LMTFile.SaveLMTFile(AFileName: String);
var
  FTempMem : TMemoryStream;
begin
  FTempMem := TMemoryStream.Create;
  try
    InternalRebuild;

    FLMTMemory.Position := 0;
    // Add Header Information
    FTempMem.Write(FHeaderLMTInfo, SizeOf(TLMT_Header));
    // Add file Index
    FTempMem.Write(FIndexMemory[0], (FHeaderLMTInfo.lhTotal_Index * SizeOf(Cardinal)));
    // Add file Textures
    FTempMem.CopyFrom(FLMTMemory, FLMTMemory.Size);
    FTempMem.Position := 0;
    if UpperCase(ExtractFileExt(AFileName)) = '.LMT' then
      FTempMem.SaveToFile(AFileName)
    else FTempMem.SaveToFile(AFileName + '.lmt');
  finally
    FTempMem.Clear;
    FreeAndNil(FTempMem);
    FLMTMemory.Clear;
    FreeAndNil(FLMTMemory);
  end;
end;

// Load new basic Texture lib
procedure TMIR3_LMTFile.LoadFromFile(AFileName: String);
begin
  Open(AFileName);
end;

function TMIR3_LMTFile.GetBMPFromIndex(AIndex: Integer; var ABitmap: TBitmap): Boolean;
var
  FPosition   : Integer;
  FTempImage  : TPNGObject;
  FDestRect   : TRect;
  FSrcRect    : TRect;
  FTempMemory : TMemoryStream;
begin
  Result := False;
  if Assigned(ABitmap) and (AIndex <= GetTotalIndex-1) then
  begin
    if (FLMT = nil) then Exit;
    CopyMemory(@FPosition, PInteger(Integer(FLMT) + ((AIndex * 4) + GetLibTypeIndexOffset(FHeaderLMTInfo.lhLib_Type))), sizeof(FPosition));
    if FPosition = 0 then
    begin
      ABitmap.Width       := 2;
      ABitmap.Height      := 2;
      ABitmap.Canvas.Brush.Color := FBackgroundColor;
      ABitmap.Canvas.FillRect(Rect(0,0,ABitmap.Width, ABitmap.Height));
      FillChar(FHeaderLMTImage, SizeOf(TLMT_Img_Header), 0);
      Result := False;
      Exit;
    end;
    FPosition := FPosition + 28 + (FHeaderLMTInfo.lhTotal_Index * SizeOf(Cardinal));

    CopyMemory(@FHeaderLMTImage, PInteger(Integer(FLMT) + FPosition), sizeof(TLMT_Img_Header));
    FPosition            := FPosition + GetLibTypeOffset(FHeaderLMTInfo.lhLib_Type);
    FTempMemory          := TMemoryStream.Create;
    FTempMemory.write(PInteger(Integer(FLMT)+FPosition)^ , FHeaderLMTImage.imgFileSize);
    FTempImage           := TPNGObject.Create;
    FTempMemory.Position := 0;
    FTempImage.LoadFromStream(FTempMemory);

    ABitmap.Width       := FHeaderLMTImage.imgWidth;
    ABitmap.Height      := FHeaderLMTImage.imgHeight;
    ABitmap.PixelFormat := pf24bit;
    // We have a Pow2 Image and need to show the orginal size
    FSrcRect  := Rect(0, 0, FHeaderLMTImage.imgWidth, FHeaderLMTImage.imgHeight);
    FDestRect := Rect(0, 0, FHeaderLMTImage.imgWidth, FHeaderLMTImage.imgHeight);
    ABitmap.Canvas.CopyRect(FDestRect, FTempImage.Canvas, FSrcRect);
    FTempMemory.Clear;
    FreeAndNil(FTempMemory);
    FreeAndNil(FTempImage);
    Result := True;
  end;
end;

function TMIR3_LMTFile.AddFilePNG(AFileName: String; AIndex: Integer; APassword: Cardinal; ACompress: Integer = 9): HRESULT;
var
  FPosIndex  : Integer;
  FTempMem   : TMemoryStream;
begin
  Result := S_OK;
  FTempMem := TMemoryStream.Create;
  try
    if AFileName <> '' then
      OpenWIL(AFileName);

    if ConvertWILtoPNG(AIndex, FTempMem, APassword, ACompress) then
    begin
      if High(FIndexMemory) < AIndex then
      begin
        SetLength(FIndexMemory, High(FIndexMemory)+ ABS((AIndex-High(FIndexMemory))) + 2);
      end;
      FIndexMemory[AIndex] := FLMTMemory.Position +1;
      FLMTMemory.CopyFrom(FTempMem, FTempMem.Size);
    end else Result := E_FAIL;

    FTempMem.Clear;
    FreeAndNil(FTempMem);
  except
    FTempMem.Clear;
    FreeAndNil(FTempMem);  
    Result := E_FAIL;
  end;
end;

function TMIR3_LMTFile.ConvertWILtoPNG(AIndex: Integer; var AStream: TMemoryStream; APassword: Cardinal; ACompress: Integer = 9): Boolean;
var
  X, Y        : Integer;
  H, W        : Integer;
  FImage      : TPngObject;
  FAlpha      : PByteArray;
  FPosition   : Integer;
  FIncX       : Integer;
  FHelp       : Integer;
  FCount      : Integer;
  FColorCount : Integer;
  FBGR        : Integer;
  PBGR        : PInteger;
  FEncodeRGBA : Integer;
  PEncodeRGBA : PInteger;
  FPixelInfo  : DWord;
  FSecureInfo : Cardinal;

  function ByteSwapColor(Color:Integer):Integer; register;
  asm
    BSWAP EAX
    SHR  EAX,8
  end;

begin
  if (FWIL = nil) or (FWIX = nil) then Exit;
  try
    CopyMemory(@FPosition   , PInteger(Integer(FWIX) + ((AIndex * 4) + GetLibTypeIndexOffset(FHeaderWILInfo.whLib_Type))), sizeof(FPosition));
    if FPosition = 0 then
    begin
      Result := False;
      Exit;
    end;

    CopyMemory(@FHeaderWILImage, PInteger(Integer(FWIL) + FPosition), sizeof(TWIL_Img_Header));
    FPosition   := FPosition + GetLibTypeOffset(FHeaderWILInfo.whLib_Type);
    MakePowerOfTwoHW(H, W, FHeaderWILImage.imgHeight, FHeaderWILImage.imgWidth);
    PBGR        := @FBGR;
    PEncodeRGBA := @FEncodeRGBA;
    AStream.Write(FHeaderWILImage, sizeof(TWIL_Img_Header));

    {$REGION ' - PNG File Information Setup '}
    FImage                  := TPngObject.CreateBlank(COLOR_RGBALPHA, 8, H, W);
    FImage.Header.Width     := W;
    FImage.Header.Height    := H;
    FImage.Header.BitDepth  := 8;
    FImage.Header.ColorType := COLOR_RGBALPHA;
    FImage.CompressionLevel := ACompress;
    TChunkIHDRHackLMT(FImage.Header).PrepareImageData;
    for X:=0 to H-1 do
    begin
      FAlpha := FImage.AlphaScanline[X];
      for Y:=0 to W-1 do
      begin
        FImage.Pixels[Y, X]  := 0;
        FAlpha[Y]            := 255;
      end;
    end;
    //FillMemory(FAlpha,W-1,255);  <-- to clean the Alpha Channel (or we need to create 2 Alpha channels later)

    {$ENDREGION}

    {$REGION ' - Wil Image Format Decoder   '}
    for Y:=0 to FHeaderWILImage.imgHeight-1 do
    begin
      FAlpha := FImage.AlphaScanline[Y];
      FIncX  := 0;  X := 0; FCount := 0;
      CopyMemory(@FCount, PInteger(Integer(FWIL)+ FPosition), sizeOf(Word));
      Inc(FPosition, 2);
      while X < FCount do
      begin
        Inc(X);
        case PByte(Integer(FWIL)+ FPosition)^ of
          192: begin
                 Inc(FPosition, 2); Inc(x); FHelp := 0; FColorCount := 0;
                 CopyMemory(@FColorCount, PInteger(Integer(FWIL)+ FPosition), 2);
                 while FHelp < FColorCount do
                 begin
                   Inc(FHelp); Inc(FIncX);
                 end;
                 Inc(FPosition, 2);
               end;//case in
          193: begin
                 Inc(FPosition, 2); Inc(X); FHelp := 0; FColorCount := 0;
                 CopyMemory(@FColorCount, PInteger(Integer(FWIL)+ FPosition), 2);
                 Inc(FPosition, 2);
                 while FHelp < FColorCount do
                 begin
                   PEncodeRGBA^ := 0;
                   CopyMemory(PEncodeRGBA, PInteger(Integer(FWIL)+ FPosition), 2);
                   PBGR^ := ($FF00 or (Trunc((((PEncodeRGBA^ and 63488) shr 11) * 8.225806) + 0.5))) shl 8;
                   PBGR^ := (PBGR^ or (Trunc((((PEncodeRGBA^ and  2016) shr  5) * 4.047619) + 0.5))) shl 8;
                   PBGR^ := (PBGR^ or (Trunc((((PEncodeRGBA^ and    31) shr  0) * 8.225806) + 0.5)));
                   FPixelInfo              := StrToInt('$'+IntToHex(PBGR^, 8));
                   FImage.Pixels[FIncX, Y] := ByteSwapColor(FPixelInfo);
                   Inc(X); Inc(FPosition, 2); Inc(FHelp); Inc(FIncX);
                 end;//while
               end;//case in
          194: begin
                 Inc(FPosition, 2); Inc(X); FHelp := 0; FColorCount := 0;
                 CopyMemory(@FColorCount, PInteger(Integer(FWIL)+ FPosition), 2);
                 Inc(FPosition, 2);
                 while FHelp < FColorCount do
                 begin
                   PEncodeRGBA^ := 0;
                   CopyMemory(PEncodeRGBA, PInteger(Integer(FWIL)+ FPosition), 2);
                   PBGR^ := ($7F00 or (Trunc((((PEncodeRGBA^ and 63488) shr 11) * 8.225806) + 0.5))) shl 8;
                   PBGR^ := (PBGR^ or (Trunc((((PEncodeRGBA^ and  2016) shr  5) * 4.047619) + 0.5))) shl 8;
                   PBGR^ := (PBGR^ or (Trunc((((PEncodeRGBA^ and    31) shr  0) * 8.225806) + 0.5)));
                   FPixelInfo               := StrToInt('$'+IntToHex(PBGR^, 8));
                   FImage.Pixels[FIncX, Y]  := ByteSwapColor(FPixelInfo);
                   FAlpha[FIncX]            := FPixelInfo shr 24;
                   Inc(X); Inc(FPosition, 2); Inc(FHelp); Inc(FIncX);
                 end;//while
               end;//case in
          else X := FCount;
        end;//case
      end;//while
    end;//for
    {$ENDREGION}

    if APassword > 0 then
    begin
      //TODO : open it for use after integration to the Server
//      FPosition := AStream.Position;
//      FImage.SaveToStream(AStream);
//      // seek to cunck Pos and Manipulate this pos with the Password ID
//      AStream.Seek(FPosition+SizeOf(TLMT_Img_Header) + 20,soBeginning);
//      AStream.Read(FSecureInfo, sizeOf(Cardinal));
//      FSecureInfo := FSecureInfo xor APassword;
//      AStream.Seek(FPosition+SizeOf(TLMT_Img_Header) + 20,soBeginning);
//      AStream.Write(FSecureInfo, sizeOf(Cardinal));
//      AStream.Seek(FPosition, soBeginning);
    end else begin
      FImage.SaveToStream(AStream);
      AStream.Seek(0,0);
      FHeaderWILImage.imgFileSize := AStream.Size-sizeof(TWIL_Img_Header);
      AStream.Write(FHeaderWILImage, sizeof(TWIL_Img_Header));
      AStream.Seek(0,0);
    end;
    FreeAndNil(FImage);
    Result := True;
  except
    Result := False;
  end;
end;


end.
