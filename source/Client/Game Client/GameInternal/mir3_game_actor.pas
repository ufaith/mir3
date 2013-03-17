(*********************************************************************
 *   LomCN Mir3 Actor core File 2012                                 *
 *                                                                   *
 *   Web       : http://www.lomcn.co.uk                              *
 *   Version   : 0.0.0.1                                             *
 *                                                                   *
 *   - File Info -                                                   *
 *                                                                   *
 *   This file hold the Actor Declarations                           *
 *                                                                   *
 *                                                                   *
 *                                                                   *
 *********************************************************************
 * Change History                                                    *
 *                                                                   *
 *  - 0.0.0.1 [2012-10-08] Coly : fist init                          *
 *                                                                   *
 *                                                                   *
 *                                                                   *
 *                                                                   *
 *********************************************************************
 *  - TODO List for this *.pas file -                                *
 *-------------------------------------------------------------------*
 *  if a todo finished, then delete it here...                       *
 *  if you find a global TODO thats need to do, then add it here..   *
 *-------------------------------------------------------------------*
 *                                                                   *
 *  - TODO : -all -fill *.pas header information                     *
 *                 (how to need this file etc.)                      *
 *                                                                   *
 *  - TODO : -all -Check if Frame timing correct at MonActions       *
 *                                                                   *
 *********************************************************************)
unit mir3_game_actor;

interface

uses Windows, Messages, SysUtils,
     mir3_misc_utils, mir3_game_actor_action, mir3_global_config;

type
  IActor = interface
  ['{F6AB6125-B91D-4B96-AE63-C181E083EDB2}']
    function GetMessage(AMessage: PActorMessage): Boolean;
    procedure ProcessActor;
  	procedure RenderActor(AX, AY: Integer; ABlend: Boolean; AFlag: Boolean);
  end;
  
  IActorNPC = interface(IActor)
  ['{DCA79765-448C-48DA-8C97-F125CD140275}']
  
  end;  
  
  IActorHuman = interface(IActor)
  ['{1B45E52A-08B7-426F-98F6-8AD208F56B07}']

  end;  

type
  (* TActor *)  
  TActor      = class(TInterfacedObject, IActor)
    { String }
    FActorName              : String;              {hold the name of the Actor or later the User Name}
	  FActorGuildName         : String;              {hold the Guild name from the Actor}
	  FActorRankName          : String;              {hold the Rank name from the Actor}
    { Byte }
    FActorJob               : Byte;                {0:Warrior, 1:Wizard, 2:Tao, 3:Assassin}
    FActorGender            : Byte;                {0:Male, 1:Female}
   	FActorRace              : Byte;                {used Race   ID 0..255}
    FActorDirectory         : Byte;                {used Directory  ID 0..7}
    FActorEffect            : Byte;                {used Dress  ID 0..255}
    FActorDress             : Byte;                {used Dress  ID 0..255}
    FActorDressColor        : Byte;                {used Dress  ID 0..255}
    FActorHair              : Byte;                {used Hair   ID 0..255}
	  FActorWeapon            : Byte;                {used Weapon ID 0..255}
	  FActorWeaponFrame       : Byte;                {used Weapon Frame ID 0..255}
	  FActorHorse             : Byte;                {used Horse  ID 0..255}
    { Integer }

    FActorCurrent_X         : Integer;             {hold the Actors X Position}
    FActorCurrent_Y         : Integer;             {hold the Actors Y Position}
	  FActorRecogId           : Integer;             {hold the Actors Recog ID}
    FActorTarget_X          : Integer;             {hold the Targets X Position}
    FActorTarget_Y          : Integer;             {hold the Targets Y Position}
    FActorTargetRecogId     : Integer;             {hold the Target Recog ID}
	  FActorCurrentAction     : Integer;             {hold the Current Actor Action}

    { Boolean }
    FActorIsDeath           : Boolean;             {Signal if Actor Death}
    FActorIsSkeleton        : Boolean;             {Signal if Actor Skeleton: Cow,Pig,Hen...}
    FActorRunSound          : Boolean;             {Signal can Actor Sound Run}
    FActorVisible	          : Boolean;             {Signal if Actor Visible ingame}
    { TList/TGList/TStringList }

	{ other }
	  FActorAction            : PMonsterAction;
	//FActorBodySurface        : IMir3Image;
	//FActorHorseSurface       : IMir3Image;
  //FActorHorseSurfaceShadow : IMir3Image;
  protected
    { Integer }
    FActorStartFrame        : Integer;             {used for Actor Image Frame Start}
    FActorEndFrame          : Integer;             {used for Actor Image Frame End}
    FActorCurrentFrame      : Integer;             {hold the last Image Frame}
    FActorCurrentFrameDef   : Integer;             {hold the last Default Image Frame}
    FActorFrameCountDef     : Integer;             {hold the last Default Frame Count}
    FActorEffectStart       : Integer;             {used for Actor Effect Frame Start}
    FActorEffectFrame       : Integer;             {used for Actor Effect Frame Max}
    FActorEffectEnd         : Integer;             {used for Actor Effect Frame End}
    FActorGold              : Integer;             {hold the Actors Gold}
  public
    { TList/TGList/TStringList }
    FActorMessageList       : TLockList;           {used for Internal Message Handling}
	  FHealthActionStatusList : TLockList;           {used to hold Action Status Messages to show ingame}
	  { other }
	  FRealActorMessage       : TActorMessage;       {used for External Message Handling}
  private
	  function GetMessage(AMessage: PActorMessage): Boolean;
  public
    constructor Create; dynamic;
    destructor Destroy; override;
  public
    procedure ProcessActor; dynamic;
	  procedure ProcessMessage;
	  procedure ProcessHurryMessage;
	  procedure RenderActor(AX, AY: Integer; ABlend: Boolean; AFlag: Boolean); dynamic;
	  procedure AddHealthActionStatus(AStatus: Byte; AValue: Integer);
  end; 
  
  (* TActorNPC *)  
  TActorNPC   = class(TActor, IActorNPC)
  public  
    constructor Create; override;
	  destructor Destroy; override;
  public
    procedure ProcessActor;	override;
    procedure RenderActor(AX, AY: Integer; ABlend: Boolean; AFlag: Boolean); override;		
  end;
  
  (* TActorHuman *)
  TActorHuman = class(TActor, IActorHuman)
  public  
    constructor Create; override;
	  destructor Destroy; override;
  public
    procedure ProcessActor;	override;
    procedure RenderActor(AX, AY: Integer; ABlend: Boolean; AFlag: Boolean); override;	
  end;
  
implementation

//**********************************************************
// TActor::Create
// Actor Constructor (Initial Memory)
//****	
constructor TActor.Create;
begin
  Inherited Create;
  FActorName                 := ''; 
  FActorGuildName            := '';
  FActorRankName             := ''; 
  {Byte}
  FActorJob                  := 0;
  FActorGender               := 0;
  FActorRace                 := 0;
  FActorDirectory            := 0;
  FActorEffect               := 0;
  FActorDress                := 0;
  FActorDressColor           := 0;
  FActorHair                 := 0;
  FActorWeapon               := 0;
  FActorWeaponFrame          := 0;
  FActorHorse                := 0;
  {Integer}                  
  FActorStartFrame           := 0;
  FActorEndFrame             := 0;
  FActorCurrentFrame         := -1;
  FActorCurrentFrameDef      := 0;
  FActorFrameCountDef        := 0;
  FActorEffectStart          := 0;
  FActorEffectFrame          := -1;
  FActorEffectEnd            := 0;
  FActorCurrent_X            := 0;
  FActorCurrent_Y            := 0;	
  FActorRecogId              := 0;
  FActorTarget_X             := 0;
  FActorTarget_Y             := 0;
  FActorTargetRecogId        := 0;
  {Boolean}                  
  FActorIsDeath              := False;
  FActorIsSkeleton           := False;
  FActorRunSound             := False;
  FActorVisible              := True;
  {TList/TGList/TStringList}
  FActorMessageList          := TLockList.Create;
  FHealthActionStatusList    := TLockList.Create;
end;
	
//**********************************************************
// TActor::Destroy
// Actor Destructor (cleanup Memory)
//****	
destructor TActor.Destroy;
var
  I       : Integer;
  FMessage: PActorMessage;
  FStatus : PHealthActionStatus;
begin
  if Assigned(FActorMessageList) then
  begin
    for I := 0 to FActorMessageList.Count - 1 do
    begin
      FMessage := FActorMessageList.Items[I];
      Dispose(FMessage);
    end;
	  FActorMessageList.Clear;
    FreeAndNil(FActorMessageList);
  end;
  
  if Assigned(FHealthActionStatusList) then
  begin
    for I := 0 to FHealthActionStatusList.Count - 1 do
    begin
      FStatus := FHealthActionStatusList.Items[I];
      Dispose(FStatus);
    end;
	  FHealthActionStatusList.Clear;
    FreeAndNil(FHealthActionStatusList);
  end;  
  
  Inherited Destroy;
end;

//**********************************************************
// TActor::ProcessActor
// Run all Actor things
//****
procedure TActor.ProcessActor;
begin

  
end;

//**********************************************************
// TActor::ProcessMessage
// Run all Actor Message things
//****
procedure TActor.ProcessMessage;
var
  FMessage : PActorMessage;
begin
  while (FActorCurrentAction = 0) and GetMessage(@FMessage) do
  begin
    case FMessage.amIdent of 
      SM_STRUCK  : begin
        //m_nHiterCode := FMessage.amSound;
        //ReadyAction(FMessage);
	    end;
      SM_DEATH   ,
      SM_NOWDEATH,
      SM_SKELETON,
      SM_ALIVE   : begin
        //ReadyAction(FMessage);
 	    end;
	  //add other ...
      else begin
        //ReadyAction(FMessage);
      end;	
    end;
  end;	
end;

//**********************************************************
// TActor::ProcessHurryMessage
// Run Hurry Actor Message things
//****
procedure TActor.ProcessHurryMessage;
var
  FCount   : Integer;
  FFinish  : Boolean;
  FMessage : PActorMessage;
begin
  while True do
  begin
    if FActorMessageList.Count <= FCount then
	    Break;
	  
	  FFinish  := False;
	  FMessage := FActorMessageList[FCount];
    case FMessage.amIdent of
      SM_MAGICFIRE      : begin
{         if m_CurMagic.ServerMagicCode <> 0 then
        begin
          m_CurMagic.ServerMagicCode := 111;
          m_CurMagic.target          := FMessage.X;
          m_CurMagic.EffectNumber    := FMessage.dir;
          m_CurMagic.targx           := FMessage.Feature;
          m_CurMagic.targy           := FMessage.State;
          m_CurMagic.Recusion        := True;
          if FMessage.Y In [0..MAXMAGICTYPE - 1] then
            m_CurMagic.EffectType := TMagicType(FMessage.Y);
          FFinish := True;
        end; }
	    end;
	    SM_MAGICFIRE_FAIL : begin
{         if m_CurMagic.ServerMagicCode <> 0 then
        begin
          m_CurMagic.ServerMagicCode := 0;
          FFinish := True;
        end; }
	    end;
	  end;//case
	
	  if FFinish then
    begin
      Dispose(FMessage);
      FActorMessageList.Delete(FCount);
    end else Inc(FCount);
  end;//whiledo
end;

//**********************************************************
// TActor::RenderActor
// Render all Actor Textures
//****
procedure TActor.RenderActor(AX, AY: Integer; ABlend: Boolean; AFlag: Boolean);
begin

end;

procedure TActor.AddHealthActionStatus(AStatus: Byte; AValue: Integer);
var
  FHealthActionStatus: PHealthActionStatus;
begin
  if GGame_Option.gos_ShowHealthActionStatus then
  begin
    New(FHealthActionStatus);
    with FHealthActionStatus^ do
    begin
      hasStatus       := AStatus;
      hasValue        := AValue;
      hasFrameTime    := GetTickCount;
      hasCurrentFrame := 0;
    end;

    FHealthActionStatusList.Lock;
    try
      FHealthActionStatusList.Add(FHealthActionStatus);
    finally
      FHealthActionStatusList.UnLock;
    end;
  end;
end;

function TActor.GetMessage(AMessage: PActorMessage): Boolean;
var
  FMessage : PActorMessage;
begin
  Result := False;
  FActorMessageList.Lock;
  try
    if FActorMessageList.Count > 0 then
    begin
      FMessage           := FActorMessageList[0];
      AMessage.amIdent   := FMessage.amIdent;
      AMessage.amX       := FMessage.amX;
      AMessage.amY       := FMessage.amY;
      AMessage.amDir     := FMessage.amDir;
      AMessage.amState   := FMessage.amState;
      AMessage.amFeature := FMessage.amFeature;
      AMessage.amSaying  := FMessage.amSaying;
      AMessage.amSound   := FMessage.amSound;
      Dispose(FMessage);
      FActorMessageList.Delete(0);
      Result := True;
    end;
  finally
    FActorMessageList.Unlock;
  end;
end;

///
////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/// TActorNPC

//**********************************************************
// TActorNPC::Create
// NPC Actor Constructor (Initial Memory)
//****	
constructor TActorNPC.Create;
begin
  Inherited Create;

end;

//**********************************************************
// TActorNPC::Destroy
// NPC Actor Destructor (cleanup Memory)
//****	
destructor TActorNPC.Destroy;
begin
  
  Inherited Destroy;
end;

//**********************************************************
// TActorNPC::ProcessActor
// Run all NPC Actor things
//****
procedure TActorNPC.ProcessActor;
begin
  Inherited ProcessActor;
  
  
end;

//**********************************************************
// TActorNPC::RenderActor
// Render all NPC Actor Textures
//****
procedure TActorNPC.RenderActor(AX, AY: Integer; ABlend: Boolean; AFlag: Boolean);
begin

end;

///
////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/// TActorHuman
	
//**********************************************************
// TActorHuman::Create
// Human Actor Constructor (Initial Memory)
//****		
constructor TActorHuman.Create;
begin
  Inherited Create;

end;	
	
//**********************************************************
// TActorHuman::Destroy
// Human Actor Destructor (cleanup Memory)
//****	
destructor TActorHuman.Destroy;
begin
  
  Inherited Destroy;
end;

//**********************************************************
// TActorHuman::ProcessActor
// Run all Human Actor things
//****
procedure TActorHuman.ProcessActor;
begin

end;

//**********************************************************
// TActorHuman::RenderActor
// Render all Human Actor Textures
//****
procedure TActorHuman.RenderActor(AX, AY: Integer; ABlend: Boolean; AFlag: Boolean);
begin

end;


end.