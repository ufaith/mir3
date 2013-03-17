unit mir3_launcher_language;

interface

uses Windows, Classes, SysUtils;

type
  TGetLangFileVersion    = function(): Integer; stdcall;
  TGetLangFileAutor      = function(Buffer: PChar) : Integer; stdcall;
  {Game Lang}
  TGetLangLauncherLine   = function(): Integer; stdcall;
  TGetLangLauncherString = function(ID: Integer; Buffer: PChar): Integer; stdcall;

  TMir3_LauncherLanguageEngine = class
  private
    FGetLangFileVersion    : TGetLangFileVersion;
    FGetLangFileAutor      : TGetLangFileAutor;
    FGetLangLauncherLine   : TGetLangLauncherLine;
    FGetLangLauncherString : TGetLangLauncherString;
    FLang_Handle           : Integer;
    FLangLauncherFileCols  : Integer;
    function GetLangLauncherFileTextCols: Integer;
    function GetLangFileVersion: Integer;
    function GetLangAutor: String;
  public
    constructor Create(ALanguage: Integer);
    destructor Destroy; override;
    function GetTextFromLangSystem(ATextID: Integer): String;
  end;

implementation

const
  GBufferSize        = 10000;
  C_LANGUAGE_GERMAN  = 0;
  C_LANGUAGE_ENGLISH = 1;

var
  GBuffer  : PChar;


////////////////////////////////////////////////////////////////////////////////
// TMir3_LauncherLanguageEngine Constructor
//..............................................................................
constructor TMir3_LauncherLanguageEngine.Create(ALanguage: Integer);
begin
  inherited Create;
  FLang_Handle           := 0;
  FLangLauncherFileCols  := 0;

  // TODO : Search for language file in lib\



//  case ALanguage of
//    C_LANGUAGE_GERMAN  : begin
//      FLang_Handle  := LoadLibrary(PChar('lib/German.lgu'));
//      if FLang_Handle = 0 then
//      begin
//        if Assigned(GRenderEngine) then
//        begin
//          GRenderEngine.System_Log('No german language file found..');
//          GRenderEngine.System_Log('Initialize language engine fail..');
//        end;
//      end;
//    end;
//    C_LANGUAGE_ENGLISH  : begin
//      FLang_Handle    := LoadLibrary(PChar('lib/English.lgu'));
//      if FLang_Handle = 0 then
//      begin
//        if Assigned(GRenderEngine) then
//        begin
//          GRenderEngine.System_Log('No english language file found..');
//          GRenderEngine.System_Log('Initialize language engine fail..');
//        end;
//      end;
//    end;
//  end;
//
//  if FLang_Handle <> 0 then                          
//  begin
//    if Assigned(GRenderEngine) then
//    begin
//      GRenderEngine.System_Log('Language Autor   : ' + GetLangAutor);
//      GRenderEngine.System_Log('Language Version : ' + IntToStr(GetLangFileVersion));
//      GRenderEngine.System_Log('Language engine initialized');
//    end;
//
//  end else Exit;
//
//  FLangGameFileCols  := GetLangGameFileTextCols;
//  FLangMagicFileCols := GetLangMagicFileTextCols;
end;

////////////////////////////////////////////////////////////////////////////////
// TMir3_LauncherLanguageEngine Destructor
//..............................................................................
destructor TMir3_LauncherLanguageEngine.Destroy;
begin
  if FLang_Handle <> 0 then
    FreeLibrary(FLang_Handle);
//  if Assigned(GRenderEngine) then
//    GRenderEngine.System_Log('Language engine destroy success');
  inherited Destroy;
end;

////////////////////////////////////////////////////////////////////////////////
// TMir3_LauncherLanguageEngine Get Language file Version
//..............................................................................
function TMir3_LauncherLanguageEngine.GetLangFileVersion: Integer;
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
// TMir3_LauncherLanguageEngine Get Language file Autor
//..............................................................................
function TMir3_LauncherLanguageEngine.GetLangAutor: String;
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
// TMir3_LauncherLanguageEngine Get Launcher Language file Max Lines
//..............................................................................
function TMir3_LauncherLanguageEngine.GetLangLauncherFileTextCols: Integer;
begin
  Result := 0;
  try
    if FLang_Handle <> 0 then
    begin
      @FGetLangLauncherLine := GetProcAddress(FLang_Handle, 'LomCN_GetLauncherLine');
      if @FGetLangLauncherLine <> nil then
      begin
        Result := FGetLangLauncherLine;
      end;
    end else Result := 0;
  except
    Result := 0;
  end;
end;

////////////////////////////////////////////////////////////////////////////////
// TMir3_LauncherLanguageEngine Get Launcher Text from Language file
//..............................................................................
function TMir3_LauncherLanguageEngine.GetTextFromLangSystem(ATextID: Integer): String;
begin
  Result := '';
  try
    if FLang_Handle <> 0 then
    begin
      if ATextID <= FLangLauncherFileCols then
      begin
        @FGetLangLauncherString := GetProcAddress(FLang_Handle, 'LomCN_GetLauncherString');
        if @FGetLangLauncherString <> nil then
        begin
          ZeroMemory(GBuffer, GBufferSize);
          FGetLangLauncherString(ATextID, GBuffer);
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
