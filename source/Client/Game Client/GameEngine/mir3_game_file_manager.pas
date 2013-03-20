(*******************************************************************
 *   LomCN Mir3 file manager core File 2012                        *
 *                                                                 *
 *   Web       : http://www.lomcn.co.uk                            *
 *   Version   : 0.0.0.2                                           *
 *                                                                 *
 *   - File Info -                                                 *
 *                                                                 *
 *   This file holds all Texture loading things and ..             *
 *                                                                 *
 *                                                                 *
 *                                                                 *
 *******************************************************************
 * Change History                                                  *
 *                                                                 *
 *  - 0.0.0.1 [2012-09-11] Coly : fist init                        *
 *  - 0.0.0.2 [2012-10-10] Coly : cleanup code                     *
 *                                                                 *
 *                                                                 *
 *                                                                 *
 *                                                                 *
 *******************************************************************
 *  - TODO List for this *.pas file -                              *
 *-----------------------------------------------------------------*
 *  if a todo finished, then delete it here...                     *
 *  if you find a global TODO thats need to do, then add it here.. *
 *-----------------------------------------------------------------*
 *                                                                 *
 *  - TODO : -all -fill *.pas header information                   *
 *                 (how to need this file etc.)                    *
 *                                                                 *
 *  Splitt in WIL Class and WTL Class                              *
 *******************************************************************)
 unit mir3_game_file_manager;

interface

uses Windows, SysUtils, Math, Graphics, Classes, D3DX9, Direct3D9, DirectShow9, ActiveX,
     mir3_game_file_manager_const, mir3_global_config, mir3_misc_utils, mir3_game_engine_def, mir3_game_engine ;

type
  { Forweard declaration }
  TMir3_Texture         = class;
  TMir3_FileMapping     = class;
  TMir3_TextureLibrary  = class;
  TMir3_FileCashManager = class;


  {$REGION ' - Wemade Orginal Header (For Import WIL/WIX) '}
     (*****************************************************************************
      * TWIL_Header WIL (Wemade Orginal) File Header
      *
      ****************************************************************************)
      PWIL_Header =^TWIL_Header;
      TWIL_Header = packed record
        whValid            : Byte;                          // 1
        whLib_Info         : array [0..20] of AnsiChar;     // ILIB v1.0-WEMADE
        whLib_Type         : Word;                          // 5000=Type2 | 17=Type1
        whTotal_Index      : Word;                          // Total Image in this File
      end;
    
     (*****************************************************************************
      * PWIX_Header WIX (Wemade Orginal) File Index Header
      *
      ****************************************************************************)
      PWIX_Header = ^TWIX_Header;
      TWIX_Header = packed record
        whLib_Info         : array [0..19] of AnsiChar;
        whTotal_Index      : Word;
      end;
    
     (*****************************************************************************
      * TWIL_Img_Header WIL_IMG (Wemade Orginal) Image Header
      *
      ****************************************************************************)
      PWIL_Img_Header = ^TWIL_Img_Header;         // WIL-File Image Offset Header
      TWIL_Img_Header = packed record
        imgWidth           : Word;                          // Image Width
        imgHeight          : Word;                          // Image Height
        imgOffset_X        : Smallint;                      // Image Offset X
        imgOffset_Y        : Smallint;                      // Image Offset Y
        imgShadow_type     : Byte;                          // Image Shadow Type
        imgShadow_Offset_X : Smallint;                      // Image Shadow Offset X
        imgShadow_Offset_Y : Smallint;                      // Image Shadow Offset Y
        imgFileSize        : Cardinal;                      // FileSize Only in Type2   or ByteSwap TEST IT // Packed and Crypted File Size (must by * 2 + Position + 21)
      end;
  {$ENDREGION}

  {$REGION ' - Records  '}
    { Records }

    PImageHeaderD3D = ^TImageHeaderD3D;
    TImageHeaderD3D = record
      ihORG_Width      : Word;                  // Breite des Images Blit Größe
      ihORG_Height     : Word;                  // Höhe des Images Blit Größe
      ihPO2_Width      : Word;                  // Breite des Images Power of 2 Größe
      ihPO2_Height     : Word;                  // Breite des Images Power of 2 Blit Größe
      ihOffset_X       : Smallint;
      ihOffset_Y       : Smallint;
      ihOffsetShadow_X : Smallint;
      ihOffsetShadow_Y : Smallint;
      ihTypeShadow     : Byte;
      ihUseTime        : LongWord;
      ihFileSize       : Integer;
      ihD3DTexture     : TMir3_Texture;
    end;

    PFileInformation =^ TFileInformation;
    TFileInformation = record
      fiFileID           : Integer;
      fiImageOpenCount   : DWord;
      fiImageMemoryUsag  : Extended;
      fiLastUseTick      : DWord;
      fiFirstUseTick     : DWord;
      fiUnloadFile       : Boolean;   // Zur Steuerung ob File aus dem Speicher geschmissen wird (Nein bei GUI Interface Image File)
      fiImageLib         : TMir3_TextureLibrary;
      fiImageList        : array of PImageHeaderD3D;
    end;
  {$ENDREGION}

{$REGION ' - Classes  '}

  { TMir3_Texture }
  TMir3_Texture = class
  strict private
    FStaticImage: ITexture;
  public
    FQuad       : THGEQuad;
    FWidth      : Integer;
    FHeight     : Integer;
    FTexWidth   : Integer;
    FTexHeight  : Integer;
    FClientRect : TRect;
  public
    constructor Create;
    destructor Destroy(); override;
  public
    function GetPixels(AX, AY: integer): LongWord;
    procedure ColorToGray(out Tmp: ITexture);
    procedure ChangeColor(out Tmp: ITexture; R, G, B: Byte);
    procedure LoadFromITexture(AImages: ITexture; AWidth, AHeight: Integer);
  end;

  { TMir3_TextureLibrary }
  TFileLibType         = (LIB_TYPE_1, LIB_TYPE_2, LIB_TYPE_3);
  TMir3_TextureLibrary = class
  strict private
    FFileName      : string;
	FUsingLibType  : TFileLibType;
    FImageIndex    : Integer;
    FTotalImage    : Integer;
    FHeaderWilInfo : TWIL_Header;
    FHeaderWixInfo : TWIX_Header;
    FHeaderImage   : TWIL_Img_Header;
    FDumpImageInfo : TWIL_Img_Header;
    FWIL           : PByte;
    FWIX           : PByte;
  private
    procedure CreateFilesMMF(FFileName: String);
    function GetLibTypeOffset(LibType: Integer): Integer;
    function GetLibTypeWixOffset(LibType: Integer): Integer;
    function GetLibType(LibType: Integer): String;
    function GetImageInformation(AFrame: Integer): PWIL_Img_Header;
  public
    constructor Create;
    destructor Destroy; override;
    procedure FlushMMF;
    function Open(FileName: string): Boolean;
    procedure Close;
    // Get Functions
    function GetTotalIndex: Integer;
    function GetVersionType: String;
    function GetOverallImage: Integer;
    function GetLastImageInt: Integer;
    function GetLastImageStr: String;
    function GetIndexInformation(AFrame: Integer): Integer;
    // Decode Functions
    function DecodeFrame32ToMir3D3DX(AFrame: Integer; var APImageRecord: PImageHeaderD3D): Boolean; overload;
    function DecodeFrame32ToMir3D3DX(AFrame: Integer; var APImageRecord: PImageHeaderD3D; AColor: Word): Boolean; overload;
    property ImageInfo[Index: Integer]: PWIL_Img_Header read GetImageInformation;
  end;

  { TMir3_FileMapping }
  TMir3_FileMapping = class
  strict private
    FStaticFileIndex : array of Pointer;
  public
    constructor Create;
    destructor  Destroy; override;
  public
    function GetStaticFile(AIndex: Integer): Pointer;
    procedure SetStaticFile(AIndex: Integer; AFilePointer: Pointer);
    procedure CleanUpStaticFileMapping(AIndex: Integer);
  end;

  { TMir3_FileManager }
  TMir3_FileManager = class
  strict private
    FThreadsRunning : Integer;
    FManager        : TMir3_FileCashManager;
    FTextureManager : TMir3_FileMapping;

    evCode : integer;
    pEvent :IMediaEvent;
    pGraph :IGraphBuilder;
    pMediaControl :IMediaControl;
    pSeeking : IMediaSeeking;
    pVidWin :IVideoWindow;
    pBasicAudio: IBasicAudio;
  strict private
    function TestIfInList(AType: Byte; AFileID: Integer) : PFileInformation;
    function GetFileNameByID(AIndexID: Integer): String;
  public
    constructor Create;
    destructor  Destroy; override;
  public //Video
    procedure RenderVideo(AType: Byte);
  public
    function GetImageD3DDirect(var AImageID, AFileID: Integer): PImageHeaderD3D;
    function GetFileMapping : TMir3_FileMapping;
    procedure Draw(AImageID, AFileID: Integer; X, y: Integer; Drawmode: word = BLEND_DEFAULT; Alpha: Byte = 255); Overload;
    procedure Draw(image: TMir3_Texture; X, y: Integer; Rect: TRect; Drawmode: Word = BLEND_DEFAULT; Alpha: Byte = 255); overload;
    procedure Draw(Image: TMir3_Texture; X, y: Integer; Drawmode: word = BLEND_DEFAULT; Alpha: Byte = 255); Overload;
    procedure DrawRect(AImageID, AFileID: Integer; AX, AY: Integer; ARect: TRect; ADrawmode: Word = BLEND_DEFAULT; AAlpha: Byte = 255);
    procedure DrawColorChange(AImage: TMir3_Texture; AX, AY: Integer; R, G, B: Byte);
    procedure DrawColor(AImage: TMir3_Texture; AX, AY: Integer; AColor: Cardinal);
    procedure DrawStrech(Image: TMir3_Texture; X, y: integer; xRate: Single; yRate: Single; Drawmode: word = BLEND_DEFAULT; Alpha: Byte = 255); Overload;
    procedure DrawStrech(AImageID, AFileID: Integer; AX, AY: Integer; ARateX: Single; yRate: Single; Drawmode: word; Alpha: Byte = 255); Overload;
  end;

  TMir3_FileCashManager = class(TThread)
  strict private
    FSpawnObject : TObject;
  protected
    procedure WatchCachLogic;
    procedure Execute; override;
  public
    constructor Create(ASpawnObject: TObject); overload;
    destructor Destroy; override;
  end;
{$ENDREGION}
  

implementation

uses mir3_game_backend;

var
  GStopThreads  : Boolean;

  {$REGION ' - TMir3_TextureLibrary Constructor / Destructor / Open / Close '}
    constructor TMir3_TextureLibrary.Create;
    begin
      inherited;
      FUsingLibType := LIB_TYPE_2;
    end;
    
    destructor TMir3_TextureLibrary.Destroy;
    begin
      try
        Close;
      except
      end;
      inherited;
    end;

    procedure TMir3_TextureLibrary.FlushMMF;
    begin
      CloseMMF(Pointer(FWIL));
      CloseMMF(Pointer(FWIX));
      Sleep(20);
      CreateFilesMMF(FFileName);
    end;

    function TMir3_TextureLibrary.Open(FileName: string): Boolean;
    begin
      Close;
      Result    := False;
      try
	    case FUsingLibType of
		  LIB_TYPE_1 , 
		  LIB_TYPE_2 : begin
            CreateFilesMMF(FileName);
            // Read Wil and Wix File Header
            CopyMemory(@FHeaderWilInfo, FWIL  , sizeof(TWIL_Header));
            CopyMemory(@FHeaderWixInfo, FWIX  , sizeof(TWIX_Header));
            FTotalImage := FHeaderWilInfo.whTotal_Index;
            FFileName   := FileName;
		  end;
		  LIB_TYPE_3 : begin
		  
		  end;
		end;
        Result      := True;
      finally
        if not Result then Close;
      end;
    end;

    procedure TMir3_TextureLibrary.Close;
    begin
      CloseMMF(Pointer(FWIL));
      CloseMMF(Pointer(FWIX));
      FTotalImage := -1;
      FillChar(FHeaderWilInfo, SizeOf(TWIL_Header)    , 0);
      FillChar(FHeaderWixInfo, SizeOf(TWIX_Header)    , 0);
      FillChar(FHeaderImage  , SizeOf(TWIL_Img_Header), 0);
      FImageIndex := -1;
      FFileName := '';
    end;
  {$ENDREGION}

  {$REGION ' - TMir3_TextureLibrary Functions     '}
    procedure TMir3_TextureLibrary.CreateFilesMMF(FFileName: String);
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

    function TMir3_TextureLibrary.GetLibTypeOffset(LibType: Integer): Integer;
    begin
      Result := 0;
      case LibType of
        17   : Result := 17;
        5000 : Result := 21;
		  //6000 : Result := 31;
      end;
    end;

    function TMir3_TextureLibrary.GetLibTypeWixOffset(LibType: Integer): Integer;
    begin
      Result := 0;
      case LibType of
        17   : Result := 24;
        5000 : Result := 28;
		  //6000 : Result := 31;
      end;
    end;

    function TMir3_TextureLibrary.GetLibType(LibType: Integer): String;
    begin
      case LibType of
        17   : Result := 'Type 1';
        5000 : Result := 'Type 2';
		    6000 : Result := 'Type 3';
      end;
    end;
  {$ENDREGION}

  {$REGION ' - TMir3_TextureLibrary Get Functions '}
      function TMir3_TextureLibrary.GetTotalIndex: Integer;
      begin
        if FWIL <> nil then
        begin
          Result := FHeaderWilInfo.whTotal_Index;
        end else Result := 0;
      end;
    
      function TMir3_TextureLibrary.GetVersionType: String;
      begin
        if FWIL <> nil then
        begin
          Result := GetLibType(FHeaderWilInfo.whLib_Type);
        end else Result := 'Unknow';
      end;

      function TMir3_TextureLibrary.GetOverallImage: Integer;
      var
        FPosition, I : Integer;
      begin
        if FWIX <> nil then
        begin
          Result := 0;
          for I := 0 to GetTotalIndex do
          begin
            CopyMemory(@FPosition, PInteger(Integer(FWIX) + ((I * 4) + GetLibTypeWixOffset(FHeaderWilInfo.whLib_Type))), sizeof(FPosition));
            if FPosition <> 0 then
              Inc(Result);
          end;
        end else Result := 0;
      end;

      function TMir3_TextureLibrary.GetLastImageInt: Integer;
      var
        FPosition, I : Integer;
      begin
        if FWIX <> nil then
        begin
          Result := 0;
          for I := GetTotalIndex downto 0 do
          begin
            CopyMemory(@FPosition, PInteger(Integer(FWIX) + ((I * 4) + GetLibTypeWixOffset(FHeaderWilInfo.whLib_Type))), sizeof(FPosition));
            if FPosition <> 0 then
            begin
              Result := I;
              Break;
            end;
          end;
        end else Result := 0;
      end;

      function TMir3_TextureLibrary.GetLastImageStr: String;
      var
        FPosition, I : Integer;
        FLastImage   : Integer;
      begin
        if FWIX <> nil then
        begin
          FLastImage := 0;
          for I := GetTotalIndex downto 0 do
          begin
            CopyMemory(@FPosition, PInteger(Integer(FWIX) + ((I * 4) + GetLibTypeWixOffset(FHeaderWilInfo.whLib_Type))), sizeof(FPosition));
            if FPosition <> 0 then
            begin
              FLastImage := I;
              Break;
            end;
          end;
          Result := IntToStr(FLastImage);
        end else Result := '0';
      end;

      function TMir3_TextureLibrary.GetIndexInformation(AFrame: Integer): Integer;
      var
        FPosition : Integer;
      begin
        if FWIX <> nil then
        begin
          CopyMemory(@FPosition, PInteger(Integer(FWIX) + ((AFrame * 4) + GetLibTypeWixOffset(FHeaderWilInfo.whLib_Type))), sizeof(FPosition));
          Result := FPosition;
        end else Result := 0;
      end;
    
      function TMir3_TextureLibrary.GetImageInformation(AFrame: Integer): PWIL_Img_Header;
      var
        FPosition : Integer;
      begin
        if (FWIX <> nil ) and (FWIL <> nil) then
        begin
          CopyMemory(@FPosition      , PInteger(Integer(FWIX) + ((AFrame * 4) + GetLibTypeWixOffset(FHeaderWilInfo.whLib_Type))), sizeof(FPosition));
          CopyMemory(@FDumpImageInfo , PInteger(Integer(FWIL) + FPosition)          , sizeof(TWIL_Img_Header));
          Result := @FDumpImageInfo;
        end else Result := nil;
      end;

  {$ENDREGION}

  {$REGION ' - TMir3_TextureLibrary Decode Functions '}
      function TMir3_TextureLibrary.DecodeFrame32ToMir3D3DX(AFrame: Integer; var APImageRecord: PImageHeaderD3D): Boolean;
      var
        FPosition    : Integer;
        X, Y, H, W   : Integer;
        FHelp        : Integer;
        FEncodeRGBA  : Integer; PEncodeRGBA  : PInteger;
        FColorCount  : Integer; PColorCount  : PInteger;
        FCount       : Integer; PCount       : PInteger;
        FIncX        : Integer; PIncX        : PInteger;
        FBGR         : Integer; PBGR         : PInteger;
        PosCount     : LongInt;
        FTexture     : ITexture;
        d3dlr        : TD3DLocked_Rect;
      begin

        Result := False;
        if (FWIX = nil) or (FWIL = nil) then Exit;

        PEncodeRGBA       := @FEncodeRGBA;
        PColorCount       := @FColorCount;
        PCount            := @FCount;
        PIncX             := @FIncX;
        PBGR              := @FBGR;

        CopyMemory(@FPosition   , PInteger(Integer(FWIX) + ((AFrame * 4) + GetLibTypeWixOffset(FHeaderWilInfo.whLib_Type))), sizeof(FPosition      ));
        if FPosition = 0 then
        begin
          Result := False;
          Exit;
        end;
        CopyMemory(@FHeaderImage, PInteger(Integer(FWIL) + FPosition)         , sizeof(TWIL_Img_Header));
        PosCount := FPosition + GetLibTypeOffset(FHeaderWilInfo.whLib_Type);
        MakePowerOfTwoHW(H, W, FHeaderImage.imgHeight, FHeaderImage.imgWidth);

        if not Assigned(APImageRecord) then
          new(APImageRecord)
        else if APImageRecord^.ihD3DTexture <> nil then
               APImageRecord^.ihD3DTexture := nil;

        FTexture := GRenderEngine.Texture_Create(W, H);
        d3dlr    := FTexture.LockExt(False);
        try
          {$REGION ' - Decoder '}
          //for Y:=0 to FHeaderImage.imgHeight-1 do
          for Y:= FHeaderImage.imgHeight-1 downto 0 do
          begin
            PIncX^ := 0;  X := 0; PCount^ := 0;
            CopyMemory(PCount, PInteger(Integer(FWIL)+ PosCount), sizeOf(Word));
            Inc(PosCount, 2);
            while X < PCount^ do
            begin
              Inc(X);
              case PByte(Integer(FWIL)+ PosCount)^ of
                192: begin
                       Inc(x);
                       Inc(PosCount, 2);
                       Inc(PIncX^, PWord(Integer(FWIL)+ PosCount)^);
                       Inc(PosCount, 2);
                     end;//case in
                193: begin
                       Inc(PosCount, 2); Inc(X); FHelp := 0; PColorCount^ := 0;
                       CopyMemory(PColorCount, PInteger(Integer(FWIL)+ PosCount), 2);
                       Inc(PosCount, 2);
                       while FHelp < PColorCount^ do
                       begin
                         PEncodeRGBA^ := 0;
                         CopyMemory(PEncodeRGBA, PInteger(Integer(FWIL)+ PosCount), 2);
                         PBGR^ := ($FF00 or (Trunc((((PEncodeRGBA^ and 63488) shr 11) * 8.225806) + 0.5))) shl 8;
                         PBGR^ := (PBGR^ or (Trunc((((PEncodeRGBA^ and  2016) shr  5) * 4.047619) + 0.5))) shl 8;
                         PBGR^ := (PBGR^ or (Trunc((((PEncodeRGBA^ and    31) shr  0) * 8.225806) + 0.5)));
                         PInteger(Integer(d3dlr.pBits) + Y * d3dlr.Pitch + PIncX^ * 4 )^ := PBGR^;
                         Inc(x); Inc(PosCount, 2); Inc(FHelp); Inc(PIncX^);
                       end;//while
                     end;//case in
                194: begin
                       Inc(PosCount, 2); Inc(X); FHelp := 0; PColorCount^ := 0;
                       CopyMemory(PColorCount, PInteger(Integer(FWIL)+ PosCount), 2);
                       Inc(PosCount, 2);
                       while FHelp < PColorCount^ do
                       begin
                         PEncodeRGBA^ := 0;
                         CopyMemory(PEncodeRGBA, PInteger(Integer(FWIL)+ PosCount), 2);
                         PBGR^ := ($7F00 or (Trunc((((PEncodeRGBA^ and 63488) shr 11) * 8.225806) + 0.5))) shl 8;
                         PBGR^ := (PBGR^ or (Trunc((((PEncodeRGBA^ and  2016) shr  5) * 4.047619) + 0.5))) shl 8;
                         PBGR^ := (PBGR^ or (Trunc((((PEncodeRGBA^ and    31) shr  0) * 8.225806) + 0.5)));
                         PInteger(Integer(d3dlr.pBits) + Y * d3dlr.Pitch + PIncX^ * 4 )^ := PBGR^;
                         Inc(X); Inc(PosCount, 2); Inc(FHelp); Inc(PIncX^);
                       end;//while
                     end;//case in
                else X := PCount^;
              end;//case
            end;//while
          end;//for
          {$ENDREGION}
          FTexture.Unlock;
          APImageRecord.ihD3DTexture      := TMir3_Texture.Create;
          APImageRecord.ihOffset_X        := FHeaderImage.imgOffset_X;
          APImageRecord.ihOffset_Y        := FHeaderImage.imgOffset_Y;
          APImageRecord.ihOffsetShadow_X  := FHeaderImage.imgShadow_Offset_X;
          APImageRecord.ihOffsetShadow_Y  := FHeaderImage.imgShadow_Offset_Y;
          APImageRecord.ihTypeShadow      := FHeaderImage.imgShadow_type;
          APImageRecord.ihORG_Width       := FHeaderImage.imgWidth;
          APImageRecord.ihORG_Height      := FHeaderImage.imgHeight;
          APImageRecord.ihPO2_Width       := W;
          APImageRecord.ihPO2_Height      := H;
          APImageRecord.ihD3DTexture.LoadFromITexture(FTexture, FHeaderImage.imgWidth, FHeaderImage.imgHeight);
        except
          FTexture.Unlock;
//          if Assigned(APImageRecord) then
//          begin
//            if Assigned(APImageRecord.ihD3DTexture) then
//            begin
//              FreeAndNil(APImageRecord.ihD3DTexture);
//            end;
//            Dispose(APImageRecord);
//          end;
        end;
      end;
(*

// the function can read Type 1 and 2 File
function TMyWILWixReader.ReadImageFromIndex(IndexID: Integer; ImageContainer: TImageContainer): HResult;
var
  Hr            : HResult;
  FWILHeader    : TWIL_Header;
  FWILImage     : TWIL_Img_Header; 
  d3dlr         : TD3DLocked_Rect;
  FPosition     : Integer;
  FReadPosition : Integer;
  FSeek         : Integer;
  Pow2Height    : Integer;
  Pow2Width     : Integer;
  xCount        : Integer;           
  xInc          : Integer;  
  BGR           : Integer;
  ColorCount    : Integer;            
  vHelp         : Integer;       
  EncodeRGB     : Integer;            
  PEncodeRGB    : PInteger;
  PBGR, PCount  : PInteger;
  PXInc         : PInteger;
  PColorCount   : PInteger;

  procedure MakePowerOfTwoHW(var H, W: Integer; valH, valW: Word);
  begin
    H := 1 shl ceil(log2(valH));
    W := 1 shl ceil(log2(valW));
  end;

begin
  if (IndexID < $00) or (IndexID > $FFFF) then Exit;
  try
    CopyMemory(@FPosition, PInteger(Integer(FWIXPointer) + ((IndexID * 4) + 28))  , sizeOf(FPosition));
    if FPosition <=0 then Exit;

    FillChar(FWILHeader, SizeOf(TWIL_Header), #0);
    CopyMemory(@FWILHeader ,FWILPointer ,sizeOf(TWIL_Header));
    case FWILHeader.Lib_Version of
       17 : FSeek := 17; //type 1
     5000 : FSeek := 21; //type 2
     else exit;
    end;

    PEncodeRGB := @EncodeRGB;
    PColorCount:= @ColorCount;
    PBGR       := @BGR;
    PCount     := @xCount;
    PXInc      := @xInc;

    FillChar(FWILImage, SizeOf(TWIL_Img_Header), #0);                        
    CopyMemory(@FWILImage, PInteger(Integer(FWILPointer) + FPosition)  ,sizeOf(TWIL_Img_Header));
    FReadPosition := FPossition + FSeek;

    MakePowerOfTwoHW(Pow2Height ,Pow2Width ,FWILImage.Height, FWILImage.Width);

    // .....
    // put all the things to the ImageContainer Height ,Width ,Offsets from WILImageHeader ec...
    // .....

    if Failed(D3DXCreateTexture(D3DDevice ,Pow2Width ,Pow2Height ,0 ,0 ,D3DFMT_A8B8G8R8 ,D3DPOOL_MANAGED, ImageContainer.Texture)) then
    begin
      Result := E_Fail;
      Exit;
    end;
    Hr := ImageContainer.Texture.LockRect(0, d3dlr, nil, 0);
    if Hr <> D3D_OK then
    begin
      Result := E_Fail;
      exit;
    end;

    try
      for y:=0 to FWILImage.Height-1 do
      begin
        PXInc^  := 0;
        x       := 0;
        PCount^ := 0;
        CopyMemory(PCount, PInteger(Integer(FWILPointer) + FReadPosition), sizeOf(Word));
        Inc(FReadPosition, 2);
        while x < PCount^ do
        begin
          Inc(x);
          case PByte(Integer(FWILPointer)+ FReadPosition)^ of
            192: begin // Black
                   // I don't Read here the Black Color, it is not need if I work with DirectX Texture
                   // so it is faster ^^. Only I Inc the counters
                   Inc(x);
                   Inc(FReadPosition, 2);
                   Inc(PxInc^, PWord(Integer(FWILPointer)+ FReadPosition)^);
                   Inc(FReadPosition, 2);
                 end;
            //
            // Here I show you a optimize way, I know, it is not so easy to understand
            // It is a bit like the Kaori Initial Code, I only have change some things 
            // to get it faster. Don't Modifi it, if you don't have Knowlage !!
            //

            193: begin // Color
                   Inc(FReadPosition, 2);
                   Inc(x);
                   vHelp := 0;
                   PColorCount^ := 0;
                   CopyMemory(PColorCount, PLongWord(Integer(FWILPointer)+ FReadPosition), 2);
                   Inc(FReadPosition, 2);
                   while vHelp < PColorCount^ do
                   begin
                     PEncodeRGB^ := 0;
                     CopyMemory(PEncodeRGB, PInteger(Integer(FWILPointer)+ FReadPosition), 2);
                     PBGR^ := ($FF00 or (Trunc((((PEncodeRGB^ and 63488) shr 11) * 8.225806)))) shl 8;
                     PBGR^ := (PBGR^ or (Trunc((((PEncodeRGB^ and  2016) shr  5) * 4.047619)))) shl 8;
                     PBGR^ := (PBGR^ or (Trunc((((PEncodeRGB^ and    31) shr  0) * 8.225806))));
                     PInteger(Integer(d3dlr.pBits) + Y * d3dlr.Pitch + PXInc^ * 4 )^ := PBGR^;
                     Inc(x);
                     Inc(FReadPosition, 2);
                     Inc(vHelp);
                     Inc(PxInc^);
                   end;// while do
                 end;// if
            194: begin // Alpha
                   Inc(FReadPosition, 2);
                   Inc(x);
                   vHelp := 0;
                   PColorCount^ := 0;
                   CopyMemory(PColorCount, PInteger(Integer(FWILPointer)+ FReadPosition), 2);
                   Inc(FReadPosition, 2);
                   while vHelp < PColorCount^ do
                   begin
                     PEncodeRGB^ := 0;
                     CopyMemory(PEncodeRGB, PInteger(Integer(FWILPointer)+ FReadPosition), 2);
                     PBGR^ := ($7F00 or (Trunc((((PEncodeRGB^ and 63488) shr 11) * 8.225806) + 0.5))) shl 8;
                     PBGR^ := (PBGR^ or (Trunc((((PEncodeRGB^ and  2016) shr  5) * 4.047619) + 0.5))) shl 8;
                     PBGR^ := (PBGR^ or (Trunc((((PEncodeRGB^ and    31) shr  0) * 8.225806) + 0.5)));
                     PInteger(Integer(d3dlr.pBits) + Y * d3dlr.Pitch + PXInc^ * 4)^ := PBGR^;
                     Inc(x);
                     Inc(FReadPosition, 2);
                     Inc(vHelp);
                     Inc(PxInc^);
                   end;// while do
                 end;// if
          end;// case of
        end;// while do
      end;// for to do
    finally
      ImageContainer.Texture.UnlockRect(0);
    end;
  except
   // Handle Error
  end;
end;

  if Ftype = 0 then
  begin
    if G3 then
      G3T := 0
    else
      G3T := 2;
    m_FileStream.Seek(Position, 0);
    m_FileStream.Read(imginfo2, sizeof(TNewWilImageInfo));
    SetLength(Buf, imginfo2.Length * 2);
    m_FileStream.Read(Buf[0], imginfo2.Length * 2);
    nWidthStart := 0;
    nWidthend := 0;
    nCurrWidth := 0;
    w := 1 Shl ceil(log2(imginfo2.Width));
    h := 1 Shl ceil(log2(imginfo2.Height));


    Image := FHGE.Texture_Create(w, h);
    color := image.Lock(False);
    colorfirst := LongWord(color);
    for nYCnt := 0 To 1 - G3T Do
    begin
      nWidthend := nWidthend + Buf[nWidthStart];
      //Inc(nWidthStart);
      Inc(nWidthend);
      nWidthStart := nWidthend;
    end;

    for nycnt := imginfo2.Height - G3T - 1 Downto 0 Do
    begin
      nWidthend := Buf[nwidthstart] + nWidthend;
      Inc(nWidthStart);
      x := nWidthStart;
      While x < nwidthend Do
      begin
        if Buf[x] = $C0 then
        begin
          Inc(x);
          nCntCopyWord := Buf[x];
          Inc(x);
          nCurrWidth := nCurrWidth + nCntCopyWord;
        end
        else if (Buf[x] = $C1) Or (Buf[x] = $C2) Or (Buf[x] = $C3) then
        begin
          Inc(x);
          nCntCopyWord := Buf[x];
          Inc(x);
          nLastWidth := nCurrWidth;
          nCurrWidth := nCurrWidth + nCntCopyWord;
          if (imginfo2.Width < nLastWidth) then
            x := x + nCntCopyWord
          else
          begin
            if (nLastWidth <= imginfo2.Width) And (imginfo2.Width < nCurrWidth) then
            begin
              color := plongword((colorfirst + (nycnt * (w) + nlastwidth) * 4));
              for k := x To (((imginfo2.Width - nlastwidth)) + x) - 1 Do
              begin
                color^ := ARGB(255, (buf[k] And $F800) Shr 8, (buf[k] And $7E0) Shr 3, (buf[k] And $1F) Shl 3);
                inc(color);
              end;
              x := x + ncntcopyword;
            end
            else
            begin
              color := plongword((colorfirst + (nycnt * (w) + nlastwidth) * 4));
              for k := x To (((nCntCopyWord)) + x) - 1 Do
              begin
                color^ := ARGB(255, (buf[k] And $F800) Shr 8, (buf[k] And $7E0) Shr 3, (buf[k] And $1F) Shl 3);
                inc(color);
              end;
              x := x + ncntcopyword;
            end;
          end;
        end
        else
        begin
          inc(x);
        end;
      end;
      Inc(nWidthend);
      nWidthStart := nWidthend;
      nCurrWidth := 0;
    end;
    Image.Unlock;
    pdximg.surface := THGEEIImages.Create;
    pdximg.nPx := imginfo2.px;
    pdximg.nPy := imginfo2.py;
    pdximg.nsPx := imginfo2.Shadowx;
    pdximg.nsPy := imginfo2.Shadowy;
    pdximg.btType := imginfo2.Shadow;
    pdximg.surface.LoadFromITexture(image, imginfo2.Width, imginfo2.Height);
  end;
*)



      function TMir3_TextureLibrary.DecodeFrame32ToMir3D3DX(AFrame: Integer; var APImageRecord: PImageHeaderD3D;  AColor: Word): Boolean;
//      var
//        FPosition    : Integer;
//        X, Y, H, W   : Integer;
//        FHelp        : Integer;
//        FEncodeRGBA  : Integer; PEncodeRGBA  : PInteger;
//        FColorCount  : Integer; PColorCount  : PInteger;
//        FCount       : Integer; PCount       : PInteger;
//        FIncX        : Integer; PIncX        : PInteger;
//        FBGR         : Integer; PBGR         : PInteger;
//        PosCount     : LongInt;

        function ByteSwapColor(Color:Integer):Integer; register;
        asm
          BSWAP EAX
          SHR   EAX,8
        end;

      begin

      end;
  {$ENDREGION}

  {$REGION ' - TMir3_FileMapping '}
    constructor TMir3_FileMapping.Create;
    begin
      inherited Create;
      FStaticFileIndex := nil;
      SetLength(FStaticFileIndex, MAX_FILE_MAPPING);
    end;
    
    destructor TMir3_FileMapping.Destroy;
    var
      I : Integer;
    begin
      if Assigned(FStaticFileIndex) then
      begin
        for I := Low(FStaticFileIndex) to High(FStaticFileIndex) do
        begin
          if Assigned(FStaticFileIndex[I]) then
          begin
            Dispose(FStaticFileIndex[I]);
            FStaticFileIndex[I] := nil;
          end;
        end;
      end;
      FStaticFileIndex := nil;
      inherited;
    end;
    
    function TMir3_FileMapping.GetStaticFile(AIndex: Integer): Pointer;
    begin
      Result := nil;
      if Assigned(FStaticFileIndex) then
      begin
        Result := FStaticFileIndex[AIndex];
      end;
    end;
    
    procedure TMir3_FileMapping.SetStaticFile(AIndex: Integer; AFilePointer: Pointer);
    begin
      FStaticFileIndex[AIndex] := AFilePointer;
    end;
    
    procedure TMir3_FileMapping.CleanUpStaticFileMapping(AIndex: Integer);
    begin
      FStaticFileIndex[AIndex] := nil;
    end;
  {$ENDREGION}

  {$REGION ' - TMir3_ImageManager '}
    constructor TMir3_Texture.Create();
    begin
      Inherited;
    
    end;
    
    destructor TMir3_Texture.Destroy();
    begin
      FQuad.Tex.Handle    := nil;
      FQuad.Tex           := nil;
      FStaticImage.Handle := nil;
      FStaticImage        := nil;
      Inherited;
    end;

    function TMir3_Texture.GetPixels(AX, AY: Integer): LongWord;
    var
      OldColP : PLongWord;
    begin
      if Assigned(FStaticImage) then
      begin
        if ((AX > FWidth) or (AX < 0)) or ((AY > FHeight) or (AY < 0)) then
        begin
          Result := 0;
          exit;
        end;
    
        OldColP := FStaticImage.Lock(True);
        Inc(OldColp, AY * FTexWidth + AX);
        Result := OldColp^;
        FStaticImage.Unlock;
      end else Result := 0;
    end;
    
    procedure TMir3_Texture.ColorToGray(out Tmp: ITexture);
    Var
      OldColP : PLongWord;
      TmpColP : PLongWord;
      I, J    : Integer;
      g       : byte;
    begin
      if Assigned(FStaticImage) then
      begin
        tmp := GRenderEngine.Texture_Create(self.FTexWidth, Self.FTexHeight);
        OldColP := FStaticImage.Lock(False);
        TmpColP := tmp.Lock(true);
        for I := 0 to FHeight - 1 do
        begin
          for J := 0 to FWidth - 1 do
          begin
            if OldColP^ = 0 then
            begin
              Inc(OldColP);
              Inc(tmpColP);
              Continue;
            end else begin
              g := GetG(OldColp^);
              tmpColP^ := ARGB(255, g, g, g);
            end;
            Inc(OldColP);
            inc(tmpColP);
          end;
          Inc(OldColP, FTexWidth - FWidth);
          Inc(TmpColP, FTexWidth - FWidth);
        end;
        FStaticImage.Unlock;
        tmp.Unlock;
      end;
    end;
    
    procedure TMir3_Texture.ChangeColor(out Tmp: ITexture; R, G, B: Byte);
    var
      OldColP           : PLongWord;
      TmpColP           : PLongWord;
      I, J              : Integer;
      R1, G1, B1, A1    : byte;
    begin
      if FStaticImage <> nil then
      begin
        tmp := GRenderEngine.Texture_Create(self.FTexWidth, Self.FTexHeight);
        OldColP := FStaticImage.Lock(False);
        TmpColP := tmp.Lock(true);
        for I := 0 to FHeight - 1 do
        begin
          for J := 0 to FWidth - 1 do
          begin
            if OldColP^ = 0 then
            begin
              Inc(OldColP);
              Inc(tmpColP);
              Continue;
            end;
            R1 := GetR(OldColP^);
            G1 := GetG(OldColP^);
            B1 := GetB(OldColP^);
            if (R1 < 128) Or (G1 < 128) Or (B1 < 128) then
            begin
              TmpColp^ := OldColP^;
              Inc(OldColP);
              Inc(tmpColP);
              Continue;
            end;
            A1 := GetA(OldColP^);
            if (abs(R1 - G1) In [0..15]) And (abs(G1 - B1) In [0..15]) then
            begin
              TmpColp^ := ARGB(A1, R, G, B);
              Inc(OldColP);
              Inc(tmpColP);
            end else begin
              TmpColp^ := OldColP^;
              Inc(OldColP);
              Inc(tmpColP);
            end;
          end;
          Inc(OldColP, FTexWidth - FWidth);
          Inc(TmpColP, FTexWidth - FWidth);
        end;
        FStaticImage.Unlock;
        tmp.Unlock;
      end;
    end;
    
    procedure TMir3_Texture.LoadFromITexture(AImages: ITexture; AWidth, AHeight: Integer);
    begin
      FStaticImage       := AImages;
      FTexWidth          := FStaticImage.GetWidth();
      FTexHeight         := FStaticImage.GetHeight();
      FWidth             := AWidth;
      FHeight            := AHeight;
      FQuad.Tex          := FStaticImage;
      FQuad.V[3].TX      := 0;
      FQuad.V[3].TY      := 0;                    //left
      FQuad.V[2].TX      := FWidth / FTexWidth;
      FQuad.V[2].TY      := 0;                    //right
      FQuad.V[1].TX      := FWidth / FTexWidth;
      FQuad.V[1].TY      := FHeight / FTexHeight; //rightbottom
      FQuad.V[0].TX      := 0;
      FQuad.V[0].TY      := FHeight / FTexHeight; //leftbottom
      FQuad.Blend        := BLEND_DEFAULT;
      FQuad.V[0].Col     := $FFFFFFFF;
      FQuad.V[1].Col     := $FFFFFFFF;
      FQuad.V[2].Col     := $FFFFFFFF;
      FQuad.V[3].Col     := $FFFFFFFF;
      FClientRect.Left   := 0;
      FClientRect.Top    := 0;
      FClientRect.Right  := FWidth;
      FClientRect.Bottom := FHeight;
    end;
    
  {$ENDREGION}


constructor TMir3_FileManager.Create();
begin
  Inherited;
  FTextureManager := TMir3_FileMapping.Create;
  GStopThreads    := False;
  FThreadsRunning := 1;
  FManager        := TMir3_FileCashManager.Create(Self);
  FManager.Resume;
end;

destructor TMir3_FileManager.Destroy();
var
  I, I2 : Integer;
  FF: PFileInformation;
begin
  FManager.Terminate;
  FManager.WaitFor;

  for I := 0 to MAX_FILE_MAPPING do
  begin
    FF := FTextureManager.GetStaticFile(I);
    if Assigned(FF) then
    begin
      if Assigned(FF.fiImageList) then
      begin
        for I2 := Low(FF.fiImageList) to High(FF.fiImageList) do
        begin
          if Assigned(FF.fiImageList[I2]) then
          begin
            FreeAndNil(FF.fiImageList[I2].ihD3DTexture);
            Dispose(FF.fiImageList[I2]);
          end;
        end;
        SetLength(FF.fiImageList, 0);
      end;
      if Assigned(FF.fiImageLib) then
        FreeAndNil(FF.fiImageLib);
    end;
  end;

  if Assigned(FTextureManager) then
    FreeAndNil(FTextureManager);

  if Assigned(FManager) then
    FreeAndNil(FManager);
  Inherited;
end;

function TMir3_FileManager.TestIfInList(AType: Byte; AFileID: Integer) : PFileInformation;
var
  FFileInfo : PFileInformation;
begin
  new(FFileInfo);
  FFileInfo.fiFileID          := AFileID;
  FFileInfo.fiImageOpenCount  := 0;
  FFileInfo.fiImageMemoryUsag := 0;
  FFileInfo.fiUnloadFile      := True;
  FFileInfo.fiImageLib        := TMir3_TextureLibrary.Create;
  FFileInfo.fiImageLib.Open(GetFileNameByID(AFileID));
  FFileInfo.fiLastUseTick     := GetTickCount;
  FFileInfo.fiFirstUseTick    := GetTickCount;
  FTextureManager.SetStaticFile(AFileID, FFileInfo);
  Result := FFileInfo;
end;

function TMir3_FileManager.GetFileNameByID(AIndexID: Integer): String;
begin
  Result := '';
  case AIndexID of
    {$REGION ' - Map Texture Data            '}
     0: Result := MAP_TEXTURE_PHAT_DATA + MAP_TEXTURE_TILESC;
     1: Result := MAP_TEXTURE_PHAT_DATA + MAP_TEXTURE_TILES30C;
     2: Result := MAP_TEXTURE_PHAT_DATA + MAP_TEXTURE_TILES5C;
     3: Result := MAP_TEXTURE_PHAT_DATA + MAP_TEXTURE_SMTILESC;
     4: Result := MAP_TEXTURE_PHAT_DATA + MAP_TEXTURE_HOUSESC;
     5: Result := MAP_TEXTURE_PHAT_DATA + MAP_TEXTURE_CLIFFSC;
     6: Result := MAP_TEXTURE_PHAT_DATA + MAP_TEXTURE_DUNGEONSC;
     7: Result := MAP_TEXTURE_PHAT_DATA + MAP_TEXTURE_INNERSC;
     8: Result := MAP_TEXTURE_PHAT_DATA + MAP_TEXTURE_FUNITURESC;
     9: Result := MAP_TEXTURE_PHAT_DATA + MAP_TEXTURE_WALLSC;
    10: Result := MAP_TEXTURE_PHAT_DATA + MAP_TEXTURE_SMOBJECTSC;
    11: Result := MAP_TEXTURE_PHAT_DATA + MAP_TEXTURE_ANIMATIONSC;
    12: Result := MAP_TEXTURE_PHAT_DATA + MAP_TEXTURE_OBJECT1C;
    13: Result := MAP_TEXTURE_PHAT_DATA + MAP_TEXTURE_OBJECT2C;
    14: Result := MAP_TEXTURE_PHAT_DATA + MAP_TEXTURE_FREEUSER;
    {$ENDREGION}
    {$REGION ' - Map Texture Wood            '}
    15: Result := MAP_TEXTURE_PHAT_WOOD + MAP_TEXTURE_TILESC;
    16: Result := MAP_TEXTURE_PHAT_WOOD + MAP_TEXTURE_TILES30C;
    17: Result := MAP_TEXTURE_PHAT_WOOD + MAP_TEXTURE_TILES5C;
    18: Result := MAP_TEXTURE_PHAT_WOOD + MAP_TEXTURE_SMTILESC;
    19: Result := MAP_TEXTURE_PHAT_WOOD + MAP_TEXTURE_HOUSESC;
    20: Result := MAP_TEXTURE_PHAT_WOOD + MAP_TEXTURE_CLIFFSC;
    21: Result := MAP_TEXTURE_PHAT_WOOD + MAP_TEXTURE_DUNGEONSC;
    22: Result := MAP_TEXTURE_PHAT_WOOD + MAP_TEXTURE_INNERSC;
    23: Result := MAP_TEXTURE_PHAT_WOOD + MAP_TEXTURE_FUNITURESC;
    24: Result := MAP_TEXTURE_PHAT_WOOD + MAP_TEXTURE_WALLSC;
    25: Result := MAP_TEXTURE_PHAT_WOOD + MAP_TEXTURE_SMOBJECTSC;
    26: Result := MAP_TEXTURE_PHAT_WOOD + MAP_TEXTURE_ANIMATIONSC;
    27: Result := MAP_TEXTURE_PHAT_WOOD + MAP_TEXTURE_OBJECT1C;
    28: Result := MAP_TEXTURE_PHAT_WOOD + MAP_TEXTURE_OBJECT2C;
    29: Result := MAP_TEXTURE_PHAT_WOOD + MAP_TEXTURE_FREEUSER;
    {$ENDREGION}
    {$REGION ' - Map Texture Sand            '}
    30: Result := MAP_TEXTURE_PHAT_SAND + MAP_TEXTURE_TILESC;
    31: Result := MAP_TEXTURE_PHAT_SAND + MAP_TEXTURE_TILES30C;
    32: Result := MAP_TEXTURE_PHAT_SAND + MAP_TEXTURE_TILES5C;
    33: Result := MAP_TEXTURE_PHAT_SAND + MAP_TEXTURE_SMTILESC;
    34: Result := MAP_TEXTURE_PHAT_SAND + MAP_TEXTURE_HOUSESC;
    35: Result := MAP_TEXTURE_PHAT_SAND + MAP_TEXTURE_CLIFFSC;
    36: Result := MAP_TEXTURE_PHAT_SAND + MAP_TEXTURE_DUNGEONSC;
    37: Result := MAP_TEXTURE_PHAT_SAND + MAP_TEXTURE_INNERSC;
    38: Result := MAP_TEXTURE_PHAT_SAND + MAP_TEXTURE_FUNITURESC;
    39: Result := MAP_TEXTURE_PHAT_SAND + MAP_TEXTURE_WALLSC;
    40: Result := MAP_TEXTURE_PHAT_SAND + MAP_TEXTURE_SMOBJECTSC;
    41: Result := MAP_TEXTURE_PHAT_SAND + MAP_TEXTURE_ANIMATIONSC;
    42: Result := MAP_TEXTURE_PHAT_SAND + MAP_TEXTURE_OBJECT1C;
    43: Result := MAP_TEXTURE_PHAT_SAND + MAP_TEXTURE_OBJECT2C;
    44: Result := MAP_TEXTURE_PHAT_SAND + MAP_TEXTURE_FREEUSER;
    {$ENDREGION}
    {$REGION ' - Map Texture Snow            '}
    45: Result := MAP_TEXTURE_PHAT_SNOW + MAP_TEXTURE_TILESC;
    46: Result := MAP_TEXTURE_PHAT_SNOW + MAP_TEXTURE_TILES30C;
    47: Result := MAP_TEXTURE_PHAT_SNOW + MAP_TEXTURE_TILES5C;
    48: Result := MAP_TEXTURE_PHAT_SNOW + MAP_TEXTURE_SMTILESC;
    49: Result := MAP_TEXTURE_PHAT_SNOW + MAP_TEXTURE_HOUSESC;
    50: Result := MAP_TEXTURE_PHAT_SNOW + MAP_TEXTURE_CLIFFSC;
    51: Result := MAP_TEXTURE_PHAT_SNOW + MAP_TEXTURE_DUNGEONSC;
    52: Result := MAP_TEXTURE_PHAT_SNOW + MAP_TEXTURE_INNERSC;
    53: Result := MAP_TEXTURE_PHAT_SNOW + MAP_TEXTURE_FUNITURESC;
    54: Result := MAP_TEXTURE_PHAT_SNOW + MAP_TEXTURE_WALLSC;
    55: Result := MAP_TEXTURE_PHAT_SNOW + MAP_TEXTURE_SMOBJECTSC;
    56: Result := MAP_TEXTURE_PHAT_SNOW + MAP_TEXTURE_ANIMATIONSC;
    57: Result := MAP_TEXTURE_PHAT_SNOW + MAP_TEXTURE_OBJECT1C;
    58: Result := MAP_TEXTURE_PHAT_SNOW + MAP_TEXTURE_OBJECT2C;
    59: Result := MAP_TEXTURE_PHAT_SNOW + MAP_TEXTURE_FREEUSER;
    {$ENDREGION}
    {$REGION ' - Map Texture Forest          '}
    60: Result := MAP_TEXTURE_PHAT_FOREST + MAP_TEXTURE_TILESC;
    61: Result := MAP_TEXTURE_PHAT_FOREST + MAP_TEXTURE_TILES30C;
    62: Result := MAP_TEXTURE_PHAT_FOREST + MAP_TEXTURE_TILES5C;
    63: Result := MAP_TEXTURE_PHAT_FOREST + MAP_TEXTURE_SMTILESC;
    64: Result := MAP_TEXTURE_PHAT_FOREST + MAP_TEXTURE_HOUSESC;
    65: Result := MAP_TEXTURE_PHAT_FOREST + MAP_TEXTURE_CLIFFSC;
    66: Result := MAP_TEXTURE_PHAT_FOREST + MAP_TEXTURE_DUNGEONSC;
    67: Result := MAP_TEXTURE_PHAT_FOREST + MAP_TEXTURE_INNERSC;
    68: Result := MAP_TEXTURE_PHAT_FOREST + MAP_TEXTURE_FUNITURESC;
    69: Result := MAP_TEXTURE_PHAT_FOREST + MAP_TEXTURE_WALLSC;
    70: Result := MAP_TEXTURE_PHAT_FOREST + MAP_TEXTURE_SMOBJECTSC;
    71: Result := MAP_TEXTURE_PHAT_FOREST + MAP_TEXTURE_ANIMATIONSC;
    72: Result := MAP_TEXTURE_PHAT_FOREST + MAP_TEXTURE_OBJECT1C;
    73: Result := MAP_TEXTURE_PHAT_FOREST + MAP_TEXTURE_OBJECT2C;
    74: Result := MAP_TEXTURE_PHAT_FOREST + MAP_TEXTURE_FREEUSER;
    {$ENDREGION}
    {$REGION ' - Game Texture (start pos 80) '}
    80: Result := MAP_TEXTURE_PHAT_DATA + GAME_TEXTURE_INTERFACE1C;
    81: Result := MAP_TEXTURE_PHAT_DATA + GAME_TEXTURE_PROGUSE;
    82: Result := MAP_TEXTURE_PHAT_DATA + GAME_TEXTURE_GAMEINTER;
    83: Result := MAP_TEXTURE_PHAT_DATA + GAME_TEXTURE_GAMEINTER1;
    84: Result := MAP_TEXTURE_PHAT_DATA + GAME_TEXTURE_GAMEINTER2;
    85: Result := MAP_TEXTURE_PHAT_DATA + GAME_TEXTURE_NPC;
    86: Result := MAP_TEXTURE_PHAT_DATA + GAME_TEXTURE_NPCFACE;
    87: Result := MAP_TEXTURE_PHAT_DATA + GAME_TEXTURE_MICON;
    88: Result := MAP_TEXTURE_PHAT_DATA + GAME_TEXTURE_MAPICON;
    89: Result := MAP_TEXTURE_PHAT_DATA + GAME_TEXTURE_MMAP;
    90: Result := MAP_TEXTURE_PHAT_DATA + GAME_TEXTURE_FMMAP;
    91: Result := MAP_TEXTURE_PHAT_DATA + GAME_TEXTURE_INVENTORY;
    92: Result := MAP_TEXTURE_PHAT_DATA + GAME_TEXTURE_STOREITEM;
    93: Result := MAP_TEXTURE_PHAT_DATA + GAME_TEXTURE_EQUIP;
    94: Result := MAP_TEXTURE_PHAT_DATA + GAME_TEXTURE_GROUND;
    95: Result := MAP_TEXTURE_PHAT_DATA + GAME_TEXTURE_PEQUIPH1;
    96: Result := MAP_TEXTURE_PHAT_DATA + GAME_TEXTURE_PEQUIPB1;
    {$ENDREGION}
    {$REGION ' - Human Texture               '}
   100: Result := MAP_TEXTURE_PHAT_DATA + HUMAN_TEXTURE_M_HUM_1;
   101: Result := MAP_TEXTURE_PHAT_DATA + HUMAN_TEXTURE_WM_HUM_1;
   102: Result := MAP_TEXTURE_PHAT_DATA + HUMAN_TEXTURE_M_HUM_2;
   103: Result := MAP_TEXTURE_PHAT_DATA + HUMAN_TEXTURE_WM_HUM_2;
   104: Result := MAP_TEXTURE_PHAT_DATA + HUMAN_TEXTURE_M_HUM_3;
   105: Result := MAP_TEXTURE_PHAT_DATA + HUMAN_TEXTURE_WM_HUM_3;
   106: Result := MAP_TEXTURE_PHAT_DATA + HUMAN_TEXTURE_M_HUM_4;
   107: Result := MAP_TEXTURE_PHAT_DATA + HUMAN_TEXTURE_WM_HUM_4;
   108: Result := MAP_TEXTURE_PHAT_DATA + HUMAN_TEXTURE_M_HUM_5;
   109: Result := MAP_TEXTURE_PHAT_DATA + HUMAN_TEXTURE_WM_HUM_5;
   110: Result := MAP_TEXTURE_PHAT_DATA + HUMAN_TEXTURE_M_HUM_6;
   111: Result := MAP_TEXTURE_PHAT_DATA + HUMAN_TEXTURE_WM_HUM_6;
  { Human Wings }
   112: Result := MAP_TEXTURE_PHAT_DATA + HUMAN_TEXTURE_M_SHUM_1;
   113: Result := MAP_TEXTURE_PHAT_DATA + HUMAN_TEXTURE_WM_SHUM_1;
   114: Result := MAP_TEXTURE_PHAT_DATA + HUMAN_TEXTURE_M_SHUM_2;
   115: Result := MAP_TEXTURE_PHAT_DATA + HUMAN_TEXTURE_WM_SHUM_2;
  { Human Hair }
   116: Result := MAP_TEXTURE_PHAT_DATA + HUMAN_TEXTURE_M_HAIR_1;
   117: Result := MAP_TEXTURE_PHAT_DATA + HUMAN_TEXTURE_WM_HAIR_1;
   118: Result := MAP_TEXTURE_PHAT_DATA + HUMAN_TEXTURE_M_HAIR_2;
   119: Result := MAP_TEXTURE_PHAT_DATA + HUMAN_TEXTURE_WM_HAIR_2;
   120: Result := MAP_TEXTURE_PHAT_DATA + HUMAN_TEXTURE_M_HAIR_3;
   121: Result := MAP_TEXTURE_PHAT_DATA + HUMAN_TEXTURE_WM_HAIR_3;
   122: Result := MAP_TEXTURE_PHAT_DATA + HUMAN_TEXTURE_M_HAIR_4;
   123: Result := MAP_TEXTURE_PHAT_DATA + HUMAN_TEXTURE_WM_HAIR_4;
  { Human Helmet }
   124: Result := MAP_TEXTURE_PHAT_DATA + HUMAN_TEXTURE_M_HELMET_1;
   125: Result := MAP_TEXTURE_PHAT_DATA + HUMAN_TEXTURE_WM_HELMET_1;
   126: Result := MAP_TEXTURE_PHAT_DATA + HUMAN_TEXTURE_M_HELMET_2;
   127: Result := MAP_TEXTURE_PHAT_DATA + HUMAN_TEXTURE_WM_HELMET_2;
   128: Result := MAP_TEXTURE_PHAT_DATA + HUMAN_TEXTURE_M_HELMET_3;
   129: Result := MAP_TEXTURE_PHAT_DATA + HUMAN_TEXTURE_WM_HELMET_3;
   130: Result := MAP_TEXTURE_PHAT_DATA + HUMAN_TEXTURE_M_HELMET_4;
   131: Result := MAP_TEXTURE_PHAT_DATA + HUMAN_TEXTURE_WM_HELMET_4;
   132: Result := MAP_TEXTURE_PHAT_DATA + HUMAN_TEXTURE_M_HELMET_5;
   133: Result := MAP_TEXTURE_PHAT_DATA + HUMAN_TEXTURE_WM_HELMET_5;
   134: Result := MAP_TEXTURE_PHAT_DATA + HUMAN_TEXTURE_M_HELMET_6;
   135: Result := MAP_TEXTURE_PHAT_DATA + HUMAN_TEXTURE_WM_HELMET_6;
  { Human Weapon }
   136: Result := MAP_TEXTURE_PHAT_DATA + HUMAN_TEXTURE_M_WEAPON_1;
   137: Result := MAP_TEXTURE_PHAT_DATA + HUMAN_TEXTURE_WM_WEAPON_1;
   138: Result := MAP_TEXTURE_PHAT_DATA + HUMAN_TEXTURE_M_WEAPON_2;
   139: Result := MAP_TEXTURE_PHAT_DATA + HUMAN_TEXTURE_WM_WEAPON_2;
   140: Result := MAP_TEXTURE_PHAT_DATA + HUMAN_TEXTURE_M_WEAPON_3;
   141: Result := MAP_TEXTURE_PHAT_DATA + HUMAN_TEXTURE_WM_WEAPON_3;
   142: Result := MAP_TEXTURE_PHAT_DATA + HUMAN_TEXTURE_M_WEAPON_4;
   143: Result := MAP_TEXTURE_PHAT_DATA + HUMAN_TEXTURE_WM_WEAPON_4;
   144: Result := MAP_TEXTURE_PHAT_DATA + HUMAN_TEXTURE_M_WEAPON_5;
   145: Result := MAP_TEXTURE_PHAT_DATA + HUMAN_TEXTURE_WM_WEAPON_5;
   146: Result := MAP_TEXTURE_PHAT_DATA + HUMAN_TEXTURE_M_WEAPON_6;
   147: Result := MAP_TEXTURE_PHAT_DATA + HUMAN_TEXTURE_WM_WEAPON_6;
   148: Result := MAP_TEXTURE_PHAT_DATA + HUMAN_TEXTURE_M_WEAPON_7;
   149: Result := MAP_TEXTURE_PHAT_DATA + HUMAN_TEXTURE_WM_WEAPON_7;
   150: Result := MAP_TEXTURE_PHAT_DATA + HUMAN_TEXTURE_M_WEAPON_8;
   151: Result := MAP_TEXTURE_PHAT_DATA + HUMAN_TEXTURE_WM_WEAPON_8;
   152: Result := MAP_TEXTURE_PHAT_DATA + HUMAN_TEXTURE_M_WEAPON_9;
   153: Result := MAP_TEXTURE_PHAT_DATA + HUMAN_TEXTURE_WM_WEAPON_9;
   154: Result := MAP_TEXTURE_PHAT_DATA + HUMAN_TEXTURE_M_WEAPON_10;
   155: Result := MAP_TEXTURE_PHAT_DATA + HUMAN_TEXTURE_WM_WEAPON_10;
   156: Result := MAP_TEXTURE_PHAT_DATA + HUMAN_TEXTURE_M_WEAPON_11;
   157: Result := MAP_TEXTURE_PHAT_DATA + HUMAN_TEXTURE_WM_WEAPON_11;
   158: Result := MAP_TEXTURE_PHAT_DATA + HUMAN_TEXTURE_M_WEAPON_12;
   159: Result := MAP_TEXTURE_PHAT_DATA + HUMAN_TEXTURE_WM_WEAPON_12;
  { Human Weapon Assassin }
   160: Result := MAP_TEXTURE_PHAT_DATA + HUMAN_TEXTURE_M_WEAPON_A1;
   161: Result := MAP_TEXTURE_PHAT_DATA + HUMAN_TEXTURE_WM_WEAPON_A1;
   162: Result := MAP_TEXTURE_PHAT_DATA + HUMAN_TEXTURE_M_WEAPON_A2;
   163: Result := MAP_TEXTURE_PHAT_DATA + HUMAN_TEXTURE_WM_WEAPON_A2;
   164: Result := MAP_TEXTURE_PHAT_DATA + HUMAN_TEXTURE_M_WEAPON_ADL1;
   165: Result := MAP_TEXTURE_PHAT_DATA + HUMAN_TEXTURE_WM_WEAPON_ADL1;
   166: Result := MAP_TEXTURE_PHAT_DATA + HUMAN_TEXTURE_M_WEAPON_ADL2;
   167: Result := MAP_TEXTURE_PHAT_DATA + HUMAN_TEXTURE_WM_WEAPON_ADL2;
   168: Result := MAP_TEXTURE_PHAT_DATA + HUMAN_TEXTURE_M_WEAPON_ADR1;
   169: Result := MAP_TEXTURE_PHAT_DATA + HUMAN_TEXTURE_WM_WEAPON_ADR1;
   170: Result := MAP_TEXTURE_PHAT_DATA + HUMAN_TEXTURE_M_WEAPON_ADR2;
   171: Result := MAP_TEXTURE_PHAT_DATA + HUMAN_TEXTURE_WM_WEAPON_ADR2;
   172: Result := MAP_TEXTURE_PHAT_DATA + HUMAN_TEXTURE_M_WEAPON_AOH1;
   173: Result := MAP_TEXTURE_PHAT_DATA + HUMAN_TEXTURE_WM_WEAPON_AOH1;
   174: Result := MAP_TEXTURE_PHAT_DATA + HUMAN_TEXTURE_M_WEAPON_AOH2;
   175: Result := MAP_TEXTURE_PHAT_DATA + HUMAN_TEXTURE_WM_WEAPON_AOH2;
   176: Result := MAP_TEXTURE_PHAT_DATA + HUMAN_TEXTURE_M_WEAPON_AOH3;
   177: Result := MAP_TEXTURE_PHAT_DATA + HUMAN_TEXTURE_WM_WEAPON_AOH3;
    {$ENDREGION}
    {$REGION ' - Human Monster Horse         '}
   180: Result := MAP_TEXTURE_PHAT_DATA + MONSTER_TEXTURE_HORSE_Shadow;
   181: Result := MAP_TEXTURE_PHAT_DATA + MONSTER_TEXTURE_HORSE_1;
   182: Result := MAP_TEXTURE_PHAT_DATA + MONSTER_TEXTURE_HORSE_2;
   183: Result := MAP_TEXTURE_PHAT_DATA + MONSTER_TEXTURE_HORSE_3;
   184: Result := MAP_TEXTURE_PHAT_DATA + MONSTER_TEXTURE_HORSE_4;
    {$ENDREGION}
    {$REGION ' - Human Magic                 '}
   190: Result := MAP_TEXTURE_PHAT_DATA + MAGIC_TEXTURE_1;
   191: Result := MAP_TEXTURE_PHAT_DATA + MAGIC_TEXTURE_2;
   192: Result := MAP_TEXTURE_PHAT_DATA + MAGIC_TEXTURE_3;
   193: Result := MAP_TEXTURE_PHAT_DATA + MAGIC_TEXTURE_4;
   194: Result := MAP_TEXTURE_PHAT_DATA + MAGIC_TEXTURE_5;
   195: Result := MAP_TEXTURE_PHAT_DATA + MAGIC_TEXTURE_6;
    {$ENDREGION}
    {$REGION ' - Human Monster Magic         '}
   200: Result := MAP_TEXTURE_PHAT_DATA + MAGIC_MONSTER_TEXTURE_1;
   201: Result := MAP_TEXTURE_PHAT_DATA + MAGIC_MONSTER_TEXTURE_2;
   202: Result := MAP_TEXTURE_PHAT_DATA + MAGIC_MONSTER_TEXTURE_3;
   203: Result := MAP_TEXTURE_PHAT_DATA + MAGIC_MONSTER_TEXTURE_4;
   204: Result := MAP_TEXTURE_PHAT_DATA + MAGIC_MONSTER_TEXTURE_5;
   205: Result := MAP_TEXTURE_PHAT_DATA + MAGIC_MONSTER_TEXTURE_6;
   206: Result := MAP_TEXTURE_PHAT_DATA + MAGIC_MONSTER_TEXTURE_7;
   207: Result := MAP_TEXTURE_PHAT_DATA + MAGIC_MONSTER_TEXTURE_8;
   208: Result := MAP_TEXTURE_PHAT_DATA + MAGIC_MONSTER_TEXTURE_9;
   209: Result := MAP_TEXTURE_PHAT_DATA + MAGIC_MONSTER_TEXTURE_10;
   210: Result := MAP_TEXTURE_PHAT_DATA + MAGIC_MONSTER_TEXTURE_11;
    {$ENDREGION}
   250..299 : Result := MAP_TEXTURE_PHAT_DATA + MONSTER_TEXTURE_NORMAL;
   300..349 : Result := MAP_TEXTURE_PHAT_DATA + MONSTER_TEXTURE_SHADOW;
  end;
end;

function TMir3_FileManager.GetFileMapping : TMir3_FileMapping;
begin
  Result := FTextureManager;
end;

function TMir3_FileManager.GetImageD3DDirect(var AImageID, AFileID: Integer): PImageHeaderD3D;
var
  FFileInfo : PFileInformation;
begin
  FFileInfo := FTextureManager.GetStaticFile(AFileID);
  if not Assigned(FFileInfo) then
  begin
    FFileInfo := TestIfInList(1,AFileID);
  end;
  if High(FFileInfo.fiImageList)+1 <= AImageID then
  begin
    SetLength(FFileInfo.fiImageList, FFileInfo.fiImageLib.GetLastImageInt+1);
  end;
  if Assigned(FFileInfo.fiImageList[AImageID]) and Assigned(FFileInfo.fiImageList[AImageID].ihD3DTexture) then
  begin
    Result                                       := FFileInfo.fiImageList[AImageID];
    FFileInfo.fiImageList[AImageID].ihUseTime    := GetTickCount;
    FFileInfo.fiLastUseTick                      := GetTickCount;
  end else begin
    FFileInfo.fiImageLib.DecodeFrame32ToMir3D3DX(AImageID, FFileInfo.fiImageList[AImageID]);
    if Assigned(FFileInfo.fiImageList[AImageID]) and Assigned(FFileInfo.fiImageList[AImageID].ihD3DTexture) then
    begin
      FFileInfo.fiImageList[AImageID].ihUseTime := GetTickCount;
      FFileInfo.fiLastUseTick                   := GetTickCount;
      Inc(FFileInfo.fiImageOpenCount);
      //IncExtended(FFileInfo.fiImageMemoryUsag, ((FFileInfo.fiImageList[AImageID].ihPO2_Width * FFileInfo.fiImageList[AImageID].ihPO2_Height) * 4));
    end;
    Result := FFileInfo.fiImageList[AImageID];
  end;
end;

procedure TMir3_FileManager.Draw(image: TMir3_Texture; X, y: Integer; Rect: TRect; Drawmode: Word; Alpha: byte);
var
  OldQuad           : THGEQuad;
  FTX               : Single;
  FTY               : Single;
  Tx1, ty1, tx2, ty2: single;
begin
  if Image <> nil then
  begin
    OldQuad := Image.FQuad;
    If Rect.Left > image.FWidth Then
      Rect.Left := image.FWidth;
    If Rect.Top > image.FHeight Then
      Rect.Top := image.FHeight;
    If Rect.Right > image.FWidth Then
      rect.Right := image.FWidth;
    If Rect.Bottom > image.FHeight Then
      rect.Bottom := image.FHeight;
    Ftx := rect.Left;
    Fty := Rect.Top;
    TX1 := FTX / image.FTexWidth;
    TY1 := FTY / image.FTexHeight;
    TX2 := (FTX + rect.Right - rect.left) / image.FTexWidth;
    TY2 := (FTY + Rect.Bottom - rect.top) / image.FTexHeight;
    Image.FQuad.V[0].TX := TX1;
    Image.FQuad.V[0].TY := TY1;

    Image.FQuad.V[1].TX := TX2;
    Image.FQuad.V[1].TY := TY1;

    Image.FQuad.V[2].TX := TX2;
    Image.FQuad.V[2].TY := TY2;

    Image.FQuad.V[3].TX := TX1;
    Image.FQuad.V[3].TY := TY2;

    Image.FQuad.V[3].X := x;
    Image.FQuad.V[3].Y := y;
    Image.FQuad.V[2].X := x + rect.Right - rect.left;
    Image.FQuad.V[2].Y := y;
    Image.FQuad.V[1].X := x + Rect.right - rect.left;
    Image.FQuad.V[1].Y := y + rect.Bottom - rect.top;
    Image.FQuad.V[0].X := x;
    Image.FQuad.V[0].Y := y + Rect.bottom - rect.top;
    Image.FQuad.V[0].Col := SetA(Image.FQuad.V[0].Col, Alpha);
    Image.FQuad.V[1].Col := SetA(Image.FQuad.V[1].Col, Alpha);
    Image.FQuad.V[2].Col := SetA(Image.FQuad.V[2].Col, Alpha);
    Image.FQuad.V[3].Col := SetA(Image.FQuad.V[3].Col, Alpha);
    image.FQuad.Blend := Drawmode;
    GRenderEngine.Gfx_RenderQuad(Image.FQuad);
    image.FQuad := OldQuad;
    OldQuad.Tex := nil;
  end;
end;

procedure TMir3_FileManager.Draw(Image: TMir3_Texture; X, y: integer; Drawmode: word; Alpha: Byte);
var
  OldQuad : THGEQuad;
begin
  If Image <> nil then
  begin
    OldQuad := Image.FQuad;
    Image.FQuad.V[0].X := x;
    Image.FQuad.V[0].Y := y;
    Image.FQuad.V[1].X := x + Image.FWidth;
    Image.FQuad.V[1].Y := y;
    Image.FQuad.V[2].X := x + Image.FWidth;
    Image.FQuad.V[2].Y := y + Image.FHeight;
    Image.FQuad.V[3].X := x;
    Image.FQuad.V[3].Y := y + Image.FHeight;
    Image.FQuad.V[0].Col := SetA(Image.FQuad.V[0].Col, Alpha);
    Image.FQuad.V[1].Col := SetA(Image.FQuad.V[1].Col, Alpha);
    Image.FQuad.V[2].Col := SetA(Image.FQuad.V[2].Col, Alpha);
    Image.FQuad.V[3].Col := SetA(Image.FQuad.V[3].Col, Alpha);
    image.FQuad.Blend := Drawmode;
    GRenderEngine.Gfx_RenderQuad(Image.FQuad);
    Image.FQuad := OldQuad;
  end;
end;

procedure TMir3_FileManager.DrawRect(AImageID, AFileID: Integer; AX, AY: Integer; ARect: TRect; ADrawmode: Word = BLEND_DEFAULT; AAlpha: Byte = 255);
var
  FOldQuad : THGEQuad;
  FImage   : TMir3_Texture;
  FTX      : Single;
  FTY      : Single;
  Tx1, Ty1,
  Tx2, Ty2 : single;
begin
  FImage := GetImageD3DDirect(AImageID, AFileID).ihD3DTexture;
  if Assigned(FImage) then
  begin
    FOldQuad := FImage.FQuad;
    If ARect.Left > FImage.FWidth Then
      ARect.Left := FImage.FWidth;
    If ARect.Top > FImage.FHeight Then
      ARect.Top := FImage.FHeight;
    If ARect.Right > FImage.FWidth Then
      ARect.Right := FImage.FWidth;
    If ARect.Bottom > FImage.FHeight Then
      ARect.Bottom := FImage.FHeight;
    Ftx := ARect.Left;
    Fty := ARect.Top;
    TX1 := FTX / FImage.FTexWidth;
    TY1 := FTY / FImage.FTexHeight;
    TX2 := (FTX + ARect.Right - ARect.left) / FImage.FTexWidth;
    TY2 := (FTY + ARect.Bottom - ARect.top) / FImage.FTexHeight;
    FImage.FQuad.V[0].TX := TX1;
    FImage.FQuad.V[0].TY := TY1;

    FImage.FQuad.V[1].TX := TX2;
    FImage.FQuad.V[1].TY := TY1;

    FImage.FQuad.V[2].TX := TX2;
    FImage.FQuad.V[2].TY := TY2;

    FImage.FQuad.V[3].TX := TX1;
    FImage.FQuad.V[3].TY := TY2;

    FImage.FQuad.V[3].X := AX;
    FImage.FQuad.V[3].Y := AY;
    FImage.FQuad.V[2].X := AX + ARect.Right  - ARect.left;
    FImage.FQuad.V[2].Y := AY;
    FImage.FQuad.V[1].X := AX + ARect.right  - ARect.left;
    FImage.FQuad.V[1].Y := AY + ARect.Bottom - ARect.top;
    FImage.FQuad.V[0].X := AX;
    FImage.FQuad.V[0].Y := AY + ARect.bottom - ARect.top;
    FImage.FQuad.V[0].Col := SetA(FImage.FQuad.V[0].Col, AAlpha);
    FImage.FQuad.V[1].Col := SetA(FImage.FQuad.V[1].Col, AAlpha);
    FImage.FQuad.V[2].Col := SetA(FImage.FQuad.V[2].Col, AAlpha);
    FImage.FQuad.V[3].Col := SetA(FImage.FQuad.V[3].Col, AAlpha);
    FImage.FQuad.Blend := ADrawmode;
    GRenderEngine.Gfx_RenderQuad(FImage.FQuad);
    FImage.FQuad := FOldQuad;
  end;
end;

procedure TMir3_FileManager.DrawStrech(Image: TMir3_Texture; X, y: integer; xRate: Single; yRate: Single; Drawmode: word; Alpha: Byte);
var
  OldQuad : THGEQuad;
begin
  if Image <> nil then
  begin
    OldQuad := Image.FQuad;
    Image.FQuad.V[0].X := x;
    Image.FQuad.V[0].Y := y;
    Image.FQuad.V[1].X := x + Image.FWidth * xRate;
    Image.FQuad.V[1].Y := y;
    Image.FQuad.V[2].X := x + Image.FWidth * xRate;
    Image.FQuad.V[2].Y := y + Image.FHeight * YRate;
    Image.FQuad.V[3].X := x;
    Image.FQuad.V[3].Y := y + Image.FHeight * YRate;
    Image.FQuad.V[0].Col := SetA(Image.FQuad.V[0].Col, Alpha);
    Image.FQuad.V[1].Col := SetA(Image.FQuad.V[1].Col, Alpha);
    Image.FQuad.V[2].Col := SetA(Image.FQuad.V[2].Col, Alpha);
    Image.FQuad.V[3].Col := SetA(Image.FQuad.V[3].Col, Alpha);
    image.FQuad.Blend := Drawmode;
    GRenderEngine.Gfx_RenderQuad(Image.FQuad);
    Image.FQuad := OldQuad;
  end;
end;

procedure TMir3_FileManager.DrawStrech(AImageID, AFileID: Integer; AX, AY: Integer; ARateX: Single; yRate: Single; Drawmode: word; Alpha: Byte);
var
  OldQuad : THGEQuad;
  FImage  : TMir3_Texture;
begin
  FImage := GetImageD3DDirect(AImageID, AFileID).ihD3DTexture;
  if Assigned(FImage) then
  begin
    OldQuad := FImage.FQuad;
    FImage.FQuad.V[0].X   := AX;
    FImage.FQuad.V[0].Y   := AY;
    FImage.FQuad.V[1].X   := AX + FImage.FWidth  * ARateX;
    FImage.FQuad.V[1].Y   := AY;
    FImage.FQuad.V[2].X   := AX + FImage.FWidth  * ARateX;
    FImage.FQuad.V[2].Y   := AY + FImage.FHeight * YRate;
    FImage.FQuad.V[3].X   := AX;
    FImage.FQuad.V[3].Y   := AY + FImage.FHeight * YRate;
    FImage.FQuad.V[0].Col := SetA(FImage.FQuad.V[0].Col, Alpha);
    FImage.FQuad.V[1].Col := SetA(FImage.FQuad.V[1].Col, Alpha);
    FImage.FQuad.V[2].Col := SetA(FImage.FQuad.V[2].Col, Alpha);
    FImage.FQuad.V[3].Col := SetA(FImage.FQuad.V[3].Col, Alpha);
    FImage.FQuad.Blend := DrawMode;
    GRenderEngine.Gfx_RenderQuad(FImage.FQuad);
    FImage.FQuad := OldQuad;
  end;
end;

procedure TMir3_FileManager.Draw(AImageID, AFileID: Integer; X, y: Integer; DrawMode: word = BLEND_DEFAULT; Alpha: Byte = 255);
var
  OldQuad : THGEQuad;
  FImage  : TMir3_Texture;
begin
  FImage := GetImageD3DDirect(AImageID, AFileID).ihD3DTexture;
  if Assigned(FImage) then
  begin
    OldQuad := FImage.FQuad;
    FImage.FQuad.V[0].X := x;
    FImage.FQuad.V[0].Y := y;
    FImage.FQuad.V[1].X := x + FImage.FWidth;
    FImage.FQuad.V[1].Y := y;
    FImage.FQuad.V[2].X := x + FImage.FWidth;
    FImage.FQuad.V[2].Y := y + FImage.FHeight;
    FImage.FQuad.V[3].X := x;
    FImage.FQuad.V[3].Y := y + FImage.FHeight;
    FImage.FQuad.V[0].Col := SetA(FImage.FQuad.V[0].Col, Alpha);
    FImage.FQuad.V[1].Col := SetA(FImage.FQuad.V[1].Col, Alpha);
    FImage.FQuad.V[2].Col := SetA(FImage.FQuad.V[2].Col, Alpha);
    FImage.FQuad.V[3].Col := SetA(FImage.FQuad.V[3].Col, Alpha);
    FImage.FQuad.Blend := Drawmode;
    GRenderEngine.Gfx_RenderQuad(FImage.FQuad);
    FImage.FQuad := OldQuad;
  end;
end;

procedure TMir3_FileManager.DrawColorChange(AImage: TMir3_Texture; AX, AY: Integer; R, G, B: Byte);
var
  FImageTemp        : ITexture;
  TmpQuad           : THGEQuad;
begin
  AImage.ChangeColor(FImageTemp, R, G, b);
  if FImageTemp <> nil then
  begin
    TmpQuad := AImage.FQuad;
    TmpQuad.V[0].X := AX;
    TmpQuad.V[0].Y := AY;
    TmpQuad.V[1].X := AX + AImage.FWidth;
    TmpQuad.V[1].Y := AY;
    TmpQuad.V[2].X := AX + AImage.FWidth;
    TmpQuad.V[2].Y := AY + AImage.FHeight;
    TmpQuad.V[3].X := AX;
    TmpQuad.V[3].Y := AY + AImage.FHeight;
    TmpQuad.Blend := BLEND_DEFAULT;
    TmpQuad.Tex := FImageTemp;
    GRenderEngine.Gfx_RenderQuad(TmpQuad);
  end;
end;

procedure TMir3_FileManager.DrawColor(AImage: TMir3_Texture; AX, AY: Integer; AColor: Cardinal);
Var
  FColor            : Cardinal;
Begin
  FColor := AImage.FQuad.V[0].Col;

  AImage.FQuad.V[0].X := AX;
  AImage.FQuad.V[0].Y := AY;
  AImage.FQuad.V[1].X := AX + AImage.FWidth;
  AImage.FQuad.V[1].Y := AY;
  AImage.FQuad.V[2].X := AX + AImage.FWidth;
  AImage.FQuad.V[2].Y := AY + AImage.FHeight;
  AImage.FQuad.V[3].X := AX;
  AImage.FQuad.V[3].Y := AY + AImage.FHeight;
  AImage.FQuad.Blend  := BLEND_DEFAULT;//Blend_Add;
  AImage.FQuad.V[0].Col := AColor;
  AImage.FQuad.V[1].Col := AColor;
  AImage.FQuad.V[2].Col := AColor;
  AImage.FQuad.V[3].Col := AColor;
  GRenderEngine.Gfx_RenderQuad(AImage.FQuad);

  AImage.FQuad.V[0].Col := FColor;
  AImage.FQuad.V[1].Col := FColor;
  AImage.FQuad.V[2].Col := FColor;
  AImage.FQuad.V[3].Col := FColor;
End;

procedure TMir3_FileManager.RenderVideo(AType: Byte);
var
  FLength : Int64;
begin
  CoInitialize(nil);
  CoCreateInstance(CLSID_FilterGraph, nil, CLSCTX_INPROC, IID_IGraphBuilder, pGraph);
  pGraph.QueryInterface(IVideoWindow,pVidWin);
  pGraph.QueryInterface(IID_IMediaControl, pMediaControl);
  pGraph.QueryInterface(IID_IMediaEvent, pEvent);
  pGraph.QueryInterface(IID_IMediaSeeking, pSeeking);
  pGraph.QueryInterface(IID_IBasicAudio,pBasicAudio);
  case AType of
    0: begin
      if FAILED(pGraph.RenderFile(MAP_TEXTURE_PHAT_DATA + VIDEO_GAME_START, nil)) then
      begin
        GRenderEngine.System_Log(' - Intel Indeo 5 Codec not found...');
      end;
      FLength := INFINITE;
    end;
    1: begin
      if FAILED(pGraph.RenderFile(MAP_TEXTURE_PHAT_DATA + VIDEO_GAME_CREATE_CHAR, nil)) then
      begin
        GRenderEngine.System_Log(' - Intel Indeo 5 Codec not found...');
      end;
      pGraph.RenderFile(SOUND_PHAT + VIDEO_SOUND_CREATE_CHAR, nil);
      FLength := 1324; // Video Special Cut, don't change it!!
    end;
    2: begin
      if FAILED(pGraph.RenderFile(MAP_TEXTURE_PHAT_DATA + VIDEO_GAME_START_GAME, nil)) then
      begin
        GRenderEngine.System_Log(' - Intel Indeo 5 Codec not found...');
      end;
      pGraph.RenderFile(SOUND_PHAT + VIDEO_SOUND_START_GAME, nil);
      FLength := 1424; // Video Special Cut, don't change it!!
    end;
  end;
  pBasicAudio.put_volume(FGameEngine.GameLauncherSetting.FVideoVolume);
  pBasicAudio := nil;
  pVidWin.put_owner(GRenderEngine.GetGameHWND);
  pVidWin.SetWindowPosition(0,0,800,600);
  pVidWin.put_MessageDrain(GRenderEngine.GetGameHWND);
  pVidWin.put_WindowStyle(WS_CHILD or WS_CLIPSIBLINGS or WS_CLIPCHILDREN);
  pMediaControl.Run();
  pEvent.WaitForCompletion(FLength, evCode);
  CoUninitialize();
end;

 { TMir3_FileCashManager }

constructor TMir3_FileCashManager.Create(ASpawnObject: TObject);
begin
  inherited Create(True);
  FreeOnTerminate := False;
  FSpawnObject    := ASpawnObject;
end;

destructor TMir3_FileCashManager.Destroy;
begin

  inherited;
end;

procedure TMir3_FileCashManager.Execute;
begin
  while not Terminated do
  begin
    WatchCachLogic;
    Sleep(450);
  end;
end;

procedure TMir3_FileCashManager.WatchCachLogic;
var
  FF: PFileInformation;
  I, I2, I3 : Integer;
begin
  for I := MAX_FILE_MAPPING downto 0 do
  begin
    FF := TMir3_FileManager(FSpawnObject).GetFileMapping.GetStaticFile(I);

    if not Assigned(FF) or (FF.fiUnloadFile = False) then Continue;

    if (GetTickCount - FF.fiLastUseTick) > 120000 then
    begin
      if Assigned(FF.fiImageList) then
      begin
        for I2 := Low(FF.fiImageList) to High(FF.fiImageList) do
        begin
          if Assigned(FF.fiImageList[I2]) then
          begin
            FreeAndNil(FF.fiImageList[I2].ihD3DTexture);
            Dispose(FF.fiImageList[I2]);
          end;
        end;
        SetLength(FF.fiImageList, 0);
      end;

      if Assigned(FF.fiImageLib) then
        FreeAndNil(FF.fiImageLib);
      TMir3_FileManager(FSpawnObject).GetFileMapping.CleanUpStaticFileMapping(FF.fiFileID);
    end else if (GetTickCount - FF.fiFirstUseTick) > 60000 then
             begin
               for I3 := Low(FF.fiImageList) to High(FF.fiImageList) do
               begin
                 if Assigned(FF.fiImageList[I3]) then
                   if (GetTickCount - FF.fiImageList[I3].ihUseTime) > 30000 then
                     if Assigned(FF.fiImageList[I3].ihD3DTexture) then
                     begin
                       //CS
                       //DecExtended(FF.fiImageMemoryUsag, ((FF.fiImageList[I3].ihPO2_Width * FF.fiImageList[I3].ihPO2_Height) * 4));
                       FreeAndNil(FF.fiImageList[I3].ihD3DTexture);
                       FF.fiImageList[I3].ihUseTime    := 0;
                       Dec(FF.fiImageOpenCount);
                       //CS
                     end;
               end;
             end;
    if (Terminated) then Exit;
  end;
end;


end.
