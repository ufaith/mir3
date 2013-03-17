unit unConfigEngine;

interface

uses Windows, SysUtils, Classes, mir3_server_global;

type
  TConfigEngine = class
  private
    FConfigFile : TConfig_Login_Gate;  
  public
    constructor Create;
    destructor Destroy; override; 
  public
    procedure LoadServiceConfig(AConfigFile: String);
    procedure SaveServiceConfig(AConfigFile: String);
    procedure CreateServiceConfig(AConfigFile: String);
    procedure ReloadServiceConfig(AConfigFile: String);
  public
    property ConfigFile : TConfig_Login_Gate read FConfigFile;
  end;

implementation

  {$REGION ' - TConfigEngine :: constructor / destructor   '}
    constructor TConfigEngine.create;
    begin
      inherited create;

    end;
     
    destructor TConfigEngine.destroy;
    begin

      inherited destroy;
    end;
  {$ENDREGION}

  {$REGION ' - TConfigEngine :: Load and Save functions    '}  
    procedure TConfigEngine.LoadServiceConfig(AConfigFile: String);
    var
      FMem : TMemoryStream;
    begin
      if FileExists(AConfigFile) then
      begin
        FMem := TMemoryStream.Create;
        try
          FMem.LoadFromFile(AConfigFile);
          FMem.Position := 0;
          FMem.Read(FConfigFile, sizeOf(TConfig_Login_Gate)); 
          if Assigned(FMem) then
            FreeAndNil(FMem);
        except
          if Assigned(FMem) then
            FreeAndNil(FMem);
        end;
      end else begin
        CreateServiceConfig(AConfigFile);
      end;
    end;
    
    procedure TConfigEngine.SaveServiceConfig(AConfigFile: String);
    var
      FMem : TMemoryStream;
    begin
      FMem := TMemoryStream.Create;
      try
        FMem.Write(FConfigFile, sizeOf(TConfig_Login_Gate));
        FMem.Position := 0;
        FMem.SaveToFile(AConfigFile);
        if Assigned(FMem) then
          FreeAndNil(FMem);        
      except
        if Assigned(FMem) then
          FreeAndNil(FMem);
      end;
    end;
    
    procedure TConfigEngine.CreateServiceConfig(AConfigFile: String);  
    begin
      try
        ZeroMemory(@FConfigFile, sizeOf(TConfig_Login_Gate));
        (* Set Default Values *)
        with FConfigFile do 
        begin
          {$REGION ' - Service Default Option   '}  
          {Service Option}                      // Default Settings
          cfPos_X              := 10;           // 10 fix me
          cfPos_Y              := 10;           // 10 fix me
          cfStartMinimized     := True;         // True
          cfLogLevel           := 10;           // 10
          {Network Option}     
          cfGate_Address       := '127.0.0.1';  // 127.0.0.1
          cfGate_Port          := 7000;         // 7000
          cfServer_Address     := '127.0.0.1';  // 127.0.0.1
          cfServer_Port        := 5500;         // 5500
          {Internal Option}
          cfBlockMethod        := 0;            // {0} mDisconnect
          cfKeepConnectTimeOut := 60000;        // 60000
          cfAttackLevel        := 1;            // 1
          cfMaxMessageLen      := 800;          // 800
          cfMaxConnectOfIPAddr := 20;           // 20
          cfReliefDefendUse    := False;        // False
          cfReliefDefendTime   := 120;          // 120
          cfMessageLenBlock    := 371;          // 371          g_boReliefenbao
          cfDefendLevelUse     := False;        // False
          cfDefendLevel        := 0;            // 0
          cfDefendLevelCount   := 3;            // 3
          cfClearTempListUse   := False;        // False   
          cfClearTempList      := 120;          // 120
          {$ENDREGION}
        end;
        SaveServiceConfig(AConfigFile);         
      except
      end;
    end;
    
    procedure TConfigEngine.ReloadServiceConfig(AConfigFile: String);  
    begin
      LoadServiceConfig(AConfigFile);
    end;
  {$ENDREGION}
  
end.