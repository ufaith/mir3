unit mir3_game_language_engine;

interface

uses Windows, Classes, SysUtils, mir3_global_config;

const
  {$REGION ' - Language Const   '}
 
  //LANG_SCENE_TYPE_NAME = Language ID;
    LANG_GAME_ERROR_OUT_OF_CONNECTION            = 0;

 
  {$ENDREGION}

type
  TGetLangFileVersion  = function(): Integer; stdcall;
  TGetLangFileAutor    = function(Buffer: PChar) : Integer; stdcall;
  {Game Lang}
  TGetLangGameLine     = function(): Integer; stdcall;
  TGetLangGameString   = function(ID: Integer; Buffer: PChar): Integer; stdcall;
  {Magic Lang}
  TGetLangMagicLine    = function(): Integer; stdcall;
  TGetLangMagicString  = function(ID: Integer; Buffer: PChar): Integer; stdcall;

  TMir3_GameLanguageEngine = class
  private
    FGetLangFileVersion : TGetLangFileVersion;
    FGetLangFileAutor   : TGetLangFileAutor;
    FGetLangGameLine    : TGetLangGameLine;
    FGetLangGameString  : TGetLangGameString;
    FGetLangMagicLine   : TGetLangMagicLine;
    FGetLangMagicString : TGetLangMagicString;
    FLang_Handle        : Integer;
    FLangGameFileCols   : Integer;
    FLangMagicFileCols  : Integer;
    function GetLangGameFileTextCols: Integer;
    function GetLangMagicFileTextCols: Integer;
    function GetLangFileVersion: Integer;
    function GetLangAutor: String;
  public
    constructor Create(ALanguage: Integer = C_LANGUAGE_ENGLISH);
    destructor Destroy; override;
    function GetTextFromLangSystem(ATextID: Integer): String;
    function GetMagicTextFromLangSystem(ATextID: Integer): String;
  end;
  
  (*
    using Language system :

    MyText := GameLanguageEngine.GetTextFromLangSystem(ID_TEXT_1);

  *)

implementation

uses mir3_game_backend;

const
  GBufferSize = 10000;

var
  GBuffer  : PChar;

////////////////////////////////////////////////////////////////////////////////
// TMir3_GameLanguageEngine Constructor
//..............................................................................
constructor TMir3_GameLanguageEngine.Create(ALanguage: Integer = C_LANGUAGE_ENGLISH);
begin
  inherited Create;
  FLang_Handle       := 0;
  FLangGameFileCols  := 0;
  FLangMagicFileCols := 0;
  case ALanguage of
    C_LANGUAGE_GERMAN  : begin
      FLang_Handle  := LoadLibrary(PChar('lib/German.lgu'));
      if FLang_Handle = 0 then
      begin
        if Assigned(GRenderEngine) then
        begin
          GRenderEngine.System_Log('No german language file found..');
          GRenderEngine.System_Log('Initialize language engine fail..');
        end;
      end;
    end;
    C_LANGUAGE_ENGLISH  : begin
      FLang_Handle    := LoadLibrary(PChar('lib/English.lgu'));
      if FLang_Handle = 0 then
      begin
        if Assigned(GRenderEngine) then
        begin
          GRenderEngine.System_Log('No english language file found..');
          GRenderEngine.System_Log('Initialize language engine fail..');
        end;
      end;
    end;
  end;

  if FLang_Handle <> 0 then                          
  begin
    if Assigned(GRenderEngine) then
    begin
      GRenderEngine.System_Log('Language Autor   : ' + GetLangAutor);
      GRenderEngine.System_Log('Language Version : ' + IntToStr(GetLangFileVersion));
      GRenderEngine.System_Log('Language engine initialized');
    end;

  end else Exit;

  FLangGameFileCols  := GetLangGameFileTextCols;
  FLangMagicFileCols := GetLangMagicFileTextCols;
end;

////////////////////////////////////////////////////////////////////////////////
// TMir3_GameLanguageEngine Destructor
//..............................................................................
destructor TMir3_GameLanguageEngine.Destroy;
begin
  if FLang_Handle <> 0 then 
    FreeLibrary(FLang_Handle);
  if Assigned(GRenderEngine) then
    GRenderEngine.System_Log('Language engine destroy success');
  inherited Destroy;
end;

////////////////////////////////////////////////////////////////////////////////
// TMir3_GameLanguageEngine Get Language file Version
//..............................................................................
function TMir3_GameLanguageEngine.GetLangFileVersion: Integer;
begin
  Result := 0;
  try
    if FLang_Handle <> 0 then
    begin
      @FGetLangFileVersion := GetProcAddress(FLang_Handle, 'LomCN_GetFileVersion');
      if @FGetLangFileVersion <> nil then
      begin
        Result := FGetLangFileVersion;
      end;
    end else Result := 0;
  except
    Result := 0;
  end;
end;

////////////////////////////////////////////////////////////////////////////////
// TMir3_GameLanguageEngine Get Language file Autor
//..............................................................................
function TMir3_GameLanguageEngine.GetLangAutor: String;
begin
  Result := '';
  try
    if FLang_Handle <> 0 then
    begin
      @FGetLangFileAutor := GetProcAddress(FLang_Handle, 'LomCN_GetFileAutor');
      if @FGetLangFileAutor <> nil then
      begin
        ZeroMemory(GBuffer, GBufferSize);
        FGetLangFileAutor(GBuffer);
        Result := Trim(StrPas(GBuffer));
      end;
    end else Result := '';
  except
    Result := '';
  end;
end;

////////////////////////////////////////////////////////////////////////////////
// TMir3_GameLanguageEngine Get Game Language file Max Lines
//..............................................................................
function TMir3_GameLanguageEngine.GetLangGameFileTextCols: Integer;
begin
  Result := 0;
  try
    if FLang_Handle <> 0 then
    begin
      @FGetLangGameLine := GetProcAddress(FLang_Handle, 'LomCN_GetGameLine');
      if @FGetLangGameLine <> nil then
      begin
        Result := FGetLangGameLine;
      end;
    end else Result := 0;
  except
    Result := 0;
  end;
end;

////////////////////////////////////////////////////////////////////////////////
// TMir3_GameLanguageEngine Get Game Text from Language file
//..............................................................................
function TMir3_GameLanguageEngine.GetTextFromLangSystem(ATextID: Integer): String;
begin
  Result := '';
  try
    if FLang_Handle <> 0 then
    begin
      if ATextID <= FLangGameFileCols then
      begin
        @FGetLangGameString := GetProcAddress(FLang_Handle, 'LomCN_GetGameString');
        if @FGetLangGameString <> nil then
        begin
          ZeroMemory(GBuffer, GBufferSize);
          FGetLangGameString(ATextID, GBuffer);
          Result := Trim(StrPas(GBuffer));
        end;
      end else Result := '.';
    end else Result := '.';
  except
    Result := '.';
  end;
end;



////////////////////////////////////////////////////////////////////////////////
// TMir3_GameLanguageEngine Get Magic Language file Max Lines
//..............................................................................
function TMir3_GameLanguageEngine.GetLangMagicFileTextCols: Integer;
begin
  Result := 0;
  try
    if FLang_Handle <> 0 then
    begin
      @FGetLangMagicLine := GetProcAddress(FLang_Handle, 'LomCN_GetMagicLine');
      if @FGetLangMagicLine <> nil then
      begin
        Result := FGetLangMagicLine;
      end;
    end else Result := 0;
  except
    Result := 0;
  end;
end;

////////////////////////////////////////////////////////////////////////////////
// TMir3_GameLanguageEngine Get Magic Text from Language file
//..............................................................................
function TMir3_GameLanguageEngine.GetMagicTextFromLangSystem(ATextID: Integer): String;
begin
  Result := '';
  try
    if FLang_Handle <> 0 then
    begin
      if ATextID <= FLangMagicFileCols then
      begin
        @FGetLangMagicString := GetProcAddress(FLang_Handle, 'LomCN_GetMagicString');
        if @FGetLangMagicString <> nil then
        begin
          ZeroMemory(GBuffer, GBufferSize);
          FGetLangMagicString(ATextID, GBuffer);
          Result := Trim(StrPas(GBuffer));
        end;
      end else Result := '.';
    end else Result := '.';
  except
    Result := '.';
  end;
end;

procedure Initialize;
begin
  GetMem(GBuffer, GBufferSize);
end;

procedure Finalize;
begin
  FreeMem(GBuffer, GBufferSize);
end;

initialization
  Initialize;

finalization
  Finalize;

end.
