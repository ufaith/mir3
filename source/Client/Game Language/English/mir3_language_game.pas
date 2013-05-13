(******************************************************************************
 *   LomCN Mir3 English Game Language LGU File 2013                           *
 *                                                                            *
 *   Web       : http://www.lomcn.org                                         *
 *   Version   : 0.0.0.7                                                      *
 *                                                                            *
 *   - File Info -                                                            *
 *                                                                            *
 *   It holds the mir3 game english language strings.                         *
 *                                                                            *
 ******************************************************************************
 * Change History                                                             *
 *                                                                            *
 *  - 0.0.0.1 [2013-02-11] Azura : first init                                 *
 *  - 0.0.0.2 [2013-03-10] Coly : change all and reorg all                    *
 *  - 0.0.0.3 [2013-03-11] Coly : add new lines                               *
 *  - 0.0.0.4 [2013-03-27] SomebodyElse : fix language                        *
 *  - 0.0.0.5 [2013-02-02] Coly : change some text (use Script Engine)        *
 *  - 0.0.0.6 [2013-04-13] Coly : change to UTF8 + code support               *
 *  - 0.0.0.7 [2013-05-02] 1PKRyan : code clean-up                            *
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

unit mir3_language_game;

interface

uses
  { Delphi }
  Windows,
  SysUtils,
  Classes;

function GetGameLine(): Integer; stdcall;
function GetGameString(ID: Integer; Buffer: PWideChar): Integer; stdcall;

implementation

function GetGameLine(): Integer; stdcall;
begin
  Result := 2000;
end;

function GetGameString(ID: Integer; Buffer: PWideChar): Integer; stdcall;
var
  Value : WideString;
begin
  case ID of
    (*******************************************************************
    *                     Login, Server Selection.                     *
    *******************************************************************)
    1 : Value := 'Log in';                                                              // Button
    2 : Value := 'Exit';                                                                // Button
    3 : Value := 'New Account';                                                         // Button URL
    4 : Value := 'Change Password';                                                     // Button URL
    5 : Value := 'ID                                      PASSWORD¦CE¦';                // Button
    6 : Value := 'Log In (L)';                                                          // [1] Hint
    7 : Value := 'Exit (X)';                                                            // [2] Hint
    8 : Value := 'New Account (N)';                                                     // [3] Hint
    9 : Value := 'Change Password (P)';                                                 // [4] Hint
    10: Value := 'You have been disconnected.';                                         // Infoboard
    11: Value := 'The server is currently\down for maintenance.';                       // Infoboard
    12: Value := 'Cannot connect to the server.\The server is unreachable.';            // Infoboard
    13: Value := 'Are you sure you want to quit?';
    14: Value := 'Reserved';
    15: Value := 'Reserved';
    { SM_LOGIN_PASSWORD_FAIL }
    16: Value := 'Your ID or password is incorrect.\Please try again.';
    17: Value := 'You have entered the wrong account\information three times.\Please try again later.';
    18: Value := 'Unable to access account information.\Please try again.';
    19: Value := 'Your account has been disabled.\Please visit www.lomcn.org\for more information.';
    20: Value := 'Your game subscription has expired.\Please visit www.lomcn.org\for more information.';
    21: Value := 'Unknown errors have occurred!\Please visit www.lomcn.org\for more information.';
    22: Value := 'Reserved';
    23: Value := 'Reserved';
    24: Value := 'Reserved';
    25: Value := 'Reserved';
    { SM_LOGIN_PASSWORD_OK Verify Subscription }
    26: Value := 'Your subscription expires today!\Please visit http://www.lomcn.org\for more information.';
    27: Value := 'Your subscription will expire in\ %d days.';
    28: Value := 'Your IP access will be valid for\another %d days.';
    29: Value := 'Your IP access expires today!';
    30: Value := 'Your IP access will be valid for\another %d hours.';
    31: Value := 'Your ID will be valid for another\ %d hours.';
    32: Value := 'Reserved';
    33: Value := 'Reserved';
    34: Value := 'Character Creation'; // Create Char Main Überschrift
    35: Value := 'Class Selection';  // Create Char Class Selection Überschrift
    36: Value := 'Gender Selection'; // Create Char Gender Selection Überschrift
    37: Value := 'Enter the name';   // Create Char Edit field Überschrift
    38: Value := 'Create Character';
    39: Value := 'Login to the Game';
    40: Value := 'Select Server';
    (*******************************************************************
    *               Character Selection / Creation                     *
    *******************************************************************)
    41: Value := 'Loading character information, please wait.';
    42: Value := 'Select Warrior';
    43: Value := 'Select Wizard';
    44: Value := 'Select Taoist';
    45: Value := 'Select Assassin';
    46: Value := 'Confirm';
    47: Value := 'Cancel';
    48: Value := 'Name';
    49: Value := 'Level';
    50: Value := 'Class';
    51: Value := 'Gold';
    52: Value := 'Exp';
    53: Value := 'Reserved';
    54: Value := 'Reserved';
    55: Value := 'Male';
    56: Value := 'Female';
    57: Value := 'Warrior';
    58: Value := 'Wizard';
    59: Value := 'Taoist';
    60: Value := 'Assassin';
    { Information about Warriors }
//    61: Value := '¦Y05¦¦C1D1AD69¦¦C23A3A3A¦ [%s Warrior]¦CE¦\¦Y08¦'             // SE: Better to have gender first
//               + ' Warriors are a class of great strength and vitality. They are not easily\'
//               + ' killed in battle and have the advantage of being able to use a variety of\'
//               + ' heavy weapons and armour. Warriors favour attacks that are based on close\'
//               + ' range physical damage, and are weak against ranged attacks. The variety\'
//               + ' of equipment that is developed specifically for Warriors complements\'
//               + ' their weakness in ranged combat. Warrior characters are recommended for\'
//               + ' beginners because of their simple yet powerful abilities.\';
    61: Value := 'Warriors are a class of great strength\'
               + 'and vitality. They are not easily killed\'
               + 'in battle and have the advantage of being\'
               + 'able to use a variety of heavy weapons\'
               + 'and armour. Warriors favour attacks that\'
               + 'are based on close range physical\'
               + 'damage, and are weak against ranged\'
               + 'attacks. The variety of equipment that\'
               + 'is developed specifically for Warriors\'
               + 'complements their weakness in ranged\'
               + 'combat. Warrior characters are\'
               + 'recommended for beginners because of\'
               + 'their simple yet powerful abilities.\';
    { Information about Wizards }
//    62: Value := '¦Y05¦¦C1D1AD69¦¦C23A3A3A¦ [%s Wizard]¦CE¦\¦Y08¦'
//               + ' Wizards are a class of low strength and stamina, but have the ability to use\'
//               + ' powerful spells. Their offensive spells are very effective, but the time it\'
//               + ' takes to cast these spells is likely to leave them vulnerable to enemy\'
//               + ' counterattacks. Therefore, a Wizard must always aim to attack his enemies\'
//               + ' from a safe distance. Being physically weak, Wizards are difficult to train\'
//               + ' in the early stages of the game, but grow into powerful characters as they\'
//               + ' learn the more advanced spells. Because of their many advantages and\'
//               + ' drawbacks, Wizards require a lot of attention and skill.\';
    62: Value := 'Wizards are a class of low strength and\'
               + 'stamina, but have the ability to use\'
               + 'powerful spells. Their offensive spells\'
               + 'are very effective, but the time it takes\'
               + 'to cast these spells is likely to leave\'
               + 'them vulnerable to enemy counterattacks.\'
               + 'Therefore, a Wizard must always aim to\'
               + 'attack his enemies from a safe distance.\'
               + 'Being physically weak, Wizards are\'
               + 'difficult to train in the early stages of\'
               + 'the game, but grow into powerful\'
               + 'characters as they learn the more\'
               + 'advanced spells.';
               //Because of their many advantages and\'
               //+ 'drawbacks, Wizards require a lot of\'
               //+ 'attention and skill.\';
    { Information about Taoists }
//    63: Value := '¦Y05¦¦C1D1AD69¦¦C23A3A3A¦ [%s Taoist]¦CE¦\¦Y08¦'
//               + ' Taoists lie between Wizards and Warriors in terms of strength and\'
//               + ' survivability, but rather than directly engaging their enemies, their true\'
//               + ' strength lies in supporting others. Their most essential skills are the\'
//               + ' ability to heal and protect other characters. They can also summon powerful\'
//               + ' creatures to assist them, and have a few well balanced offensive options.\'
//               + ' Even though Taoists have many skills, their lack of physical power makes them\'
//               + ' difficult to train. They must always look out for other players to fight with.\';
    63: Value := 'Taoists lie between Wizards and Warriors\'
               + 'in terms of strength and survivability,\'
               + 'but rather than directly engaging their\'
               + 'enemies, their true strength lies in\'
               + 'supporting others. Their most essential\'
               + 'skills are the ability to heal and protect\'
               + 'other characters. They can also summon\'
               + 'powerful creatures to assist them, and\'
               + 'have a few well balanced offensive\'
               + 'options. Even though Taoists have many\'
               + 'skills, their lack of physical power\'
               + 'makes them difficult to train.\';
               // They must\'
               //+ 'always look out for other players to\'
               //+ 'fight with.\';
    { Information about Assassins }
//    64: Value :=  '¦Y05¦¦C1D1AD69¦¦C23A3A3A¦ [%s Assassin]¦CE¦\¦Y08¦'
//               + '¦C1D1AD69¦¦C2C19D59¦ Assassins are members of a secret organization and their history is relatively\'
//               + ' unknown. They are physically weak but are capable of hiding themselves and\'
//               + ' performing attacks while being unseen by others, and are naturally excellent\'
//               + ' at making fast kills. However they must be careful to avoid engagements\'
//               + ' against multiple opponents as they have less defensive options than other\'
//               + ' characters. Assassins are recommended for experienced players, as they\'
//               + ' require smart moves, cunning decisions and quick thinking.¦CE¦\';
    64: Value := 'Assassins are members of a secret\'
               + 'organization and their history is\'
               + 'relatively unknown. They are physically\'
               + 'weak but are capable of hiding themselves\'
               + 'and performing attacks while being unseen\'
               + 'by others, and are naturally excellent at\'
               + 'making fast kills. However they must be\'
               + 'careful to avoid engagements against\'
               + 'multiple opponents as they have less\'
               + 'defensive options than other characters.\'
               + 'Assassins are recommended for experienced\'
               + 'players, as they require smart moves,\'
               + 'cunning decisions and quick thinking.\';
    65: Value := 'Character deleted.';
    66: Value := 'Deleted characters cannot be recovered, and\'
               + 'you cannot create another character with\'
               + 'the same name for a while. If you wish to\'
               + 'continue, please type your password and\'
               + 'press the "Confirm" button.';     //SE: Fixed... Coly: used ID 79 and 80 for this one
    67: Value := 'You cannot create more than %d characters.';
    68: Value := 'Please create a character first.';
    69: Value := 'Character information cannot be accessed.';
    70: Value := 'A character with this name already exists.';
    71: Value := 'You cannot create another character.';
    72: Value := 'Character creation failure - Error code 4';
    73: Value := 'Unknown errors have occurred.\Please visit www.lomcn.org\for more information.';
    74: Value := 'An error has occurred while deleting\your character.';
    75: Value := 'Start Game';//¦CE¦';
    76: Value := 'New Character';//¦CE¦';
    77: Value := 'Delete Character';//¦CE¦';
    78: Value := 'Exit';//¦CE¦';
    79: Value := 'Confirm';                       //Button Text
    80: Value := 'Cancel';                        //Button Text
    (*******************************************************************
    *                        InGame Text                               *
    *******************************************************************)
    {Menu Bar}
    81: Value := 'Settings';
    82: Value := 'Chat';
    83: Value := 'Message';
    84: Value := 'Group';
    85: Value := 'Guild';
    86: Value := 'Avatar';
    87: Value := 'Siege';
    88: Value := 'Auto-Features';
    89: Value := 'Exit';
    90: Value := 'Close';
    91: Value := 'Set 2nd Password';//¦CE¦';
    92: Value := 'Character Selection';
    93..100 : Value := 'Reserved';
    {Game Settings}
    101: Value := 'Basic';
    102: Value := 'Security'; //'Permissions'; //'Privileges'; // SE: Security should fit! //'Permit';
    103: Value := 'Chat';
    104: Value := 'Visual';
    { Page 1 Basic }
    105: Value := 'Attack Stance: All';
    106: Value := 'Attack Stance: Peaceful';
    107: Value := 'Attack Stance: Lover'; //(Dear)'; - Lover, Partner, Spouse, Couple, Marriage
    108: Value := 'Attack Stance: Master';
    109: Value := 'Attack Stance: Group';
    110: Value := 'Attack Stance: Guild';
    111: Value := 'Attack Stance: Red vs. White';
    112: Value := 'Reserved';
    113: Value := 'Reserved';
    114: Value := 'Change Attack Stance';                   // Hint for Attack Mode
    116: Value := 'Normal Attack Stance';
    117: Value := 'Change Attack Stance';                   // Hint for Attack Mode
    118: Value := 'Background Music';
    119: Value := '[ Background Music On/Off ]';            // Hint Background Music
    120: Value := 'Sound Effects';
    121: Value := '[ Sound Effects On/Off ]';               // Hint Sound Effects
    122: Value := 'Directional (Stereo) Sound';
    123: Value := '[ Directional Sound On/Off ]';           // Hint Sound Effects
    124: Value := 'Automatic Pick-up';
    125: Value := '[ Automatic Pick-up On/Off ]';           // Hint Sound Effects
    126: Value := 'Show names of dropped items';
    127: Value := '[ Show names of dropped items On/Off ]'; // Hint Sound Effects
    { Page 2 Permissions }
    128: Value := 'Allow Group Invitations';
    129: Value := '[ Allow Group Invitations On/Off ]';
    130: Value := 'Allow Guild Invitations';
    131: Value := '[ Allow Guild Invitations On/Off ]';
    132: Value := 'Allow Resurrection';
    133: Value := '[ Allow Resurrection On/Off ]';
    134: Value := 'Allow Recall';
    135: Value := '[ Allow Recall On/Off ]';
    136: Value := 'Allow Trading';
    137: Value := '[ Allow Trading On/Off ]';
    138: Value := 'Blood Splatter Effects (18+)'; // Fixed
    139: Value := '[ Blood Splatter Effects On/Off ]';
    140: Value := 'Reserved';
    141: Value := 'hint reserved';
    142: Value := 'Reserved';
    143: Value := 'hint reserved';
    144: Value := 'Reserved';
    145: Value := 'hint reserved';
    146: Value := 'Reserved';
    147: Value := 'hint reserved';
    { Page 3 Chatting }
    148: Value := 'Whispering';
    149: Value := '[ Listen to Whispering On/Off ]';
    150: Value := 'Shouting';
    151: Value := '[ Listen to Shouting On/Off ]';
    152: Value := 'Reserved';
    153: Value := 'hint reserved';
    154: Value := 'Guild Messages';
    155: Value := '[ Listen to Guild Messages On/Off ]';
    156: Value := 'Block whispering from User';
    157: Value := '[ Whispering from User blocked ]';    // SE: it would be nice for the %s to let you know who is blocked - not necessary though | Coly: Prio 8 or so...
    158: Value := 'Reserved';
    159: Value := 'Reserved';
    160: Value := 'hint reserved';
    161: Value := 'Reserved';
    162: Value := 'hint reserved';
    163: Value := 'Reserved';
    164: Value := 'hint reserved';
    165: Value := 'Reserved';
    166: Value := 'hint reserved';
    167: Value := 'Reserved';
    168: Value := 'hint reserved';
    { Page 4 Visual }
    169: Value := 'HP Change Indicator';
    170: Value := '[ HP Change Indicator On/Off ]';
    171: Value := 'Display Magic Graphics';
    172: Value := '[ Magic Graphics On/Off ]';
    173: Value := 'Display Bright Shadows';
    174: Value := '[ Bright Shadows On/Off ]';
    175: Value := 'Display Helmet Graphics';
    176: Value := '[ Helmet Graphics On/Off ]';
    177: Value := 'Display Monster Effects';
    178: Value := '[ Monster Effects On/Off ]';
    179: Value := 'Display dyed hair colours';
    180: Value := '[ Dyed Hair Colours On/Off ]';
    181: Value := 'Display Avatar';
    182: Value := '[ Avatar On/Off ]';
    183: Value := 'Show Monsters on Mini-map';  // The text is a bit too long - SE: fixed?
    184: Value := '[ Monsters on Mini-map On/Off ]';
    185: Value := 'Display Player HP Gauge';
    186: Value := '[ Player HP Gauge On/Off ]';
    187: Value := 'Display Monster HP Gauge';
    188: Value := '[ Monster HP Gauge On/Off ]';
    189: Value := 'Reserved';
    { Exit Window }
    190: Value := 'Exit';
    191: Value := 'Exit the game.';
    192: Value := 'Log out';
    193: Value := 'Log out and select a new character.';
    194: Value := 'Are you sure you want to quit?';
    195: Value := 'Cancel';
    { Belt Window }
    196: Value := 'Rotate';         //Hint
    197: Value := 'Close';          //Hint
    198: Value := 'Reserved';
    199: Value := 'Reserved';
    200: Value := 'Reserved';
    { Mini Map }
    201: Value := ''; //Hint
    202: Value := ''; //Hint
    203: Value := ''; //Hint
    204: Value := ''; //Hint
    205: Value := 'No Mini-map';
    206: Value := 'No map available!';
    207: Value := 'Not Used';
    208..210: Value := 'Reserved';
    { Body Window }
    211: Value := 'Level';
    212: Value := 'Experience';
    213: Value := 'Health Points (HP)';
    214: Value := 'Mana Points (MP)';
    215: Value := 'Bag Weight';
    216: Value := 'Body Weight';
    217: Value := 'Hand Weight';
    218: Value := 'Accuracy';
    219: Value := 'Agility';
    220: Value := 'Ele(Atk)';
    221: Value := 'Ele(Def)';
    222: Value := 'Ele(Wkn)';
    223: Value := 'Element Atk (Attack)';           //Hint
    224: Value := 'Element Def (Defence)';          //Hint
    225: Value := 'Element Wkn (Weakness)';         //Hint
    226: Value := 'Element Fire (Attack)';          //Hint
    227: Value := 'Element Fire (Defence)';         //Hint
    228: Value := 'Element Fire (Weakness)';        //Hint
    229: Value := 'Element Ice (Attack)';           //Hint
    230: Value := 'Element Ice (Defence)';          //Hint
    231: Value := 'Element Ice (Weakness)';         //Hint
    232: Value := 'Element Thunder (Attack)';       //Hint
    233: Value := 'Element Thunder (Defence)';      //Hint
    234: Value := 'Element Thunder (Weakness)';     //Hint
    235: Value := 'Element Wind (Attack)';          //Hint
    236: Value := 'Element Wind (Defence)';         //Hint
    237: Value := 'Element Wind (Weakness)';        //Hint
    238: Value := 'Element Holy (Attack)';          //Hint
    239: Value := 'Element Holy (Defence)';         //Hint
    240: Value := 'Element Holy (Weakness)';        //Hint
    241: Value := 'Element Dark (Attack)';          //Hint
    242: Value := 'Element Dark (Defence)';         //Hint
    243: Value := 'Element Dark (Weakness)';        //Hint
    244: Value := 'Element Phantom (Attack)';       //Hint
    245: Value := 'Element Phantom (Defence)';      //Hint
    246: Value := 'Element Phantom (Weakness)';     //Hint
    247..250: Value := 'Reserved';
    { Group Window }
    251: Value := 'Group';
    252: Value := 'Close group window';             //Hint
    253: Value := 'Add Member to Group';            //Hint
    254: Value := 'Delete a Member from Group';     //Hint
    255: Value := 'Create a Group';                 //Hint
    256: Value := 'Allow Group Invitations';        //Hint
    257..260: Value := 'Reserved';
    { Magic Window }
    261: Value := ' Fire  ';                            //Hint
    262: Value := ' Ice  ';                             //Hint
    263: Value := ' Lightning  ';                       //Hint
    264: Value := ' Wind  ';                            //Hint
    265: Value := ' Holy  ';                            //Hint
    266: Value := ' Dark  ';                            //Hint
    267: Value := ' Phantom  ';                         //Hint
    268: Value := ' Physical ';//'Martial Art';         //Hint
    269: Value := 'Close Window';//'Close Magic Window';//Hint
    { Assassin Magic Window }
    270: Value := ' Atrocity  ';                        //Hint - SE: I have no idea what these 3 should actually be...
    271: Value := ' Assa  ';                            //Hint - ??
    272: Value := ' Assassinate  ';                     //Hint - ??

    (* Development Strings, not for real play *)
    1050: Value := 'DC 1000-1000';
    1051: Value := 'AC 1000-1000';
    1052: Value := 'BC 1000-1000';
    1053: Value := 'MC 1000-1000';
    1054: Value := 'SC 1000-1000';
    1055: Value := 'MR 1000-1000';
    1056: Value := '+1000';
    1057: Value := '1000/1000';
    1058: Value := '194';
    1059: Value := '3.55 %';
    1060: Value := 'Coly\GameMasterGuild';
    1061: Value := 'Coly´s Spouse';
    1062: Value := '100-100';
    1063: Value := '10000';
    1064: Value := '1000';
    1065: Value := '99';
    1066: Value := '10';
    1067: Value := '+';
    1068: Value := '-';
    1069: Value := 'x';
    1070: Value := '*';

    1071..2000: Value := 'Reserved';
    else Value := 'Unsupported';
  end;

  ////////////////////////////////////////////////////////////////////////////
  ///

  if Assigned(Buffer) then
    lstrcpynW(Buffer, PWideChar(Value), lstrlenW(PWideChar(Value)) + 1);

  Result := lstrlenW(PWideChar(Value)) + 1;
end;

end.
