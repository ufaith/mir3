unit mir3_misc_utils;

interface

uses
  { Delphi }
  Windows,
  SysUtils,
  Math,
  Classes,
  Registry,
  ShellAPI;

type
  TLockList = class(TList)
  private
    FCriticalSection: TRTLCriticalSection;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Lock;
    procedure UnLock;
  end;

  TMir3LockSection = class
  private
    FCriticalSection: TRTLCriticalSection;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Lock;
    procedure UnLock;
  end;

function MakePowerOfTwo(Value: Integer): Integer;
procedure MakePowerOfTwoHW(var H, W, valH, valW: Integer); overload;
procedure MakePowerOfTwoHW(var H, W: Integer; valH, valW: Word); overload;
function CreateMMF(vFileName: String; vOnlyRead: Boolean; var vFileSize: Cardinal; var vError: Integer): PByte;
procedure CloseMMF(var MMFPointer: Pointer);

procedure IncExtended(var aValue: Extended; bValue : Extended);
procedure DecExtended(var aValue: Extended; bValue : Extended);

function RectWidth(const prc: TRect): Integer; inline;
function RectHeight(const prc: TRect): Integer; inline;

function BrowseURL(const URL: string) : Boolean;
function ArrestStringEx (Source, SearchAfter, ArrestBefore: string; var ArrestStr: string): string;
function GetValidStr3(Str: String; var Dest: String; const Divider: Array of Char): String;
function GetClassAsString(AClass: Integer): String;

function _MIN(n1, n2: Integer): Integer;
function _MAX(n1, n2: Integer): Integer;

function HexToInt(AValue: string): LongInt;

implementation

{ TLockList }

  {$REGION ' - TLockList Class  '}
    constructor TLockList.Create;
    begin
      inherited;

      InitializeCriticalSection(FCriticalSection);
    end;

    destructor TLockList.Destroy;
    begin
      DeleteCriticalSection(FCriticalSection);

      inherited;
    end;

    procedure TLockList.Lock;
    begin
      EnterCriticalSection(FCriticalSection);
    end;

    procedure TLockList.UnLock;
    begin
      LeaveCriticalSection(FCriticalSection);
    end;
  {$ENDREGION}

{ TMir3LockSection }

  {$REGION ' - TMir3LockSection Class  '}
    constructor TMir3LockSection.Create;
    begin
      inherited;

      InitializeCriticalSection(FCriticalSection);
    end;

    destructor TMir3LockSection.Destroy;
    begin
      DeleteCriticalSection(FCriticalSection);

      inherited;
    end;

    procedure TMir3LockSection.Lock;
    begin
      EnterCriticalSection(FCriticalSection);
    end;

    procedure TMir3LockSection.UnLock;
    begin
      LeaveCriticalSection(FCriticalSection);
    end;
  {$ENDREGION}

function MakePowerOfTwo(Value: Integer): Integer;
begin
  Result := 1 shl Ceil(Log2(Value));
end;

procedure MakePowerOfTwoHW(var H, W, valH, valW: Integer); overload;
begin
  H := 1 shl Ceil(Log2(valH));
  W := 1 shl Ceil(Log2(valW));
end;

procedure MakePowerOfTwoHW(var H, W: Integer; valH, valW: Word); overload;
begin
  H := 1 shl Ceil(Log2(valH));
  W := 1 shl Ceil(Log2(valW));
end;

function CreateMMF(vFileName: String; vOnlyRead: Boolean; var vFileSize: Cardinal; var vError: Integer): PByte;
var
  FFileHandle : Integer;
  FMMFHandle  : Integer;
begin
  Result    := nil;
  vError    := 0;
  vFileSize := 0;
  case vOnlyRead of
    True:
    begin;                              //fmShareDenyNone or
      FFileHandle := FileOpen(vFileName, fmOpenRead);
      if FFileHandle <> 0 then
      begin
        vFileSize  := GetFileSize(FFileHandle, nil);
        FMMFHandle := CreateFileMapping(FFileHandle, nil, PAGE_READONLY, 0, vFileSize, nil);
        if FMMFHandle = 0 then
        begin
          Result := nil;
          CloseHandle(FFileHandle);
          vError := 2;
          Exit;
        end;
        Result := MapViewOfFile(FMMFHandle, FILE_MAP_READ, 0, 0, vFileSize);
        if Result = nil then
        begin
          vError := 3;
          CloseHandle(FFileHandle);
          CloseHandle(FMMFHandle);
          Exit;
        end;
      end else
      begin
        Result := nil;
        vError := 4;
        Exit;
      end;
      CloseHandle(FFileHandle);
      CloseHandle(FMMFHandle);
    end;

    False:
    begin
      FFileHandle := FileOpen(vFileName, fmOpenReadWrite);
      if FFileHandle <> 0 then
      begin
        vFileSize  := GetFileSize(FFileHandle, nil);
        FMMFHandle := CreateFileMapping(FFileHandle, nil, PAGE_READWRITE, 0, vFileSize, nil);
        if FMMFHandle = 0 then
        begin
          Result := nil;
          CloseHandle(FFileHandle);
          vError := 2;
          Exit;
        end;
        Result := MapViewOfFile(FMMFHandle, FILE_MAP_ALL_ACCESS, 0, 0, vFileSize);
        if Result = nil then
        begin
          vError := 3;
          CloseHandle(FFileHandle);
          CloseHandle(FMMFHandle);
          Exit;
        end;                         
      end else
      begin
        Result := nil;
        vError := 4;
        Exit;
      end;
      CloseHandle(FFileHandle);
      CloseHandle(FMMFHandle);
    end;
  end;
end;

procedure CloseMMF(var MMFPointer: Pointer);
begin
  if MMFPointer <> nil then
  begin
    try
      UnmapViewOfFile(MMFPointer);
      MMFPointer := PtrToNil;
    except
      MMFPointer := nil;
    end;
  end;
end;

procedure IncExtended(var aValue: Extended; bValue : Extended);
begin
  aValue := aValue + bValue;
end; { IncExtended }

procedure DecExtended(var aValue: Extended; bValue : Extended);
begin
  aValue := aValue - bValue;
end; { DecExtended }

function RectWidth(const prc: TRect): Integer; inline;
begin
  Result:= prc.right - prc.left;
end; { RectWidth }

function RectHeight(const prc: TRect): Integer; inline;
begin
  Result:= prc.bottom - prc.top;
end; { RectHeight }

function BrowseURL(const URL: string) : Boolean;
var
  FBrowser: string;
begin
  Result := True;
  FBrowser := '';

  with TRegistry.Create do 
  begin // Ryan - Don't really need the begin but just keeps it all maintained so we know who the 'with' 'do' belongs two.
    try
      RootKey := HKEY_CLASSES_ROOT;
      Access  := KEY_QUERY_VALUE;
      if OpenKey('\htmlfile\shell\open\command', False) then
        FBrowser := ReadString('') ;
      CloseKey;
    finally
      Free;
    end;
  end;

  if FBrowser = '' then
  begin
    Result := False;
    Exit;
  end;
  FBrowser := Copy(FBrowser, Pos('"', FBrowser) + 1, Length(FBrowser)) ;
  FBrowser := Copy(FBrowser, 1, Pos('"', FBrowser) - 1) ;
  ShellExecute(0, 'open', PChar(FBrowser), PChar(URL), nil, SW_SHOW) ;
end;

function ArrestStringEx(Source, SearchAfter, ArrestBefore: string; var ArrestStr: string): string;
var
  BufCount, SrcCount, SrcLen: Integer;
  GoodData, Fin, flag: Boolean;
  i, n: Integer;
begin
  ArrestStr := ''; {result string}
  Result    := '';
  if Source = '' then
    Exit;

  try
    SrcLen := Length(Source);
    GoodData := False;
    if SrcLen >= 2 then
      if Source[1] = SearchAfter then
      begin
        Source := Copy(Source, 2, SrcLen - 1);
        SrcLen := Length(Source);
        GoodData := TRUE;
      end else
      begin
        n := Pos (SearchAfter, Source);
        if n > 0 then
        begin
          Source := Copy(Source, n + 1, SrcLen - (n));
          SrcLen := Length(Source);
          GoodData := TRUE;
        end;
      end;

    if GoodData then
    begin
      n := Pos (ArrestBefore, Source);
      if n > 0 then
      begin
        ArrestStr := Copy(Source, 1, n - 1);
        Result := Copy(Source, n + 1, SrcLen - n);
      end else Result := SearchAfter + Source;
    end else if SrcLen = 1 then
      if Source[1] = SearchAfter then
        Result := Source;
  except
    ArrestStr := '';
    Result := '';
  end;
end;

function GetValidStr3(Str: String; var Dest: String; const Divider: Array of Char): String;
const
   BUF_SIZE = 20480;
var
	Buf: array[0..BUF_SIZE] of char;
  BufCount,
  Count,
  SrcLen, I,
  ArrCount: Longint;
  Ch: char;
label
	CATCH_DIV;
begin
  try
    SrcLen := Length(Str);
    BufCount := 0;
    Count := 1;
    Ch := #0;

    if SrcLen >= BUF_SIZE - 1 then
    begin
       Result := '';
       Dest   := '';
       Exit;
    end;

    if Str = '' then
    begin
       Dest   := '';
       Result := Str;
       Exit;
    end;
    ArrCount := SizeOf(Divider) div SizeOf(Char);

    while True do
    begin
      if Count <= SrcLen then
      begin
        Ch := Str[Count];
        for I := 0 to ArrCount - 1 do
           if Ch = Divider[I] then
             goto CATCH_DIV;
      end;

      if Count > SrcLen then
      begin
        CATCH_DIV:
        if (BufCount > 0) then
        begin
          if BufCount < BUF_SIZE - 1 then
          begin
            Buf[BufCount] := #0;
            Dest := string(Buf);
            Result := Copy(Str, Count + 1, SrcLen - Count);
          end;
          Break;
        end else
        begin
          if Count > SrcLen then
          begin
            Dest := '';
            Result := Copy (Str, Count + 2, SrcLen - 1);
            break;
          end;
        end;
      end else
      begin
        if BufCount < BUF_SIZE - 1 then
        begin
          Buf[BufCount] := Ch;
          Inc(BufCount);
        end;
      end;
      Inc(Count);
    end;
  except
    Dest   := '';
    Result := '';
  end;
end;

function GetClassAsString(AClass: Integer): String;
begin
  case AClass of
    0: Result := 'Warrior';
    1: Result := 'Wizard';
    2: Result := 'Taoist';
    3: Result := 'Assassin';
  end;
end;

function _MIN(n1, n2: Integer): Integer;
begin
  if n1 < n2 then
    Result := n1
  else Result := n2;
end;

function _MAX(n1, n2: Integer): Integer;
begin
  if n1 > n2 then
    Result := n1
  else Result := n2;
end;

function HexToInt(AValue: string): LongInt;
var
  digit: Char;
  Count, I: Integer;
  cur, Val: LongInt;
begin
  Val   := 0;
  Count := Length(AValue);
  for I := 1 to Count do
  begin
    digit := AValue[I];
    if (digit >= '0') and (digit <= '9') then
      cur := Ord(digit) - Ord('0')
    else if (digit >= 'A') and (digit <= 'F') then
      cur := Ord(digit) - Ord('A') + 10
    else if (digit >= 'a') and (digit <= 'f') then
      cur := Ord(digit) - Ord('a') + 10
    else cur := 0;
    Val := Val + (cur shl (4 * (Count - I)));
  end;
  Result := Val;
  //   Result := (Val and $0000FF00) or ((Val shl 16) and $00FF0000) or ((Val shr 16) and $000000FF);
end;

end.
