(*******************************************************************
 *   LomCN Mir3 Font System game File 2013                         *
 *                                                                 *
 *   Web       : http://www.lomcn.co.uk                            *
 *   Version   : 0.0.0.2                                           *
 *                                                                 *
 *   - File Info -                                                 *
 *                                                                 *
 *   A Texture Based Font Render System, create exlusive for this  *
 *   Client / Game                                                 *
 *                                                                 *
 *******************************************************************
 * Change History                                                  *
 *                                                                 *
 *  - 0.0.0.1 [2013-03-20] Coly : first init                       *
 *  - 0.0.0.2 [2013-03-20] Coly : Optimize Code (get 230 FPS more )*
 *                                                                 *
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
 *  - TODO : Add Color Use (need to have a Place Holder like       *
 *           {COLOR:AARRGGBB} {COLOR:AARRGGBB:END} )               *
 *  - TODO : Optimize Font System                                  *
 *  - TODO : Change Font System (Idea: Splitt to one Font)         *
 *                                                                 *
 *           --TFontEngine                                         *
 *                 |-TFont (Option:Size:FontType)                  *
 *                 |-TFont (Option:Size:FontType)                  *
 *                     "           "                               *
 *                                                                 * 
 *******************************************************************)

unit mir3_game_font_engine;

interface

uses 
{Delphi }  Windows, SysUtils ,Classes, 
{DirectX}  D3DX9, Direct3D9,
{Game   }  mir3_game_engine, mir3_game_file_manager, mir3_game_file_manager_const;

//Mir3FontData.mfd

type
  TMIR3_Align        = (alLeft, alCenter, alRight);
  TMIR3_VAlign       = (avTop , avCenter, avBottom);
  TMIR3_FontSetting  = (fsBold, fsItalic);
  PMIR3_FontSettings = ^TMIR3_FontSettings;
  TMIR3_FontSettings = set of TMIR3_FontSetting;

  PDrawSetting       = ^TDrawSetting;
  TDrawSetting       = record
    dsControlWidth   : Integer;
    dsControlHeigth  : Integer;
    dsAX             : Integer;
    dsAY             : Integer;
    dsAX_Offset      : Integer;
    dsAY_Offset      : Integer;
    dsFontHeight     : Integer;
    dsFontType       : Integer;
    dsFontSetting    : TMIR3_FontSettings;
    dsFontSpacing    : Integer;
    dsUseKerning     : Boolean;
    dsColor          : Longword;
    dsColorMC_1      : Longword;
    dsColorMC_2      : Longword;
    dsColorMC_3      : Longword;
    dsColorMC_4      : Longword;
    dsColorMC_B      : Longword;
    dsColorMC_B2     : Longword;
    dsHAlign         : TMir3_Align;
    dsVAlign         : TMIR3_VAlign;
    dsUseMultiColor  : Boolean;
    dsMaxWidth       : Integer;
    dsMagicUse       : Boolean;
  end;

  TTextScrollInfo = record
    FText : String[255];
    FShow : Boolean;
  end;
  
  TFontSetup = record
    fsFontType    : Integer;
    fsFontHeight  : Integer;
    fsFontSetting : TMIR3_FontSettings;  
  end;   

  {$REGION ' - MFD Binary File Records   '}
  TMFD_FontInformation    = packed record
    ihFontSize            : Word;
    ihFontBold            : Boolean;
    ihFontItalic          : Boolean;
    ihFontOutline         : Byte;
    chLineHeight          : Word;
    chBase                : Word;
    chScaleW              : Word;
    chScaleH              : Word;
  end; 

  PMFD_Char               =^TMFD_Char;
  TMFD_Char               = packed record
    chID                  : DWORD;
    chX                   : Word;
    chY                   : Word;
    chWidth               : Word;
    chHeight              : Word;
    chXOffset             : Smallint;
    chYOffset             : Smallint;
    chXAdvance            : Smallint;
    chChannel             : Byte;
  end;
  
  TMFD_Kerning            = packed record
    khFirst               : DWord;
    khSecond              : DWord;
    khAmount              : SmallInt;
  end;

  TMFD_BlockInfo          = packed record
    BlockType             : Byte;
    BlockSize             : Integer;
  end;

  TMFD_FileHeader         = packed record
    Magic                 : array [0..2] of char;
    Version               : DWord;
    SetsInFile            : Word;
  end;

  PMIR3_MFD_Font_Set       = ^TMIR3_MFD_Font_Set;
  TMIR3_MFD_Font_Set       = record
    FSetActive             : Boolean;
    FFontTexture           : TMir3_Texture;
    FFontInformationHeader : TMFD_FontInformation;
    FCharHeader            : array [0..600] of TMFD_Char;
    FKerningHeader         : array of TMFD_Kerning;
  end;

  {$ENDREGION}

  IMIR3_Font = interface
  ['{27CAF778-3E49-4E7C-93DF-2555498C1B70}']
    function GetFontIndex(ADrawSetting: PDrawSetting): Integer;
    function CalculateKerningPairs(AFontID, AFirst, ASecond: Integer): Single;
    function RenderText(const AFontHeight : Integer; AChar: PMFD_Char; AFontSet: PMIR3_MFD_Font_Set; AX, AY: Single; AColor: Longword = $FFFFFFFF): Single;
    function RenderTextMultiColor(const ADrawSetting: PDrawSetting; AChar: PMFD_Char; AFontSet: PMIR3_MFD_Font_Set; AX, AY: Single; AColor1: Longword = $FFFFFFFF; AColor2: Longword = $FFFFFFFF): Single;
    function LoadMFDFile(AFileName: String): Boolean;
    function GetLineCount(AText: PChar): Integer;
    function GetLineCountMaxWidth(AText: PChar; ADrawSetting: PDrawSetting): Integer;
    function GetScriptHeight(AText: PChar): Integer;
    function GetScriptedTextWidth(ALine: Integer; AText: PChar; ADrawSetting: PDrawSetting): Single;
    function GetCharWidth(AChar: Char; ADrawSetting: PDrawSetting): Single;
    function GetTextWidth(AText: PChar; ADrawSetting: PDrawSetting): Single;
    procedure GetFirstPositionOfChar(AFontID: Integer; ATextField: String; AXOldPos: Integer; var FCharCountPos: Integer; AMouseUse: Boolean=False);
    procedure GetFirstVisibleChar(AFontID: Integer; ATextField: String; FCharCountPos: Integer; var AXPos: Integer);
    procedure DrawText(AText: String; ADrawSetting: PDrawSetting);
    procedure DrawTextRect(AText: String; AFirstVisibleChar: Integer; ADrawSetting: PDrawSetting);
    procedure DrawTextColor(AText: String; ADrawSetting: PDrawSetting);
    procedure DrawControlText(AText: String; ADrawSetting: PDrawSetting);
    procedure DrawHint(AX, AY: Integer; AText: array of char; ADrawSetting: PDrawSetting);
    procedure DrawItemHint(AX, AY: Integer; AText: array of char; ADrawSetting: PDrawSetting);
    procedure DrawMoveV(AIndex: Integer; AText: String; ADrawSetting: PDrawSetting);
  end;

  TMIR3_Font = class(TInterfacedObject, IMIR3_Font)
  strict private
    FIndex            : Integer;
    FScale            : Single;
    FFileHeader       : TMFD_FileHeader;
    FFontSetup        : array [1..15] of TFontSetup;
    FMFD_FontSets     : array of TMIR3_MFD_Font_Set;
  private
    function GetFontIndex(ADrawSetting: PDrawSetting): Integer;
    function CalculateKerningPairs(AFontID, AFirst, ASecond: Integer): Single;
    function RenderText(const AFontHeight : Integer; AChar: PMFD_Char; AFontSet: PMIR3_MFD_Font_Set; AX, AY: Single; AColor: Longword = $FFFFFFFF): Single;
    function RenderTextMultiColor(const ADrawSetting: PDrawSetting; AChar: PMFD_Char; AFontSet: PMIR3_MFD_Font_Set; AX, AY: Single; AColor1: Longword = $FFFFFFFF; AColor2: Longword = $FFFFFFFF): Single;
    function LoadMFDFile(AFileName: String): Boolean;
  public
    constructor Create;
    destructor Destroy; override;
  public
    function GetLineCount(AText: PChar): Integer;
    function GetLineCountMaxWidth(AText: PChar; ADrawSetting: PDrawSetting): Integer;
    function GetScriptHeight(AText: PChar): Integer;
    function GetScriptedTextWidth(ALine: Integer; AText: PChar; ADrawSetting: PDrawSetting): Single;
    function GetCharWidth(AChar: Char; ADrawSetting: PDrawSetting): Single;
    function GetTextWidth(AText: PChar; ADrawSetting: PDrawSetting): Single;
    procedure GetFirstPositionOfChar(AFontID: Integer; ATextField: String; AXOldPos: Integer; var FCharCountPos: Integer; AMouseUse: Boolean=False);
    procedure GetFirstVisibleChar(AFontID: Integer; ATextField: String; FCharCountPos: Integer; var AXPos: Integer);
    
    procedure DrawText(AText: String; ADrawSetting: PDrawSetting);
    procedure DrawTextRect(AText: String; AFirstVisibleChar: Integer; ADrawSetting: PDrawSetting);
    procedure DrawTextColor(AText: String; ADrawSetting: PDrawSetting);
    procedure DrawControlText(AText: String; ADrawSetting: PDrawSetting);
    procedure DrawHint(AX, AY: Integer; AText: array of char; ADrawSetting: PDrawSetting);
    procedure DrawItemHint(AX, AY: Integer; AText: array of char; ADrawSetting: PDrawSetting);
    procedure DrawMoveV(AIndex: Integer; AText: String; ADrawSetting: PDrawSetting);
  end;
   
  procedure InitDrawSetting(var ADrawSetting: TDrawSetting);
  
implementation

uses mir3_game_backend, mir3_misc_utils;

  procedure InitDrawSetting(var ADrawSetting: TDrawSetting);
  begin
    with ADrawSetting do
    begin
      dsControlWidth  := 0;
      dsControlHeigth := 0;
      dsAX            := 0;
      dsAY            := 0;
      dsFontType      := 0;
      dsFontHeight    := 0;
      dsFontSpacing   := 0;
      dsFontSetting   := [];
      dsUseKerning    := False;
      dsColor         := $FFFFFFFF;
      dsHAlign        := alLeft;
      dsVAlign        := avTop;
      dsMaxWidth      := 0;
    end;
  end;

  {$REGION ' - TMIR3_Font :: constructor / destructor   '}
    constructor TMIR3_Font.Create;
    begin
      inherited create;
      FScale := 1.0;
      LoadMFDFile(LIB_PHAT+FONT_FILE);
      FFontSetup[1].fsFontType    := 1; //Arial
      FFontSetup[1].fsFontHeight  := 14;
      FFontSetup[1].fsFontSetting := [];

      FFontSetup[2].fsFontType    := 1; //Arial
      FFontSetup[2].fsFontHeight  := 15;
      FFontSetup[2].fsFontSetting := [];

      FFontSetup[3].fsFontType    := 1; //Arial
      FFontSetup[3].fsFontHeight  := 16;
      FFontSetup[3].fsFontSetting := [];

      FFontSetup[4].fsFontType    := 1; //Arial
      FFontSetup[4].fsFontHeight  := 18;
      FFontSetup[4].fsFontSetting := [];

      FFontSetup[5].fsFontType    := 1; //Arial
      FFontSetup[5].fsFontHeight  := 21;
      FFontSetup[5].fsFontSetting := [];

      FFontSetup[6].fsFontType    := 2; //Tahoma
      FFontSetup[6].fsFontHeight  := 14;
      FFontSetup[6].fsFontSetting := [];

      FFontSetup[7].fsFontType    := 2; //Tahoma
      FFontSetup[7].fsFontHeight  := 15;
      FFontSetup[7].fsFontSetting := [];

      FFontSetup[8].fsFontType    := 2; //Tahoma
      FFontSetup[8].fsFontHeight  := 16;
      FFontSetup[8].fsFontSetting := [];

      FFontSetup[9].fsFontType    := 2; //Tahoma
      FFontSetup[9].fsFontHeight  := 18;
      FFontSetup[9].fsFontSetting := [];

      FFontSetup[10].fsFontType    := 2; //Tahoma
      FFontSetup[10].fsFontHeight  := 21;
      FFontSetup[10].fsFontSetting := [];

      FFontSetup[11].fsFontType    := 3; //Georgia
      FFontSetup[11].fsFontHeight  := 14;
      FFontSetup[11].fsFontSetting := [];

      FFontSetup[12].fsFontType    := 3; //Georgia
      FFontSetup[12].fsFontHeight  := 15;
      FFontSetup[12].fsFontSetting := [];

      FFontSetup[13].fsFontType    := 3; //Georgia
      FFontSetup[13].fsFontHeight  := 16;
      FFontSetup[13].fsFontSetting := [];

      FFontSetup[14].fsFontType    := 3; //Georgia
      FFontSetup[14].fsFontHeight  := 18;
      FFontSetup[14].fsFontSetting := [];

      FFontSetup[15].fsFontType    := 3; //Georgia
      FFontSetup[15].fsFontHeight  := 21;
      FFontSetup[15].fsFontSetting := [];
    end;

    destructor TMIR3_Font.destroy;
    var
      I : Integer;
    begin
      for I := Low(FMFD_FontSets) to High(FMFD_FontSets) do
      begin
        if Assigned(FMFD_FontSets[I].FFontTexture) then
          FMFD_FontSets[I].FFontTexture.Free;
        ZeroMemory(@FMFD_FontSets[High(FMFD_FontSets)].FCharHeader, (256 * SizeOf(TMFD_Char)));
        SetLength(FMFD_FontSets[I].FKerningHeader, 0);
      end;
      SetLength(FMFD_FontSets, 0);
      FMFD_FontSets := nil;
      inherited destroy;
    end;
  {$ENDREGION}

  {$REGION ' - TMIR3_Font :: functions   '}
  function TMIR3_Font.LoadMFDFile(AFileName: String): Boolean;
  var
    I, I2           : Integer;
    FMem            : TMemoryStream;
    FImageMem       : TMemoryStream;
    FBlock          : TMFD_BlockInfo;
    FTempCharHeader : array of TMFD_Char;
  begin
    Result                 := True;
    FMem                   := TMemoryStream.Create;
    FImageMem              := TMemoryStream.Create;
    try
      FMem.LoadFromFile(AFileName);
      if Length(FMFD_FontSets) >=0 then
      begin
        for I := Low(FMFD_FontSets) to High(FMFD_FontSets) do
        begin
          if Assigned(FMFD_FontSets[High(FMFD_FontSets)].FFontTexture) then
            FMFD_FontSets[High(FMFD_FontSets)].FFontTexture.Free;
          ZeroMemory(@FMFD_FontSets[High(FMFD_FontSets)].FCharHeader, (600 * SizeOf(TMFD_Char)));//SizeOf(TMFD_CharPack)));
          SetLength(FMFD_FontSets[High(FMFD_FontSets)].FKerningHeader, 0);
        end;
        SetLength(FMFD_FontSets, 0);
      end;
      ZeroMemory(@FFileHeader, SizeOf(TMFD_FileHeader));
      FMem.Read(FFileHeader, SizeOf(TMFD_FileHeader));

      if (FFileHeader.Magic <> 'MDF') and (FFileHeader.Version <> 1) then
      begin
        Result := False;
        Exit;
      end;

      SetLength(FMFD_FontSets, FFileHeader.SetsInFile +1);
      FIndex := FFileHeader.SetsInFile +1;
      for I := Low(FMFD_FontSets) to High(FMFD_FontSets) do
      begin
        //Overall Begin typ 0 (Full Size)
        FMem.Read(FBlock, SizeOf(TMFD_BlockInfo));
        //Info Begin typ 1
        FMem.Read(FBlock, SizeOf(TMFD_BlockInfo));
        FMem.Read(FMFD_FontSets[I].FFontInformationHeader, SizeOf(TMFD_FontInformation));

        //Char Begin typ 2      FMFD_FontSets[I].FCharHeader
        FMem.Read(FBlock, SizeOf(TMFD_BlockInfo));
        SetLength(FTempCharHeader, (FBlock.BlockSize div SizeOf(TMFD_Char)));
        for I2 := Low(FTempCharHeader) to High(FTempCharHeader) do
        begin
          FMem.Read(FTempCharHeader[I2], SizeOf(TMFD_Char));  //TMFD_CharPack
          //FMFD_FontSets[I].FCharHeader[FTempCharHeader[I2].chID].cpChar := FTempCharHeader[I2];
          FMFD_FontSets[I].FCharHeader[FTempCharHeader[I2].chID] := FTempCharHeader[I2];
        end;

        //Kerning Begin typ 3
        FMem.Read(FBlock, SizeOf(TMFD_BlockInfo));
        SetLength(FMFD_FontSets[I].FKerningHeader, (FBlock.BlockSize div SizeOf(TMFD_Kerning)));
        for I2 := Low(FMFD_FontSets[I].FKerningHeader) to High(FMFD_FontSets[I].FKerningHeader) do
        begin
          FMem.Read(FMFD_FontSets[I].FKerningHeader[I2], SizeOf(TMFD_Kerning));
          //FMFD_FontSets[I].FCharHeader.[FTempCharHeader[I2].chID]
        end;

        //Image Begin typ 4
        FMem.Read(FBlock, SizeOf(TMFD_BlockInfo));
        FImageMem.CopyFrom(FMem, FBlock.BlockSize);
        FImageMem.Position := 0;

        FMFD_FontSets[I].FFontTexture := TMir3_Texture.Create;
        FMFD_FontSets[I].FFontTexture.LoadFromITexture(GRenderEngine.Texture_LoadMemory(FImageMem.Memory, FImageMem.Size),
                                                       FMFD_FontSets[I].FFontInformationHeader.chScaleW,
                                                       FMFD_FontSets[I].FFontInformationHeader.chScaleH);
        if Assigned(FMFD_FontSets[I].FFontTexture.FQuad.Tex) then
        begin
          FMFD_FontSets[I].FSetActive := True;
        end else begin
          FMFD_FontSets[I].FSetActive := False;
        end;
      end;

      if Assigned(FImageMem) then
        FreeAndNil(FImageMem);
      if Assigned(FMem) then
        FreeAndNil(FMem);
    except
      if Assigned(FMem) then
        FreeAndNil(FMem);
      if Assigned(FImageMem) then
        FreeAndNil(FImageMem);
      Result := False;
    end;
  end;
  {$ENDREGION}


function TMIR3_Font.GetFontIndex(ADrawSetting: PDrawSetting): Integer;
begin
  {$REGION ' - Font Setting '}
    Result := 0;
    case ADrawSetting.dsFontHeight of
      1..14 : begin
        case ADrawSetting.dsFontType of
          {$REGION ' - Font Typen '}
          0 : begin // Arial
            if (fsBold in ADrawSetting.dsFontSetting) then
            begin
             if not FMFD_FontSets[1].FSetActive then Exit;
               Result := 1;
            end else if (fsItalic in ADrawSetting.dsFontSetting) then
                     begin
                       if not FMFD_FontSets[2].FSetActive then Exit;
                         Result := 2;
                     end else begin
                       if not FMFD_FontSets[0].FSetActive then Exit;
                         Result := 0;
                     end;
          end;
          1 : begin // Tahoma
            if (fsBold in ADrawSetting.dsFontSetting) then
            begin
             if not FMFD_FontSets[16].FSetActive then Exit;
               Result := 16;
            end else if (fsItalic in ADrawSetting.dsFontSetting) then
                     begin
                       if not FMFD_FontSets[17].FSetActive then Exit;
                         Result := 17;
                     end else begin
                       if not FMFD_FontSets[15].FSetActive then Exit;
                         Result := 15;
                     end;
          end;
          2 : begin // Georgia
            if (fsBold in ADrawSetting.dsFontSetting) then
            begin
             if not FMFD_FontSets[31].FSetActive then Exit;
               Result := 31;
            end else if (fsItalic in ADrawSetting.dsFontSetting) then
                     begin
                       if not FMFD_FontSets[32].FSetActive then Exit;
                         Result := 32;
                     end else begin
                       if not FMFD_FontSets[30].FSetActive then Exit;
                         Result := 30;
                     end;
          end;
          3 : begin // Courier New
            if (fsBold in ADrawSetting.dsFontSetting) then
            begin
             if not FMFD_FontSets[46].FSetActive then Exit;
               Result := 46;
            end else if (fsItalic in ADrawSetting.dsFontSetting) then
                     begin
                       if not FMFD_FontSets[47].FSetActive then Exit;
                         Result := 47;
                     end else begin
                       if not FMFD_FontSets[45].FSetActive then Exit;
                         Result := 45;
                     end;
          end;
          {$ENDREGION}
        end;
      end;
      15 : begin
        case ADrawSetting.dsFontType of
          {$REGION ' - Font Typen '}
          0 : begin
            if (fsBold in ADrawSetting.dsFontSetting) then
            begin
             if not FMFD_FontSets[4].FSetActive then Exit;
               Result := 4;
            end else if (fsItalic in ADrawSetting.dsFontSetting) then
                     begin
                       if not FMFD_FontSets[5].FSetActive then Exit;
                         Result := 5;
                     end else begin
                       if not FMFD_FontSets[3].FSetActive then Exit;
                         Result := 3;
                     end;
          end;
          1 : begin
            if (fsBold in ADrawSetting.dsFontSetting) then
            begin
             if not FMFD_FontSets[19].FSetActive then Exit;
               Result := 19;
            end else if (fsItalic in ADrawSetting.dsFontSetting) then
                     begin
                       if not FMFD_FontSets[20].FSetActive then Exit;
                         Result := 20;
                     end else begin
                       if not FMFD_FontSets[18].FSetActive then Exit;
                         Result := 18;
                     end;
          end;
          2 : begin
            if (fsBold in ADrawSetting.dsFontSetting) then
            begin
             if not FMFD_FontSets[34].FSetActive then Exit;
               Result := 34;
            end else if (fsItalic in ADrawSetting.dsFontSetting) then
                     begin
                       if not FMFD_FontSets[35].FSetActive then Exit;
                         Result := 35;
                     end else begin
                       if not FMFD_FontSets[33].FSetActive then Exit;
                         Result := 33;
                     end;
          end;
          3 : begin // Courier New
            if (fsBold in ADrawSetting.dsFontSetting) then
            begin
             if not FMFD_FontSets[49].FSetActive then Exit;
               Result := 49;
            end else if (fsItalic in ADrawSetting.dsFontSetting) then
                     begin
                       if not FMFD_FontSets[50].FSetActive then Exit;
                         Result := 50;
                     end else begin
                       if not FMFD_FontSets[48].FSetActive then Exit;
                         Result := 48;
                     end;
          end;
          {$ENDREGION}
        end;
      end;
      16..17 : begin
        case ADrawSetting.dsFontType of
          {$REGION ' - Font Typen '}
          0 : begin
            if (fsBold in ADrawSetting.dsFontSetting) then
            begin
             if not FMFD_FontSets[7].FSetActive then Exit;
               Result := 7;
            end else if (fsItalic in ADrawSetting.dsFontSetting) then
                     begin
                       if not FMFD_FontSets[8].FSetActive then Exit;
                         Result := 8;
                     end else begin
                       if not FMFD_FontSets[6].FSetActive then Exit;
                         Result := 6;
                     end;
          end;
          1 : begin
            if (fsBold in ADrawSetting.dsFontSetting) then
            begin
             if not FMFD_FontSets[22].FSetActive then Exit;
               Result := 22;
            end else if (fsItalic in ADrawSetting.dsFontSetting) then
                     begin
                       if not FMFD_FontSets[23].FSetActive then Exit;
                         Result := 23;
                     end else begin
                       if not FMFD_FontSets[21].FSetActive then Exit;
                         Result := 21;
                     end;
          end;
          2 : begin
            if (fsBold in ADrawSetting.dsFontSetting) then
            begin
             if not FMFD_FontSets[37].FSetActive then Exit;
               Result := 37;
            end else if (fsItalic in ADrawSetting.dsFontSetting) then
                     begin
                       if not FMFD_FontSets[38].FSetActive then Exit;
                         Result := 38;
                     end else begin
                       if not FMFD_FontSets[36].FSetActive then Exit;
                         Result := 36;
                     end;
          end;
          3 : begin // Courier New
            if (fsBold in ADrawSetting.dsFontSetting) then
            begin
             if not FMFD_FontSets[52].FSetActive then Exit;
               Result := 52;
            end else if (fsItalic in ADrawSetting.dsFontSetting) then
                     begin
                       if not FMFD_FontSets[53].FSetActive then Exit;
                         Result := 53;
                     end else begin
                       if not FMFD_FontSets[51].FSetActive then Exit;
                         Result := 51;
                     end;
          end;
          {$ENDREGION}
        end;
      end;
      18..20 : begin
        case ADrawSetting.dsFontType of
          {$REGION ' - Font Typen '}
          0 : begin
            if (fsBold in ADrawSetting.dsFontSetting) then
            begin
             if not FMFD_FontSets[10].FSetActive then Exit;
               Result := 10;
            end else if (fsItalic in ADrawSetting.dsFontSetting) then
                     begin
                       if not FMFD_FontSets[11].FSetActive then Exit;
                         Result := 11;
                     end else begin
                       if not FMFD_FontSets[9].FSetActive then Exit;
                         Result := 9;
                     end;
          end;
          1 : begin
            if (fsBold in ADrawSetting.dsFontSetting) then
            begin
             if not FMFD_FontSets[25].FSetActive then Exit;
               Result := 25;
            end else if (fsItalic in ADrawSetting.dsFontSetting) then
                     begin
                       if not FMFD_FontSets[26].FSetActive then Exit;
                         Result := 26;
                     end else begin
                       if not FMFD_FontSets[24].FSetActive then Exit;
                         Result := 24;
                     end;
          end;
          2 : begin
            if (fsBold in ADrawSetting.dsFontSetting) then
            begin
             if not FMFD_FontSets[40].FSetActive then Exit;
               Result := 40;
            end else if (fsItalic in ADrawSetting.dsFontSetting) then
                     begin
                       if not FMFD_FontSets[41].FSetActive then Exit;
                         Result := 41;
                     end else begin
                       if not FMFD_FontSets[39].FSetActive then Exit;
                         Result := 39;
                     end;
          end;
          3 : begin // Courier New
            if (fsBold in ADrawSetting.dsFontSetting) then
            begin
             if not FMFD_FontSets[55].FSetActive then Exit;
               Result := 55;
            end else if (fsItalic in ADrawSetting.dsFontSetting) then
                     begin
                       if not FMFD_FontSets[56].FSetActive then Exit;
                         Result := 56;
                     end else begin
                       if not FMFD_FontSets[54].FSetActive then Exit;
                         Result := 54;
                     end;
          end;
          {$ENDREGION}
        end;
      end;
      21..100 : begin
        case ADrawSetting.dsFontType of
          {$REGION ' - Font Typen '}
          0 : begin
            if (fsBold in ADrawSetting.dsFontSetting) then
            begin
             if not FMFD_FontSets[13].FSetActive then Exit;
               Result := 13;
            end else if (fsItalic in ADrawSetting.dsFontSetting) then
                     begin
                       if not FMFD_FontSets[14].FSetActive then Exit;
                         Result := 14;
                     end else begin
                       if not FMFD_FontSets[12].FSetActive then Exit;
                         Result := 12;
                     end;
          end;
          1 : begin
            if (fsBold in ADrawSetting.dsFontSetting) then
            begin
             if not FMFD_FontSets[28].FSetActive then Exit;
               Result := 28;
            end else if (fsItalic in ADrawSetting.dsFontSetting) then
                     begin
                       if not FMFD_FontSets[29].FSetActive then Exit;
                         Result := 29;
                     end else begin
                       if not FMFD_FontSets[27].FSetActive then Exit;
                         Result := 27;
                     end;
          end;
          2 : begin
            if (fsBold in ADrawSetting.dsFontSetting) then
            begin
             if not FMFD_FontSets[43].FSetActive then Exit;
               Result := 43;
            end else if (fsItalic in ADrawSetting.dsFontSetting) then
                     begin
                       if not FMFD_FontSets[44].FSetActive then Exit;
                         Result := 44;
                     end else begin
                       if not FMFD_FontSets[42].FSetActive then Exit;
                         Result := 42;
                     end;
          end;
          3 : begin // Courier New
            if (fsBold in ADrawSetting.dsFontSetting) then
            begin
             if not FMFD_FontSets[58].FSetActive then Exit;
               Result := 58;
            end else if (fsItalic in ADrawSetting.dsFontSetting) then
                     begin
                       if not FMFD_FontSets[59].FSetActive then Exit;
                         Result := 59;
                     end else begin
                       if not FMFD_FontSets[57].FSetActive then Exit;
                         Result := 57;
                     end;
          end;
          {$ENDREGION}
        end;
      end;
    end;
  {$ENDREGION}
end;

function TMIR3_Font.CalculateKerningPairs(AFontID, AFirst, ASecond: Integer): Single;
var
  I : Integer;
begin
  Result := 0;
  for I := Low(FMFD_FontSets[AFontID].FKerningHeader) to High(FMFD_FontSets[AFontID].FKerningHeader) do
  begin
    if (FMFD_FontSets[AFontID].FKerningHeader[I].khFirst  = AFirst)  and
       (FMFD_FontSets[AFontID].FKerningHeader[I].khSecond = ASecond) then
    begin
      Result := FMFD_FontSets[AFontID].FKerningHeader[I].khAmount;
      Break;
    end;
  end;
end;

function TMIR3_Font.GetLineCount(AText: PChar): Integer;
begin
  Result      := 1;
  while (AText^ <> #0) do
  begin
    if  (AText^ in [#13,'\']) then
      Inc(Result);
    Inc(AText);
  end;
end;

function TMIR3_Font.GetLineCountMaxWidth(AText: PChar; ADrawSetting: PDrawSetting): Integer;
var
  FTempLine : Single;
  FTempSize : Integer;
  FTempSet  : PMIR3_MFD_Font_Set;
  FTempDrawSetting : TDrawSetting;
begin
  Result           := 0;
  FTempDrawSetting := ADrawSetting^;
  FTempSet         := @FMFD_FontSets[GetFontIndex(@FTempDrawSetting)];
  while (AText^ <> #0) do
  begin
    FTempLine := 0;
    while (not (AText^ in [#0,#13,'\'])) do
    //while (not (AText^ in [#0])) do
    begin
      if  (AText^ in ['¦']) then
      begin
        Inc(AText);
        case AText^ of
          'Y': Inc(AText, 3);
          'X': Inc(AText, 3);
          'P': begin // ¦PE¦
            Inc(AText);
            case AText^ of
              'E': Inc(AText,2);
              else Inc(AText,3);
            end;
          end;
          'Z' : begin
            Inc(AText,2);
          end;          
          'F': begin
            Inc(AText);
            case AText^ of
              'E': begin
                FTempDrawSetting.dsFontType := ADrawSetting^.dsFontType;
                FTempSet := @FMFD_FontSets[GetFontIndex(@FTempDrawSetting)];
                Inc(AText,2);
              end;
              else begin
                FTempDrawSetting.dsFontType := StrToIntDef(Copy(AText, 0, 2),16);
                FTempSet := @FMFD_FontSets[GetFontIndex(@FTempDrawSetting)];
                Inc(AText,3);
              end;
            end;
          end;
          'N': Inc(AText,7);
          'S': begin
            Inc(AText);
            case AText^ of
              'E': begin
                FTempDrawSetting.dsFontHeight := ADrawSetting^.dsFontHeight;
                Inc(AText,2);
                FTempSet := @FMFD_FontSets[GetFontIndex(@FTempDrawSetting)];
              end;
              else begin
                FTempDrawSetting.dsFontHeight := StrToIntDef(Copy(AText, 0, 2),16);
                Inc(AText,3);
                FTempSet := @FMFD_FontSets[GetFontIndex(@FTempDrawSetting)];
              end;
            end;
          end;
          'C': begin
            Inc(AText);
            case AText^ of
              'E': Inc(AText,2);
              '1': Inc(AText,8);
              '2': Inc(AText,8);
            end;
          end;
          'B': begin
            Inc(AText);
            case AText^ of
              'E': begin
                FTempDrawSetting.dsFontSetting := FTempDrawSetting.dsFontSetting -[fsBold];
                Inc(AText,2);
                FTempSet := @FMFD_FontSets[GetFontIndex(@FTempDrawSetting)];
              end;
              else begin
                FTempDrawSetting.dsFontSetting := FTempDrawSetting.dsFontSetting +[fsBold];
                Inc(AText,1);
                FTempSet := @FMFD_FontSets[GetFontIndex(@FTempDrawSetting)];
              end;
            end;
          end;
          'I': begin
            Inc(AText);
            case AText^ of
              'E': begin
                FTempDrawSetting.dsFontSetting := FTempDrawSetting.dsFontSetting -[fsItalic];
                Inc(AText,2);
                FTempSet := @FMFD_FontSets[GetFontIndex(@FTempDrawSetting)];
              end;
              else begin
                FTempDrawSetting.dsFontSetting := FTempDrawSetting.dsFontSetting +[fsItalic];
                Inc(AText,1);
                FTempSet := @FMFD_FontSets[GetFontIndex(@FTempDrawSetting)];
              end;
            end;
          end;
          'T': Inc(AText,9);
        end;
      end else begin
        FTempLine := FTempLine + ((ADrawSetting.dsFontHeight / FTempSet.FFontInformationHeader.ihFontSize) * FTempSet.FCharHeader[Ord(AText^)].chXAdvance) + ADrawSetting.dsFontSpacing;
        Inc(AText);
      end;
    end;
    FTempSize := Round(FTempLine)+4;
    if Result < FTempSize then
      Result := FTempSize;
    Inc(AText);
  end;
end;

function TMIR3_Font.GetScriptHeight(AText: PChar): Integer;
begin
  Result      := 0;
  while (AText^ <> #0) do
  begin
    if  (AText^ in ['¦']) then
    begin
      inc(AText);
      if (AText^ in ['Y']) then
      begin
        Inc(AText);
        Result := Result + StrToIntDef(Copy(AText, 0, 2), 0);
        Inc(AText, 2);
      end;
    end;
    if (AText^ in ['¦']) then
    else Inc(AText);
  end;
end;

function TMIR3_Font.GetScriptedTextWidth(ALine: Integer; AText: PChar; ADrawSetting: PDrawSetting): Single;
var
  FLines      : Integer;
  FTempLine   : Single;
  FTempSet    : PMIR3_MFD_Font_Set;
  FTempDrawSetting : TDrawSetting;
begin
  Result           := 0;
  FTempDrawSetting := ADrawSetting^;
  FTempSet         := @FMFD_FontSets[GetFontIndex(@FTempDrawSetting)];
  FLines    := 0;
  if ALine > 0 then
  begin
    while True do
    begin
      if (AText^ in [#10,#13,'\']) then Inc(FLines);
      if ALine = FLines            then
      begin
        Inc(AText);
        Break;
      end;
      Inc(AText);
    end;
  end;

  while (AText^ <> #0) do
  begin
    FTempLine := 0;

    while (not (AText^ in [#0,#13,'\'])) do
    begin
      if  (AText^ in ['¦']) then
      begin
        Inc(AText);
        case AText^ of
          'Y': Inc(AText, 3);
          'X': Inc(AText, 3); 
          'P': begin // ¦PE¦ ¦P00¦
            Inc(AText);
            case AText^ of
              'E': Inc(AText,2);
              else Inc(AText,3);
            end;
          end;
          'Z' : begin
            Inc(AText,2);
          end;
          'F': begin
            Inc(AText);
            case AText^ of
              'E': begin
                FTempDrawSetting.dsFontType := ADrawSetting^.dsFontType;
                FTempSet := @FMFD_FontSets[GetFontIndex(@FTempDrawSetting)];
                Inc(AText,2);
              end;
              else begin
                FTempDrawSetting.dsFontType := StrToIntDef(Copy(AText, 0, 2),16);
                FTempSet := @FMFD_FontSets[GetFontIndex(@FTempDrawSetting)];
                Inc(AText,3);
              end;
            end;
          end;
          'N': Inc(AText,7);
          'S': begin
            Inc(AText);
            case AText^ of
              'E': begin
                FTempDrawSetting.dsFontHeight := ADrawSetting^.dsFontHeight;
                Inc(AText,2);
                FTempSet := @FMFD_FontSets[GetFontIndex(@FTempDrawSetting)];
              end;
              else begin
                FTempDrawSetting.dsFontHeight := StrToIntDef(Copy(AText, 0, 2),16);
                Inc(AText,3);
                FTempSet := @FMFD_FontSets[GetFontIndex(@FTempDrawSetting)];
              end;
            end;
          end;
          'C': begin
            Inc(AText);
            case AText^ of
              'E': Inc(AText,2);
              '1': Inc(AText,8);
              '2': Inc(AText,8);
            end;
          end;
          'B': begin
            Inc(AText);
            case AText^ of
              'E': begin
                FTempDrawSetting.dsFontSetting := FTempDrawSetting.dsFontSetting -[fsBold];
                Inc(AText,2);
                FTempSet := @FMFD_FontSets[GetFontIndex(@FTempDrawSetting)];
              end;
              else begin
                FTempDrawSetting.dsFontSetting := FTempDrawSetting.dsFontSetting +[fsBold];
                Inc(AText,2);
                FTempSet := @FMFD_FontSets[GetFontIndex(@FTempDrawSetting)];
              end;
            end;
          end;
          'I': begin
            Inc(AText);
            case AText^ of
              'E': begin
                FTempDrawSetting.dsFontSetting := FTempDrawSetting.dsFontSetting -[fsItalic];
                Inc(AText,2);
                FTempSet := @FMFD_FontSets[GetFontIndex(@FTempDrawSetting)];
              end;
              else begin
                FTempDrawSetting.dsFontSetting := FTempDrawSetting.dsFontSetting +[fsItalic];
                Inc(AText,2);
                FTempSet := @FMFD_FontSets[GetFontIndex(@FTempDrawSetting)];
              end;
            end;
          end;
          'T': Inc(AText,9);
        end;
      end else begin
        FTempLine := FTempLine + ((ADrawSetting.dsFontHeight / FTempSet.FFontInformationHeader.ihFontSize) * FTempSet.FCharHeader[Ord(AText^)].chXAdvance) + ADrawSetting.dsFontSpacing;
        Inc(AText);
      end;
    end;
    if (FTempLine > Result) then
      Result := FTempLine;
    if (AText^ in [#10,#13,'\']) then Break;
  end;
end;

function TMIR3_Font.GetTextWidth(AText: PChar; ADrawSetting: PDrawSetting): Single;
var
  FTempString : PChar;
  FTempLine   : Single;
  FTempSet    : PMIR3_MFD_Font_Set;
begin
  Result      := 0;
  FTempString := AText;
  FTempSet    := @FMFD_FontSets[GetFontIndex(ADrawSetting)];
  while (FTempString^ <> #0) do
  begin
    FTempLine := 0;
    while (not (FTempString^ in [#0,#10,#13,'\'])) do
    begin
      FTempLine := FTempLine + ((ADrawSetting.dsFontHeight / FTempSet.FFontInformationHeader.ihFontSize) * FTempSet.FCharHeader[Ord(FTempString^)].chXAdvance) + ADrawSetting.dsFontSpacing;// + 1;
      Inc(FTempString);
    end;
    if (FTempLine > Result) then
      Result := FTempLine;
    if (FTempString^ in [#10,#13,'\']) then Break;
  end;
end;

procedure TMIR3_Font.GetFirstPositionOfChar(AFontID: Integer; ATextField: String; AXOldPos: Integer; var FCharCountPos: Integer; AMouseUse: Boolean=False);
var
  I,FPos       : Integer;
  FDrawSetting : TDrawSetting;
begin
  InitDrawSetting(FDrawSetting);
  FDrawSetting.dsFontHeight  := FFontSetup[AFontID].fsFontHeight;
  FDrawSetting.dsFontSetting := FFontSetup[AFontID].fsFontSetting;
  for I := 1 to Length(ATextField) do
  begin
    FPos := Trunc(GetTextWidth(PChar(Copy(ATextField, 0, I)), @FDrawSetting));
    Inc(FCharCountPos);
    if FPos >= AXOldPos then
    begin
      if AMouseUse then
      begin
        if (FPos div 2) > (AXOldPos div 2) then
          Dec(FCharCountPos);
      end;
      Break;
    end;
  end;
end;

procedure TMIR3_Font.GetFirstVisibleChar(AFontID: Integer; ATextField: String; FCharCountPos: Integer; var AXPos: Integer);
var
  FDrawSetting : TDrawSetting;
begin
  AXPos := 0;
  if (ATextField = '') or (FCharCountPos = 0) or (FCharCountPos > Length(ATextField)) then  Exit;

  InitDrawSetting(FDrawSetting);
  FDrawSetting.dsFontHeight  := FFontSetup[AFontID].fsFontHeight;
  FDrawSetting.dsFontSetting := FFontSetup[AFontID].fsFontSetting;

  AXPos := Round(GetTextWidth(PChar(Copy(ATextField, 0, FCharCountPos)), @FDrawSetting));

end;

function TMIR3_Font.GetCharWidth(AChar: Char; ADrawSetting: PDrawSetting): Single;
var
  FTempSet : PMIR3_MFD_Font_Set;
begin
   FTempSet := @FMFD_FontSets[GetFontIndex(ADrawSetting)];
   Result   := ((ADrawSetting.dsFontHeight / FTempSet.FFontInformationHeader.ihFontSize) * FTempSet.FCharHeader[Ord(AChar)].chXAdvance) + ADrawSetting.dsFontSpacing;//+ 1;
end;

function TMIR3_Font.RenderText(const AFontHeight : Integer; AChar: PMFD_Char; AFontSet: PMIR3_MFD_Font_Set; AX, AY: Single; AColor: Longword = $FFFFFFFF): Single;
var
  FTempQuad         : THGEQuad;
  TX1, TY1, TX2, TY2: Single;
  OX,OY, W, H       : Single;
  AScale            : Single;
begin
  FTempQuad := AFontSet.FFontTexture.FQuad;
  AScale    := AFontHeight / AFontSet.FFontInformationHeader.ihFontSize;
  Result    := (AScale * AChar.chXAdvance);// + ADrawSetting.dsFontSpacing;//;// + 1;
  AY        := AY - (AScale * 2);

  Tx1       := ((AChar.chX) / AFontSet.FFontInformationHeader.chScaleW );
  Ty1       := ((AChar.chY) / AFontSet.FFontInformationHeader.chScaleH);
  Tx2       := Tx1 + (AChar.chWidth)  / AFontSet.FFontInformationHeader.chScaleW;
  Ty2       := Ty1 + (AChar.chHeight) / AFontSet.FFontInformationHeader.chScaleH;

  OX        := AScale * AChar.chXOffset;
  OY        := AScale * AChar.chYOffset;
   W        := AScale * AChar.chWidth;
   H        := AScale * AChar.chHeight;

  with AFontSet.FFontTexture do
  begin
    FQuad.V[0].TX := Tx1;     FQuad.V[0].TY := Ty2;
    FQuad.V[1].TX := Tx2;     FQuad.V[1].TY := Ty2;
    FQuad.V[2].TX := Tx2;     FQuad.V[2].TY := Ty1;
    FQuad.V[3].TX := Tx1;     FQuad.V[3].TY := Ty1;

    FQuad.V[0].X  := AX+OX;   FQuad.V[0].Y  := (AY+H+OY);
    FQuad.V[1].X  := AX+W+OX; FQuad.V[1].Y  := (AY+H+OY);
    FQuad.V[2].X  := AX+W+OX; FQuad.V[2].Y  := AY+OY;
    FQuad.V[3].X  := AX+OX;   FQuad.V[3].Y  := AY+OY;
    if AColor <> $FFFFFFFF then
    begin
      FQuad.V[0].Col := AColor;
      FQuad.V[1].Col := AColor;
      FQuad.V[2].Col := AColor;
      FQuad.V[3].Col := AColor;
    end;
    GRenderEngine.Gfx_RenderQuad(FQuad);
  end;
  AFontSet.FFontTexture.FQuad := FTempQuad;
end;

function TMIR3_Font.RenderTextMultiColor(const ADrawSetting: PDrawSetting; AChar: PMFD_Char; AFontSet: PMIR3_MFD_Font_Set; AX, AY: Single; AColor1: Longword = $FFFFFFFF; AColor2: Longword = $FFFFFFFF): Single;
var
  FTempQuad         : THGEQuad;
  TX1, TY1, TX2, TY2: Single;
  OX,OY, W, H       : Single;
  AScale            : Single;
begin
  FTempQuad := AFontSet.FFontTexture.FQuad;
  AScale    := ADrawSetting.dsFontHeight / AFontSet.FFontInformationHeader.ihFontSize;
  Result    := (AScale * AChar.chXAdvance) + ADrawSetting.dsFontSpacing;
  AY        := AY - (AScale * 2);

  Tx1       := ((AChar.chX) / AFontSet.FFontInformationHeader.chScaleW );
  Ty1       := ((AChar.chY) / AFontSet.FFontInformationHeader.chScaleH);
  Tx2       := Tx1 + (AChar.chWidth)  / AFontSet.FFontInformationHeader.chScaleW;
  Ty2       := Ty1 + (AChar.chHeight) / AFontSet.FFontInformationHeader.chScaleH;

  OX        := AScale * AChar.chXOffset;
  OY        := AScale * AChar.chYOffset;
   W        := AScale * AChar.chWidth;
   H        := AScale * AChar.chHeight;

  with AFontSet.FFontTexture do
  begin
    FQuad.V[0].TX := Tx1;     FQuad.V[0].TY := Ty2;
    FQuad.V[1].TX := Tx2;     FQuad.V[1].TY := Ty2;
    FQuad.V[2].TX := Tx2;     FQuad.V[2].TY := Ty1;
    FQuad.V[3].TX := Tx1;     FQuad.V[3].TY := Ty1;

    FQuad.V[0].X  := AX+OX;   FQuad.V[0].Y  := (AY+H+OY);
    FQuad.V[1].X  := AX+W+OX; FQuad.V[1].Y  := (AY+H+OY);
    FQuad.V[2].X  := AX+W+OX; FQuad.V[2].Y  := AY+OY;
    FQuad.V[3].X  := AX+OX;   FQuad.V[3].Y  := AY+OY;
    if AColor1 <> $FFFFFFFF then
    begin
      FQuad.V[0].Col := AColor1;
      FQuad.V[1].Col := AColor1;
      if AColor2 <> 0 then
      begin
        FQuad.V[2].Col := AColor2;
        FQuad.V[3].Col := AColor2;
      end else begin
        FQuad.V[2].Col := AColor1;
        FQuad.V[3].Col := AColor1;
      end;
    end;

    GRenderEngine.Gfx_RenderQuad(FQuad);
  end;
  AFontSet.FFontTexture.FQuad := FTempQuad;
end;

procedure TMIR3_Font.DrawText(AText: String; ADrawSetting: PDrawSetting);
var
  I          : Integer;
  FFontIndex : Integer;
  FX, FY     : Single;
  FTempChar  : PMFD_Char;
  FTempLines : Integer;
begin
  with ADrawSetting^ do
  begin
    FFontIndex := GetFontIndex(ADrawSetting);
    case dsHAlign of
      alLeft   : begin
        {$REGION ' - Align Left '}
        FX         := dsAX;
        case dsVAlign of
          avTop    : FY := dsAY;
          avCenter : begin
            FTempLines := GetLineCount(PChar(AText)) * (dsFontHeight + 1);
            FY         := dsAY + (dsControlHeigth div 2) - (FTempLines div 2);          
          end;
          avBottom : begin
            FTempLines := GetLineCount(PChar(AText)) * (dsFontHeight + 1);
            FY         := dsAY + dsControlHeigth - FTempLines;          
          end;
        end;
        
        for I := 1 to Length(AText) do
        begin
          with FMFD_FontSets[FFontIndex].FCharHeader[Ord(AText[I])] do
          begin
            if (AText[I] = #13) or (AText[I] = '\') or (AText[I] = #10) then
            begin
              if (AText[I] = #13) or (AText[I] = '\') then
              begin
                FX := dsAX;
                FY := FY + dsFontHeight +1;
              end;
            end else begin
              // Test if Char in List.. if not set "?" as place holder
              if chID = 0 then
                FTempChar := @FMFD_FontSets[FFontIndex].FCharHeader[63] // change to "?"
              else FTempChar := @FMFD_FontSets[FFontIndex].FCharHeader[Ord(AText[I])];
              // Calculate and Render Char
              FX := FX + (RenderText(dsFontHeight, FTempChar, @FMFD_FontSets[FFontIndex], FX, FY, dsColor));
              // Check, Set and Calculate Kerning
              if (dsUseKerning) and (Length(AText) >= I+1) then
                FX := FX + CalculateKerningPairs(FFontIndex, Ord(AText[I]), Ord(AText[I+1]));
            end;
          end;
        end;
        {$ENDREGION}
      end;
      alCenter : begin
        {$REGION ' - Align Center '}
        FX         := dsAX + (dsControlWidth div 2) - Trunc(GetTextWidth(PChar(AText), ADrawSetting) / 2);
        case dsVAlign of
          avTop    : FY := dsAY;
          avCenter : begin
            FTempLines := GetLineCount(PChar(AText)) * (dsFontHeight + 1);
            FY         := dsAY + (dsControlHeigth div 2) - (FTempLines div 2);          
          end;
          avBottom : begin
            FTempLines := GetLineCount(PChar(AText)) * (dsFontHeight + 1);
            FY         := dsAY + dsControlHeigth - FTempLines;          
          end;
        end;
        for I := 1 to Length(AText) do
        begin
          with FMFD_FontSets[FFontIndex].FCharHeader[Ord(AText[I])] do
          begin
            if (AText[I] = #13) or (AText[I] = '\') or (AText[I] = #10) then
            begin
              if (AText[I] = #13) or (AText[I] = '\') then
              begin
                FX := dsAX + (dsControlWidth div 2) - Trunc(GetTextWidth(PChar(Copy(AText,I + 1, MaxInt)), ADrawSetting) / 2);
                FY := FY   + dsFontHeight +1;
              end;
            end else begin
              // Test if Char in List.. if not set "?" as place holder
              if chID = 0 then
                FTempChar := @FMFD_FontSets[FFontIndex].FCharHeader[63] // change to "?"
              else FTempChar := @FMFD_FontSets[FFontIndex].FCharHeader[Ord(AText[I])];
        
              // Calculate and Render Char
              FX := FX + (RenderText(dsFontHeight, FTempChar, @FMFD_FontSets[FFontIndex], FX, FY, dsColor));
              // Check, Set and Calculate Kerning
              if (dsUseKerning) and (Length(AText) >= I+1) then
                FX := FX + CalculateKerningPairs(FFontIndex, Ord(AText[I]), Ord(AText[I+1]));
            end;
          end;
        end;
        {$ENDREGION}
      end;
      alRight  : begin
        {$REGION ' - Align Right '}
        FX         := dsAX + dsControlWidth - GetTextWidth(PChar(AText), ADrawSetting);
        case dsVAlign of
          avTop    : FY := dsAY;
          avCenter : begin
            FTempLines := GetLineCount(PChar(AText)) * (dsFontHeight + 1);
            FY         := dsAY + (dsControlHeigth div 2) - (FTempLines div 2);
          end;
          avBottom : begin
            FTempLines := GetLineCount(PChar(AText)) * (dsFontHeight + 1);
            FY         := dsAY + dsControlHeigth - FTempLines;          
          end;
        end;  
        for I := 1 to Length(AText) do
        begin
          with FMFD_FontSets[FFontIndex].FCharHeader[Ord(AText[I])] do
          begin
            if (AText[I] = #13) or (AText[I] = '\') or (AText[I] = #10) then
            begin
              if (AText[I] = #13) or (AText[I] = '\') then
              begin
                FX := dsAX + dsControlWidth - GetTextWidth(PChar(Copy(AText,I + 1, MaxInt)), ADrawSetting);
                FY := FY   + dsFontHeight +1;
              end;
            end else begin
              // Test if Char in List.. if not set "?" as place holder
              if chID = 0 then
                FTempChar := @FMFD_FontSets[FFontIndex].FCharHeader[63] // change to "?"
              else FTempChar := @FMFD_FontSets[FFontIndex].FCharHeader[Ord(AText[I])];
       
              // Calculate and Render Char
              FX := FX + (RenderText(dsFontHeight, FTempChar, @FMFD_FontSets[FFontIndex], FX, FY, dsColor));
              // Check, Set and Calculate Kerning
              if (dsUseKerning) and (Length(AText) >= I+1) then
                FX := FX + CalculateKerningPairs(FFontIndex, Ord(AText[I]), Ord(AText[I+1]));
       
            end;
          end;
        end;
        {$ENDREGION}
      end;
    end;
  end;
end;

procedure TMIR3_Font.DrawTextRect(AText: String; AFirstVisibleChar: Integer; ADrawSetting: PDrawSetting);
var
  I          : Integer;
  FFontIndex : Integer;
  FX, FY     : Single;
  FTempChar  : PMFD_Char;
  FTempLines : Integer;
begin
  with ADrawSetting^ do
  begin
    FFontIndex := GetFontIndex(ADrawSetting);
    case dsHAlign of
      alLeft   : begin
        {$REGION ' - Align Left '}
        FX         := dsAX;
        FTempLines := GetLineCount(PChar(AText)) * (dsFontHeight + 1);
        FY         := dsAY + (dsControlHeigth div 2) - (FTempLines div 2);

        for I := AFirstVisibleChar+1 to Length(AText) do
        begin
          with FMFD_FontSets[FFontIndex].FCharHeader[Ord(AText[I])] do
          begin
            // Test if Char in List.. if not set "?" as place holder
            if chID = 0 then
              FTempChar := @FMFD_FontSets[FFontIndex].FCharHeader[63] // change to "?"
            else FTempChar := @FMFD_FontSets[FFontIndex].FCharHeader[Ord(AText[I])];
            // Calculate and Render Char
            FX := FX + (RenderText(dsFontHeight, FTempChar, @FMFD_FontSets[FFontIndex], FX, FY, dsColor));
            if FX > dsMaxWidth then
              Break
            else if (I+1 <= Length(AText)) and (FX+GetCharWidth(AText[I+1], ADrawSetting) > dsMaxWidth) then
                   Break;
          end;
        end;
        {$ENDREGION}
      end;
      alCenter : begin
        {$REGION ' - Align Center '}
        FX         := dsAX + (dsControlWidth div 2) - Trunc(GetTextWidth(PChar(AText), ADrawSetting) / 2);
        FTempLines := GetLineCount(PChar(AText)) * (dsFontHeight + 1);
        FY         := dsAY + (dsControlHeigth div 2) - (FTempLines div 2);
        for I := AFirstVisibleChar+1 to Length(AText) do
        begin
          with FMFD_FontSets[FFontIndex].FCharHeader[Ord(AText[I])] do
          begin
            // Test if Char in List.. if not set "?" as place holder
            if chID = 0 then
              FTempChar := @FMFD_FontSets[FFontIndex].FCharHeader[63] // change to "?"
            else FTempChar := @FMFD_FontSets[FFontIndex].FCharHeader[Ord(AText[I])];

            // Calculate and Render Char
            FX := FX + (RenderText(dsFontHeight, FTempChar, @FMFD_FontSets[FFontIndex], FX, FY, dsColor));
            if FX > dsMaxWidth then
              Break
            else if (I+1 <= Length(AText)) and (FX+GetCharWidth(AText[I+1], ADrawSetting) > dsMaxWidth) then
                   Break;
          end;
        end;
        {$ENDREGION}
      end;
      alRight  : begin
        {$REGION ' - Align Right '}
        FX         := dsAX + dsControlWidth - GetTextWidth(PChar(AText), ADrawSetting);
        FTempLines := GetLineCount(PChar(AText)) * (dsFontHeight + 1);
        FY         := dsAY + (dsControlHeigth div 2) - (FTempLines div 2);
        for I := AFirstVisibleChar+1 to Length(AText) do
        begin
          with FMFD_FontSets[FFontIndex].FCharHeader[Ord(AText[I])] do
          begin
            // Test if Char in List.. if not set "?" as place holder
            if chID = 0 then
              FTempChar := @FMFD_FontSets[FFontIndex].FCharHeader[63] // change to "?"
            else FTempChar := @FMFD_FontSets[FFontIndex].FCharHeader[Ord(AText[I])];

            // Calculate and Render Char
            FX := FX + (RenderText(dsFontHeight, FTempChar, @FMFD_FontSets[FFontIndex], FX, FY, dsColor));
            if FX > dsMaxWidth then
              Break
            else if (I+1 <= Length(AText)) and (FX+GetCharWidth(AText[I+1], ADrawSetting) > dsMaxWidth) then
                   Break;
          end;
        end;
        {$ENDREGION}
      end;
    end;
  end;
end;

procedure TMIR3_Font.DrawTextColor(AText: String; ADrawSetting: PDrawSetting);
var
  I          : Integer;
  FFontIndex : Integer;
  FX, FY     : Single;
  FTempChar  : PMFD_Char;
  FTempLines : Integer;
  FColor1    : Integer;
  FColor2    : Integer;
  FLineCount : Integer;
  FTempDrawSetting : TDrawSetting;
begin
  FTempDrawSetting := ADrawSetting^;
  with FTempDrawSetting do
  begin
    FFontIndex := GetFontIndex(ADrawSetting);
    case dsHAlign of
      alLeft   : begin
        {$REGION ' - Align Left '}
        FX         := dsAX;
        case dsVAlign of
          avTop    : FY := dsAY;
          avCenter : begin
            FTempLines := GetLineCount(PChar(AText)) * (dsFontHeight + 1);
            FY         := dsAY + (dsControlHeigth div 2) - (FTempLines div 2);          
          end;
          avBottom : begin
            FTempLines := GetLineCount(PChar(AText)) * (dsFontHeight + 1);
            FY         := dsAY + dsControlHeigth - FTempLines;          
          end;
        end;

 // Add Coloring
 // '¦SFFFFFF¦Text¦E¦'
 // '¦NFFFFFF¦Text .......'

(*
   Color Commands::
   ¦CNFFFFFF¦ Start Color
   ¦CE¦ End Color
   example : '¦C1FFFFFF¦Text¦CE¦'
             '¦C1FFFFFF¦¦C2FFFFFF¦Text¦CE¦'   <--Grandient

   ¦NFFFFFF¦ Start Color with out end of Coloring (used for one color in one line)
   example : '¦NFFFFFF¦Text .......'

   Texture Commands::
   ¦TFFFF¦FFF¦ Texture ID ¦ File ID

   1821 ¦ 94
   ¦T071D¦05E¦

    GAME_TEXTURE_GROUND_INT         = 94;

   Other Commands, like Bold, Italic::
   ¦B¦ ¦BE¦ Bold
   ¦I¦ ¦IE¦ Italic

*)      FLineCount := 0;
        FColor1    := dsColor;
        FColor2    := 0;

        I := 1;
        while True do
        begin
          if I > Length(AText) then break;

          if AText[I] = '¦' then
          begin
            case AText[I+1] of
              'Y' : begin // add special Space Height ¦Y00¦
                FY := FY + StrToIntDef(Copy(AText, I+2, 2), 0);
                Inc(I,5);
              end;
              'X' : begin // add special Space Width ¦X00¦
                FX := FX + StrToIntDef(Copy(AText, I+2, 2), 0);
                Inc(I,5);
              end;
              'P' : begin // add special Space Width ¦P00¦
                case AText[I+2] of
                  'E': begin // ¦PE¦
                    dsFontSpacing := ADrawSetting^.dsFontSpacing;
                    Inc(I,4);
                    FFontIndex := GetFontIndex(@FTempDrawSetting);
                  end;
                else begin // ¦P00¦
                    dsFontSpacing := StrToIntDef(Copy(AText, I+2, 2), 0);
                    Inc(I,5);
                    FFontIndex := GetFontIndex(@FTempDrawSetting);
                  end;
                end;
              end;
              'Z' : begin
                FX := dsAX + (dsControlWidth div 2) - Trunc(GetScriptedTextWidth(FLineCount, PChar(AText), @FTempDrawSetting) / 2);
                Inc(I,3);
              end;
              'F' : begin // Draw new Font Type
                case AText[I+2] of
                  'E': begin // ¦FE¦
                    dsFontType := ADrawSetting^.dsFontType;
                    Inc(I,4);
                    FFontIndex := GetFontIndex(@FTempDrawSetting);
                  end;
                else begin // ¦F00¦
                    dsFontType := StrToIntDef(Copy(AText, I+2, 2),16);
                    Inc(I,5);
                    FFontIndex := GetFontIndex(@FTempDrawSetting);
                  end;
                end;
              end;
              'S' : begin // Draw new Text Size
                case AText[I+2] of
                  'E': begin // ¦SE¦
                    dsFontHeight := ADrawSetting^.dsFontHeight;
                    Inc(I,4);
                    FFontIndex := GetFontIndex(@FTempDrawSetting);
                  end;
                else begin // ¦S00¦
                    dsFontHeight := StrToIntDef(Copy(AText, I+2, 2),16);
                    Inc(I,5);
                    FFontIndex := GetFontIndex(@FTempDrawSetting);
                  end;
                end;
              end;
              'C' : begin  // Draw Text Color Start
                case AText[I+2] of
                  'E': begin // ¦CE¦
                    FColor1 := dsColor;
                    FColor2 := 0;
                    Inc(I,4);
                  end;
                  '1': begin  //Base Color or Start Color for Grandient
                    FColor1    := HexToInt('$FF'+ Copy(AText, I+3, 6));
                    Inc(I,10);
                  end;
                  '2': begin  //End Color for Grandient
                    FColor2    := HexToInt('$FF'+ Copy(AText, I+3, 6));
                    Inc(I,10);
                  end;
                end;
              end;
              'N' : begin  // Draw Text Color without end (full line)
                FColor1    := HexToInt('$FF'+Copy(AText, I+2, 6));
                Inc(I,9);
              end;
              'B' : begin  // Draw Text Bold
                case AText[I+2] of
                  'E': begin // ¦BE¦
                    dsFontSetting := dsFontSetting -[fsBold];
                    Inc(I,4);
                    FFontIndex := GetFontIndex(@FTempDrawSetting);
                  end;
                  '¦': begin
                    dsFontSetting := dsFontSetting +[fsBold];
                    Inc(I,3);
                    FFontIndex := GetFontIndex(@FTempDrawSetting);
                  end;
                end;
              end;
              'I' : begin  // Draw Text Italic
                case AText[I+2] of
                  'E': begin // ¦IE¦
                    dsFontSetting := dsFontSetting -[fsItalic];
                    Inc(I,4);
                    FFontIndex := GetFontIndex(@FTempDrawSetting);
                  end;
                  '¦': begin
                    dsFontSetting := dsFontSetting +[fsItalic];
                    Inc(I,3);
                    FFontIndex := GetFontIndex(@FTempDrawSetting);
                  end;
                end;
              end;
              'T' : begin  // Texture Command (Draw Item)

              end;
            end;
          end;

          if AText[I] = '¦' then Continue;
          if I > Length(AText) then break;
          
          with FMFD_FontSets[FFontIndex].FCharHeader[Ord(AText[I])] do
          begin
            if (AText[I] = #13) or (AText[I] = '\') or (AText[I] = #10) then
            begin
              if (AText[I] = #13) or (AText[I] = '\') then
              begin
                FX := dsAX;
                FY := FY + dsFontHeight +1;
                Inc(FLineCount);
              end;
            end else begin
              // Test if Char in List.. if not set "?" as place holder
              if chID = 0 then
                FTempChar := @FMFD_FontSets[FFontIndex].FCharHeader[63] // change to "?"
              else FTempChar := @FMFD_FontSets[FFontIndex].FCharHeader[Ord(AText[I])];
              // Calculate and Render Char
              FX := FX + (RenderTextMultiColor(@FTempDrawSetting, FTempChar, @FMFD_FontSets[FFontIndex], FX, FY, FColor1, FColor2));
            end;
          end;
          Inc(I);
        end;
        {$ENDREGION}
      end;
      alCenter : begin
        {$REGION ' - Align Center '}
        FX         := dsAX + (dsControlWidth div 2) - Trunc(GetTextWidth(PChar(AText), ADrawSetting) / 2);
        case dsVAlign of
          avTop    : FY := dsAY;
          avCenter : begin
            FTempLines := GetLineCount(PChar(AText)) * (dsFontHeight + 1);
            FY         := dsAY + (dsControlHeigth div 2) - (FTempLines div 2);          
          end;
          avBottom : begin
            FTempLines := GetLineCount(PChar(AText)) * (dsFontHeight + 1);
            FY         := dsAY + dsControlHeigth - FTempLines;          
          end;
        end;
        for I := 1 to Length(AText) do
        begin
          with FMFD_FontSets[FFontIndex].FCharHeader[Ord(AText[I])] do
          begin
            if (AText[I] = #13) or (AText[I] = '\') or (AText[I] = #10) then
            begin
              if (AText[I] = #13) or (AText[I] = '\') then
              begin
                FX := dsAX + (dsControlWidth div 2) - Trunc(GetTextWidth(PChar(Copy(AText,I + 1, MaxInt)), ADrawSetting) / 2);
                FY := FY   + dsFontHeight +1;
              end;
            end else begin
              // Test if Char in List.. if not set "?" as place holder
              if chID = 0 then
                FTempChar := @FMFD_FontSets[FFontIndex].FCharHeader[63] // change to "?"
              else FTempChar := @FMFD_FontSets[FFontIndex].FCharHeader[Ord(AText[I])];
        
              // Calculate and Render Char
              FX := FX + (RenderText(dsFontHeight, FTempChar, @FMFD_FontSets[FFontIndex], FX, FY, dsColor));
            end;
          end;
        end;
        {$ENDREGION}
      end;
      alRight  : begin
        {$REGION ' - Align Right '}
        FX         := dsAX + dsControlWidth - GetTextWidth(PChar(AText), ADrawSetting);
        case dsVAlign of
          avTop    : FY := dsAY;
          avCenter : begin
            FTempLines := GetLineCount(PChar(AText)) * (dsFontHeight + 1);
            FY         := dsAY + (dsControlHeigth div 2) - (FTempLines div 2);
          end;
          avBottom : begin
            FTempLines := GetLineCount(PChar(AText)) * (dsFontHeight + 1);
            FY         := dsAY + dsControlHeigth - FTempLines;          
          end;
        end;  
        for I := 1 to Length(AText) do
        begin
          with FMFD_FontSets[FFontIndex].FCharHeader[Ord(AText[I])] do
          begin
            if (AText[I] = #13) or (AText[I] = '\') or (AText[I] = #10) then
            begin
              if (AText[I] = #13) or (AText[I] = '\') then
              begin
                FX := dsAX + dsControlWidth - GetTextWidth(PChar(Copy(AText,I + 1, MaxInt)), ADrawSetting);
                FY := FY   + dsFontHeight +1;
              end;
            end else begin
              // Test if Char in List.. if not set "?" as place holder
              if chID = 0 then
                FTempChar := @FMFD_FontSets[FFontIndex].FCharHeader[63] // change to "?"
              else FTempChar := @FMFD_FontSets[FFontIndex].FCharHeader[Ord(AText[I])];
       
              // Calculate and Render Char
              FX := FX + (RenderText(dsFontHeight, FTempChar, @FMFD_FontSets[FFontIndex], FX, FY, dsColor));
            end;
          end;
        end;
        {$ENDREGION}
      end;
    end;
  end;
end;

////////////////////////////////////////////////////////////////////////////////
// TMIR3_Font DrawControlText 
// It don't support Kerning or Multi Lines
// It is Optimize for draw Text on Controls Only
// It can by use at all Ingame things thats use one line and one color and
// without text script engine
//..............................................................................
procedure TMIR3_Font.DrawControlText(AText: String; ADrawSetting: PDrawSetting);
var
  I          : Integer;
  FFontIndex : Integer;
  FX, FY     : Single;
  FTempChar  : PMFD_Char;
begin
  with ADrawSetting^ do
  begin
    FFontIndex := GetFontIndex(ADrawSetting);
    case dsHAlign of
      alLeft   : begin
        {$REGION ' - Align Left   '}
        FX         := dsAX;
        case dsVAlign of
          avTop    : FY := dsAY;
          avCenter : begin
            FY         := dsAY + (dsControlHeigth div 2) - (dsFontHeight div 2);
          end;
          avBottom : begin
            FY         := dsAY + dsControlHeigth - dsFontHeight;
          end;
        end;
        
        for I := 1 to Length(AText) do
        begin
          with FMFD_FontSets[FFontIndex].FCharHeader[Ord(AText[I])] do
          begin
            // Test if Char in List.. if not set "?" as place holder
            if chID = 0 then
              FTempChar := @FMFD_FontSets[FFontIndex].FCharHeader[63] // change to "?"
            else FTempChar := @FMFD_FontSets[FFontIndex].FCharHeader[Ord(AText[I])];
            // Calculate and Render Char
            FX := FX + (RenderText(dsFontHeight, FTempChar, @FMFD_FontSets[FFontIndex], FX, FY, dsColor));
          end;
        end;
        {$ENDREGION}
      end;
      alCenter : begin
        {$REGION ' - Align Center '}
        FX         := dsAX + (dsControlWidth div 2) - Trunc(GetTextWidth(PChar(AText), ADrawSetting) / 2);
        case dsVAlign of
          avTop    : FY := dsAY;
          avCenter : begin
            FY         := dsAY + (dsControlHeigth div 2) - (dsFontHeight div 2);
          end;
          avBottom : begin
            FY         := dsAY + dsControlHeigth - dsFontHeight;
          end;
        end;
        for I := 1 to Length(AText) do
        begin
          with FMFD_FontSets[FFontIndex].FCharHeader[Ord(AText[I])] do
          begin
            // Test if Char in List.. if not set "?" as place holder
            if chID = 0 then
              FTempChar := @FMFD_FontSets[FFontIndex].FCharHeader[63] // change to "?"
            else FTempChar := @FMFD_FontSets[FFontIndex].FCharHeader[Ord(AText[I])];
            // Calculate and Render Char
            FX := FX + (RenderText(dsFontHeight, FTempChar, @FMFD_FontSets[FFontIndex], FX, FY, dsColor));
          end;
        end;
        {$ENDREGION}
      end;
      alRight  : begin
        {$REGION ' - Align Right  '}
        FX         := dsAX + dsControlWidth - GetTextWidth(PChar(AText), ADrawSetting);
        case dsVAlign of
          avTop    : FY := dsAY;
          avCenter : begin
            FY         := dsAY + (dsControlHeigth div 2) - (dsFontHeight div 2);
          end;
          avBottom : begin
            FY         := dsAY + dsControlHeigth - dsFontHeight;
          end;
        end;  
        for I := 1 to Length(AText) do
        begin
          with FMFD_FontSets[FFontIndex].FCharHeader[Ord(AText[I])] do
          begin
            // Test if Char in List.. if not set "?" as place holder
            if chID = 0 then
              FTempChar := @FMFD_FontSets[FFontIndex].FCharHeader[63] // change to "?"
            else FTempChar := @FMFD_FontSets[FFontIndex].FCharHeader[Ord(AText[I])];
       
            // Calculate and Render Char
            FX := FX + (RenderText(dsFontHeight, FTempChar, @FMFD_FontSets[FFontIndex], FX, FY, dsColor));
          end;
        end;
        {$ENDREGION}
      end;
    end;
  end;
end;

procedure TMIR3_Font.DrawHint(AX, AY: Integer; AText: array of char; ADrawSetting: PDrawSetting);
var
  FWidth        : Integer;
  FTempLines    : Integer;
  FScriptHeight : Integer;
begin

  with ADrawSetting^ do
  begin
    if dsMagicUse then
    begin
      FTempLines    := GetLineCount(PChar(String(AText)));
      FWidth        := GetLineCountMaxWidth(PChar(String(AText)), ADrawSetting);
      FScriptHeight := GetScriptHeight(PChar(String(AText)));
      ADrawSetting.dsControlWidth  := FWidth;
      ADrawSetting.dsControlHeigth := dsFontHeight;
      ADrawSetting.dsAX            := AX + 20;
      ADrawSetting.dsAY            := AY + 20;
      ADrawSetting.dsAX_Offset     := 26;
      ADrawSetting.dsAY_Offset     := 20;

      if ADrawSetting.dsAY + (FTempLines*(dsFontHeight + 1))+FScriptHeight+2 > 585 then
         ADrawSetting.dsAY := 550 - (FTempLines*(dsFontHeight + 1))+FScriptHeight+2;

      if ADrawSetting.dsAX + FWidth > 790 then
        ADrawSetting.dsAX := 795 - FWidth;

     if dsUseMultiColor then
     begin
       // Border
       GRenderEngine.RoundRect(ADrawSetting.dsAX - 8, ADrawSetting.dsAY - 2, FWidth+12, (FTempLines*(dsFontHeight + 1))+FScriptHeight+2, dsColorMC_B, dsColorMC_B2);
       // Inner
       GRenderEngine.RoundRect(ADrawSetting.dsAX - 6, ADrawSetting.dsAY    , FWidth+8 , (FTempLines*(dsFontHeight + 1))+FScriptHeight-2, dsColorMC_1, dsColorMC_2);

       DrawTextColor(String(AText), ADrawSetting);
     end else begin
       // Border
       GRenderEngine.RoundRect(ADrawSetting.dsAX - 8, ADrawSetting.dsAY - 2, FWidth+12, (FTempLines*(dsFontHeight + 1))+2, dsColorMC_B, dsColorMC_B2);
       // Inner
       GRenderEngine.RoundRect(ADrawSetting.dsAX - 7, ADrawSetting.dsAY    , FWidth+9 , (FTempLines*(dsFontHeight + 1))-2, dsColorMC_1, dsColorMC_2);

       DrawTextColor(String(AText), ADrawSetting);
     end;

    end else begin
      FWidth   := Round(GetTextWidth(PChar(String(AText)), ADrawSetting))+ 4;
      ADrawSetting.dsControlWidth  := FWidth;
      ADrawSetting.dsControlHeigth := dsFontHeight;
      ADrawSetting.dsAX            := AX + 16;
      ADrawSetting.dsAY            := AY + 16;

      if ADrawSetting.dsAY > 585 then
         ADrawSetting.dsAY := 585;

      if ADrawSetting.dsAX + FWidth > 790 then
        ADrawSetting.dsAX := 795 - FWidth;

      (* Red *)
      dsColorMC_1     := $9F0a0a2a;//$9F2a0a0a; 
      dsColorMC_2     := $AF020202;

      dsColorMC_B     := $EF656565; //Border
      dsColorMC_B2    := $EF323232;

      // Border
      GRenderEngine.RoundRect(ADrawSetting.dsAX - 4, ADrawSetting.dsAY - 1, FWidth+4, dsFontHeight+1, dsColorMC_B, dsColorMC_B2);
      // Inner
      GRenderEngine.RoundRect(ADrawSetting.dsAX - 3, ADrawSetting.dsAY    , FWidth+2 , dsFontHeight-1, dsColorMC_1, dsColorMC_2);
      ADrawSetting.dsAY := ADrawSetting.dsAY -2;
      DrawText(String(AText), ADrawSetting);
    end;
  end;
end;

procedure TMIR3_Font.DrawItemHint(AX, AY: Integer; AText: array of char; ADrawSetting: PDrawSetting);
var
  I          : Integer;
  FFontIndex : Integer;
  FX, FY     : Single;
  FTempChar  : PMFD_Char;
  TestText   : String;
  FColor     : Cardinal;
begin
 // Add Coloring
 // '¦SFFFFFF¦Text¦EFFFFFF¦'
 // '¦NFFFFFF¦Text .......'

(*
   Color Commands::
   ¦SFFFFFF¦ Start Color
   ¦EFFFFFF¦ End Color
   example : '¦SFFFFFF¦Text¦EFFFFFF¦'

   ¦NFFFFFF¦ Start Color with out end of Coloring (used for one color in one line)
   example : '¦NFFFFFF¦Text .......'

   Texture Commands::
   ¦IFFFF¦FFF¦ Texture ID ¦ File ID

   1821 ¦ 94
   ¦I071D¦05E¦

    GAME_TEXTURE_GROUND_INT         = 94;

   Other Commands, like Bold, Italic::
   ¦B¦ ¦BE¦ Bold
   ¦I¦ ¦IE¦ Italic


*)

  I := 0;
  TestText := '¦SFF0000¦DC¦EFF0000¦ ¦SFFFF00¦100 - 100¦EFFFF00¦ Das ist ein test..';
  CopyMemory(@AText[0], PChar(TestText), Length(TestText));
  with ADrawSetting^ do
  begin
//    for I := 1 to Length(AText) do
//    begin
    //FColor
    while True do
    begin
     if (AText[I] = '¦') and (AText[I+1] = 'S') then
     begin
       FColor := HexToInt('FF' + Copy(AText[I],I+2,6));
       Inc(I, 9);
     end else if (AText[I] = '¦') and (AText[I+1] = 'E') then
              begin
                FColor := dsColor;
                Inc(I, 9);
              end else if (AText[I] = '¦') and (AText[I+1] = 'N') then
                       begin
                         FColor := HexToInt('FF' + Copy(AText[I],I+2,6));
                         Inc(I, 9);
                       end;
     //TestText := TestText + '';

      with FMFD_FontSets[FFontIndex].FCharHeader[Ord(AText[I])] do
      begin
        if (AText[I] = #13) or (AText[I] = '\') or (AText[I] = #10) then
        begin
          if (AText[I] = #13) or (AText[I] = '\') then
          begin
            FX := dsAX;
            FY := FY + dsFontHeight +1;
          end;
        end else begin
          // Test if Char in List.. if not set "?" as place holder
          if chID = 0 then
            FTempChar := @FMFD_FontSets[FFontIndex].FCharHeader[63] // change to "?"
          else FTempChar := @FMFD_FontSets[FFontIndex].FCharHeader[Ord(AText[I])];
          // Calculate and Render Char
          FX := FX + (RenderText(dsFontHeight, FTempChar, @FMFD_FontSets[FFontIndex], FX, FY, FColor));
          // Check, Set and Calculate Kerning
          if (dsUseKerning) and (Length(AText) >= I+1) then
            FX := FX + CalculateKerningPairs(FFontIndex, Ord(AText[I]), Ord(AText[I+1]));
        end;
      end;
    end;
  end;

end;

procedure TMIR3_Font.DrawMoveV(AIndex: Integer; AText: String; ADrawSetting: PDrawSetting);
var
  I               : Integer;
  FTempLines      : Integer;
  FTempText       : String;
  FCutRect        : TRect;
  FTextArray      : array of TTextScrollInfo;
begin
  with ADrawSetting^ do
  begin
    FCutRect   := Rect(dsAX, dsAY-dsFontHeight, dsAX+dsControlWidth, dsAY+dsControlHeigth-(dsFontHeight * 2));
    dsAY       := dsAY + dsControlHeigth - AIndex;
    FTempText  := AText;
    FTempLines := GetLineCount(PChar(AText));
    SetLength(FTextArray, FTempLines);

    for I := 0 to FTempLines-1 do
    begin
      if Pos(#13, FTempText) > 0 then
      begin
        FTextArray[I].FText := Copy(FTempText, 0, Pos(#10, FTempText));
        if PtInRect(FCutRect, Point(dsAX +1, dsAY + ( I * (dsFontHeight + 1))))  then
          FTextArray[I].FShow := True;
        FTempText    := Copy(FTempText, Pos(#13, FTempText)+1, 9999);
      end else begin
        FTextArray[I].FText := FTempText;
        if PtInRect(FCutRect, Point(dsAX +1, dsAY + ( I * (dsFontHeight + 1))))  then
          FTextArray[I].FShow := True;
      end;
    end;

    for I := 0 to FTempLines-1 do
    begin
      dsAY := dsAY + (dsFontHeight + 1);    
      if FTextArray[I].FShow then
      begin
        DrawText(FTextArray[I].FText, ADrawSetting);
      end;
    end;

  end;
  SetLength(FTextArray, 0);
end;

end.
