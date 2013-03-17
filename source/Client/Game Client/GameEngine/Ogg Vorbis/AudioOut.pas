{*************************************************************************
  This unit is modified version of Audio.pas written by Mr. Hakan Bergzen.
  I have removed two classes(TMixerSettings & TRecorder) from Audio.pas,
    changed the flow of wave-out process for my audio players and renamed
    to AudioOut.Pas
  Thanks to Mr Hakan Bergzen.


  Unit:                AudioOut.pas

  Description:         TAudioOut component for accessing wave-out device

  Version              1.1

  Accessed Units:      mmSystem.pas

  Rewriter:            Silhwan Hyun  hsh@chollian.net

  Changed from Ver 1.0
    - modified procedure TPlayer.MessageHandler to fix non-termination problem
     (Program which uses TAudioOut Ver 1.0 won't terminate at system termination)
**************************************************************************}

Unit AudioOut;

{$WARNINGS OFF} 

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Forms, Classes, mmSystem{, Fourier};
  // Fourier : A unit which processes FFT & estimates the intensity of
  //            frequancy bands for spectrum visualizer
  // I have excluded my own unit named 'Fourier' and a related event method
  //  because it's output is not so good.
  // I have 2 unresolved issues
  //   - how to devide frequancy bands
  //   - how to estimates the intensity per each frequancy band
  //  for spectrum visualizer with the result of FFT.
  // If you have any sources or ideas on above issues, please let me know.
type
   TChannels = (Mono, Stereo);
   TBPS = (_8,_16);

const
   DefaultAudioDeviceID  = UINT(WAVE_MAPPER);
   No_Buffers = 8;
   ChannelsDefault = Stereo;
   BPSDefault = _16;
   SPSDefault = 44100;
   NoSamplesDefault = 8192;
   WM_NewFFTData     = WM_USER + 103;
   FreqBands = 25;   // Number of frquency bands ( It can be any numbers )
{$IFDEF WIN32}
   Ver = '4.1 (32bit)';
{$ELSE}
   Ver = '4.1 (16bit)';
{$ENDIF}

type
  TBandOut = array[0..FreqBands-1] of word; // Intensity of each frequancy band

  TNotifyBufferPlayedEvent = function(Buffer : pchar; var Size : word)
                                             : boolean of object;
  TNotifyPlayedEvent = procedure(Sender: TObject) of object;
  TNotifyNewFFTDataEvent = procedure(Sender: TObject; BandOut : TBandOut;
                                             var PostFlag : boolean) of object;

  TAudioOut = class;

{$IFDEF WIN32}
  ValuesArray = array [0..1] of integer;

{$ENDIF}

  TAudioSettings = class(TPersistent)
  private
    FAudio               : TAudioOut;
    pWaveHeader          : array [0..No_Buffers-1] of PWAVEHDR;
    pWaveBuffer          : array [0..No_Buffers-1] of pointer;
    ForwardIndex         : Integer;
    DeviceOpen           : Boolean;
  private
    FChannels            : TChannels;
    FBPS                 : TBPS;
    FSPS                 : Word;
    FNoSamples           : Word;
{$IFDEF WIN32}
    pWaveFmt             : pWaveFormatEx;
{$ELSE}
    pWaveFmt             : pPCMWaveFormat;
{$ENDIF}
    WaveBufSize          : Word;
    procedure SetChannels(Value: TChannels);
    procedure SetBPS(Value: TBPS);
    procedure SetSPS(Value: Word);
    procedure SetNoSamples(Value: Word);
    procedure InitWaveHeaders;
    function  AllocateMemory: Boolean;
    procedure FreeMemory;
  public
    Active               : Boolean;
  published
    property BitsPerSample: TBPS read FBPS write SetBPS default BPSDefault;
    property Channels: TChannels read FChannels write SetChannels default ChannelsDefault;
    property SampleRate: Word read FSPS write SetSPS default SPSDefault;
    property NoSamples: Word read FNoSamples write SetNoSamples default NoSamplesDefault;
  end;

  PPlayer = ^TPlayer;
  TPlayer = class(TAudioSettings)
  private
    WaveOut                : HWAVEIN;
    FQueuedBuffers         : Word;
//    BandOutBuffer          : array[0..No_Buffers-1] of TBandOut;
    fBandOut               : TBandOut;
    fPostFlag              : boolean;
    InitialLoad            : boolean;
    ContinueProcessing     : boolean;
    MessageHandle          : hWnd;
    procedure MessageHandler(var Msg: TMessage);
    procedure FillWaveBuffer;
    procedure QueueBuffer;
    procedure Close;
    function  Open : boolean;
    procedure GetError(iErr : Integer; Additional: string);
  public
    property  QueuedBuffers : Word read FQueuedBuffers;
    procedure SetVolume(LeftVolume, RightVolume: Word);
    procedure GetVolume(var LeftVolume, RightVolume: Word);
    function  Start : boolean;
    procedure StopGracefully;
    procedure Stop;
  published

  end;

  TAudioOut = class(TComponent)
  private
    FVersion             : string;
    FDeviceID            : UINT;
    FReadyToGo           : boolean;
    procedure SetDeviceID(Value: UINT);
    procedure SetVersion(Value: string);
  private
    FOnBufferPlayed      : TNotifyBufferPlayedEvent;
    FOnPlayed            : TNotifyPlayedEvent;
    FOnNewFFTData        : TNotifyNewFFTDataEvent;
    FPlayer              : TPlayer;
  private
    FWindowHandle        : HWND;
    WaveFmtSize          : Integer;
    procedure AudioCallBack(var Msg: TMessage); export;
  public
    ErrorMessage         : string;
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
  published
    property AudioDeviceID: UINT read FDeviceID write SetDeviceID default DefaultAudioDeviceID;
    property Player: TPlayer read FPlayer write FPlayer;
    property Version: string read FVersion write SetVersion;
    property ReadyToGo : boolean read FReadyToGo;
    property OnBufferPlayed: TNotifyBufferPlayedEvent read FOnBufferPlayed write FOnBufferPlayed;
    property OnPlayed: TNotifyPlayedEvent read FOnPlayed write FOnPlayed;
  //  property OnNewFFTData: TNotifyNewFFTDataEvent read FOnNewFFTData write FOnNewFFTData;
  end;

{$IFDEF WIN32}
{$ELSE}
  function CorrectedwaveInClose(hWaveIn: HWaveIn): Word;
{$ENDIF}

  procedure Register;

implementation

{$IFDEF WIN32}
{$ELSE}
function CorrectedwaveInClose; external 'MMSYSTEM' index 505;
{$ENDIF}

{------------- WinAPI CallBack routines --------------------------------}
{ Callback routine used for CALLBACK_WINDOW in waveInOpen and waveOutOpen    }
procedure TAudioOut.AudioCallBack(var Msg: TMessage);
begin
  case Msg.Msg of
    mm_wom_OPEN  : FPlayer.Active := true;
    mm_wom_CLOSE : FPlayer.Active := false;
    mm_wom_DONE  : if FPlayer.Active then
                   begin
                      dec(FPlayer.FQueuedBuffers);
                      if not FPlayer.ContinueProcessing then
                      begin
                        if FPlayer.FQueuedBuffers = 0 then
                           PostMessage(FPlayer.MessageHandle, mm_wom_CLOSE, 0, 0);
                      end else
                        PostMessage(FPlayer.MessageHandle, wom_DONE, 0, 0);
                   end;

    wm_QueryEndSession : Destroy;    { only called if Callback_Window is used }
  end;
end;
{------------- Internal/Private routines -------------------------------}

procedure TAudioSettings.InitWaveHeaders;
var
  i : Integer;
begin
  for i:=0 to No_Buffers-1 do begin
    pWaveHeader[i]^.lpData := pWaveBuffer[i];
    pWaveHeader[i]^.dwBufferLength := WaveBufSize;
    pWaveHeader[i]^.dwBytesRecorded := 0;
    pWaveHeader[i]^.dwUser := 0;
    pWaveHeader[i]^.dwFlags := 0;
    pWaveHeader[i]^.dwLoops := 0;
    pWaveHeader[i]^.lpNext := nil;
    pWaveHeader[i]^.reserved := 0;
  end;
end;

function TAudioSettings.AllocateMemory: Boolean;
var
  i : Integer;
begin
    pWaveFmt := nil;
    try
      GetMem(pWaveFmt, FAudio.WaveFmtSize);
    except
      FAudio.ErrorMessage := 'Not enough memory to allocate WaveFormat';
      Result := false;
      Exit;
    end;
    if FBPS=_8 then
       pWaveFmt^.wBitsPerSample := 8
    else
       pWaveFmt^.wBitsPerSample := 16;
{$IFDEF WIN32}
    pWaveFmt^.cbSize := 0;
    with pWaveFmt^ do begin
{$ELSE}
    with pWaveFmt^.wf do begin
{$ENDIF}
      wFormatTag := WAVE_FORMAT_PCM;
      if FChannels = Mono then
         nChannels := 1
      else
         nChannels := 2;
      nSamplesPerSec := FSPS;
{ BlockAlign : e.g. 16-bit stereo PCM => 4 = 2 channels x 2 bytes/channel    }
      if FBPS = _8 then
         nBlockAlign := (8 div 8) * nChannels
      else
         nBlockAlign := (16 div 8) * nChannels;
      nAvgBytesPerSec := nSamplesPerSec * nBlockAlign;
      WaveBufSize := FNoSamples * nBlockAlign;
    end;

    for i := 0 to No_Buffers-1 do
    begin
      pWaveHeader[i] := nil;
      try
        GetMem(pWaveHeader[i], sizeof(TWAVEHDR));
      except
        FAudio.ErrorMessage := 'Not enough memory to allocate WaveHeader';
        Result := false;
        Exit;
      end;

      pWaveBuffer[i] := nil;
      try
        GetMem(pWaveBuffer[i], WaveBufSize);
      except
        FAudio.ErrorMessage := 'Not enough memory to allocate Wave Buffer';
        Result := false;
        Exit;
      end;
      pWaveHeader[i]^.lpData := pWaveBuffer[i];
    end;

    FAudio.FReadyToGo := true;
    Result := true;
end;

procedure TAudioSettings.FreeMemory;
var
  i : Integer;
begin
  FAudio.FReadyToGo := false;

  if (pWaveFmt = nil) then
     Exit
  else begin
    FreeMem(pWaveFmt, FAudio.WaveFmtSize);
    pWaveFmt := nil;
  end;

  for i := 0 to No_Buffers - 1 do
  begin
    if (pWaveBuffer[i] <> nil) then
       FreeMem(pWaveBuffer[i], WaveBufSize);
    pWaveBuffer[i] := nil;
    if (pWaveHeader[i] <> nil) then
       FreeMem(pWaveHeader[i], sizeof(TWAVEHDR));
    pWaveHeader[i] := nil;
  end;
end;


procedure TPlayer.GetError(iErr : Integer; Additional:string);
var
  ErrorText : string;
  pError : PChar;
begin
  GetMem(pError, 256 * 2);   { make sure there is ample space if WideChar is used }
  waveOutGetErrorText(iErr, pError,255);
  ErrorText := StrPas(pError);
  FreeMem(pError, 256 * 2);
  if length(ErrorText) = 0 then
     FAudio.ErrorMessage := Additional
  else
     FAudio.ErrorMessage := Additional + ' ' + ErrorText;
end;


{------------- Public methods ---------------------------------------}
constructor TAudioOut.Create(AOwner: TComponent);
begin
   inherited Create(AOwner);
   FDeviceID := DefaultAudioDeviceID;
   FVersion := Ver;
   FReadyToGo := false;
   FPlayer := TPlayer.Create; FPlayer.FAudio := Self;
   FPlayer.Active := false;
   FPlayer.FBPS := BPSDefault;
   FPlayer.FNoSamples := NoSamplesDefault;
   FPlayer.FChannels := ChannelsDefault;
   FPlayer.FSPS := SPSDefault;
   FPlayer.MessageHandle := AllocateHWnd(FPlayer.MessageHandler);
 //  FWindowHandle:=AllocateHWnd(AudioCallBack);
{$IFDEF WIN32}
   WaveFmtSize := SizeOf(TWaveFormatEx);
{$ELSE}
   WaveFmtSize := SizeOf(TPCMWaveFormat);
{$ENDIF}

   if (waveOutGetNumDevs < 1) then
      Exit;

   FPlayer.AllocateMemory;
end;

destructor TAudioOut.Destroy;
begin
   FPlayer.Stop;

  with FPlayer do
  begin
    FreeMemory;
    if MessageHandle <> 0 then
       DeallocateHWnd(MessageHandle);
    Free;
  end;

  if FWindowHandle <> 0 then
     DeAllocateHWnd(FWindowHandle);

  inherited Destroy;
end;

procedure TPlayer.MessageHandler(var Msg: TMessage);
begin
// Added to fix Non-termination problem
   if Msg.Msg = wm_QueryEndSession then
   begin
     Msg.Result := 1;
     exit;
   end;

   case Msg.Msg of
      WM_NewFFTData : if Assigned(FAudio.FOnNewFFTData) then
                         FAudio.FOnNewFFTData(Self, fBandOut, fPostFlag);
      wom_DONE      : if DeviceOpen and ContinueProcessing then
                         FillWaveBuffer;
      mm_wom_CLOSE  : if DeviceOpen then
                         Close;
   end;
end;


procedure TPlayer.FillWaveBuffer;
var
   ReadSize : word;
begin
   ReadSize := WaveBufSize;
   if Assigned(FAudio.FOnBufferPlayed) then
      if FAudio.FOnBufferPlayed(pWaveBuffer[ForwardIndex], ReadSize) then
         if ReadSize > 0 then
         begin
            pwaveheader[ForwardIndex]^.dwBufferLength := ReadSize;
            if not InitialLoad then
               QueueBuffer
            else
               ForwardIndex := (ForwardIndex + 1) mod No_Buffers;
         end else
            ContinueProcessing := false
      else
         ContinueProcessing := false
   else
      ContinueProcessing := false;
end;

procedure TPlayer.QueueBuffer;
var
   iErr{, i} : integer;
begin
   pwaveheader[ForwardIndex]^.dwFlags := WHDR_PREPARED;

   iErr := waveOutWrite(WaveOut, pwaveheader[ForwardIndex], sizeof(TWAVEHDR));
   if iErr <> 0 then
   begin
      GetError(iErr,'');
      Exit;
   end;

   inc(FQueuedBuffers);

 { Performs frequency band-intensity estimation and posts a message to inform to
   internal message handler.
    BandOutBuffer : Buffer which holds the result of frequency band-intensity
           estimation to adjust the time delay from data aquisition to sound
           output
      note) AudioOut starts sound out after filling all the sound buffers(pWaveBuffer) }

 {  if not fPostFlag then  // Check if previous data was received
   begin
      if not InitialLoad then
      begin
         fBandOut := BandOutBuffer[ForwardIndex];
         PostMessage(NewFFTDataHandle, WM_NewFFTData, 0, 0);
         fPostFlag := true;
      end;

      if (Channels = Stereo) then
         fft_integer2(1024,  // Number of Samples (should be power of 2)
                      2,     // Channels
                      pWaveBuffer[ForwardIndex],    // Buffer holds audio data
                      BandOutBuffer[ForwardIndex])  // Buffer holds result
      else
         fft_integer2(1024,  // Number of Samples (should be power of 2)
                      1,     // Channels
                      pWaveBuffer[ForwardIndex],    // Buffer holds audio data
                      BandOutBuffer[ForwardIndex]); // Buffer holds result
   end; }

   ForwardIndex := (ForwardIndex + 1) mod No_Buffers;
end;


{ Callback routine used for CALLBACK_FUNCTION in waveOutOpen   }
{$IFDEF WIN32}
procedure PlayerCallBack(hW : HWAVEOUT; uMsg, dwInstance, dwParam1, dwParam2 : DWORD);  stdcall;
{$ELSE}
procedure PlayerCallBack(hW : HWAVEOUT; uMsg, dwInstance, dwParam1, dwParam2 : LongInt);  stdcall;
{$ENDIF}
var PlayPtr : PPlayer;
begin
  PlayPtr := Pointer(dwInstance);
  with PlayPtr^ do begin
   case uMsg of
    wom_OPEN  : Active := true;
    wom_CLOSE : Active := false;
    wom_DONE  : if Active then
                begin
                    dec(FQueuedBuffers);
                    if not ContinueProcessing then
                    begin
                       if (FQueuedBuffers = 0) then
                          PostMessage(MessageHandle, mm_wom_CLOSE, 0, 0);
                    end else
                       PostMessage(MessageHandle, wom_DONE, 0, 0);
                end;

   end;
  end;
end;

function TPlayer.Open : boolean;
var
  iErr, i : Integer;
begin
   if not(DeviceOpen) then
   begin
    Result := false;

{$IFDEF WIN32}
   iErr := waveOutOpen(@WaveOut, FAudio.FDeviceID, pWaveFmt, dword(@PlayerCallBack),
                      dword(@FAudio.FPlayer), CALLBACK_FUNCTION + WAVE_ALLOWSYNC);
 { iErr := waveOutOpen(@WaveOut, FAudio.FDeviceID, pWaveFmt, FAudio.FWindowHandle, 0,
                        CALLBACK_WINDOW + WAVE_ALLOWSYNC); }
{$ELSE}
{  iErr := waveOutOpen(@WaveOut, FAudio.FDeviceID, @pWaveFmt^.wf, LongInt(@PlayerCallBack),
                    LongInt(@FAudio.FPlayer), CALLBACK_FUNCTION + WAVE_ALLOWSYNC);   }
{ Problem to get CALLBACK_FUNCTION to work in 16bit version     }
    iErr := waveOutOpen(@WaveOut, FAudio.FDeviceID, @pWaveFmt^.wf,
                       FAudio.FWindowHandle, 0, CALLBACK_WINDOW + WAVE_ALLOWSYNC);
{$ENDIF}

    if (iErr <> 0) then
    begin
      GetError(iErr, 'Could not open the output device for playing: ');
      Exit;
    end;

    DeviceOpen := true;
    InitWaveHeaders;
    for i := 0 to No_Buffers - 1 do
    begin
       iErr := waveOutPrepareHeader(WaveOut, pWaveHeader[i], sizeof(TWAVEHDR));
       if iErr <> 0 then
       begin
          GetError(iErr, '');
          Exit;
       end;
     end;
  end;

  Result := true;
end;

function TPlayer.Start : boolean;
var
   i : integer;
begin
   result := false;   // Assume any error
   if not(Open) then
      exit;

   ForwardIndex := 0;
   InitialLoad := true;
   ContinueProcessing := true;
   for i := 1 to No_Buffers do
   begin
      FillWaveBuffer;
      if not ContinueProcessing then
         break;
   end;

   if i = 1 then  // no data
      exit;

   FQueuedBuffers := 0;
   ForwardIndex := 0;
   fPostFlag := false;

   for i := 1 to No_Buffers do
      QueueBuffer;
   InitialLoad := false;

   if FQueuedBuffers > 0 then
      result := true;
end;

procedure TPlayer.StopGracefully;
begin
   if not DeviceOpen then
      exit;

   ContinueProcessing := false;
end;


procedure TPlayer.Close;
var
  iErr, i : Integer;
begin
  if not(DeviceOpen) then
  begin
     FAudio.ErrorMessage := 'Player already closed';
     exit;
  end;

  for i := 0 to No_Buffers-1 do
  begin
     iErr := waveOutUnPrepareHeader(WaveOut, pWaveHeader[i], sizeof(TWAVEHDR));
     if (iErr <> 0) then
     begin
        GetError(iErr, 'Error unpreparing header for playing: ');
        Exit;
     end;
  end;

  iErr := waveOutClose(WaveOut);
  if (iErr <> 0) then
  begin
     GetError(iErr, 'Error closing output device: ');
     Exit;
  end;

  DeviceOpen := false;

  if Assigned(FAudio.FOnPlayed) then
     FAudio.FOnPlayed(Self);
end;

procedure TPlayer.Stop;
var
  iErr : integer;
begin
  if not(DeviceOpen) then
  begin
    FAudio.ErrorMessage := 'Player already closed';
    exit;
  end;

  if (FQueuedBuffers <> 0) then
  begin
    iErr := waveOutReset(WaveOut);
    if (iErr <> 0) then
    begin
      FAudio.ErrorMessage := 'Error in waveOutReset';
      Exit;
    end;
  end;

  while Active do Application.ProcessMessages;
end;

{------------- Property Controls ------------------------------------}

procedure TAudioOut.SetVersion(Value : string);
begin
  FVersion := Ver;
end;

procedure TAudioSettings.SetChannels(Value : TChannels);
begin
   if FAudio.Player.FChannels <> Value then
   begin
      FAudio.Player.FChannels := Value;
      FAudio.Player.FreeMemory;
      FAudio.Player.AllocateMemory;
   end;
end;

procedure TAudioSettings.SetBPS(Value : TBPS);
begin
   if FAudio.Player.FBPS <> Value then
   begin
      FAudio.Player.FBPS := Value;
      FAudio.Player.FreeMemory;
      FAudio.Player.AllocateMemory;
   end;
end;

procedure TAudioSettings.SetSPS(Value : Word);
begin
   if FAudio.Player.FSPS <> Value then
   begin
      FAudio.Player.FSPS := Value;
      FAudio.Player.FreeMemory;
      FAudio.Player.AllocateMemory;
   end;
end;

procedure TAudioSettings.SetNoSamples(Value : Word);
begin
  if FAudio.Player.FNoSamples <> Value then
  begin
     FAudio.Player.FNoSamples := Value;
     FAudio.Player.FreeMemory;
     FAudio.Player.AllocateMemory;
  end;
end;


procedure TPlayer.GetVolume(var LeftVolume, RightVolume:Word);
var
  iErr : Integer;
{$IFDEF WIN32}
  Vol : dword;
{$ELSE}
  Vol : longint;
{$ENDIF}
begin
  iErr := waveOutGetVolume(FAudio.FDeviceID, @Vol);
  if (iErr <> 0) then GetError(iErr, '');
  LeftVolume := Word(Vol and $FFFF);
  RightVolume := Word(Vol shr 16);
end;

procedure TPlayer.SetVolume(LeftVolume, RightVolume : Word);
var
  iErr : Integer;
{$IFDEF WIN32}
  Vol : dword;
{$ELSE}
  Vol : longint;
{$ENDIF}
begin
  Vol := RightVolume;
  Vol := (Vol shl 16) + LeftVolume;
  iErr := waveOutSetVolume(FAudio.FDeviceID, Vol);
  if (iErr <> 0) then
     GetError(iErr, '');
end;

procedure TAudioOut.SetDeviceID(Value : UINT);
begin
  if FDeviceID <> Value then
  begin
    if Value > 9 then
       FDeviceID := WAVE_MAPPER
    else
       FDeviceID := Value;

    FPlayer.FreeMemory;
    FPlayer.AllocateMemory;
  end;
end;


procedure Register;
begin
  RegisterComponents('Samples', [TAudioOut]);
end;

end.

