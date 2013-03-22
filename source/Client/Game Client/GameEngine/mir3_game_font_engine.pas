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
    dsFontHeight     : Integer;
    dsFontSetting    : TMIR3_FontSettings;
    dsUseKerning     : Boolean;
    dsColor          : Longword;
    dsHAlign         : TMir3_Align;
    dsVAlign         : TMIR3_VAlign;
    dsMaxWidth       : Integer;
  end;

  TTextScrollInfo = record
    FText : String[255];
    FShow : Boolean;
  end;
  
  TFontSetup = record
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
    FCharHeader            : array [0..255] of TMFD_Char;
    FKerningHeader         : array of TMFD_Kerning;
  end;

  {$ENDREGION}

  IMIR3_Font = interface
  ['{27CAF778-3E49-4E7C-93DF-2555498C1B70}']
    function GetFontIndex(AFontHeight: Integer; AFontSetting: PMIR3_FontSettings): Integer;
    function CalculateKerningPairs(AFontID, AFirst, ASecond: Integer): Single;
    function RenderText(const AFontHeight : Integer; AChar: PMFD_Char; AFontSet: PMIR3_MFD_Font_Set; AX, AY: Single; AColor: Longword = $FFFFFFFF): Single;
    function LoadMFDFile(AFileName: String): Boolean;
    function GetLineCount(AText: PChar): Integer;
    function GetCharWidth(AChar: Char; AFontHeight: Integer; AFontSetting: PMIR3_FontSettings): Single;
    function GetTextWidth(AText: PChar; AFontHeight: Integer; AFontSetting: PMIR3_FontSettings): Single;
    procedure GetFirstPositionOfChar(AFontID: Integer; ATextField: String; AXOldPos: Integer; var FCharCountPos: Integer; AMouseUse: Boolean=False);
    procedure GetFirstVisibleChar(AFontID: Integer; ATextField: String; FCharCountPos: Integer; var AXPos: Integer);
    procedure DrawText(AText: String; ADrawSetting: PDrawSetting);
    procedure DrawTextRect(AText: String; AFirstVisibleChar: Integer; ADrawSetting: PDrawSetting);
    procedure DrawControlText(AText: String; ADrawSetting: PDrawSetting);
    procedure DrawHint(AX, AY: Integer; AText: PChar; ADrawSetting: PDrawSetting);
    procedure DrawMoveV(AIndex: Integer; AText: String; ADrawSetting: PDrawSetting);
  end;

  TMIR3_Font = class(TInterfacedObject, IMIR3_Font)
  strict private
    FIndex            : Integer;
    FScale            : Single;
    FFileHeader       : TMFD_FileHeader;
    FFontSetup        : array [1..8] of TFontSetup;
    FMFD_FontSets     : array of TMIR3_MFD_Font_Set;
  private
    function GetFontIndex(AFontHeight: Integer; AFontSetting: PMIR3_FontSettings): Integer;
    function CalculateKerningPairs(AFontID, AFirst, ASecond: Integer): Single;
    function RenderText(const AFontHeight : Integer; AChar: PMFD_Char; AFontSet: PMIR3_MFD_Font_Set; AX, AY: Single; AColor: Longword = $FFFFFFFF): Single;
    function LoadMFDFile(AFileName: String): Boolean;
  public
    constructor Create;
    destructor Destroy; override;
  public
    function GetLineCount(AText: PChar): Integer;
    function GetCharWidth(AChar: Char; AFontHeight: Integer; AFontSetting: PMIR3_FontSettings): Single;
    function GetTextWidth(AText: PChar; AFontHeight: Integer; AFontSetting: PMIR3_FontSettings): Single;
    procedure GetFirstPositionOfChar(AFontID: Integer; ATextField: String; AXOldPos: Integer; var FCharCountPos: Integer; AMouseUse: Boolean=False);
    procedure GetFirstVisibleChar(AFontID: Integer; ATextField: String; FCharCountPos: Integer; var AXPos: Integer);
    
    procedure DrawText(AText: String; ADrawSetting: PDrawSetting);
    procedure DrawTextRect(AText: String; AFirstVisibleChar: Integer; ADrawSetting: PDrawSetting);
    procedure DrawControlText(AText: String; ADrawSetting: PDrawSetting);
    procedure DrawHint(AX, AY: Integer; AText: PChar; ADrawSetting: PDrawSetting);
    procedure DrawMoveV(AIndex: Integer; AText: String; ADrawSetting: PDrawSetting);
  end;
   
  procedure InitDrawSetting(var ADrawSetting: TDrawSetting);
  
implementation

uses mir3_game_backend;

  procedure InitDrawSetting(var ADrawSetting: TDrawSetting);
  begin
    with ADrawSetting do
    begin
      dsControlWidth  := 0;
      dsControlHeigth := 0;
      dsAX            := 0;
      dsAY            := 0;
      dsFontHeight    := 0;
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
      FFontSetup[1].fsFontHeight  := 16; 
      FFontSetup[1].fsFontSetting := [];
      FFontSetup[2].fsFontHeight  := 18; 
      FFontSetup[2].fsFontSetting := [];
      FFontSetup[3].fsFontHeight  := 21;
      FFontSetup[3].fsFontSetting := [];
    end;

    destructor TMIR3_Font.destroy;
    var
      I : Integer;
    begin
      for I := Low(FMFD_FontSets) to High(FMFD_FontSets) do
      begin
        if Assigned(FMFD_FontSets[I].FFontTexture) then
          FMFD_FontSets[I].FFontTexture.Free;
        ZeroMemory(@FMFD_FontSets[High(FMFD_FontSets)].FCharHeader, (256 * SizeOf(TMFD_Char)));//SizeOf(TMFD_CharPack)));
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
          ZeroMemory(@FMFD_FontSets[High(FMFD_FontSets)].FCharHeader, (256 * SizeOf(TMFD_Char)));//SizeOf(TMFD_CharPack)));
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


function TMIR3_Font.GetFontIndex(AFontHeight: Integer; AFontSetting: PMIR3_FontSettings): Integer;
begin
  {$REGION ' - Font Setting '}
    case AFontHeight of
      0..14 : begin
        if (fsBold in AFontSetting^) and not (fsItalic in AFontSetting^) then
        begin
          if not FMFD_FontSets[1].FSetActive then Exit;
            Result := 1;
        end else if (fsItalic in AFontSetting^) and not (fsBold in AFontSetting^) then
                 begin
                   if not FMFD_FontSets[2].FSetActive then Exit;
                     Result := 2;
                 end else if (fsItalic in AFontSetting^) and (fsBold in AFontSetting^) then
                          begin
                            if not FMFD_FontSets[3].FSetActive then Exit;
                              Result := 3;
                          end else begin
                            if not FMFD_FontSets[0].FSetActive then Exit;
                              Result := 0;
                          end;
      end;
      15..20 : begin
        if (fsBold in AFontSetting^) and not (fsItalic in AFontSetting^) then
        begin
          if not FMFD_FontSets[5].FSetActive then Exit;
            Result := 5;
        end else if (fsItalic in AFontSetting^) and not (fsBold in AFontSetting^) then
                 begin
                   if not FMFD_FontSets[6].FSetActive then Exit;
                     Result := 6;
                 end else if (fsItalic in AFontSetting^) and (fsBold in AFontSetting^) then
                          begin
                            if not FMFD_FontSets[7].FSetActive then Exit;
                              Result := 7;
                          end else begin
                            if not FMFD_FontSets[4].FSetActive then Exit;
                              Result := 4;
                          end;
      end;
      21..25 : begin
        if (fsBold in AFontSetting^) and not (fsItalic in AFontSetting^) then
        begin
          if not FMFD_FontSets[9].FSetActive then Exit;
            Result := 9;
        end else if (fsItalic in AFontSetting^) and not (fsBold in AFontSetting^) then
                 begin
                   if not FMFD_FontSets[10].FSetActive then Exit;
                     Result := 10;
                 end else if (fsItalic in AFontSetting^) and (fsBold in AFontSetting^) then
                          begin
                            if not FMFD_FontSets[11].FSetActive then Exit;
                              Result := 11;
                          end else begin
                            if not FMFD_FontSets[8].FSetActive then Exit;
                              Result := 8;
                          end;
      end;
      26..100 : begin
        if (fsBold in AFontSetting^) and not (fsItalic in AFontSetting^) then
        begin
          if not FMFD_FontSets[13].FSetActive then Exit;
            Result := 13;
        end else if (fsItalic in AFontSetting^) and not (fsBold in AFontSetting^) then
                 begin
                   if not FMFD_FontSets[14].FSetActive then Exit;
                     Result := 14;
                 end else if (fsItalic in AFontSetting^) and (fsBold in AFontSetting^) then
                          begin
                            if not FMFD_FontSets[15].FSetActive then Exit;
                              Result := 15;
                          end else begin
                            if not FMFD_FontSets[12].FSetActive then Exit;
                              Result := 12;
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

function TMIR3_Font.GetTextWidth(AText: PChar; AFontHeight: Integer; AFontSetting: PMIR3_FontSettings): Single;
var
  FTempString : PChar;
  FTempLine   : Single;
  FTempSet    : PMIR3_MFD_Font_Set;
begin
  Result      := 0;
  FTempString := AText;
  FTempSet    := @FMFD_FontSets[GetFontIndex(AFontHeight, AFontSetting)];
  while (FTempString^ <> #0) do
  begin
    FTempLine := 0;
    while (not (FTempString^ in [#0,#10,#13,'\'])) do
    begin
      FTempLine := FTempLine + ((AFontHeight / FTempSet.FFontInformationHeader.ihFontSize) * FTempSet.FCharHeader[Ord(FTempString^)].chXAdvance) + 1;
      Inc(FTempString);
    end;
    if (FTempLine > Result) then
      Result := FTempLine;
    if (FTempString^ in [#10,#13,'\']) then Break;
  end;
  Result := Result;
end;

procedure TMIR3_Font.GetFirstPositionOfChar(AFontID: Integer; ATextField: String; AXOldPos: Integer; var FCharCountPos: Integer; AMouseUse: Boolean=False);
var
  I,FPos : Integer;
begin
  for I := 1 to Length(ATextField) do
  begin
    FPos := Trunc(GetTextWidth(PChar(Copy(ATextField, 0, I)), FFontSetup[AFontID].fsFontHeight, @FFontSetup[AFontID].fsFontSetting));
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
begin
  AXPos := 0;
  if (ATextField = '') or (FCharCountPos = 0) or (FCharCountPos > Length(ATextField)) then  Exit;

  AXPos := Round(GetTextWidth(PChar(Copy(ATextField, 0, FCharCountPos)), FFontSetup[AFontID].fsFontHeight, @FFontSetup[AFontID].fsFontSetting));

end;

function TMIR3_Font.GetCharWidth(AChar: Char; AFontHeight: Integer; AFontSetting: PMIR3_FontSettings): Single;
var
  FTempSet : PMIR3_MFD_Font_Set;
begin
   FTempSet := @FMFD_FontSets[GetFontIndex(AFontHeight, AFontSetting)];
   Result   := ((AFontHeight / FTempSet.FFontInformationHeader.ihFontSize) * FTempSet.FCharHeader[Ord(AChar)].chXAdvance) + 1;
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
  Result    := (AScale * AChar.chXAdvance) + 1;
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
    FFontIndex := GetFontIndex(dsFontHeight, @dsFontSetting);
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
        FX         := dsAX + (dsControlWidth div 2) - Trunc(GetTextWidth(PChar(AText), dsFontHeight, @dsFontSetting) / 2);
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
                FX := dsAX + (dsControlWidth div 2) - Trunc(GetTextWidth(PChar(Copy(AText,I + 1, MaxInt)), dsFontHeight, @dsFontSetting) / 2);
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
        FX         := dsAX + dsControlWidth - GetTextWidth(PChar(AText), dsFontHeight, @dsFontSetting);
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
                FX := dsAX + dsControlWidth - GetTextWidth(PChar(Copy(AText,I + 1, MaxInt)), dsFontHeight, @dsFontSetting);
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
    FFontIndex := GetFontIndex(dsFontHeight, @dsFontSetting);
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
            else if (I+1 <= Length(AText)) and (FX+GetCharWidth(AText[I+1], dsFontHeight, @dsFontSetting) > dsMaxWidth) then
                   Break;
          end;
        end;
        {$ENDREGION}
      end;
      alCenter : begin
        {$REGION ' - Align Center '}
        FX         := dsAX + (dsControlWidth div 2) - Trunc(GetTextWidth(PChar(AText), dsFontHeight, @dsFontSetting) / 2);
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
            else if (I+1 <= Length(AText)) and (FX+GetCharWidth(AText[I+1], dsFontHeight, @dsFontSetting) > dsMaxWidth) then
                   Break;
          end;
        end;
        {$ENDREGION}
      end;
      alRight  : begin
        {$REGION ' - Align Right '}
        FX         := dsAX + dsControlWidth - GetTextWidth(PChar(AText), dsFontHeight, @dsFontSetting);
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
            else if (I+1 <= Length(AText)) and (FX+GetCharWidth(AText[I+1], dsFontHeight, @dsFontSetting) > dsMaxWidth) then
                   Break;
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
// It can by use at all Ingame things thats use one line and one color
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
    FFontIndex := GetFontIndex(dsFontHeight, @dsFontSetting);
    case dsHAlign of
      alLeft   : begin
        {$REGION ' - Align Left '}
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
        FX         := dsAX + (dsControlWidth div 2) - Trunc(GetTextWidth(PChar(AText), dsFontHeight, @dsFontSetting) / 2);
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
        {$REGION ' - Align Right '}
        FX         := dsAX + dsControlWidth - GetTextWidth(PChar(AText), dsFontHeight, @dsFontSetting);
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

procedure TMIR3_Font.DrawHint(AX, AY: Integer; AText: PChar; ADrawSetting: PDrawSetting);
var
  FWidth     : Integer;
begin
  with ADrawSetting^ do
  begin
    FWidth     := Round(GetTextWidth(AText, dsFontHeight, @dsFontSetting))+ 4;
    ADrawSetting.dsControlWidth  := FWidth;
    ADrawSetting.dsControlHeigth := dsFontHeight;
    ADrawSetting.dsAX            := AX + 14;
    ADrawSetting.dsAY            := AY + 14;

    if ADrawSetting.dsAY > 585 then
       ADrawSetting.dsAY := 585;

    if ADrawSetting.dsAX + FWidth > 790 then
      ADrawSetting.dsAX := 795 - FWidth;
    
    GRenderEngine.Rectangle1Color(ADrawSetting.dsAX - 2, ADrawSetting.dsAY - 1, FWidth, dsFontHeight + 1, $EF131313, $EF585a5e, True);
    GRenderEngine.Rectangle(ADrawSetting.dsAX - 2, ADrawSetting.dsAY - 1, FWidth, dsFontHeight + 1, $AF030303, False);
    DrawText(AText, ADrawSetting);
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
