(*******************************************************************
 *   LomCN Mir3 German Game Language LGU File 2013                 *
 *                                                                 *
 *   Web       : http://www.lomcn.co.uk                            *
 *   Version   : 0.0.0.2                                           *
 *                                                                 *
 *   - File Info -                                                 *
 *                                                                 *
 *   It holds the mir3 game German language strings.               *
 *                                                                 *
 *******************************************************************
 * Change History                                                  *
 *                                                                 *
 *  - 0.0.0.1 [2013-02-11] Coly : first init                       *
 *  - 0.0.0.2 [2013-03-11] Coly : add new lines                    * 
 *                                                                 *
 *                                                                 *
 *******************************************************************
 * :Info:                                                          *
 * The Maximum of String Literale is 255 so you need to add ' + '  *
 * at the end of 255 Char...                                       *
 * The String it self can have a length of 1024                    *
 *******************************************************************)

unit mir3_language_game;

interface

uses Windows, SysUtils, Classes;

function GetGameLine(): Integer; stdcall;
function GetGameString(ID: Integer; Buffer: PChar): Integer; stdcall;

implementation

function GetGameLine(): Integer; stdcall;
begin
  Result := 63;
end;

function GetGameString(ID: Integer; Buffer: PChar): Integer; stdcall;
var
  Value : string;
begin
  case ID of
   (*******************************************************************
    *                     Login, Server Selection.                     *
    *******************************************************************)
    1 : Value := 'Login';                                                               // Button
    2 : Value := 'Exit';                                                                // Button
    3 : Value := 'New Account';                                                         // Button URL
    4 : Value := 'Änder Password';                                                      // Button URL
    5 : Value := 'ID                              PASSWORT';                            // Button
    6 : Value := 'Login (L)';                                                           // [1] Hint
    7 : Value := 'Exit(X)';                                                             // [2] Hint
    8 : Value := 'Neuer Account (N)';                                                     // [3] Hint
    9 : Value := 'Änder Passwort(P)';                                                   // [4] Hint
    10: Value := 'You have been disconnected.';                                         // Infoboard
    11: Value := 'Servers are currently'+#10#13+'down for maintenance.';                // Infoboard
    12: Value := 'Kann keine Verbindung zum Server'+#10#13+'aufbauen. Der Server ist nicht erreichbar.';  // Infoboard
    13: Value := 'Möchtest du das Spiel wirklich beeenden?';
    14: Value := 'reserve';
    15: Value := 'reserve';
    { SM_LOGIN_PASSWORD_FAIL }
    16: Value := 'The user name or password is incorrect.'+#10#13+'Please try again.';
    17: Value := 'You have entered the wrong account'     +#10#13+'information three times.'           +#10#13+'Please restart the game client.';
    18: Value := 'Unable to access account information.'  +#10#13+'Please try again.';
    19: Value := 'Your account has been disabled.'        +#10#13+'Please visit http://www.LomCN.co.uk'+#10#13+'for more information.';
    20: Value := 'Your game subscription has expired.'    +#10#13+'Please visit http://www.LomCN.co.uk'+#10#13+'for more information.';
    21: Value := 'Unknown errors have occurred. '         +#10#13+'Please visit http://www.LomCN.co.uk'+#10#13+'for more information.';
    22: Value := 'reserve';
    23: Value := 'reserve';
    24: Value := 'reserve';
    25: Value := 'reserve';
    { SM_LOGIN_PASSWORD_OK Verify Subscription }
    26: Value := 'Your game subscription expires today';
    27: Value := 'Your game subscription will expire in'+#10#13+' %d days';
    28: Value := 'Your IP in use has remaining'+#10#13+' %d days to access.';
    29: Value := 'Your IP in use expires today.';
    30: Value := 'Your IP in use has remaining'+#10#13+' %d hours to access.';
    31: Value := 'Your ID in use has remaining'+#10#13+' %d hours to access.';
    32: Value := 'reserve';
    33: Value := 'reserve';
    34: Value := 'reserve';
    35: Value := 'reserve';
    36: Value := 'reserve';
    37: Value := 'reserve';
    38: Value := '100-100';
    39: Value := '10000';
    40: Value := '1000';
    (*******************************************************************
    *               Character Selection / Creation                     *
    *******************************************************************)
    41: Value := 'Loading character information. Please wait.';
    42: Value := 'Select Warrior Class';
    43: Value := 'Select Wizard Class';
    44: Value := 'Select Taoist Class';
    45: Value := 'Select Assassin Class';
    46: Value := 'Bestätige';
    47: Value := 'Abbruch';
    48: Value := 'Name';
    49: Value := 'Level';
    50: Value := 'Klasse';
    51: Value := 'Gold';
    52: Value := 'Exp';
    53: Value := '[ ';
    54: Value := ' ]';
    55: Value := 'Mänlicher ';
    56: Value := 'Weiblicher ';
    57: Value := 'Warrior';
    58: Value := 'Wizard';
    59: Value := 'Taoist';
    60: Value := 'Assassin';
    { Information to Warriors }
    61: Value := 'Warriors are a class of great strength and vitality. They are not easily    ' + #10#13 +
                 'killed in battle and have the advantage of being able to use a variety of   ' + #10#13 +
                 'heavy weapons and armor. Therefore, Warriors favor attacks that are based   ' + #10#13 +
                 'on melee physical damage. They are weak in ranged attacks, however the      ' + #10#13 +
                 'variety of equipment that are developed specifically for Warriors complement' + #10#13 +
                 'their weakness in ranged combat. Warriors are recommended for beginners     ' + #10#13 +
                 'because of their simple yet destructive abilities.                          ';
    { Information to Wizards }
    62: Value := 'Wizards are a class of low strength and stamina, but have the ability to use' + #10#13 +
                 'powerful spells. Their offensive spells are very effective, but because it  ' + #10#13 +
                 'takes time to cast these spells, they''''re likely to leave themselves open ' + #10#13 +
                 'for enemy''''s attacks. Therefore, the physically weak Wizards must aim to  ' + #10#13 +
                 'attack their enemies from a safe distance. Wizards are difficult to level   ' + #10#13 +
                 'in the early stages of the game, but grow into powerful characters as they  ' + #10#13 +
                 'learn additional powerful spells. Because of their many advantages and      ' + #10#13 +
                 'disadvantages, Wizards are a character that requires a lot of attention.    ';
    { Information to Taoists }
    63: Value := 'Taoists are well disciplined in the study of Astronomy, Medicine, and others ' + #10#13 +
                 'aside from Mu-Gong. Rather than directly engaging the enemies, their         ' + #10#13 +
                 'specialty lies in assisting their allies with support. Taoists can summon    ' + #10#13 +
                 'powerful creatures and have high resistances to magic, and is a class with   ' + #10#13 +
                 'well balanced offensive and defensive abilities. Even though Taoists have    ' + #10#13 +
                 'many abilities, their lack in physical attack power makes them difficult to  ' + #10#13 +
                 'level up. In order to overcome the slow leveling process, they must look for ' + #10#13 +
                 'others to group with, and above all, have the desire to help others.         ';
    { Information to Assassins }
    64:Value :=  'Assassins are members of a secret organization and their history is relatively' + #10#13 +
                 'unknown. They''''re capable of hiding themselves and performing attacks while ' + #10#13 +
                 'being unseen by others, which naturally makes them excellent at making fast   ' + #10#13 +
                 'kills. It is necessary for them to avoid being in battles with multiple       ' + #10#13 +
                 'enemies due to their weak vitality and strength. Assassins are recommended for' + #10#13 +
                 'experienced players, as they require smart moves, as well as cunning decisions.';

    65: Value := 'Lösche Character';             
    66: Value := 'Deleted characters cannot be recovered and'+ #10#13 +'you cannot create another character with'+ #10#13 +
                 'the same name for a few days. If you wish '+ #10#13 +'to continue please type the game        '+ #10#13 +
                 'password and press the Yes button.';
    67: Value := 'You cannot create more than %d characters.';
    68: Value := 'Please create a character first by'+ #10#13 +'clicking the New Character button.';
    69: Value := 'Character information can not be acquired.';
    70: Value := 'This name already exists.';
    71: Value := 'You cannot create anymore characters.';
    72: Value := 'Character creating failure. Error=4';
    73: Value := 'Unknown errors have occurred.'+#10#13+'Please visit mir3.wemade.net'+#10#13+'for more information.'; 
    74: Value := 'An error has occurred while'+#10#13+'deleting a character.';
    75: Value :='reserve';
    else Value := 'Unsupport';
  end;

  ////////////////////////////////////////////////////////////////////////////
  ///

  if Assigned(Buffer) then
    CopyMemory(Buffer, PChar(Value), Length(Value));
  Result := Length(Value);
end;

end.
