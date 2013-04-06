(******************************************************************************
 *   LomCN Mir3 English Magic Language LGU File 2013                          *
 *                                                                            *
 *   Web       : http://www.lomcn.co.uk                                       *
 *   Version   : 0.0.0.2                                                      *
 *                                                                            *
 *   - File Info -                                                            *
 *                                                                            *
 *   It holds the mir3 English language strings.                              *
 *                                                                            *
 ******************************************************************************
 * Change History                                                             *
 *                                                                            *
 *  - 0.0.0.1 [2013-02-11] Coly  : first init                                 *
 *  - 0.0.0.2 [2013-03-22] Coly  : add first Magic                            *
 *                                                                            *
 *                                                                            *
 ******************************************************************************
 * :Info:                                                                     *
 * The Maximum of String Literale is 255 so you need to add ' + '             *
 * at the end of 255 Char...                                                  *
 * The String it self can have a length of 1024                               *
 *                                                                            *
 * !! Don't localize or delete things with "¦" !!                             *
 * !! it is part of the Script Engine Commands !!                             *
 ******************************************************************************)

unit mir3_language_magic;

interface

uses Windows, SysUtils, Classes;

function GetMagicLine(): Integer; stdcall;
function GetMagicString(ID: Integer; Buffer: PChar): Integer; stdcall;

implementation

function GetMagicLine(): Integer; stdcall;
begin
  Result := 2000;
end;

function GetMagicString(ID: Integer; Buffer: PChar): Integer; stdcall;
var
  Value : String;
begin
  case ID of
    (*******************************************************************
    *                  Magic  Informations strings                     *
    *******************************************************************)
    1  : begin
      {$REGION ' - Fireball            '}
      Value  := '¦Z¦¦F01¦¦C1FAFAFA¦¦C2806F5C¦¦B¦¦S18¦¦P01¦[Fireball]\'
              + '¦Z¦<Active>¦PE¦¦SE¦¦BE¦¦CE¦\¦Y-7¦'
              + '¦Z¦¦C1454555¦¦F03¦¦S16¦____________¦SE¦¦FE¦¦CE¦\¦Y07¦'
              + '¦X07¦¦F01¦¦S15¦Magic     : Nature\'
              + '¦X07¦Element : Ignis(Fire, Flame)\¦Y04¦'
              + '¦X07¦¦C1E5B681¦Level 1 requirement: Level 7\'
              + '¦X07¦ - skill points required: 100¦CE¦\'
              + '¦X07¦¦C1CCA272¦Level 2 requirement: Level 9\'
              + '¦X07¦ - skill points required: 200¦CE¦\'
              + '¦X07¦¦C1B38E64¦Level 3 requirement: Level 11\'
              + '¦X07¦ - skill points required: 300¦CE¦\'
              + '¦X07¦¦C1997A56¦Level 4 requirement: Quest\'
              + '¦X07¦ - skill points required: 500¦CE¦\'
              + '¦X07¦¦C17F6547¦Level 5 requirement: Quest\'
              + '¦X07¦ - skill points required: 800¦CE¦\¦Y08¦'
              + '¦X07¦The very basic fire spell.\'
              + '¦X07¦As you become more skillfull,\'
              + '¦X07¦it will get more lethal.¦SE¦\¦Y08¦'
              + '¦X07¦¦C1FF0a0a¦Level : %s¦CE¦¦FE¦';
      {$ENDREGION}
    end;
    2  : begin
      {$REGION ' -  Healing            '}
      Value  := '¦Z¦¦F01¦¦C1FAFAFA¦¦C2806F5C¦¦B¦¦S18¦¦P01¦[Healing]\'
              + '¦Z¦<Active>¦PE¦¦SE¦¦BE¦¦CE¦\¦Y-7¦'
              + '¦Z¦¦C1454555¦¦F03¦¦S16¦____________¦SE¦¦FE¦¦CE¦\¦Y07¦'
              + '¦X07¦¦F01¦¦S15¦Magic     : Soul\'
              + '¦X07¦Element : Sacer(Holy, Sacred, Divine)\¦Y04¦'
              + '¦X07¦¦C1E5B681¦Level 1 requirement: Level 7\'
              + '¦X07¦ - skill points required: 100¦CE¦\'
              + '¦X07¦¦C1CCA272¦Level 2 requirement: Level 9\'
              + '¦X07¦ - skill points required: 200¦CE¦\'
              + '¦X07¦¦C1B38E64¦Level 3 requirement: Level 11\'
              + '¦X07¦ - skill points required: 300¦CE¦\'
              + '¦X07¦¦C1997A56¦Level 4 requirement: Quest\'
              + '¦X07¦ - skill points required: 500¦CE¦\'
              + '¦X07¦¦C17F6547¦Level 5 requirement: Quest\'
              + '¦X07¦ - skill points required: 800¦CE¦\¦Y08¦'
              + '¦X07¦An art of healing.\'
              + '¦X07¦As you become more skilful,\'
              + '¦X07¦more HP can be recovered.\'
              + '¦X07¦Can be targeted on other players.¦SE¦\¦Y08¦'
              + '¦X07¦¦C1FF0a0a¦Level : %s¦CE¦¦FE¦';
      {$ENDREGION}
    end;
    3  : begin
      {$REGION ' - Swordmanship        '}
      Value  := '¦Z¦¦F01¦¦C1FAFAFA¦¦C2806F5C¦¦B¦¦S18¦¦P01¦[Swordmanship]\'
              + '¦Z¦<Passive>¦PE¦¦SE¦¦BE¦¦CE¦\¦Y-7¦'
              + '¦Z¦¦C1454555¦¦F03¦¦S16¦____________¦SE¦¦FE¦¦CE¦\¦Y07¦'
              + '¦X07¦¦F01¦¦S15¦Magic     : N/A\'
              + '¦X07¦Element : N/A\¦Y04¦'
              + '¦X07¦¦C1E5B681¦Level 1 requirement: Level 7\'
              + '¦X07¦ - skill points required: 100¦CE¦\'
              + '¦X07¦¦C1CCA272¦Level 2 requirement: Level 9\'
              + '¦X07¦ - skill points required: 200¦CE¦\'
              + '¦X07¦¦C1B38E64¦Level 3 requirement: Level 11\'
              + '¦X07¦ - skill points required: 300¦CE¦\'
              + '¦X07¦¦C1997A56¦Level 4 requirement: Quest\'
              + '¦X07¦ - skill points required: 500¦CE¦\'
              + '¦X07¦¦C17F6547¦Level 5 requirement: Quest\'
              + '¦X07¦ - skill points required: 800¦CE¦\¦Y08¦'
              + '¦X07¦A martial art that raises\'
              + '¦X07¦your accuracy giving you more\'
              + '¦X07¦chance to hit your opponent,\'
              + '¦X07¦as you become more skilful\'
              + '¦X07¦the more¦SE¦\¦Y08¦'
              + '¦X07¦¦C1FF0a0a¦Level : %s¦CE¦¦FE¦';
      {$ENDREGION}
    end;
    4  : begin
      {$REGION ' - SpiritSword        '}
      Value  := '¦Z¦¦F01¦¦C1FAFAFA¦¦C2806F5C¦¦B¦¦S18¦¦P01¦[SpiritSword]\'
              + '¦Z¦<Passive>¦PE¦¦SE¦¦BE¦¦CE¦\¦Y-7¦'
              + '¦Z¦¦C1454555¦¦F03¦¦S16¦____________¦SE¦¦FE¦¦CE¦\¦Y07¦'
              + '¦X07¦¦F01¦¦S15¦Magic     : N/A\'
              + '¦X07¦Element : N/A\¦Y04¦'
              + '¦X07¦¦C1E5B681¦Level 1 requirement: Level 8\'
              + '¦X07¦ - skill points required: 100¦CE¦\'
              + '¦X07¦¦C1CCA272¦Level 2 requirement: Level 10\'
              + '¦X07¦ - skill points required: 200¦CE¦\'
              + '¦X07¦¦C1B38E64¦Level 3 requirement: Level 12\'
              + '¦X07¦ - skill points required: 300¦CE¦\'
              + '¦X07¦¦C1997A56¦Level 4 requirement: Quest\'
              + '¦X07¦ - skill points required: 500¦CE¦\'
              + '¦X07¦¦C17F6547¦Level 5 requirement: Quest\'
              + '¦X07¦ - skill points required: 800¦CE¦\¦Y08¦'
              + '¦X07¦A Tao martial art that raises\'
              + '¦X07¦your accuracy, as you\'
              + '¦X07¦become more skilful the more\'
              + '¦X07¦accuracy you will receive.¦SE¦\¦Y08¦'
              + '¦X07¦¦C1FF0a0a¦Level : %s¦CE¦¦FE¦';
      {$ENDREGION}
    end;
    5  : begin
      {$REGION ' - AdamantineFireball        '}
      Value  := '¦Z¦¦F01¦¦C1FAFAFA¦¦C2806F5C¦¦B¦¦S18¦¦P01¦[AdamantineFireball]\'
              + '¦Z¦<Active>¦PE¦¦SE¦¦BE¦¦CE¦\¦Y-7¦'
              + '¦Z¦¦C1454555¦¦F03¦¦S16¦____________¦SE¦¦FE¦¦CE¦\¦Y07¦'
              + '¦X07¦¦F01¦¦S15¦Magic     : Nature\'
              + '¦X07¦Element : Ignis(Fire, Flame)\¦Y04¦'
              + '¦X07¦¦C1E5B681¦Level 1 requirement: Level 15\'
              + '¦X07¦ - skill points required: 400¦CE¦\'
              + '¦X07¦¦C1CCA272¦Level 2 requirement: Level 17\'
              + '¦X07¦ - skill points required: 500¦CE¦\'
              + '¦X07¦¦C1B38E64¦Level 3 requirement: Level 19\'
              + '¦X07¦ - skill points required: 600¦CE¦\'
              + '¦X07¦¦C1997A56¦Level 4 requirement: Quest\'
              + '¦X07¦ - skill points required: 800¦CE¦\'
              + '¦X07¦¦C17F6547¦Level 5 requirement: Quest\'
              + '¦X07¦ - skill points required: 1100¦CE¦\¦Y08¦'
              + '¦X07¦A fire spell that is more destructive\'
              + '¦X07¦than Fireball. As you become more\'
              + '¦X07¦skillful, the spell gets more\'
              + '¦X07¦powerful.¦SE¦\¦Y08¦'
              + '¦X07¦¦C1FF0a0a¦Level : %s¦CE¦¦FE¦';
      {$ENDREGION}
    end;
    100..2000: Value := 'Fix me in Language File';
    else Value := 'Unsupport';
  end;

  ////////////////////////////////////////////////////////////////////////////
  if Assigned(Buffer) then
    CopyMemory(Buffer, PChar(Value), Length(Value));
  Result := Length(Value);
end;

end.
