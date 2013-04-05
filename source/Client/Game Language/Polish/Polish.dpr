(*******************************************************************
 *   LomCN Mir3 Polish Language LGU File 2013                      *
 *                                                                 *
 *   Web       : http://www.lomcn.co.uk                            *
 *   Version   : 0.0.0.1                                           *
 *                                                                 *
 *   - File Info -                                                 *
 *                                                                 *
 *   It holds the mir3 polish language strings.                    *
 *                                                                 *
 *******************************************************************
 * Change History                                                  *
 *                                                                 *
 *  - 0.0.0.1 [2013-04-05] Coly  : first init                      *
 *                                                                 *
 *                                                                 *
 *                                                                 *
 *                                                                 *
 *                                                                 *
 *******************************************************************)

library Polish;

uses
  Windows, 
  SysUtils,
  Classes,
  mir3_language_game     in 'mir3_language_game.pas',
  mir3_language_launcher in 'mir3_language_launcher.pas',
  mir3_language_magic    in 'mir3_language_magic.pas';

{$E lgu}
{$R *.res}

const
  LANGUAGE_FILE_AUTOR   = 'Budyniowski';
  LANGUAGE_FILE_VERSION = $00000001;


function GetFileAutor(Buffer: PChar) : Integer; stdcall;
var
  Value : String;
begin
  if Assigned(Buffer) then
  begin
    Value := LANGUAGE_FILE_AUTOR;
    CopyMemory(Buffer, PChar(Value), Length(Value));
  end;
  Result := Length(Value);
end;

function GetFileVersion(): Integer; stdcall;
begin
  Result := LANGUAGE_FILE_VERSION;
end;

exports
   GetFileAutor      name 'LomCN_GetFileAutor',
   GetFileVersion    name 'LomCN_GetFileVersion',

   GetLauncherLine   name 'LomCN_GetLauncherLine',
   GetLauncherString name 'LomCN_GetLauncherString',
   
   GetGameLine       name 'LomCN_GetGameLine',
   GetGameString     name 'LomCN_GetGameString',

   GetMagicLine      name 'LomCN_GetMagicLine',
   GetMagicString    name 'LomCN_GetMagicString';

begin
end.
