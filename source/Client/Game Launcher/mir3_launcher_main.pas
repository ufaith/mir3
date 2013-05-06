unit mir3_launcher_main;

interface

uses
  { Delphi }
  Windows,
  Messages,
  SysUtils,
  Variants,
  Classes,
  Graphics,
  Controls,
  Forms,
  Dialogs,
  StdCtrls,
  ExtCtrls,
  { Raize }
  RzCmboBx,
  RzButton,
  RzTabs,
  RzStatus,
  RzRadChk;

type
  PMir3_GameClientSetting = ^TMir3_GameClientSetting;
  TMir3_GameClientSetting = record
    { Server Part }
    FServer_1_Name : String[30];
    FServer_1_IP   : String[15];
    FServer_1_Port : Integer;
    FServer_2_Name : String[30];
    FServer_2_IP   : String[15];
    FServer_2_Port : Integer;
    { Client Part }
    FFull_Screen   : Boolean;
    FUseStartVideo : Boolean;
    FVideoVolume   : Integer;
    FLanguageId    : Integer;
  end;

  { TfrmLauncherMain }
  TfrmLauncherMain = class(TForm)
    Panel1: TPanel;
    RzPageControl1: TRzPageControl;
    laVerInfo: TRzVersionInfoStatus;
    verInfo: TRzVersionInfo;
    TabSheet1: TRzTabSheet;
    TabSheet2: TRzTabSheet;
    TabSheet3: TRzTabSheet;
    TabSheet4: TRzTabSheet;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    btnStartGame: TRzBitBtn;
    btnAccountManager: TRzBitBtn;
    btnExitGame: TRzBitBtn;
    btnGameOptions: TRzBitBtn;
    RzComboBox1: TRzComboBox;
    RzCheckBox1: TRzCheckBox;
    RzCheckBox2: TRzCheckBox;
    procedure btnExitGameClick(Sender: TObject);
    procedure btnStartGameClick(Sender: TObject);
  private
    { Private - Declarations }
  public
    { Public - Declarations }
  end;

var
  frmLauncherMain: TfrmLauncherMain;

implementation

{$R *.dfm}

procedure TfrmLauncherMain.btnExitGameClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmLauncherMain.btnStartGameClick(Sender: TObject);
//var
  //FMModuleInfoNode : ProcessModuleInfo;//_ModuleInfoNode;
begin
  { Start Game }

// TODO : -Coly -Add LDR Hide via PEB system to prevent Script Cheat Kiddys... (Need Admin Rights...)
//               (Flip Double linked lists in LDR Header in user mode)

//  WinExec(PChar(ExtractFilePath(ParamStr(0)) + '\Mir3Client.exe'), SW_SHOW);
//  if not CreateProcess(nil, PChar(FCommandLine), nil, nil, True, 0, nil, PChar(FCurDirectory), FStartupInfo, AProgramInfo.prProcessInfo) then
//  begin
//    Result := GetLastError();
//  end;
end;

(*
function HidingFile: Integer;
var
  dwPEB_LDR_DATA : Integer;
begin

asm

pushad;
pushfd;
mov eax, fs:[30h] // PEB
mov eax, [eax+0Ch] // PEB->ProcessModuleInfo
mov dwPEB_LDR_DATA, eax // Save ProcessModuleInfo

InLoadOrderModuleList:
mov esi, [eax+0Ch] // ProcessModuleInfo->InLoadOrderModuleList[FORWARD]
mov edx, [eax+10h] // ProcessModuleInfo->InLoadOrderModuleList[BACKWARD]

LoopInLoadOrderModuleList:
lodsd // Load First Module
mov esi, eax // ESI points to Next Module
mov ecx, [eax+18h] // LDR_MODULE->BaseAddress
cmp ecx, hModule // Is it Our Module ?
jne SkipA // If Not, Next Please (@f jumps to nearest Unamed Lable @@:)
mov ebx, [eax] // [FORWARD] Module
mov ecx, [eax+4] // [BACKWARD] Module
mov [ecx], ebx // Previous Module's [FORWARD] Notation, Points to us, Replace it with, Module++
mov [ebx+4], ecx // Next Modules, [BACKWARD] Notation, Points to us, Replace it with, Module--
jmp InMemoryOrderModuleList // Hidden, so Move onto Next Set
SkipA:
cmp edx, esi // Reached End of Modules ?
jne LoopInLoadOrderModuleList // If Not, Re Loop

InMemoryOrderModuleList:
mov eax, dwPEB_LDR_DATA // PEB->ProcessModuleInfo
mov esi, [eax+14h] // ProcessModuleInfo->InMemoryOrderModuleList[START]
mov edx, [eax+18h] // ProcessModuleInfo->InMemoryOrderModuleList[FINISH]

LoopInMemoryOrderModuleList:
lodsd
mov esi, eax
mov ecx, [eax+10h]
cmp ecx, hModule
jne SkipB
mov ebx, [eax]
mov ecx, [eax+4]
mov [ecx], ebx
mov [ebx+4], ecx
jmp InInitializationOrderModuleList
SkipB:
cmp edx, esi
jne LoopInMemoryOrderModuleList

InInitializationOrderModuleList:
mov eax, dwPEB_LDR_DATA // PEB->ProcessModuleInfo
mov esi, [eax+1Ch] // ProcessModuleInfo->InInitializationOrderModuleList[START]
mov edx, [eax+20h] // ProcessModuleInfo->InInitializationOrderModuleList[FINISH]

LoopInInitializationOrderModuleList:
lodsd
mov esi, eax
mov ecx, [eax+08h]
cmp ecx, hModule
jne SkipC
mov ebx, [eax]
mov ecx, [eax+4]
mov [ecx], ebx
mov [ebx+4], ecx
jmp Finished
SkipC:
cmp edx, esi
jne LoopInInitializationOrderModuleList

Finished:
popfd;
popad;

end;
end;
end.
*)


end.
