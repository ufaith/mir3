(*******************************************************************
 *   LomCN Mir3 English Game Language LGU File 2013                *
 *                                                                 *
 *   Web       : http://www.lomcn.co.uk                            *
 *   Version   : 0.0.0.3                                           *
 *                                                                 *
 *   - File Info -                                                 *
 *                                                                 *
 *   It holds the mir3 game english language strings.              *
 *                                                                 *
 *******************************************************************
 * Change History                                                  *
 *                                                                 *
 *  - 0.0.0.1 [2013-02-11] Azura : first init                      *
 *  - 0.0.0.2 [2013-03-10] Coly : change all and reorg all         *
 *  - 0.0.0.3 [2013-03-11] Coly : add new lines                    *
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
  Result := 207;
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
    4 : Value := 'Change Password';                                                     // Button URL
    5 : Value := 'ID                              PASSWORD';                            // Button
    6 : Value := 'Login (L)';                                                           // [1] Hint
    7 : Value := 'Exit(X)';                                                             // [2] Hint
    8 : Value := 'New Account (N)';                                                     // [3] Hint
    9 : Value := 'Change Password(P)';                                                  // [4] Hint
    10: Value := 'You have been disconnected.';                                         // Infoboard
    11: Value := 'Servers are currently'+#10#13+'down for maintenance.';                // Infoboard
    12: Value := 'Can not connect to the server.'+#10#13+'The server is unreachable.';  // Infoboard
    13: Value := 'You really want to quit the game?';
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
    46: Value := 'Confirm';
    47: Value := 'Cancel';
    48: Value := 'Name';
    49: Value := 'Level';
    50: Value := 'Class';
    51: Value := 'Gold';
    52: Value := 'Exp';
    53: Value := '[ ';
    54: Value := ' ]';
    55: Value := 'Male ';
    56: Value := 'Female ';
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

    65: Value := 'Deleted Character';             
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
    75: Value := 'reserve';
    76: Value := 'reserve';
    77: Value := 'reserve';
    78: Value := 'reserve';
    79: Value := 'reserve';
    80: Value := 'reserve';
    {Menue Bar}
    81: Value := 'Settings';
    82: Value := 'Chat';
    83: Value := 'Message';
    84: Value := 'Group';
    85: Value := 'Guild';
    86: Value := 'Avatar';
    87: Value := 'Siege';
    88: Value := 'Exit';
    89: Value := 'Auto Features';
    90: Value := 'Close Menue';
    91..100 : Value := 'reserve';
    {Game Settings}
    101: Value := 'Basic';
    102: Value := 'Permit';
    103: Value := 'Chatting';
    104: Value := 'Visual';
    { Page 1 Basic }
    105: Value := 'Attack Mode(All)';
    106: Value := 'Attack Mode(Peaceful)';
    107: Value := 'Attack Mode(Dear)';
    108: Value := 'Attack Mode(Master)';
    109: Value := 'Attack Mode(Group)';
    110: Value := 'Attack Mode(Guild)';
    111: Value := 'Attack Mode(Good vs. Evil)';
    112: Value := 'reserved';
    113: Value := 'reserved';
    114: Value := 'Change Attack Mode';           // Hint for Attack Mode
    115: Value := 'Forced Attack Mode';
	  116: Value := 'Normal Attack Mode';
    117: Value := 'Change Attacking';             // Hint for Attack Mode
    118: Value := 'B    G    M';
    119: Value := '[ Background Music On/Off ]';  // Hint Background Music
    120: Value := 'Sound Effects';
    121: Value := '[ Sound Effects On/Off ]';     // Hint Sound Effects
    122: Value := 'Right <-> Left (3D Sound)';
    123: Value := '[ 3D Sound On/Off ]';          // Hint Sound Effects
    124: Value := 'Automatic picking';
    125: Value := '[ Automatic picking On/Off ]'; // Hint Sound Effects
    126: Value := 'Display dropped Item Name';
    127: Value := '[ Display Name of a dropped Item On/Off ]'; // Hint Sound Effects
    { Page 2 Permit }
	  128: Value := 'Permit Group Invitation';
	  129: Value := '[ Permit/Block Group Invitation ]';
    130: Value := 'Guild Joining Allowed';
	  131: Value := '[ Guild Joining Allowed On/Off ]';
	  132: Value := 'Resurrection Allowed';
	  133: Value := '[ Resurrection Allowed On/Off ]';
	  134: Value := 'Recall Allowed';
	  135: Value := '[ Recall Allowed On/Off ]';
	  136: Value := 'Trading Allowed';
	  137: Value := '[ Trading Allowed On/Off ]';
	  138: Value := 'Blood Display';
	  139: Value := '[ Blood Display On/Off ]';
	  140: Value := 'reserved';
	  141: Value := 'hint reserved';
	  142: Value := 'reserved';
    143: Value := 'hint reserved';
    144: Value := 'reserved';
    145: Value := 'hint reserved';
    146: Value := 'reserved';
    147: Value := 'hint reserved';
    { Page 3 Chatting }
    148: Value := 'Whispering Allowed';
    149: Value := '[ Whispering Allowed On/Off ]';
    150: Value := 'Shouting Allowed';
    151: Value := '[ Shouting Allowed On/Off ]';
    152: Value := 'reserved';
    153: Value := 'hint reserved';
    154: Value := 'Guild Message Allowed';
    155: Value := '[ Guild Message Allowed On/Off ]';
    156: Value := 'Lock Whispering From Certain User';
    158: Value := '[ Set Lock Whispering from Certain User ]';
    157: Value := 'reserved';
    159: Value := 'reserved';
    160: Value := 'hint reserved';
    161: Value := 'reserved';
    162: Value := 'hint reserved';
    163: Value := 'reserved';
    164: Value := 'hint reserved';
    165: Value := 'reserved';
    166: Value := 'hint reserved';
    167: Value := 'reserved';
    168: Value := 'hint reserved';
    { Page 4 Visual }
    169: Value := 'HP change displayed';
    170: Value := '[ HP change displayed On/Off ]';
    171: Value := 'Display Magic Graphic Effect';
    172: Value := '[ Magic Graphic Effect On/Off ]';
    173: Value := 'Display Bright Shadow';
    174: Value := '[ Display Bright Shadow On/Off ]';
    175: Value := 'Display Helmet';
    176: Value := '[ Display Helmet On/Off ]';
    177: Value := 'Display Monster Effect';
    178: Value := '[ Display Monster Effect On/Off ]';
    179: Value := 'Display Dyed Hair';
    180: Value := '[ Display Dyed Hair On/Off ]';
    181: Value := 'Display Avatar';
    182: Value := '[ Display Avatar On/Off ]';
    183: Value := 'Display Monster on Minimap';
    184: Value := '[ Display Monster on Minimap On/Off ]';
    185: Value := 'Display HP Gauge';
    186: Value := '[ Display HP Gauge On/Off ]';
    187: Value := 'Display Monster HP';
    188: Value := '[ Display Monster HP On/Off ]';
    189: Value := 'reserved';
    { Exit Window }
    190: Value := 'Exit';
    191: Value := 'Exit the Game';
    192: Value := 'Logout';
    193: Value := 'Logout and Select a New Character..';
    194: Value := 'Do you wan´t to quit?';
    195: Value := 'Cancel';
    { Belt Window }
    196: Value := 'Rotate';        //Hint
    197: Value := 'Close Belt';    //Hint
    198: Value := 'reserved';
    199: Value := 'reserved';
    200: Value := 'reserved';
    { Mini Map }
    201: Value := ''; //Hint
    202: Value := ''; //Hint
    203: Value := ''; //Hint
    204: Value := ''; //Hint
    205: Value := 'No Mini Map';
    206: Value := 'No Map';
    207: Value := 'Not Used';
    else Value := 'Unsupport';
  end;

  ////////////////////////////////////////////////////////////////////////////
  ///

  if Assigned(Buffer) then
    CopyMemory(Buffer, PChar(Value), Length(Value));
  Result := Length(Value);
end;

end.
