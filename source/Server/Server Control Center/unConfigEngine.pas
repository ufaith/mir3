unit unConfigEngine;

interface

uses
  { Delphi }
  Windows,
  SysUtils,
  Classes,
  { Mir3 Game }
  mir3_server_global;

const 
  TYPE_LOGIN_GATE       = 1;
  TYPE_SELECT_GATE      = 2; 
  TYPE_RUN_GATE         = 3;
  TYPE_LOGIN_SERVER     = 4;
  TYPE_DB_SERVER        = 5;
  TYPE_LOG_SERVER       = 6;
  TYPE_GAME_SERVER      = 7;
  TYPE_ADMINISTRATION   = 8;

type
  TConfigEngine = class
  private
    FConfigFile_Login_Gate      : TConfig_Login_Gate;
    FConfigFile_SelectChar_Gate : TConfig_SelectChar_Gate;
    FConfigFile_Run_Game_Gate   : TConfig_Run_Game_Gate;         
    FConfigFile_Login_Server    : TConfig_Login_Server;  
    FConfigFile_DataBase_Server : TConfig_DataBase_Server;  
    FConfigFile_Log_Server      : TConfig_Log_Server;
    FConfigFile_Game_Server     : TConfig_Game_Server;
    FConfigFile_Administration  : TConfig_Administration;
  public
    constructor Create;
    destructor Destroy; override; 
  public
    procedure LoadServiceConfig(AType: Integer; AConfigFile: String);
    procedure SaveServiceConfig(AType: Integer; AConfigFile: String);
    procedure CreateServiceConfig(AType: Integer; AConfigFile: String);
    procedure ReloadServiceConfig(AType: Integer; AConfigFile: String);
  public
    property ConfigFile_LoginGate      : TConfig_Login_Gate      read FConfigFile_Login_Gate      write FConfigFile_Login_Gate;
    property ConfigFile_SelectGate     : TConfig_SelectChar_Gate read FConfigFile_SelectChar_Gate write FConfigFile_SelectChar_Gate;
    property ConfigFile_RunGate        : TConfig_Run_Game_Gate   read FConfigFile_Run_Game_Gate   write FConfigFile_Run_Game_Gate;
    property ConfigFile_Login_Server   : TConfig_Login_Server    read FConfigFile_Login_Server    write FConfigFile_Login_Server;
    property ConfigFile_DBServer       : TConfig_DataBase_Server read FConfigFile_DataBase_Server write FConfigFile_DataBase_Server;
    property ConfigFile_LogServer      : TConfig_Log_Server      read FConfigFile_Log_Server      write FConfigFile_Log_Server;
    property ConfigFile_GameServer     : TConfig_Game_Server     read FConfigFile_Game_Server     write FConfigFile_Game_Server;
    property ConfigFile_Administration : TConfig_Administration  read FConfigFile_Administration  write FConfigFile_Administration;
  end;

implementation

   { TConfigEngine }

  {$REGION ' - TConfigEngine :: constructor / destructor   '}
    constructor TConfigEngine.Create;
    begin
      inherited create;

      ZeroMemory(@FConfigFile_Login_Gate     , SizeOf(TConfig_Login_Gate));
      ZeroMemory(@FConfigFile_SelectChar_Gate, SizeOf(TConfig_SelectChar_Gate));
      ZeroMemory(@FConfigFile_Run_Game_Gate  , SizeOf(TConfig_Run_Game_Gate));
      ZeroMemory(@FConfigFile_Login_Server   , SizeOf(TConfig_Login_Server));
      ZeroMemory(@FConfigFile_DataBase_Server, SizeOf(TConfig_DataBase_Server));
      ZeroMemory(@FConfigFile_Log_Server     , SizeOf(TConfig_Log_Server));
      ZeroMemory(@FConfigFile_Game_Server    , SizeOf(TConfig_Game_Server));
    end;
     
    destructor TConfigEngine.Destroy;
    begin
      ZeroMemory(@FConfigFile_Login_Gate     , SizeOf(TConfig_Login_Gate));
      ZeroMemory(@FConfigFile_SelectChar_Gate, SizeOf(TConfig_SelectChar_Gate));
      ZeroMemory(@FConfigFile_Run_Game_Gate  , SizeOf(TConfig_Run_Game_Gate));
      ZeroMemory(@FConfigFile_Login_Server   , SizeOf(TConfig_Login_Server));
      ZeroMemory(@FConfigFile_DataBase_Server, SizeOf(TConfig_DataBase_Server));
      ZeroMemory(@FConfigFile_Log_Server     , SizeOf(TConfig_Log_Server));
      ZeroMemory(@FConfigFile_Game_Server    , SizeOf(TConfig_Game_Server));

      inherited destroy;
    end;
  {$ENDREGION}

  {$REGION ' - TConfigEngine :: Load and Save functions    '}  
    procedure TConfigEngine.LoadServiceConfig(AType: Integer; AConfigFile: String);
    var
      FMem : TMemoryStream;
    begin
      if FileExists(AConfigFile) then
      begin
        FMem := TMemoryStream.Create;
        try
          FMem.LoadFromFile(AConfigFile);
          FMem.Position := 0;
          case AType of 
            TYPE_LOGIN_GATE     : FMem.Read(FConfigFile_Login_Gate     , SizeOf(TConfig_Login_Gate));
            TYPE_SELECT_GATE    : FMem.Read(FConfigFile_SelectChar_Gate, SizeOf(TConfig_SelectChar_Gate));
            TYPE_RUN_GATE       : FMem.Read(FConfigFile_Run_Game_Gate  , SizeOf(TConfig_Run_Game_Gate));         
            TYPE_LOGIN_SERVER   : FMem.Read(FConfigFile_Login_Server   , SizeOf(TConfig_Login_Server));  
            TYPE_DB_SERVER      : FMem.Read(FConfigFile_DataBase_Server, SizeOf(TConfig_DataBase_Server));  
            TYPE_LOG_SERVER     : FMem.Read(FConfigFile_Log_Server     , SizeOf(TConfig_Log_Server));
            TYPE_GAME_SERVER    : FMem.Read(FConfigFile_Game_Server    , SizeOf(TConfig_Game_Server));   
            TYPE_ADMINISTRATION : FMem.Read(FConfigFile_Administration , SizeOf(TConfig_Administration));
          end;          
          if Assigned(FMem) then
            FreeAndNil(FMem);
        except
          if Assigned(FMem) then
            FreeAndNil(FMem);
        end;
      end else begin
        CreateServiceConfig(AType, AConfigFile);
      end;
    end;
    
    procedure TConfigEngine.SaveServiceConfig(AType: Integer; AConfigFile: String);
    var
      FMem : TMemoryStream;
    begin
      FMem := TMemoryStream.Create;
      try
        case AType of 
          TYPE_LOGIN_GATE     : FMem.Write(FConfigFile_Login_Gate     , SizeOf(TConfig_Login_Gate));
          TYPE_SELECT_GATE    : FMem.Write(FConfigFile_SelectChar_Gate, SizeOf(TConfig_SelectChar_Gate));
          TYPE_RUN_GATE       : FMem.Write(FConfigFile_Run_Game_Gate  , SizeOf(TConfig_Run_Game_Gate));
          TYPE_LOGIN_SERVER   : FMem.Write(FConfigFile_Login_Server   , SizeOf(TConfig_Login_Server));
          TYPE_DB_SERVER      : FMem.Write(FConfigFile_DataBase_Server, SizeOf(TConfig_DataBase_Server));
          TYPE_LOG_SERVER     : FMem.Write(FConfigFile_Log_Server     , SizeOf(TConfig_Log_Server));
          TYPE_GAME_SERVER    : FMem.Write(FConfigFile_Game_Server    , SizeOf(TConfig_Game_Server));
          TYPE_ADMINISTRATION : FMem.Write(FConfigFile_Administration , SizeOf(TConfig_Administration));
        end;
        FMem.Position := 0;
        FMem.SaveToFile(AConfigFile);
        if Assigned(FMem) then
          FreeAndNil(FMem);        
      except
        if Assigned(FMem) then
          FreeAndNil(FMem);
      end;
    end;
    
    procedure TConfigEngine.CreateServiceConfig(AType: Integer; AConfigFile: String);  
    begin
      try
        (* Set Default Values *)
        case AType of 
          TYPE_LOGIN_GATE:
          begin
            ZeroMemory(@FConfigFile_Login_Gate, SizeOf(TConfig_Login_Gate));
            with FConfigFile_Login_Gate do
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
          end;

          TYPE_SELECT_GATE:
          begin
            ZeroMemory(@FConfigFile_SelectChar_Gate, SizeOf(TConfig_SelectChar_Gate));
            with FConfigFile_SelectChar_Gate do
            begin
              {$REGION ' - Service Default Option   '}
              {Service Option}                      // Default Settings
              cfPos_X              := 10;           // 10 fix me
              cfPos_Y              := 10;           // 10 fix me
              cfStartMinimized     := True;         // True
              cfLogLevel           := 3;            // 3
              {Network Option}     
              cfGate_Address       := '127.0.0.1';  // 127.0.0.1
              cfGate_Port          := 7101;         // 7101
              cfServer_Address     := '127.0.0.1';  // 127.0.0.1
              cfServer_Port        := 5100;         // 5100
              {Internal Option}
              cfBlockMethod        := 0;            // {0} mDisconnect
              cfKeepConnectTimeOut := 120000;       // 120000
              cfAttackLevel        := 1;            // 1
              cfMaxMessageLen      := 800;          // 800
              cfMaxConnectOfIPAddr := 20;           // 20
              cfReliefDefendUse    := False;        // False
              cfReliefDefendTime   := 120;          // 120
              cfMessageLenBlock    := 408;          // 408          g_boReliefenbao
              cfDefendLevelUse     := True;         // True
              cfDefendLevel        := 0;            // 0
              cfDefendLevelCount   := 3;            // 3
              cfClearTempListUse   := True;         // True   
              cfClearTempList      := 120;          // 120
              {$ENDREGION}
            end;          
          end;

          TYPE_RUN_GATE:
          begin
            ZeroMemory(@FConfigFile_Run_Game_Gate, SizeOf(TConfig_Run_Game_Gate));
            with FConfigFile_Run_Game_Gate do
            begin
              {$REGION ' - Service Default Option   '}  
              {Service Option}                      // Default Settings
              cfPos_X              := 10;           // 10 fix me
              cfPos_Y              := 10;           // 10 fix me
              cfStartMinimized     := True;         // True
              cfLogLevel           := 2;            // 2
              {Network Option}     
              cfGate_Address       := '127.0.0.1';  // 127.0.0.1
              cfGate_Port          := 7201;         // 7201
              cfServer_Address     := '127.0.0.1';  // 127.0.0.1
              cfServer_Port        := 5000;         // 5000
              {Internal Option}
              
              {$ENDREGION}
            end;            
          end;

          TYPE_LOGIN_SERVER:
          begin
            ZeroMemory(@FConfigFile_Login_Server, SizeOf(TConfig_Login_Server));
            with FConfigFile_Login_Server do
            begin
              {$REGION ' - Service Default Option   '}  
              {Service Option}                         // Default Settings
              cfPos_X              := 10;              // 10 fix me
              cfPos_Y              := 10;              // 10 fix me
              cfStartMinimized     := True;            // True
              cfLogLevel           := 2;               // 2
              {Network Option}                         
              cfGate_Address       := '127.0.0.1';     // 127.0.0.1
              cfGate_Port          := 5500;            // 5500
              cfServer_Address     := '127.0.0.1';     // 127.0.0.1
              cfServer_Port        := 5600;            // 5600
              cfDBServer_Address   := '127.0.0.1';     // 127.0.0.1
              cfDBServer_Port      := 16300;           // 16300
              cfLogServer_Address  := '127.0.0.1';     // 127.0.0.1
              cfLogServer_Port     := 16301;           // 16301      
              {Internal Option}
              cfCharReplaceWord    := '*';             // *              
              {DB Setup Option}
              cfDBType             := 0;               // dbtMSSQL
              cfSQLAddress         := '(local)';       // (local)
              cfSQLUserName        := 'sa';            // sa   
              cfSQLPassword        := 'sa';            // sa
              cfDataBaseName       := 'LomCN_MIR3_V1'  // LomCN_MIR3_V1 
              {$ENDREGION}
            end;
          end;

          TYPE_DB_SERVER:
          begin
            ZeroMemory(@FConfigFile_DataBase_Server, SizeOf(TConfig_DataBase_Server));
            with FConfigFile_DataBase_Server do
            begin
              {$REGION ' - Service Default Option   '}  
              {Service Option}                         // Default Settings
              cfPos_X              := 10;              // 10 fix me
              cfPos_Y              := 10;              // 10 fix me
              cfStartMinimized     := True;            // True
              cfLogLevel           := 3;               // 3
              {Network Option}     
              cfGate_Address       := '127.0.0.1';     // 127.0.0.1
              cfGate_Port          := 5100;            // 5100
              cfServer_Address     := '127.0.0.1';     // 127.0.0.1
              cfServer_Port        := 6000;            // 6000
              {DB Setup Option}
              cfDBType             := 0;               // dbtMSSQL
              cfSQLAddress         := '(local)';       // (local)
              cfSQLUserName        := 'sa';            // sa   
              cfSQLPassword        := 'sa';            // sa
              cfDataBaseName       := 'LomCN_MIR3_V1'  // LomCN_MIR3_V1 
              {$ENDREGION}
            end;            
          end;

          TYPE_LOG_SERVER:
          begin
            ZeroMemory(@FConfigFile_Log_Server, SizeOf(TConfig_Log_Server));
            with FConfigFile_Log_Server do
            begin
              {$REGION ' - Service Default Option   '}
              {Service Option}                         // Default Settings
              cfPos_X              := 10;              // 10 fix me
              cfPos_Y              := 10;              // 10 fix me
              cfStartMinimized     := True;            // True
              cfLogLevel           := 2;               // 2
              {Network Option}                         
              cfServer_Address     := '127.0.0.1';     // 127.0.0.1
              cfServer_Port        := 10000;           // 10000
              {$ENDREGION}
            end;            
          end;

          TYPE_GAME_SERVER:
          begin
            ZeroMemory(@FConfigFile_Game_Server, SizeOf(TConfig_Game_Server));
            with FConfigFile_Game_Server do
            begin
              {$REGION ' - Service Default Option   '}  
              {Service Option}                         // Default Settings
              cfPos_X              := 10;              // 10 fix me
              cfPos_Y              := 10;              // 10 fix me
              cfStartMinimized     := True;            // True
              cfLogLevel           := 2;               // 2
              cfServerName         := 'TestServer';    // TestServer
              {Network Option}                         
              cfGate_Address       := '127.0.0.1';     // 127.0.0.1
              cfGate_Port          := 5000;            // 5000       
              cfDBServer_Address   := '127.0.0.1';     // 127.0.0.1
              cfDBServer_Port      := 6000;            // 6000
              cfLogServer_Address  := '127.0.0.1';     // 127.0.0.1
              cfLogServer_Port     := 10000;           // 10000
              cfMsgServer_Address  := '127.0.0.1';     // 127.0.0.1
              cfMsgServer_Port     := 4900;            // 4900
              {DB Setup Option}
              cfDBType             := 0;               // dbtMSSQL
              cfSQLAddress         := '(local)';       // (local)
              cfSQLUserName        := 'sa';            // sa   
              cfSQLPassword        := 'sa';            // sa
              cfDataBaseName       := 'LomCN_MIR3_V1'  // LomCN_MIR3_V1    
              {$ENDREGION}
            end;            
          end;

          TYPE_ADMINISTRATION:
          begin
            ZeroMemory(@FConfigFile_Administration, SizeOf(TConfig_Administration));
            with FConfigFile_Administration do
            begin
              {$REGION ' - Administration Default Option   '} 
              
              {$ENDREGION}  
            end;              
          end;
        end; 
        SaveServiceConfig(AType, AConfigFile);         
      except
      end;
    end;  
    
    procedure TConfigEngine.ReloadServiceConfig(AType: Integer; AConfigFile: String);  
    begin
      LoadServiceConfig(AType, AConfigFile);
    end;   
  {$ENDREGION}
  
end.