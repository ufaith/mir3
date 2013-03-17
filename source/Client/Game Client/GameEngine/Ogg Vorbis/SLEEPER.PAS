unit Sleeper;

interface

uses
  Classes, ExtCtrls;

type
  TSleeper = class(TComponent)
  private
    FTimer: TTimer;
    Expired: Boolean;
    procedure Expire(Sender: TObject);
    function GetInterval: LongInt;
    procedure SetInterval(AInterval: LongInt);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Sleep;
    procedure SleepFor(AInterval: LongInt);
  published
    property Interval: LongInt read GetInterval write SetInterval;
  end;

procedure Register;

implementation

uses
  Forms;

constructor TSleeper.Create(AOwner: TComponent);
begin
inherited Create(AOwner);
FTimer := TTimer.Create(Self);
FTimer.Enabled := False;
end;

destructor TSleeper.Destroy;
begin
FTimer.Free;
FTimer := nil;
inherited Destroy;
end;

procedure TSleeper.Expire(Sender: TObject);
begin
Expired := True;
end;

function TSleeper.GetInterval: LongInt;
begin
if Assigned(FTimer) then Result := FTimer.Interval
else Result := 0;
end;

procedure TSleeper.SetInterval(AInterval: LongInt);
begin
if Assigned(FTimer) then FTimer.Interval := AInterval;
end;

procedure TSleeper.Sleep;
begin
if Assigned(FTimer) then
  begin
  Expired := False;
  FTimer.OnTimer := Expire;
  FTimer.Enabled := True;
  repeat
    Application.ProcessMessages;
    until Expired;
  FTimer.Enabled := False;
  end;
end;

procedure TSleeper.SleepFor(AInterval: LongInt);
begin
if Assigned(FTimer) then
  begin
  if FTimer.Interval <> AInterval then
    FTimer.Interval := AInterval;
  Sleep;
  end;
end;

procedure Register;
begin
RegisterComponents('Samples', [TSleeper]);
end;

end.
