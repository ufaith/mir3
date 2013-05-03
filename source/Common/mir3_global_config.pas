(*****************************************************************************
 *   LomCN Mir3 Global Config File 2011                                      *
 *                                                                           *
 *   Web       : http://www.lomcn.co.uk                                      *
 *   Version   : 0.0.0.3                                                     *
 *                                                                           *
 *   - File Info -                                                           *
 *                                                                           *
 *   This file holds Client and Server                                       *
 *   records and communication protocol consts and                           *
 *   some help function...                                                   *
 *                                                                           *
 *****************************************************************************
 * Change History                                                            *
 *                                                                           *
 *  - 0.0.0.1 [2011-08-20] Coly : fist final clean up                        *
 *  - 0.0.0.2 [2012-09-29] Coly : add Language and Spell Consts              *
 *  - 0.0.0.3 [2012-10-01] Coly : add Attack Mode Consts and Options record  *
 *                                                                           *
 *****************************************************************************
 *  - TODO List for this *.pas file -                                        *
 *---------------------------------------------------------------------------*
 *  If a todo finished, then delete it here...                               *
 *  If you find a global TODO thats need to do, then add it here..           *
 *---------------------------------------------------------------------------*
 *                                                                           *
 *  - TODO : -all -This file need more information /                         *
 *                 hints (how to use const or records)                       *
 *  - TODO : -all -A bit more clean up (delete all not used things)          *
 *  - TODO : -all -Sorting the Const and Records                             *
 *  - TODO : -all -fill *.pas header information                             *
 *                 (how to need this file etc.)                              *
 *                                                                           *
 *****************************************************************************)

unit mir3_global_config;

interface

uses
  { Delphi }
  Windows,
  Classes,
  Controls,
  { Common }
  mir3_game_socket;

const
  GGameClientVersion             = '0.0.1.3';

  KEY                            = 20100730;
  RUNGATEMAX                     = 20;
  RUNGATECODE                    = $AA55AA55;
  CLIENT_VERSION_NUMBER          = 120061220;

  HEROVERSION                    = 1;
  USELOCALCODE                   = 0;
  USEREMOTECODE                  = 1;
  USECODE                        = USELOCALCODE;
  MAXPATHLEN                     = 255;
  DIRPATHLEN                     = 80;
  MAPNAMELEN                     = 16;
  ACTORNAMELEN                   = 14;
  DEFBLOCKSIZE                   = 27;
  BUFFERSIZE                     = 30000;
  DATA_BUFSIZE2                  = 16348;
  DATA_BUFSIZE                   = 8192;
  GROUPMAX                       = 11;
  BAGGOLD                        = 5000000;
  BODYLUCKUNIT                   = 10;
  MAX_STATUS_ATTRIBUTE           = 30;
  MAXBAGITEM                     = 46;
  MAXHEROBAGITEM                 = 40;
  STATE_OPENHEATH                = 1;
  POISON_68                      = 68;
  STATE_STONE_MODE               = 1;
  UNIT_BIG_X                     = 96;
  UNIT_BIG_Y                     = 64;
  UNIT_X                         = 48;
  UNIT_Y                         = 32;
  HALF_X                         = 24;
  HALF_Y                         = 16;
  MAXMAGIC                       = 20;
  MAXSTORAGEITEM                 = 50;
  LOGICALMAPUNIT                 = 40;
  LONG_HEIGHT_IMAGE              = 35;

 (****************************************************
  *        Server Control Center Consts              *
  ****************************************************)

  (* Server Control Center --> Service *)
  GS_QUIT                        = 3000;
  GS_RECORD                      = 3001; //Coly : place holder

  (* Service --> Server Control Center *)
  SG_FORM_HANDLE                 = 2000;
  SG_START_NOW                   = 2001;
  SG_START_OK                    = 2002;
  SG_STOP_OK                     = 2003;

  (* Service Identifier*)
  IDENT_LOGIN_GATE               = 100;
  IDENT_SELECTCHAR_GATE          = 101;
  IDENT_RUN_GAME_GATE            = 102;
  IDENT_LOGIN_SERVER             = 103;
  IDENT_DB_SERVER                = 104;
  IDENT_GAME_SERVER              = 105;
  IDENT_LOG_SERVER               = 106;

 (****************************************************
  *        Character Direction Consts                *
  ****************************************************)
  DR_UP                          = 0;
  DR_UPRIGHT                     = 1;
  DR_RIGHT                       = 2;
  DR_DOWNRIGHT                   = 3;
  DR_DOWN                        = 4;
  DR_DOWNLEFT                    = 5;
  DR_LEFT                        = 6;
  DR_UPLEFT                      = 7;

 (****************************************************
  *        User Item Consts                          *
  ****************************************************)
  U_DRESS                        = 0;
  U_WEAPON                       = 1;
  U_RIGHTHAND                    = 2;
  U_NECKLACE                     = 3;
  U_HELMET                       = 4;
  U_ARMRINGL                     = 5;
  U_ARMRINGR                     = 6;
  U_RINGL                        = 7;
  U_RINGR                        = 8;
  U_BUJUK                        = 9;
  U_INTEGRAL                     = 10;
  U_BOOTS                        = 11;
  U_CHARM                        = 12;
  U_HORSE                        = 13;

 (****************************************************
  *     Global Help for Classes Consts               *
  ****************************************************)
  C_WARRIOR                      = 0;
  C_WIZZARD                      = 1;
  C_TAOIST                       = 2;
  C_ASSASSIN                     = 3;

 (****************************************************
  *     Global Help for Gender Consts                *
  ****************************************************)
  C_MALE                         = 0;
  C_FEMALE                       = 1;

 (****************************************************
  *     Global Help for Language Consts              *
  ****************************************************)
  C_LANGUAGE_MAX                 = 4;
  C_LANGUAGE_GERMAN              = 0;
  C_LANGUAGE_ENGLISH             = 1;
  C_LANGUAGE_POLISH              = 2;
  C_LANGUAGE_SPANISH             = 3;

 (****************************************************
  *        Attack Mode Consts                        *
  ****************************************************)
  C_MODE_ALL                     = 0;
  C_MODE_PEACE                   = 1;
  C_MODE_DEAR                    = 2;
  C_MODE_MASTER                  = 3;
  C_MODE_GROUP                   = 4;
  C_MODE_GUILD                   = 5;
  C_MODE_PKATTACK                = 6;  

 (****************************************************
  *     Global Help for Spells Consts                *
  ****************************************************)
  C_SPELL_FIREBALL               = 1;
  C_SPELL_HEALING                = 2;
  C_SPELL_SWORDMANSHIP           = 3;
  C_SPELL_SPIRITSWORD            = 4;
  C_SPELL_ADAMANTINEFIREBALL     = 5;
  C_SPELL_POISONING              = 6;
  C_SPELL_SLAYING                = 7;
  C_SPELL_FLAMEREPULSOR          = 8;
  C_SPELL_SCORCHEDEARTH          = 9;
  C_SPELL_LIGHTNINGBEAM          = 10;
  C_SPELL_LIGHTNINGBOLT          = 11;
  C_SPELL_ADVANCEDSLAYING        = 12;
  C_SPELL_TAOEXPLOSION           = 13;
  C_SPELL_MAGICPROTECTION        = 14;
  C_SPELL_RESILIENCE             = 15;
  C_SPELL_TRAPOCTAGON            = 16;
  C_SPELL_SUMMONSKELETON         = 17;
  C_SPELL_INVISIBILITY           = 18;
  C_SPELL_MASSINVISIBILITY       = 19;
  C_SPELL_STUNNING               = 20;
  C_SPELL_TELEPORT               = 21;
  C_SPELL_FIRECLOUD              = 22;
  C_SPELL_EXPLOSION              = 23;
  C_SPELL_LIGHTNINGFLOWER        = 24;
  C_SPELL_HALFMOON               = 25;
  C_SPELL_FLAMINGSWORD           = 26;
  C_SPELL_SHOULDERDASH           = 27;
  C_SPELL_MASSHEALING            = 29;
  C_SPELL_SUMMONSHINSO           = 30;
  C_SPELL_MAGICSHILD             = 31;
  C_SPELL_TURNUNDEAD             = 32;
  C_SPELL_ICESTORM               = 33;
  C_SPELL_BLADESTORM             = 34;
  C_SPELL_DRAGONRISE             = 35;
  C_SPELL_TAOCOMBATKICK          = 36;
  C_SPELL_EVILSLAYER             = 37;
  C_SPELL_GREATEVILSLAYER        = 38;
  C_SPELL_ICEBALL                = 39;
  C_SPELL_ICEBLADES              = 40;
  C_SPELL_LIGHTNINGBALL          = 41;
  C_SPELL_FROZENEARTH            = 53;
  C_SPELL_POWERBURST             = 67;
  C_SPELL_DRAGONTORNADO          = 72;
  C_SPELL_BLOWEARTH              = 73;
  C_SPELL_GREATPOWERBURST        = 74;
  C_SPELL_RESURRECTION           = 77;
  C_SPELL_ELEMENTALSUPERIORITY   = 89;
  C_SPELL_BLOODLUST              = 94;
  C_SPELL_DEFIANCE               = 102;
  C_SPELL_DESTRUCTIVESURGE       = 103;
  C_SPELL_GEOMANIPULATION        = 104;
  C_SPELL_SUMMONJINSKELETON      = 105;
  C_SPELL_MIGHT                  = 106;
  C_SPELL_INTERCHANGE            = 107;
  C_SPELL_BECKON                 = 108;
  C_SPELL_ASSAULT                = 109;
  C_SPELL_GREATFROZENEARTH       = 110;
  C_SPELL_CHAINLIGHTNING         = 111;
  C_SPELL_RENOUNCE               = 112;
  C_SPELL_METEORSHOWER           = 113;
  C_SPELL_TEMPEST                = 114;
  C_SPELL_PURIFICATION           = 120;
  C_SPELL_TRANSPARENCY           = 121;
  C_SPELL_CELESTIALLIGHT         = 122;
  C_SPELL_STRENGTHOFFAITH        = 123;
  C_SPELL_GREATERTAOEXPLOSION    = 124;


 (****************************************************
  *        ... Consts                          *
  ****************************************************)
  POISON_DEC_HEALTH              = 0;
  POISON_DAMAGE_ARMOR            = 1;
  POISON_LOCK_SPELL              = 2;
  POISON_DONT_MOVE               = 4;
  POISON_STONE                   = 5;
  POISON_ICE                     = 6;

 (****************************************************
  *        ... Consts                          *
  ****************************************************)
  STATE_TRANSPARENT              = 8;
  STATE_DEFENCEUP                = 9;
  STATE_MAGDEFENCEUP             = 10;
  STATE_BUBBLEDEFENCEUP          = 11;
  STATE_YYFHDEFENCEUP            = 12;
  STATE_MYWZ                     = 13;

 (****************************************************
  *        ... Consts                          *
  ****************************************************)
  USERMODE_PLAYGAME              = 1;
  USERMODE_LOGIN                 = 2;
  USERMODE_LOGOFF                = 3;
  USERMODE_NOTICE                = 4;

 (****************************************************
  *        ... Consts                          *
  ****************************************************)
  OS_MOVINGOBJECT                = 1;
  OS_ITEMOBJECT                  = 2;
  OS_EVENTOBJECT                 = 3;
  OS_GATEOBJECT                  = 4;
  OS_SWITCHOBJECT                = 5;
  OS_MAPEVENT                    = 6;
  OS_DOOR                        = 7;
  OS_ROON                        = 8;

 (****************************************************
  *        ... Consts                          *
  ****************************************************)
  RC_PLAYOBJECT                  = 0;
  RC_PLAYMOSTER                  = 150;
  RC_HEROOBJECT                  = 66;
  RC_GUARD                       = 12;
  RC_PEACENPC                    = 15;
  RC_ANIMAL                      = 50;
  RC_MONSTER                     = 80;
  RC_NPC                         = 10;
  RC_ARCHERGUARD                 = 112;

 (****************************************************
  *        ... Consts                          *
  ****************************************************)
  RCC_USERHUMAN                  = RC_PLAYOBJECT;
  RCC_GUARD                      = RC_GUARD;
  RCC_MERCHANT                   = RC_ANIMAL;

 (****************************************************
  *        ... Consts                          *
  ****************************************************)
  ISM_WHISPER                    = 1234;

 (****************************************************
  *        ... Consts                          *
  ****************************************************)
  C_GAME_800_600                 = 1;
  C_GAME_1024_768                = 2;

{$REGION ' - Server Message Protocol Consts     '}
 (****************************************************
  *        Server Message Protocol Consts            *
  ****************************************************)
  SM_HORSEWALK                   = 4;
  SM_HORSE_WALK                  = 4; // <-- LomCN Client
  SM_HORSERUN                    = 5;
  SM_HORSE_RUN                   = 5; // <-- LomCN Client
  SM_RUSH                        = 6;
  SM_RUSHKUNG                    = 7;
  SM_FIREHIT                     = 8;
  SM_BACKSTEP                    = 9;
  SM_TURN                        = 10;
  SM_WALK                        = 11;
  SM_SITDOWN                     = 12;
  SM_RUN                         = 13;
  SM_HIT                         = 14;
  SM_HEAVYHIT                    = 15;
  SM_HEAVY_HIT                   = 15; // <-- LomCN Client
  SM_BIGHIT                      = 16;
  SM_SPELL                       = 17;
  SM_POWERHIT                    = 18;
  SM_LONGHIT                     = 19;
  SM_DIGUP                       = 20;
  SM_DIGDOWN                     = 21;
  SM_FLYAXE                      = 22;
  SM_LIGHTING                    = 23;
  SM_WIDEHIT                     = 24;
  SM_CRSHIT                      = 25;
  SM_TWINHIT                     = 26;
  SM_ALIVE                       = 27;
  SM_MOVEFAIL                    = 28;
  SM_HIDE                        = 29;
  SM_DISAPPEAR                   = 30;
  SM_STRUCK                      = 31;
  SM_DEATH                       = 32;
  SM_SKELETON                    = 33;
  SM_NOWDEATH                    = 34;
  SM_NOW_DEATH                   = 34;
  SM_34SKILLHIT                  = 35;
  SM_35SKILLHIT                  = 36;
  SM_103SKILLHIT                 = 37;
  SM_REMOTEHIT                   = 38;
  SM_MONSPELL                    = 39;
  SM_HEAR                        = 40;
  SM_FEATURECHANGED              = 41;
  SM_USERNAME                    = 42;
  SM_WINEXP                      = 44;
  SM_LEVELUP                     = 45;
  SM_DAYCHANGING                 = 46;
  SM_MONSPELLEFF                 = 47;
  SM_SHOWEFF                     = 48;
  SM_MAGICEFF                    = 49;
  SM_LOGON                       = 50;
  SM_SERVER_LOGON                = 50; //<-- LomCN Client
  SM_NEWMAP                      = 51;
  SM_NEW_MAP                     = 51; // <-- LomCN Client  
  SM_ABILITY                     = 52;
  SM_HEALTHSPELLCHANGED          = 53;
  SM_MAPDESCRIPTION              = 54;
  SM_GAMEGOLDNAME                = 55;
  SM_MONSTERABILITY              = 56;
  SM_SOUND                       = 57;
  SM_CHANGESUCCESS               = 58;
  SM_SETBUTTON                   = 59;
  SM_PUTDOWNFAIL                 = 60;
  SM_PUTDOWNDIAMONDFAIL          = 61;
  SM_CRYWORLD                    = 98;
  SM_ITEMREALIVE                 = 99;
  SM_SYSMESSAGE                  = 100;
  SM_GROUPMESSAGE                = 101;
  SM_CRY                         = 102;
  SM_WHISPER                     = 103;
  SM_GUILDMESSAGE                = 104;
  SM_GUILDFLAG                   = 105;
  SM_BUFF                        = 106;
  SM_DKSUCCESS                   = 107;
  SM_DKFAIL                      = 108;
  SM_XQSUCCESS                   = 109;
  SM_XQFAIL                      = 110;
  SM_PXTBSEND                    = 111;
  SM_SPELL2                      = 117;
  SM_ADDITEM                     = 200;
  SM_BAGITEMS                    = 201;
  SM_DELITEM                     = 202;
  SM_UPDATEITEM                  = 203;
  SM_ITEMCHANGECOUNT             = 204;
  SM_ADDMAGIC                    = 210;
  SM_SENDMYMAGIC                 = 211;
  SM_DELMAGIC                    = 212;
  SM_106SKILL                    = 213;
  SM_ACTION_MIN                  = SM_RUSH;
  SM_ACTION_MAX                  = SM_WIDEHIT;
  SM_ACTION2_MIN                 = 65072;
  SM_ACTION2_MAX                 = 65073;
  SM_GAME_OPTION                 = 499;
  SM_CERTIFICATION_FAIL          = 501;
  SM_ID_NOTFOUND                 = 502;
  SM_PASSWD_FAIL                 = 503;
  SM_LOGIN_PASSWORD_FAIL         = 503; // <-- LomCN Client
  SM_NEWID_SUCCESS               = 504;
  SM_NEWID_FAIL                  = 505;
  SM_CHGPASSWD_SUCCESS           = 506;
  SM_CHGPASSWD_FAIL              = 507;
  SM_GETBACKPASSWD_SUCCESS       = 508;
  SM_GETBACKPASSWD_FAIL          = 509;
  SM_QUERYCHR                    = 520;
  SM_NEWCHR_SUCCESS              = 521;
  SM_NEWCHR_FAIL                 = 522;
  SM_DELCHR_SUCCESS              = 523;
  SM_DELCHR_FAIL                 = 524;
  SM_STARTPLAY                   = 525;
  SM_STARTFAIL                   = 526;
  SM_QUERYCHR_FAIL               = 527;
  SM_OUTOFCONNECTION             = 528;
  SM_PASSOK_SELECTSERVER         = 529;
  SM_LOGIN_PASSWORD_OK           = 529; // <-- LomCN Client
  SM_SELECTSERVER_OK             = 530;
  SM_NEEDUPDATE_ACCOUNT          = 531;
  SM_UPDATEID_SUCCESS            = 532;
  SM_UPDATEID_FAIL               = 533;
  SM_DROPITEM_SUCCESS            = 600;
  SM_DROPITEM_FAIL               = 601;
  SM_EATITEM                     = 609;
  SM_ITEMSHOW                    = 610;
  SM_ITEMHIDE                    = 611;
  SM_OPENDOOR_OK                 = 612;
  SM_OPENDOOR_LOCK               = 613;
  SM_CLOSEDOOR                   = 614;
  SM_TAKEON_OK                   = 615;
  SM_TAKEON_FAIL                 = 616;
  SM_EAT_DEC                     = 617;
  SM_TAKEOFF_OK                  = 619;
  SM_TAKEOFF_FAIL                = 620;
  SM_SENDUSEITEMS                = 621;
  SM_WEIGHTCHANGED               = 622;
  SM_CLEAROBJECTS                = 633;
  SM_CHANGEMAP                   = 634;
  SM_CHANGE_MAP                  = 634; // <-- LomCN Client
  SM_EAT_OK                      = 635;
  SM_EAT_FAIL                    = 636;
  SM_BUTCH                       = 637;
  SM_MAGICFIRE                   = 638;
  SM_MAGICFIRE_FAIL              = 639;
  SM_MAGIC_LVEXP                 = 640;
  SM_DURACHANGE                  = 642;
  SM_MERCHANTSAY                 = 643;
  SM_MERCHANTDLGCLOSE            = 644;
  SM_SENDGOODSLIST               = 645;
  SM_SENDUSERSELL                = 646;
  SM_SENDBUYPRICE                = 647;
  SM_USERSELLITEM_OK             = 648;
  SM_USERSELLITEM_FAIL           = 649;
  SM_BUYITEM_SUCCESS             = 650;
  SM_BUYITEM_FAIL                = 651;
  SM_SENDDETAILGOODSLIST         = 652;
  SM_GOLDCHANGED                 = 653;
  SM_CHANGELIGHT                 = 654;
  SM_LAMPCHANGEDURA              = 655;
  SM_CHANGENAMECOLOR             = 656;
  SM_CHARSTATUSCHANGED           = 657;
  SM_SENDNOTICE                  = 658;
  SM_GROUPMODECHANGED            = 659;
  SM_CREATEGROUP_OK              = 660;
  SM_CREATEGROUP_FAIL            = 661;
  SM_GROUPADDMEM_OK              = 662;
  SM_GROUPDELMEM_OK              = 663;
  SM_GROUPADDMEM_FAIL            = 664;
  SM_GROUPDELMEM_FAIL            = 665;
  SM_GROUPCANCEL                 = 666;
  SM_GROUPMEMBERS                = 667;
  SM_SENDUSERREPAIR              = 668;
  SM_USERREPAIRITEM_OK           = 669;
  SM_USERREPAIRITEM_FAIL         = 670;
  SM_SENDREPAIRCOST              = 671;
  SM_DEALMENU                    = 673;
  SM_DEALTRY_FAIL                = 674;
  SM_DEALADDITEM_OK              = 675;
  SM_DEALADDITEM_FAIL            = 676;
  SM_DEALDELITEM_OK              = 677;
  SM_DEALDELITEM_FAIL            = 678;
  SM_DEALCANCEL                  = 681;
  SM_DEALREMOTEADDITEM           = 682;
  SM_DEALREMOTEDELITEM           = 683;
  SM_DEALCHGGOLD_OK              = 684;
  SM_DEALCHGGOLD_FAIL            = 685;
  SM_DEALREMOTECHGGOLD           = 686;
  SM_DEALSUCCESS                 = 687;
  SM_SENDUSERSTORAGEITEM         = 700;
  SM_STORAGE_OK                  = 701;
  SM_STORAGE_FULL                = 702;
  SM_STORAGE_FAIL                = 703;
  SM_SAVEITEMLIST                = 704;
  SM_TAKEBACKSTORAGEITEM_OK      = 705;
  SM_TAKEBACKSTORAGEITEM_FAIL    = 706;
  SM_TAKEBACKSTORAGEITEM_FULLBAG = 707;
  SM_AREASTATE                   = 708;
  SM_DELITEMS                    = 709;
  SM_READMINIMAP_OK              = 710;
  SM_READMINIMAP_FAIL            = 711;
  SM_SENDUSERMAKEDRUGITEMLIST    = 712;
  SM_MAKEDRUG_SUCCESS            = 713;
  SM_MAKEDRUG_FAIL               = 65036;
  SM_CHANGEGUILDNAME             = 750;
  SM_SENDUSERSTATE               = 751;
  SM_SUBABILITY                  = 752;
  SM_OPENGUILDDLG                = 753;
  SM_OPENGUILDDLG_FAIL           = 754;
  SM_SENDGUILDMEMBERLIST         = 756;
  SM_GUILDADDMEMBER_OK           = 757;
  SM_GUILDADDMEMBER_FAIL         = 758;
  SM_GUILDDELMEMBER_OK           = 759;
  SM_GUILDDELMEMBER_FAIL         = 760;
  SM_GUILDRANKUPDATE_FAIL        = 761;
  SM_BUILDGUILD_OK               = 762;
  SM_BUILDGUILD_FAIL             = 763;
  SM_DONATE_OK                   = 764;
  SM_DONATE_FAIL                 = 765;
  SM_MYSTATUS                    = 766;
  SM_MENU_OK                     = 767;
  SM_GUILDMAKEALLY_OK            = 768;
  SM_GUILDMAKEALLY_FAIL          = 769;
  SM_GUILDBREAKALLY_OK           = 770;
  SM_GUILDBREAKALLY_FAIL         = 771;
  SM_DLGMSG                      = 772;
  SM_WEAPONSTRONG                = 799;
  SM_SPACEMOVE_HIDE              = 800;
  SM_SPACEMOVE_SHOW              = 801;
  SM_RECONNECT                   = 802;
  SM_GHOST                       = 803;
  SM_SHOWEVENT                   = 804;
  SM_HIDEEVENT                   = 805;
  SM_SPACEMOVE_HIDE2             = 806;
  SM_SPACEMOVE_SHOW2             = 807;
  SM_SPACEMOVE_SHOW3             = 808;
  SM_SPACEMOVE_HIDE3             = 809;
  SM_TIMECHECK_MSG               = 810;
  SM_ADJUST_BONUS                = 811;
  SM_OPENHEALTH                  = 1100;
  SM_CLOSEHEALTH                 = 1101;
  SM_BREAKWEAPON                 = 1102;
  SM_INSTANCEHEALGUAGE           = 1103;
  SM_CHANGEFACE                  = 1104;
  SM_VERSION_FAIL                = 1106;
  SM_ITEMUPDATE                  = 1500;
  SM_MONSTERSAY                  = 1501;
  SM_EXCHGTAKEON_OK              = 65023;
  SM_EXCHGTAKEON_FAIL            = 65024;
  SM_TEST                        = 65037;
  SM_DEVELOPMENT                 = 65037;
  SM_TESTHERO                    = 65038;
  SM_THROW                       = 65069;
  SM_716                         = 716;
  SM_PASSWORD                    = 3030;
  SM_PLAYDICE                    = 1200;
  SM_SERVERCONFIG                = 20002;
  SM_GETREGINFO                  = 20003;
  SM_NEEDPASSWORD                = 8003;
  SM_RANDOMCODE                  = 2007;
  SM_ACTORHP                     = 6001;
  SM_BUYSHOPITEM_SUCCESS         = 9003;
  SM_BUYSHOPITEM_FAIL            = 9004;
  SM_SENGSHOPITEMS               = 9001;
  SM_QUERYUSERLEVELSORT          = 2500;
  SM_SENDSELLOFFGOODSLIST        = 20008;
  SM_SENDUSERSELLOFFITEM         = 20005;
  SM_SENDBUYSELLOFFITEM_OK       = 20010;
  SM_SENDBUYSELLOFFITEM_FAIL     = 20011;
  SM_SENDUSERSELLOFFITEM_FAIL    = 20007;
  SM_SENDUSERSELLOFFITEM_OK      = 20006;
  SM_HEROLOGOUT                  = 5003;
  SM_CREATEHERO                  = 5004;
  SM_HERODEATH                   = 5005;
  SM_RECALLHERO                  = 5001;
  SM_HEROTAKEON_OK               = 5015;
  SM_HEROTAKEON_FAIL             = 5016;
  SM_HEROTAKEOFF_OK              = 5017;
  SM_HEROTAKEOFF_FAIL            = 5018;
  SM_TAKEOFFTOHEROBAG_OK         = 5019;
  SM_TAKEOFFTOHEROBAG_FAIL       = 5020;
  SM_TAKEOFFTOMASTERBAG_OK       = 5021;
  SM_TAKEOFFTOMASTERBAG_FAIL     = 5022;
  SM_SENDITEMTOMASTERBAG_OK      = 5025;
  SM_SENDITEMTOMASTERBAG_FAIL    = 5026; 
  SM_SENDITEMTOHEROBAG_OK        = 5027; 
  SM_SENDITEMTOHEROBAG_FAIL      = 5028;
  SM_QUERYHEROBAGCOUNT           = 5030;
  SM_SENDHEROUSEITEMS            = 5032;
  SM_HEROBAGITEMS                = 5033;
  SM_HEROADDITEM                 = 5034;
  SM_HERODELITEM                 = 5035;
  SM_HEROUPDATEITEM              = 5036;
  SM_HEROADDMAGIC                = 5037;
  SM_HEROSENDMYMAGIC             = 5038;
  SM_HERODELMAGIC                = 5039;
  SM_HEROABILITY                 = 5040;
  SM_HEROSUBABILITY              = 5041;
  SM_HEROWEIGHTCHANGED           = 5042;
  SM_HEROEAT_OK                  = 5044;
  SM_HEROEAT_FAIL                = 5045;
  SM_HEROMAGIC_LVEXP             = 5046;
  SM_HERODURACHANGE              = 5047;
  SM_HEROWINEXP                  = 5048;
  SM_HEROLEVELUP                 = 5049;
  SM_HEROCHANGEITEM              = 5050;
  SM_HERODELITEMS                = 5051;
  SM_HERODROPITEM_SUCCESS        = 5053;
  SM_HERODROPITEM_FAIL           = 5054;
  SM_GOTETHERUSESPELL            = 5056;
  SM_FIRDRAGONPOINT              = 5057;
  SM_REPAIRFIRDRAGON_OK          = 5059;
  SM_REPAIRFIRDRAGON_FAIL        = 5060;

{$ENDREGION}

{$REGION ' - Remote Message Protocol Consts     '}
  (****************************************************
  *        Remote Message Protocol Consts            *
  ****************************************************)
  RM_SOUND                       = 8997;
  RM_MAGICEFF                    = 8998;
  RM_106SKILL                    = 8999;
  RM_SHOWEFF                     = 9003;
  RM_DELITEMS                    = 9000;
  RM_MONSPELL                    = 9001;
  RM_MONSPELLEFF                 = 9002;
  RM_REMOTEHIT                   = 10000;
  RM_TURN                        = 10001;
  RM_WALK                        = 10002;
  RM_RUN                         = 10003;
  RM_HIT                         = 10004;
  RM_HEAVYHIT                    = 10005;
  RM_BIGHIT                      = 10006;
  RM_SPELL                       = 10007;
  RM_SPELL2                      = 10008;
  RM_POWERHIT                    = 10009;
  RM_MOVEFAIL                    = 10010;
  RM_CRSHIT                      = 11014;
  RM_RUSHKUNG                    = 11015;
  RM_LONGHIT                     = 10011;
  RM_WIDEHIT                     = 10012;
  RM_PUSH                        = 10013;
  RM_FIREHIT                     = 10014;
  RM_RUSH                        = 10015;
  RM_34HIT                       = 10016;
  RM_35HIT                       = 10017;
  RM_103HIT                      = 10018;
  RM_STRUCK                      = 10020;
  RM_DEATH                       = 10021;
  RM_DISAPPEAR                   = 10022;
  RM_MAGSTRUCK                   = 10025;
  RM_MAGHEALING                  = 10026;
  RM_STRUCK_MAG                  = 10027;
  RM_MAGSTRUCK_MINE              = 10028;
  RM_INSTANCEHEALGUAGE           = 10029;
  RM_HEAR                        = 10030;
  RM_WHISPER                     = 10031;
  RM_CRY                         = 10032;
  RM_RIDE                        = 10033;
  RM_CRYWORLD                    = 10034;
  RM_WINEXP                      = 10044;
  RM_USERNAME                    = 10043;
  RM_LEVELUP                     = 10045;
  RM_CHANGENAMECOLOR             = 10046;
  RM_LOGON                       = 10050;
  RM_ABILITY                     = 10051;
  RM_HEALTHSPELLCHANGED          = 10052;
  RM_DAYCHANGING                 = 10053;
  RM_SYSMESSAGE                  = 10100;
  RM_GROUPMESSAGE                = 10102;
  RM_SYSMESSAGE2                 = 10103;
  RM_GUILDMESSAGE                = 10104;
  RM_SYSMESSAGE3                 = 10105;
  RM_GUILDFLAG                   = 10106;
  RM_ITEMSHOW                    = 10110;
  RM_ITEMHIDE                    = 10111;
  RM_DOOROPEN                    = 10112;
  RM_DOORCLOSE                   = 10113;
  RM_SENDUSEITEMS                = 10114;
  RM_WEIGHTCHANGED               = 10115;
  RM_FEATURECHANGED              = 10116;
  RM_CLEAROBJECTS                = 10117;
  RM_CHANGEMAP                   = 10118;
  RM_BUTCH                       = 10119;
  RM_MAGICFIRE                   = 10120;
  RM_MAGICFIREFAIL               = 10121;
  RM_SENDMYMAGIC                 = 10122;
  RM_MAGIC_LVEXP                 = 10123;
  RM_SKELETON                    = 10024;
  RM_DURACHANGE                  = 10125;
  RM_MERCHANTSAY                 = 10126;
  RM_MERCHANTDLGCLOSE            = 10127;
  RM_SENDGOODSLIST               = 10128;
  RM_SENDUSERSELL                = 10129;
  RM_SENDBUYPRICE                = 10130;
  RM_USERSELLITEM_OK             = 10131;
  RM_USERSELLITEM_FAIL           = 10132;
  RM_BUYITEM_SUCCESS             = 10133;
  RM_BUYITEM_FAIL                = 10134;
  RM_SENDDETAILGOODSLIST         = 10135;
  RM_GOLDCHANGED                 = 10136;
  RM_CHANGELIGHT                 = 10137;
  RM_LAMPCHANGEDURA              = 10138;
  RM_CHARSTATUSCHANGED           = 10139;
  RM_GROUPCANCEL                 = 10140;
  RM_SENDUSERSREPAIR             = 10141;
  RM_SENDREPAIRCOST              = 10142;
  RM_USERREPAIRITEM_OK           = 10143;
  RM_USERREPAIRITEM_FAIL         = 10144;
  RM_EATITEM                     = 10145;
  RM_USERSTORAGEITEM             = 10146;
  RM_USERGETBACKITEM             = 10147;
  RM_SENDDELITEMLIST             = 10148;
  RM_USERMAKEDRUGITEMLIST        = 10149;
  RM_MAKEDRUG_SUCCESS            = 10150;
  RM_MAKEDRUG_FAIL               = 10151;
  RM_DELAYMAGIC                  = 10154;
  RM_10155                       = 10155;
  RM_DELAYMAGICEFF               = 10156;
  RM_DELAYMONEFF                 = 10157;
  RM_DIGUP                       = 10200;
  RM_DIGDOWN                     = 10201;
  RM_FLYAXE                      = 10202;
  RM_LIGHTING                    = 10204;
  RM_SUBABILITY                  = 10302;
  RM_DONATE_FAIL                 = 10306;
  RM_TRANSPARENT                 = 10308;
  RM_SPACEMOVE_SHOW              = 10331;
  RM_RECONNECTION                = 10330;
  RM_SPACEMOVE_SHOW2             = 10332;
  RM_SPACEMOVE_SHOW3             = 10335;
  RM_HIDEEVENT                   = 10333;
  RM_SHOWEVENT                   = 10334;
  RM_ZEN_BEE                     = 10337;
  RM_OPENHEALTH                  = 10410;
  RM_CLOSEHEALTH                 = 10411;
  RM_DOOPENHEALTH                = 10412;
  RM_BREAKWEAPON                 = 10413;
  RM_CHANGEFACE                  = 10415;
  RM_PASSWORD                    = 10416;
  RM_ITEMUPDATE                  = 11000;
  RM_MONSTERSAY                  = 11001;
  RM_MAKESLAVE                   = 11002;
  RM_MONMOVE                     = 21004;
  RM_10205                       = 10205;
  RM_10101                       = 10101;
  RM_ALIVE                       = 10153;
  RM_CHANGEGUILDNAME             = 10301;
  RM_10414                       = 10414;
  RM_POISON                      = 10300;
  RM_DELAYPUSHED                 = 10555;
  RM_10401                       = 10401;
  RM_MENU_OK                     = 10309;
  RM_SENDUSERREPAIR              = 11139;
  RM_USERBIGSTORAGEITEM          = 20146;
  RM_USERBIGGETBACKITEM          = 20147;
  RM_USERLEVELORDER              = 20148;
  RM_SPACEMOVE_FIRE2             = 11330;
  RM_SPACEMOVE_FIRE              = 11331;
  RM_SPACEMOVE_FIRE3             = 11332;
  RM_PLAYDICE                    = 10500;
  RM_ADJUST_BONUS                = 10400;
  RM_BUILDGUILD_OK               = 10303;
  RM_BUILDGUILD_FAIL             = 10304;
  RM_DONATE_OK                   = 10305;
  RM_GAMEGOLDCHANGED             = 10666;
  RM_MYSTATUS                    = 10777;
  RM_HORSERUN                    = 11000;
  RM_41                          = 41;
  RM_42                          = 42;
  RM_43                          = 43;
  RM_QUERYUSERLEVELSORT          = 35000;
  RM_SENDSELLOFFGOODSLIST        = 21008;
  RM_SENDUSERSELLOFFITEM         = 21005;
  RM_SENDSELLOFFITEMLIST         = 22009;
  RM_SENDBUYSELLOFFITEM_OK       = 21010;
  RM_SENDBUYSELLOFFITEM_FAIL     = 21011;
  RM_SENDSELLOFFITEM             = 41004;
  RM_SENDBUYSELLOFFITEM          = 41005;
  RM_SENDQUERYSELLOFFITEM        = 41006;
  RM_SENDUSERSELLOFFITEM_FAIL    = 2007;
  RM_SENDUSERSELLOFFITEM_OK      = 2006;
  RM_RECALLHERO                  = 19999;
  RM_HEROWEIGHTCHANGED           = 20000;
  RM_SENDHEROUSEITEMS            = 20001;
  RM_SENDHEROMYMAGIC             = 20002;
  RM_HEROMAGIC_LVEXP             = 20003;
  RM_QUERYHEROBAGCOUNT           = 20004;
  RM_HEROABILITY                 = 20005;
  RM_HERODURACHANGE              = 20006;
  RM_HERODEATH                   = 20007;
  RM_HEROLEVELUP                 = 20008;
  RM_HEROWINEXP                  = 20009;
  RM_HEROLOGOUT                  = 20010;
  RM_CREATEHERO                  = 20011;
  RM_MAKEGHOSTHERO               = 20012;
  RM_HEROSUBABILITY              = 20013;
  RM_GOTETHERUSESPELL            = 20014;
  RM_FIRDRAGONPOINT              = 20015;
  RM_CHANGETURN                  = 20016;

  LA_UNDEAD                      = 1;
{$ENDREGION}

{$REGION ' - SS Message Protocol Consts         '}
  (****************************************************
  *        SS Message Protocol Consts                 *
  ****************************************************)
  SS_200                         = 200;
  SS_201                         = 201;
  SS_202                         = 202;
  SS_WHISPER                     = 203;
  SS_204                         = 204;
  SS_205                         = 205;
  SS_206                         = 206;
  SS_207                         = 207;
  SS_208                         = 208;
  SS_209                         = 219;
  SS_210                         = 210;
  SS_211                         = 211;
  SS_212                         = 212;
  SS_213                         = 213;
  SS_214                         = 214;
{$ENDREGION}

{$REGION ' - Client Message Protocol Consts     '}
  (****************************************************
  *        Client Message Protocol Consts             *
  ****************************************************)
  CM_POWERBLOCK                  = 0;
  CM_GETBACKPASSWORD             = 2010;
  CM_QUERYUSERNAME               = 80;
  CM_QUERYBAGITEMS               = 81;
  CM_QUERYUSERSTATE              = 82;
  CM_ITEMDAKON                   = 83;
  CM_ITEMXIANQIAN                = 84;
  CM_PUTDOWNCL                   = 85;
  CM_PUTDOWNDIAMOND              = 86;
  CM_CHOICEITEM                  = 87;
  CM_QUERY_CHAR                  = 100;
  CM_NEW_CHAR                    = 101;
  CM_DELETE_CHAR                 = 102;
  CM_SELECT_CHAR                 = 103;
  CM_SELECTSERVER                = 104;
  CM_NPC                         = 105;
  CM_DROPITEM                    = 1000;
  CM_PICKUP                      = 1001;
  CM_OPENDOOR                    = 1002;
  CM_TAKEONITEM                  = 1003;
  CM_TAKEOFFITEM                 = 1004;
  CM_QUERYSX                     = 1005;
  CM_EAT                         = 1006;
  CM_BUTCH                       = 1007;
  CM_MAGICKEYCHANGE              = 1008;
  CM_SOFTCLOSE                   = 1009;
  CM_CLICKNPC                    = 1010;
  CM_MERCHANTDLGSELECT           = 1011;
  CM_MERCHANTQUERYSELLPRICE      = 1012;
  CM_USERSELLITEM                = 1013;
  CM_USERBUYITEM                 = 1014;
  CM_USERGETDETAILITEM           = 1015;
  CM_DROPGOLD                    = 1016;
  CM_1017                        = 1017;
  CM_LOGINNOTICEOK               = 1018;
  CM_GROUPMODE                   = 1019;
  CM_CREATEGROUP                 = 1020;
  CM_ADDGROUPMEMBER              = 1021;
  CM_DELGROUPMEMBER              = 1022;
  CM_USERREPAIRITEM              = 1023;
  CM_MERCHANTQUERYREPAIRCOST     = 1024;
  CM_DEALTRY                     = 1025;
  CM_DEALADDITEM                 = 1026;
  CM_DEALDELITEM                 = 1027;
  CM_DEALCANCEL                  = 1028;
  CM_DEALCHGGOLD                 = 1029;
  CM_DEALEND                     = 1030;
  CM_USERSTORAGEITEM             = 1031;
  CM_USERTAKEBACKSTORAGEITEM     = 1032;
  CM_WANTMINIMAP                 = 1033;
  CM_USERMAKEDRUGITEM            = 1034;
  CM_OPENGUILDDLG                = 1035;
  CM_GUILDHOME                   = 1036;
  CM_GUILDMEMBERLIST             = 1037;
  CM_GUILDADDMEMBER              = 1038;
  CM_GUILDDELMEMBER              = 1039;
  CM_GUILDUPDATENOTICE           = 1040;
  CM_GUILDUPDATERANKINFO         = 1041;
  CM_ADJUST_BONUS                = 1043;
  CM_SPEEDHACKUSER               = 10430;
  CM_GUILDALLY                   = 1044;
  CM_GUILDBREAKALLY              = 1045;
  CM_ITEMFENJAI                  = 1046;
  CM_PASSWORD                    = 1105;
  CM_CHGPASSWORD                 = 1221;
  CM_SETPASSWORD                 = 1222;
  CM_PROTOCOL                    = 2000;
  CM_IDPASSWORD                  = 2001;
  CM_ADDNEWUSER                  = 2002;
  CM_CHANGEPASSWORD              = 2003;
  CM_UPDATEUSER                  = 2004;
  CM_RANDOMCODE                  = 2006;
  CM_CLOSEUSER                   = 2007;
  CM_THROW                       = 3005;
  CM_HORSEWALK                   = 3008;
  CM_HORSE_WALK                  = 3008;  
  CM_HORSERUN                    = 3009;
  CM_HORSE_RUN                   = 3009;
  CM_TURN                        = 3010;
  CM_WALK                        = 3011;
  CM_SITDOWN                     = 3012;
  CM_RUN                         = 3013;
  CM_HIT                         = 3014;
  CM_HEAVYHIT                    = 3015;
  CM_BIGHIT                      = 3016;
  CM_SPELL                       = 3017;
  CM_POWERHIT                    = 3018;
  CM_LONGHIT                     = 3019;
  CM_REMOTEHIT                   = 3020;
  CM_WIDEHIT                     = 3024;
  CM_FIREHIT                     = 3025;
  CM_34SKILLHIT                  = 3026;
  CM_35SKILLHIT                  = 3027;
  CM_103SKILLHIT                 = 3028;
  CM_SAY                         = 3030;
  CM_CRSHIT                      = 3036;
  CM_TWNHIT                      = 3037;
  CM_TWINHIT                     = CM_TWNHIT;
  CM_PHHIT                       = 3038;
  CM_GAME_OPTION                 = 3040;
  CM_QUERYUSERSET                = 49999;
  CM_OPENSHOP                    = 9000;
  CM_BUYSHOPITEM                 = 9002;
  CM_RECALLHERO                  = 5000;
  CM_HEROLOGOUT                  = 5002;
  CM_ACTORHP                     = 6000;
  CM_QUERYUSERLEVELSORT          = 3500;
  CM_SENDSELLOFFITEM             = 4004;
  CM_SENDBUYSELLOFFITEM          = 4005;
  CM_SENDQUERYSELLOFFITEM        = 4006;
  CM_SENDSELLOFFITEMLIST         = 20009;
  CM_HEROCHGSTATUS               = 5006;
  CM_HEROATTACKTARGET            = 5007;
  CM_HEROPROTECT                 = 5008;
  CM_HEROTAKEONITEM              = 5009;
  CM_HEROTAKEOFFITEM             = 5010;
  CM_TAKEOFFITEMHEROBAG          = 5011;
  CM_TAKEOFFITEMTOMASTERBAG      = 5012;
  CM_SENDITEMTOMASTERBAG         = 5013;
  CM_SENDITEMTOHEROBAG           = 5014;
  CM_HEROGOTETHERUSESPELL        = 5055;
  CM_HERODROPITEM                = 5052;
  CM_HEROEAT                     = 5043;
  CM_QUERYHEROBAGITEMS           = 5031; 
  CM_HEROTAKEONITEMFORMMASTERBAG = 5023;
  CM_TAKEONITEMFORMHEROBAG       = 5024;
  CM_QUERYHEROBAGCOUNT           = 5029;
  CM_REPAIRFIRDRAGON             = 5058;
  CM_HEROGOTETHERUSESPELL2       = 5061;

{$ENDREGION}

{$REGION ' - ET Message Protocol Consts         '}
  (****************************************************
  *        ET Message Protocol Consts                 *
  ****************************************************)
  ET_DIGOUTZOMBI                 = 1;
  ET_PILESTONES                  = 3;
  ET_HOLYCURTAIN                 = 4;
  ET_FIRE                        = 5;
  ET_SCULPEICE                   = 6;
  ET_FIREFLOWER_1                = 7;
  ET_FIREFLOWER_2                = 8;
  ET_FIREFLOWER_3                = 9;
  ET_FIREFLOWER_4                = 10;
  ET_FIREFLOWER_5                = 11;
  ET_FIREFLOWER_6                = 12;
  ET_FIREFLOWER_7                = 13;
  ET_FIREFLOWER_8                = 14;
  ET_FIRER                       = 15;
  ET_ICER                        = 16;
  ET_WALL2                       = 17;
  ET_WALL3                       = 18;
  ET_WALL4                       = 19;
  ET_WALL5                       = 20;
  ET_WALL6                       = 21;
  ET_WALL7                       = 22;
{$ENDREGION}

{$REGION ' - DataBase Message Protocol Consts   '}
  (****************************************************
  *        DataBase Message Protocol Consts           *
  ****************************************************)
  DB_LOADHUMANRCD                = 1000;
  DB_LOADHERORCD                 = 1001;
  DB_QUERYHERORCD                = 1002;
  DB_NEWHERORCD                  = 1003;
  DB_DELHERORCD                  = 1004;
  DB_SAVEHUMANRCD                = 1010;
  DB_SAVEHERORCD                 = 1011;
  DB_SAVEHUMANRCDEX              = 1020;
  DBR_LOADHUMANRCD               = 1100;
  DBR_SAVEHUMANRCD               = 1101;
  DBR_FAIL                       = 1102;
{$ENDREGION}

{$IF HEROVERSION = 1}
  SIZEOFTHUMAN = 6598;
{$ELSE}
  SIZEOFTHUMAN = $C63 - 1;
{$IFEND}

type
  PPowerBlock      = ^TPowerBlock;
  TPowerBlock      = array[0..100 - 1] of Word;
                   
  PCharName        = ^TCharName;
  TCharName        = string[ACTORNAMELEN + 1];
                   
  PHeroName        = ^THeroName;
  THeroName        = string[ACTORNAMELEN * 2 + 2];

  TItemCount       = Integer;
                   
  TMonStatus       = (s_KillHuman, s_UnderFire, s_Die, s_MonGen);
  TMsgColor        = (c_Red, c_Green, c_Blue, c_White, c_Cs);
  TMsgType         = (t_Notice, t_Hint, t_System, t_Say, t_Send, t_Mon, t_GM, t_Cust, t_Castle, t_All);
  TSayMsgType      = (s_NoneMsg, s_GroupMsg, s_GuildMsg, s_SystemMsg, s_NoticeMsg);
  TConnectionStep  = (csLogin, csSelChr, csReSelChr, csNotice, csPlay);
  
  TMIR3_Game_Scene = (gsNone, gsScene_PlayVideo, gsScene_Login, gsScene_SelChar, gsScene_PlayGame);

{$REGION ' - Records  '}

 (****************************************************
  *        Global Option Settings                    *
  ****************************************************)
  PGameOptionSet = ^TGameOptionSet;
  TGameOptionSet = packed record
    // Basic
    gos_Attack_Mode                  : Byte;
    gos_Forced_Attack_Mode           : Boolean;
    gos_Back_Ground_Music            : Boolean;
    gos_Sound_Effects                : Boolean;
    gos_BGM_Volume                   : Byte;
    gos_Sound_FX_Volume              : Byte;	
    gos_Right_Left_Sound             : Boolean;
    gos_Automatic_Picking            : Boolean;
    gos_Name_Of_Dropped_Item         : Boolean;
    gos_Game_Language                : Word;    // need to check the Set System
    gos_not_in_use_A9                : Boolean;
    // Permit
    gos_Permit_Group_Invitation      : Boolean;
    gos_Guild_Joining_Allowed        : Boolean;
    gos_Resurrection_Allowed         : Boolean;
    gos_Recall_Allowed               : Boolean;
    gos_Trading_Allowed              : Boolean;
    //Chatting
    gos_Whispering_Allowed           : Boolean;
    gos_Shouting_Allowed             : Boolean;
    gos_Guild_Message_Allowed        : Boolean;
    gos_Block_Whispering_User        : Integer; // need to check the Set System
    //Visual
    gos_HP_Change_Displayed          : Boolean;
    gos_Magic_Graphic_Effect_Display : Boolean;
    gos_Bright_Shadow                : Boolean;
    gos_Helmet_Display               : Boolean;
    gos_Monster_Effect_Display       : Boolean;
    gos_Dyed_Hair_Display            : Boolean;
    gos_Display_Avatar               : Boolean;
    gos_Minimap_Monster_Display      : Boolean;
    gos_HP_Gauge_Display             : Boolean;
    gos_Display_Monster_HP           : Boolean;   
    gos_Blood_Display                : Boolean;	
    gos_ShowHealthActionStatus       : Boolean;
  end;


  PMir3Character = ^TMir3Character;
  TMir3Character = record
    Char_Select : Boolean;                                                 
    Char_Delete : Boolean;
    Char_Found  : Boolean;
    Char_Name   : String[50];
    Char_Job    : Byte;
    Char_Hair   : Byte;
    Char_Exp    : String[50];//Double;
    Char_Gold   : Cardinal;
    Char_Level  : Word;
    Char_Gender : Byte;
  end;

  { TMir3CharacterList }
  PMir3CharacterList = ^TMir3CharacterList;
  TMir3CharacterList = record
    CharSelect   : Integer;
    CharName     : String[50];
    {Character 1}
    Char_1_Found : Boolean;
    Char_1_Info  : TMir3Character;
    {Character 2}
    Char_2_Found : Boolean;
    Char_2_Info  : TMir3Character;
    {Character 3}
    Char_3_Found : Boolean;
    Char_3_Info  : TMir3Character;
  end;

  { TOldDefaultMessage }
  POldDefaultMessage = ^TOldDefaultMessage;
  TOldDefaultMessage = record //16 bit
    Recog    : Integer;
    Ident    : Word;
    Param    : Word;
    Tag      : Word;
    Series   : Word;
  end;

  { TDefaultMessage }
  PDefaultMessage = ^TDefaultMessage;
  TDefaultMessage = record //32 bit
    Recog    : Integer;
    Ident    : Integer;
    Param    : Integer;
    Tag      : Integer;
    Series   : Integer;
  end;

  { TPaiHan }
  PPaiHan = ^TPaiHan;
  TPaiHan = packed record
    sName      : String[14];
    sJob       : String[4];
    nLevel     : Integer;
    nShengWang : Integer;
    nGold      : Integer;
    nExp       : Integer;
  end;

  { TAllPaiHan }
  PAllPaiHan = ^TAllPaiHan;
  TAllPaiHan = packed record
    ToTal     : array[0..29] of TPaiHan;
    War       : array[0..29] of TPaiHan;
    Wiz       : array[0..29] of TPaiHan;
    Tao       : array[0..29] of TPaiHan;
    Assas     : array[0..29] of TPaiHan;
    Gold      : array[0..29] of TPaiHan;
    ShengWang : array[0..29] of TPaiHan;
    boRefresh : Boolean;
  end;

  { TOSObject }
  POSObject = ^TOSObject;
  TOSObject = record
    btType          : Byte;
    CellObj         : TObject;
    dwAddTime       : LongWord;
    boObjectDispose : Boolean;
  end;

  { TSendMessage }
  PSendMessage = ^TSendMessage;
  TSendMessage = record
    wIdent         : Word;
    wParam         : Integer;
    nParam1        : Integer;
    nParam2        : Integer;
    nParam3        : Integer;
    BaseObject     : TObject;
    dwAddTime      : LongWord;
    dwDeliveryTime : LongWord;
    boLateDelivery : Boolean;
    Buff           : PChar;
  end;

  { TProcessMessage }
  PProcessMessage = ^TProcessMessage;
  TProcessMessage = record
    wIdent         : Word;
    wParam         : Integer;
    nParam1        : Integer;
    nParam2        : Integer;
    nParam3        : Integer;
    BaseObject     : TObject;
    boLateDelivery : Boolean;
    dwDeliveryTime : LongWord;
    sMsg           : String;
  end;

  { TLoadHuman }
  PLoadHuman = ^TLoadHuman;
  TLoadHuman = record
    sAccount    : String[12];
    sChrName    : String[ACTORNAMELEN];
    sUserAddr   : String[15];
    nSessionID  : Integer;
  end;

  { TShortMessage }
  PShortMessage = ^TShortMessage;
  TShortMessage = record
    Ident   : Word;
    wMsg    : Word;
  end;

  { TMessageBodyW }
  PMessageBodyW = ^TMessageBodyW;
  TMessageBodyW = record
    Param1 : Word;
    Param2 : Word;
    Tag1   : Word;
    Tag2   : Word;
  end;

  { TMessageBodyWL }
  PMessageBodyWL = ^TMessageBodyWL;
  TMessageBodyWL = record
    lParam1 : Integer;
    lParam2 : Integer;
    lTag1   : Integer;
    lTag2   : Integer;
  end;

  { TCharDesc }
  PCharDesc = ^TCharDesc;
  TCharDesc = record
    feature   : Integer;
    featureEx : Integer;
    Status    : Integer;
    Eff       : array [0..1] of Integer;
    fighteff  : Integer;
  end;

  { TSessInfo }
  PSessInfo = ^TSessInfo;
  TSessInfo = record
    sAccount       : string[12];
    sIPaddr        : string[15];
    nSessionID     : Integer;
    nPayMent       : Integer;
    nPayMode       : Integer;
    nSessionStatus : Integer;
    dwStartTick    : LongWord;
    dwActiveTick   : LongWord;
    nRefCount      : Integer;
  end;

  { TQuestInfo }
  PQuestInfo = ^TQuestInfo;
  TQuestInfo = record
    wFlag      : Word;
    btValue    : Byte;
    nRandRage  : Integer;
  end;

  { TScript }
  PScript = ^TScript;
  TScript = record
    boQuest    : Boolean;
    QuestInfo  : array [0..9] of TQuestInfo;
    nQuest     : Integer;
    RecordList : TList;
  end;

  { TMonItem }
  PMonItem = ^TMonItem;
  TMonItem = record
    n00      : Integer;
    n04      : Integer;
    sMonName : string;
    n18      : Integer;
  end;

  { TItemName }
  PItemName = ^TItemName;
  TItemName = record
    nItemIndex : Integer;
    nMakeIndex : Integer;
    sItemName  : string;
  end;

  { TDynamicVar }
  TVarType = (vNone, vInteger, vString);
  PDynamicVar = ^TDynamicVar;
  TDynamicVar = record
    sName     : String;
    VarType   : TVarType;
    nInternet : Integer;
    sString   : String;
  end;

  { TRecallMigic }
  PRecallMigic = ^TRecallMigic;
  TRecallMigic = record
    nHumLevel : Integer;
    sMonName  : String;
    nCount    : Integer;
    nLevel    : Integer;
  end;

  { TMonSayMsg }
  PMonSayMsg = ^TMonSayMsg;
  TMonSayMsg = record
    nRate    : Integer;
    sSayMsg  : String;
    State    : TMonStatus;
    Color    : TMsgColor;
  end;

  { TMonDrop }
  PMonDrop = ^TMonDrop;
  TMonDrop = record
    sItemName    : string;
    nDropCount   : Integer;
    nNoDropCount : Integer;
    nCountLimit  : Integer;
  end;

  { TGameCmd }
  PGameCmd = ^TGameCmd;
  TGameCmd = record
    sCmd           : String[25];
    nPermissionMin : Integer;
    nPermissionMax : Integer;
  end;

  { TIPAddr }
  PIPAddr = ^TIPAddr;
  TIPAddr = record
    dIPaddr  : String[15];
    sIPaddr  : String[15];
  end;

  { TSrvNetInfo }
  PSrvNetInfo = ^TSrvNetInfo;
  TSrvNetInfo = record
    sIPaddr  : String[15];
    nPort    : Integer;
  end;

  { TStdItem }
  PStdItem = ^TStdItem;
  TStdItem = packed record
    Name         : String[16];
    StdMode      : Word;
    Shape        : Word;
    Weight       : Word;
    CharLooks    : Word;
    AniCount     : Word;
    Source       : Word;
    Reserved     : Word;
    NeedIdentify : Byte;
    throw        : Word;
    Looks        : Integer;
    DuraMax      : Integer;
    AC           : Integer;
    AC2          : Integer;
    MAC          : Integer;
    MAC2         : Integer;
    DC           : Integer;
    DC2          : Integer;
    McType       : Word;
    MC           : Integer;
    MC2          : Integer;
    SC           : Integer;
    SC2          : Integer;
    SAC          : Integer;
    SAC2         : Integer;
    FuncType     : Byte;
    Func         : Integer;
    Need         : Integer;
    NeedLevel    : Integer;
    Price        : Integer;
    memo         : String[50];
  end;

  { TSetItems }
  PSetItems = ^TSetItems;
  TSetItems = packed record
    SETName      : String[20];
    SETHelmet    : PStdItem;
    SETDress     : PStdItem;
    SETWeapon    : PStdItem;
    SETRing1     : PStdItem;
    SETRing2     : PStdItem;
    SETBracelet1 : PStdItem;
    SETBracelet2 : PStdItem;
    SETNecklace  : PStdItem;
    SETBelt      : PStdItem;
    SETShoes     : PStdItem;
    SETStone     : PStdItem;
    SETMedal     : PStdItem;
    SETAC        : Integer;
    SETMAC       : Integer;
    SETDC        : Integer;
    SETMC        : Integer;
    SETSC        : Integer;
    SETSPEED     : Integer;
    SETLUCK      : Integer;
    SETNEEDTYPE  : Byte;
    SETNEEDLEVEL : SmallInt;
    SETNEEDSC    : SmallInt;
    SETNEEDMC    : SmallInt;
    SETNEEDDC    : SmallInt;
    SETNEEDJOB   : Byte;
    SETPRICE     : Integer;
    SETLOOKS     : Integer;
  end;

  { TOStdItem }
  POStdItem = ^TOStdItem;
  TOStdItem = packed record
    Name         : string[16];
    StdMode      : Byte;
    Shape        : Byte;
    Weight       : Byte;
    AniCount     : Byte;
    Source       : ShortInt;
    Reserved     : Byte;
    NeedIdentify : Byte;
    Looks        : Word;
    DuraMax      : Word;
    AC           : Word;
    MAC          : Word;
    DC           : Word;
    MC           : Word;
    SC           : Word;
    Need         : Byte;
    NeedLevel    : Byte;
    w26          : Word;
    Price        : Integer;
  end;

  { TOClientItem }
  POClientItem = ^TOClientItem;
  TOClientItem = record
    s         : TOStdItem;
    MakeIndex : Integer;
    Dura      : Word;
    DuraMax   : Word;
  end;

  { THoleItem }
  PHoleItem = ^THoleItem;
  THoleItem = record
    idx      : byte;
    name     : string[20];
    looks    : Integer;
    AC       : Word;
    AC2      : Word;
    MAC      : Word;
    MAC2     : Word;
    DC       : Word;
    DC2      : Word;
    MCTYPE   : Byte;
    MC       : Word;
    MC2      : Word;
    SC       : Word;
    SC2      : Word;
    FUNCTYPE : Byte;
    FUNC     : Word;
  end;

  { TClientItem }
  PClientItem = ^TClientItem;
  TClientItem = record
    s         : TStdItem;
    MakeIndex : Integer;
    Dura      : Integer;
    DuraMax   : Integer;
    btValue   : array [0.. 19] of Word;
    Holes     : array [0..3]   of THoleItem;
  end;

  { TMonInfo }
  PMonInfo = ^TMonInfo;
  TMonInfo = record
    sName        : String[14];
    btRace       : Byte;
    btRaceImg    : Byte;
    wAppr        : Word;
    wLevel       : Integer;
    btLifeAttrib : Byte;
    boUndead     : Boolean;
    wCoolEye     : Word;
    dwExp        : LongWord;
    wMP          : Integer;
    wHP          : Integer;
    wAC          : Integer;
    wDC          : Integer;
    wMaxDC       : Integer;
    wFUNC        : array [0..6] of SmallInt;
    wMC_TYPE     : Byte;
    wMC          : Integer;
    wMaxMC       : Integer;
    wSpeed       : Word;
    wHitPoint    : Word;
    wWalkSpeed   : Word;
    wWalkStep    : Word;
    wWalkWait    : Word;
    wAttackSpeed : Word;
    ItemList     : TList;
  end;

  { TMagic }
  PMagic = ^TMagic;
  TMagic = record
    MagicId      : Word;
    MagicName    : String[12];
    EffectType   : Byte;
    Effect       : Byte;
    bt11         : Byte;
    wSpell       : Word;
    wPower       : Word;
    TrainLevel   : array [0..3] of Byte;
    w02          : Word;
    MaxTrain     : array [0..3] of Integer;
    btTrainLv    : Byte;
    btJob        : Byte;
    wMagicIdx    : Word;
    dwDelayTime  : LongWord;
    btDefSpell   : Byte;
    btDefPower   : Byte;
    wMaxPower    : Word;
    btDefMaxPower: Byte;
    sDescr       : String[18];
  end;

  { TClientMagic }
  PClientMagic = ^TClientMagic;
  TClientMagic = record
    Key      : Char;
    Level    : Byte;
    CurTrain : Integer;
    Def      : TMagic;
  end;

  { TUserMagic }
  PUserMagic = ^TUserMagic;
  TUserMagic = record
    MagicInfo : PMagic;
    MagIdx    : Word;
    Level     : Byte;
    Key       : Byte;
    TranPoint : Integer;
  end;

  { TMonMagic }
  PMonMagic = ^TMonMagic;
  TMonMagic = record
    btSpellAct        : Byte;
    sSpellActMode     : string;
    DelayTime         : integer;
    nSpellDamage      : integer;
    nSpellMagicID     : integer;
    SPellRangeType    : string;
    btSpellAttackType : Byte;
    nRange            : Byte;
  end;

  { TMinMap }
  PMinMap = ^TMinMap;
  TMinMap = record
    sName : string;
    nID   : Integer;
  end;

  { TMapRoute }
  PMapRoute = ^TMapRoute;
  TMapRoute = record
    sSMapNO : String;
    nDMapX  : Integer;
    nSMapY  : Integer;
    sDMapNO : String;
    nSMapX  : Integer;
    nDMapY  : Integer;
  end;

  { TMapInfo }
  PMapInfo = ^TMapInfo;
  TMapInfo = record
    sName            : string;
    sMapNO           : string;
    nL               : Integer;
    nServerIndex     : Integer;
    nNEEDONOFFFlag   : Integer;
    boNEEDONOFFFlag  : Boolean;
    sShowName        : string; 
    sReConnectMap    : string; 
    boSAFE           : Boolean;
    boDARK           : Boolean;
    boFIGHT          : Boolean;
    boFIGHT3         : Boolean;
    boDAY            : Boolean;
    boQUIZ           : Boolean;
    boNORECONNECT    : Boolean;
    boNEEDHOLE       : Boolean;
    boNORECALL       : Boolean;
    boNORANDOMMOVE   : Boolean;
    boNODRUG         : Boolean;
    boMINE           : Boolean;
    boNOPOSITIONMOVE : Boolean;
  end;

  { TUnbindInfo }
  PUnbindInfo = ^TUnbindInfo;
  TUnbindInfo = record
    nUnbindCode : Integer;
    sItemName   : string[16];
  end;

  { TQuestDiaryInfo }
  PQuestDiaryInfo = ^TQuestDiaryInfo;
  TQuestDiaryInfo = record
    QDDinfoList : TList;
  end;

  { TAdminInfo }
  PAdminInfo = ^TAdminInfo;
  TAdminInfo = record
    nLv      : Integer;
    sChrName : string[ACTORNAMELEN];
    sIPaddr  : string[15];
  end;

  { THumMagic }
  PHumMagic = ^THumMagic;
  THumMagic = record
    wMagIdx    : Integer;
    btLevel    : Byte;
    btKey      : Byte;
    nTranPoint : Integer;
  end;

  { TNakedAbility }
  PNakedAbility = ^TNakedAbility;
  TNakedAbility = packed record
    DC    : Word;
    MC    : Word;
    SC    : Word;
    AC    : Word;
    MAC   : Word;
    HP    : Word;
    MP    : Word;
    Hit   : Word;
    Speed : Word;
    X2    : Word;
  end;

  { TAbility }
  PAbility = ^TAbility;
  TAbility = packed record
    Level          : Word;
    AC             : Integer;
    AC2            : Integer;
    MAC            : Integer;
    MAC2           : Integer;
    DC             : Integer;
    DC2            : Integer;
    MC             : Integer;
    MC2            : Integer;
    SC             : Integer;
    SC2            : Integer;
    SAC            : array [0..6] of Integer;
    SAC2           : array [0..6] of Integer;
    FUNC           : array [0..6] of Integer;
    HP             : Integer;
    MP             : Integer; 
    MaxHP          : Integer;
    MaxMP          : Integer;
    Exp            : LongWord;
    MaxExp         : LongWord;
    Weight         : Integer;
    MaxWeight      : Integer;
    WearWeight     : Integer;
    MaxWearWeight  : Integer;
    HandWeight     : Integer;
    MaxHandWeight  : Integer;
  end;

  { TOAbility }
  POAbility = ^TOAbility;
  TOAbility = packed record
    Level         : Integer;
    AC            : Integer;
    MAC           : Integer;
    DC            : Integer;
    MC            : Integer;
    SC            : Integer;
    HP            : Integer;
    MP            : Integer;
    MaxHP         : Integer;
    MaxMP         : Integer;
    btReserved1   : Byte;
    btReserved2   : Byte;
    btReserved3   : Byte;
    btReserved4   : Byte;
    Exp           : LongWord;
    MaxExp        : LongWord;
    Weight        : Word;
    MaxWeight     : Word;
    WearWeight    : Byte;
    MaxWearWeight : Byte;
    HandWeight    : Byte;
    MaxHandWeight : Byte;
  end;

  { TAddAbility }
  PAddAbility = ^TAddAbility;
  TAddAbility = record
    wHP            : Integer;
    wMP            : Integer;
    wHitPoint      : Integer;
    wSpeedPoint    : Integer;
    wAC            : Integer;
    wAC2           : Integer;
    wMAC           : Integer;
    wMAC2          : Integer;
    wDC            : Integer;
    wDC2           : Integer;
    wMC            : Integer;
    wMC2           : Integer;
    wSC            : Integer;
    wSC2           : Integer;
    SAC            : array [0..6] of Integer;
    SAC2           : array [0..6] of Integer;
    FUNC           : array [0..6] of Integer;
    bt1DF          : Byte;
    bt035          : Byte;
    wAntiPoison    : Word;
    wPoisonRecover : Word;
    wHealthRecover : Word;
    wSpellRecover  : Word;
    wAntiMagic     : Word;
    btLuck         : Byte;
    btUnLuck       : Byte;
    nHitSpeed      : Integer;
    btWeaponStrong : Byte;
  end;

  { TWAbility }
  PWAbility = ^TWAbility;
  TWAbility = record
    dwExp   : LongWord;
    wHP     : Word;
    wMP     : Word;
    wMaxHP  : Word;
    wMaxMP  : Word
  end;

  { TMerchantInfo }
  PMerchantInfo = ^TMerchantInfo;
  TMerchantInfo = record
    sScript   : String[14];
    sMapName  : String[14];
    nX        : Integer;
    nY        : Integer;
    sNPCName  : String[40];
    nFace     : Integer;
    nBody     : Integer;
    boCastle  : Boolean;
  end;

  { TSocketBuff }
  PSocketBuff = ^TSocketBuff;
  TSocketBuff = record
    Buffer : PChar;
    nLen   : Integer;
  end;

  { TSendBuff }
  PSendBuff = ^TSendBuff;
  TSendBuff = record
    nLen   : Integer;
    Buffer : array[0..DATA_BUFSIZE - 1] of Char;
  end;

  { TUserItem }
  PUserItem = ^TUserItem;
  TUserItem = record
    MakeIndex : Integer;
    wIndex    : Integer;
    Dura      : Word;
    DuraMax   : Word;
    btValue   : array [0..19] of word;
  end;

  { TMonItemInfo }
  PMonItemInfo = ^TMonItemInfo;
  TMonItemInfo = record
    SelPoint  : Integer;
    MaxPoint  : Integer;
    ItemName  : string;
    Count     : Integer;
  end;

  { TMonsterInfo }
  PMonsterInfo = ^TMonsterInfo;
  TMonsterInfo = record
    Name     : string;
    ItemList : TList;
  end;

  { TMapItem }
  PMapItem = ^TMapItem;
  TMapItem = record
    Name            : string;
    Looks           : Word;
    AniCount        : Byte;
    Reserved        : Byte;
    Count           : Integer;
    OfBaseObject    : TObject;
    DropBaseObject  : TObject;
    dwCanPickUpTick : LongWord;
    UserItem        : TUserItem;
  end;

  { TVisibleMapItem }
  PVisibleMapItem = ^TVisibleMapItem;
  TVisibleMapItem = record
   {wIdent        : Word;
    nParam1       : Integer;
    Buff          : PChar;}
    MapItem       : PMapItem;
    nVisibleFlag  : Integer;
    nX            : Integer;
    nY            : Integer;
    sName         : string;
    wLooks        : Word;
  end;

  { TVisibleMapEvent }
  PVisibleMapEvent = ^TVisibleMapEvent;
  TVisibleMapEvent = record
    MapEvent     : TObject;
    nVisibleFlag : Integer;
    nX           : Integer;
    nY           : Integer;
  end;

  { TVisibleBaseObject }
  PVisibleBaseObject = ^TVisibleBaseObject;
  TVisibleBaseObject = record
    BaseObject   : TObject;
    nVisibleFlag : Integer;
  end;

  { THumanRcd }
  PHumanRcd = ^THumanRcd;
  THumanRcd = record
    sUserID      : string[10];
    sCharName    : string[14];
    btJob        : Byte;
    btGender     : Byte;
    btLevel      : Byte;
    btHair       : Byte;
    sMapName     : string[16];
    btAttackMode : Byte;
    btIsAdmin    : Byte;
    nX           : Integer;
    nY           : Integer;
    nGold        : Integer;
    dwExp        : LongWord;
  end;

  { TObjectFeature }
  PObjectFeature = ^TObjectFeature;
  TObjectFeature = record
    btGender : Byte;
    btWear   : Byte;
    btHair   : Byte;
    btWeapon : Byte;
  end;

  { TStatusInfo }
  PStatusInfo = ^TStatusInfo;
  TStatusInfo = record
    nStatus      : Integer;
    dwStatusTime : LongWord;
    sm218        : SmallInt;
    dwTime220    : LongWord;
  end;

  { TCheckCode }
  PCheckCode = ^TCheckCode;
  TCheckCode = record

  end;

  { TMsgHeader }
  PMsgHeader = ^TMsgHeader;
  TMsgHeader = record
    dwCode          : LongWord;
    nSocket         : Integer;
    wGSocketIdx     : Word;
    wIdent          : Word;
    wUserListIndex  : Integer;
    nLength         : Integer;
  end;

  { TUserInfo }
  PUserInfo = ^TUserInfo;
  TUserInfo = record
    bo00        : Boolean;
    bo01        : Boolean;
    bo02        : Boolean;
    bo03        : Boolean;
    n04         : Integer;
    n08         : Integer;
    bo0C        : Boolean;
    bo0D        : Boolean;
    bo0E        : Boolean;
    bo0F        : Boolean;
    n10         : Integer;
    n14         : Integer;
    n18         : Integer;
    sStr        : String[20];
    nSocket     : Integer; 
    nGateIndex  : Integer; 
    n3C         : Integer; 
    n40         : Integer; 
    n44         : Integer; 
    List48      : TList;   
    Cert        : TObject; 
    dwTime50    : LongWord;
    bo54        : Boolean;
  end;

  { TGlobaSessionInfo }
  PGlobaSessionInfo = ^TGlobaSessionInfo;
  TGlobaSessionInfo = record
    sAccount    : String;
    sIPaddr     : String;
    nSessionID  : Integer;
    n24         : Integer;
    bo28        : Boolean;
    boLoadRcd   : Boolean;
    boStartPlay : Boolean;
    dwAddTick   : LongWord;
    dAddDate    : TDateTime;
  end;

  { TUserStateInfo }
  PUserStateInfo = ^TUserStateInfo;
  TUserStateInfo = record
    feature       : Integer;
    UserName      : String[ACTORNAMELEN];
    NAMECOLOR     : LongWord;
    GuildName     : String[ACTORNAMELEN];
    GuildRankName : String[16];
    UseItems      : array [0..12] of TClientItem;
    GuildFlag     : Byte;
  end;

  { TSellOffHeader }
  PSellOffHeader = ^TSellOffHeader;
  TSellOffHeader = record
    nItemCount: Integer;
  end;

  { TSellOffInfo }
  PSellOffInfo = ^TSellOffInfo;
  TSellOffInfo = packed record
    sCharName     : String[ACTORNAMELEN];
    dSellDateTime : TDateTime;
    nSellGold     : Integer;
    N             : Integer;
    UseItems      : TUserItem;
    n1            : Integer;
  end;

  { TBigStorage }
  PBigStorage = ^TBigStorage;
  TBigStorage = packed record
    boDelete     : Boolean;
    sCharName    : String[ACTORNAMELEN];
    SaveDateTime : TDateTime;
    UseItems     : TUserItem;
    nCount       : Integer;
  end;

  { TBindItem }
  PBindItem = ^TBindItem;
  TBindItem = record
    sUnbindItemName : String[16];
    nStdMode        : Integer;
    nShape          : Integer;
    btItemType      : Byte;
  end;

  { TOUserStateInfo }
  POUserStateInfo = ^ TOUserStateInfo;
  TOUserStateInfo = packed record
    feature       : Integer;
    UserName      : String[15];
    GuildName     : String[14];
    GuildRankName : String[16];
    NAMECOLOR     : Word;
    UseItems      : array [0..8] of TOClientItem;
  end;

  { TIDRecordHeader }
  PIDRecordHeader = ^TIDRecordHeader;
  TIDRecordHeader = packed record
    boDeleted  : Boolean;
    bt1        : Byte;
    bt2        : Byte;
    bt3        : Byte;
    CreateDate : TDateTime;
    UpdateDate : TDateTime;
    sAccount   : string[11];
  end;

  { TRecordHeader }
  PRecordHeader = ^TRecordHeader;
  TRecordHeader = packed record
    boDeleted   : Boolean;
    nSelectID   : Byte;
    boIsHero    : Boolean;
    bt2         : Byte;
    dCreateDate : TDateTime;
    sName       : string[ACTORNAMELEN];
  end;
  
  TUnKnow         = array[0..39]  of Byte;
  TQuestUnit      = array[0..127] of Byte;
  TQuestFlag      = array[0..127] of Byte;
  TStatusTime     = array[0..MAX_STATUS_ATTRIBUTE - 1] of Word;
  THumItems       = array[0..8]   of TUserItem;
  THumAddItems    = array[9..12]  of TUserItem;
  TBagItems       = array[0..45]  of TUserItem;
  TStorageItems   = array[0..45]  of TUserItem;
  THumMagics      = array[0..39]  of THumMagic;
  THumanUseItems  = array[0..12]  of TUserItem;
  THeroItems      = array[0..12]  of TUserItem;
  THeroBagItems   = array[0..40 - 1] of TUserItem;

  PTPLAYUSEITEMS  = ^THumanUseItems;
  pTHeroItems     = ^THeroItems;
  pTHumItems      = ^THumItems;
  pTBagItems      = ^TBagItems;
  pTStorageItems  = ^TStorageItems;
  pTHumAddItems   = ^THumAddItems;
  pTHumMagics     = ^THumMagics;
  pTHeroBagItems  = ^THeroBagItems;

  { THeroData }
  PHeroData = ^THeroData;
  THeroData = packed record
    sChrName        : string[ACTORNAMELEN];
    btHair          : Byte;
    btSex           : Byte;
    btJob           : Byte;
    Abil            : TOAbility;
    //wStatusTimeArr: TStatusTime;
    btReLevel       : Byte;
    btCreditPoint   : Byte;
    nBagItemCount   : Integer;
    nPKPOINT        : Integer;
    btStatus        : Byte;
    boProtectStatus : Boolean;
    nProtectTargetX : Integer;
    nProtectTargetY : Integer;
    UnKnow          : array[0..9] of Byte;
    HumItems        : THumanUseItems;
    BagItems        : THeroBagItems;
    HumMagics       : THumMagics;
  end;

  { THumData }
  PHumData = ^THumData;
  THumData = packed record
    sChrName            : string[ACTORNAMELEN];
    sCurMap             : string[MAPNAMELEN];
    wCurX               : Word;
    wCurY               : Word;
    btDir               : Byte;
    btHair              : Byte;
    btSex               : Byte;
    btJob               : Byte;
    nGold               : Integer;
    Abil                : TOAbility;
    wStatusTimeArr      : TStatusTime;
    sHomeMap            : string[MAPNAMELEN];
    btUnKnow1           : Byte;
    wHomeX              : Word;
    wHomeY              : Word;
    sDearName           : String[ACTORNAMELEN];
    sMasterName         : String[ACTORNAMELEN];
    boMaster            : Boolean;
    btCreditPoint       : Integer;
    btDivorce           : Byte;
    btMarryCount        : Byte;
    sStoragePwd         : string[7];
    btReLevel           : Byte;
    btUnKnow2           : array[0..2] of Byte;
    BonusAbil           : TNakedAbility;
    nBonusPoint         : Integer;
    nGameGold           : Integer;
    nGamePoint          : Integer;
    nPayMentPoint       : Integer;
    nGameDIamond        : Integer;
    nGameGirD           : Integer;
    //N                   : Integer;
    nPKPOINT            : Integer;
    btAllowGroup        : Byte;
    btF9                : Byte;
    btAttatckMode       : Byte;
    btIncHealth         : Byte;
    btIncSpell          : Byte;
    btIncHealing        : Byte;
    btFightZoneDieCount : Byte;
    sAccount            : string[10];
    btEE                : Byte;
    btEF                : Byte;
    boLockLogon         : Boolean;
    wContribution       : Word;
    nHungerStatus       : Integer;
    boAllowGuildReCall  : Boolean; 
    wGroupRcallTime     : Word;    
    dBodyLuck           : Double;  
    boAllowGroupReCall  : Boolean; 
    nEXPRATE            : Integer; 
    nExpTime            : Integer; 
    btLastOutStatus     : Byte;    
    wMasterCount        : Word;    
    boHasHero           : Boolean; 
    boIsHero            : Boolean; 
    btStatus            : Byte;    
    sHeroChrName        : String[ACTORNAMELEN];
    UnKnow              : TUnKnow;
    QuestFlag           : TQuestFlag;
    HumItems            : THumItems;
    BagItems            : TBagItems;
    HumMagics           : THumMagics;
    StorageItems        : TStorageItems;
    HumAddItems         : THumAddItems;
    password            : String[11];
    nVal                : array [0..49] of word;
  end;

  { THumDataInfo }
  PHumDataInfo = ^THumDataInfo;
  THumDataInfo = packed record //Size 3168
    Header : TRecordHeader;
    Data   : THumData;
  end;

  { TSaveRcd }
  PSaveRcd = ^TSaveRcd;
  TSaveRcd = record
    sAccount    : string[12];
    sChrName    : string[ACTORNAMELEN];
    nSessionID  : Integer;
    nReTryCount : Integer;
    dwSaveTick  : LongWord;
    PlayObject  : TObject;
    HumanRcd    : THumDataInfo;
    boIsHero    : Boolean;
  end;

  { TLoadDBInfo }
  PLoadDBInfo = ^TLoadDBInfo;
  TLoadDBInfo = record
    sAccount         : string[12];
    sCharName        : string[ACTORNAMELEN];
    sIPaddr          : string[15];
    sMsg             : string;
    nSessionID       : Integer;
    nSoftVersionDate : Integer;
    nPayMent         : Integer;
    nPayMode         : Integer;
    nSocket          : Integer;
    nGSocketIdx      : Integer;
    nGateIdx         : Integer;
    boClinetFlag     : Boolean;
    dwNewUserTick    : LongWord;
    PlayObject       : TObject;
    nReLoadCount     : Integer;
    boIsHero         : Boolean;
    btLoadDBType     : Byte;
  end;

  { TUserOpenInfo }
  PUserOpenInfo = ^TUserOpenInfo;
  TUserOpenInfo = record
    sAccount    : String[12];
    sChrName    : String[ACTORNAMELEN];
    LoadUser    : TLoadDBInfo;
    HumanRcd    : THumDataInfo;
    nOpenStatus : Integer;
  end;

  { TLoadUser }
  PLoadUser = ^TLoadUser;
  TLoadUser = record
    sAccount        : string[12];
    sChrName        : string[ACTORNAMELEN];
    sIPaddr         : string[15];
    nSessionID      : Integer;
    nSocket         : Integer;
    nGateIdx        : Integer;
    nGSocketIdx     : Integer;
    nPayMent        : Integer;
    nPayMode        : Integer;
    dwNewUserTick   : LongWord;
    nSoftVersionDate: Integer;
  end;

  { TDoorStatus }
  PDoorStatus = ^TDoorStatus;
  TDoorStatus = record
    bo01       : Boolean;
    boOpened   : Boolean;
    dwOpenTick : LongWord;
    nRefCount  : Integer;
    n04        : Integer;
  end;

  { TDoorInfo }
  PDoorInfo = ^TDoorInfo;
  TDoorInfo = record
    nX     : Integer;
    nY     : Integer;
    n08    : Integer;
    Status : PDoorStatus;
  end;

  { TSlaveInfo }
  PSlaveInfo = ^TSlaveInfo;
  TSlaveInfo = record
    sSalveName      : string;
    btSalveLevel    : Byte;
    btSlaveExpLevel : Byte;
    dwRoyaltySec    : LongWord;
    nKillCount      : Integer;
    nHP             : Integer;
    nMP             : Integer;
  end;

  { TSwitchDataInfo }
  PSwitchDataInfo = ^TSwitchDataInfo;
  TSwitchDataInfo = record
    sChrName        : string[ACTORNAMELEN];
    sMAP            : string[MAPNAMELEN];
    wX              : Word;
    wY              : Word;
    Abil            : TAbility;
    nCode           : Integer;
    boC70           : Boolean;
    boBanShout      : Boolean;
    boHearWhisper   : Boolean;
    boBanGuildChat  : Boolean;
    boAdminMode     : Boolean;
    boObMode        : Boolean;
    BlockWhisperArr : array [0..5]  of String;
    SlaveArr        : array [0..10] of TSlaveInfo;
    StatusValue     : array [0..5]  of Word;
    StatusTimeOut   : array [0..5]  of LongWord;
  end;

  { TGoldChangeInfo }
  PGoldChangeInfo = ^TGoldChangeInfo;
  TGoldChangeInfo = record
    sGameMasterName : string;
    sGetGoldUser    : string;
    nGold           : Integer;
  end;

  { TGateInfo }
  PGateInfo = ^TGateInfo;
  TGateInfo = record
    Socket           : TCustomWinSocket;
    boUsed           : Boolean;
    sAddr            : string[15];
    nPort            : Integer;
    n520             : Integer;
    UserList         : TList;
    nUserCount       : Integer;
    Buffer           : PChar;
    nBuffLen         : Integer;
    BufferList       : TList;
    boSendKeepAlive  : Boolean;
    nSendChecked     : Integer;
    nSendBlockCount  : Integer;
    dwTime544        : LongWord;
    nSendMsgCount    : Integer;
    nSendRemainCount : Integer;
    dwSendTick       : LongWord;
    nSendMsgBytes    : Integer;
    nSendBytesCount  : Integer;
    nSendedMsgCount  : Integer;
    nSendCount       : Integer;
    dwSendCheckTick  : LongWord;
  end;

  { TStartPoint }
  PStartPoint = ^TStartPoint;
  TStartPoint = record
    m_sMapName      : String[MAPNAMELEN];
    m_nCurrX        : Integer;
    m_nCurrY        : Integer;
    m_boNotAllowSay : Boolean;
    m_nRange        : Integer;
    m_nType         : Integer;
    m_nPkZone       : Integer;
    m_nPkFire       : Integer;
    m_btShape       : Byte;
  end;

  { TQuestUnitStatus }
  PQuestUnitStatus = ^TQuestUnitStatus;
  TQuestUnitStatus = record
    nQuestUnit : Integer;
    boOpen     : Boolean;
  end;

  { TMapCondition }
  PMapCondition = ^TMapCondition;
  TMapCondition = record
    nHumStatus  : Integer;
    sItemName   : string[16];
    boNeedGroup : Boolean;
  end;

  { TStartScript }
  PStartScript = ^TStartScript;
  TStartScript = record
    nLable : Integer;
    sLable : string[100];
  end;

  { TMapEvent }
  PMapEvent = ^TMapEvent;
  TMapEvent = record
    m_sMapName: string[MAPNAMELEN];
    m_nCurrX       : Integer;
    m_nCurrY       : Integer;
    m_nRange       : Integer;
    m_MapFlag      : TQuestUnitStatus;
    m_nRandomCount : Integer;
    m_Condition    : TMapCondition;
    m_StartScript  : TStartScript;
  end;

  { TItemEvent }
  PItemEvent = ^TItemEvent;
  TItemEvent = record
    m_sItemName  : string[15];
    m_nMakeIndex : Integer;
    m_sMapName   : string[MAPNAMELEN];
    m_nCurrX     : Integer;
    m_nCurrY     : Integer;
  end;

  { TSendUserData }
  PSendUserData = ^TSendUserData;
  TSendUserData = record
    nSocketIndx   : Integer;
    nSocketHandle : Integer;
    sMsg          : string;
  end;

  { TCheckVersion }
  PCheckVersion = ^TCheckVersion;
  TCheckVersion = record
  end;

  { TRecordDeletedHeader }
  PRecordDeletedHeader = ^TRecordDeletedHeader;
  TRecordDeletedHeader = packed record
    boDeleted       : Boolean;
    bt1             : Byte;
    bt2             : Byte;
    bt3             : Byte;
    CreateDate      : TDateTime;
    LastLoginDate   : TDateTime;
    n14             : Integer;
    nNextDeletedIdx : Integer;
    //sAccount   :String[11];//0x14
  end;

  { TUserEntry }
  PUserEntry = ^TUserEntry;
  TUserEntry = packed record
    sAccount  : string[10];
    sPassword : string[255];
    sUserName : string[20];
    sSSNo     : string[14];
    sPhone    : string[14];
    sQuiz     : string[20];
    sAnswer   : string[12];
    sEMail    : string[40];
  end;

  { TUserEntryAdd }
  PUserEntryAdd = ^TUserEntryAdd;
  TUserEntryAdd = packed record
    sQuiz2       : string[20];
    sAnswer2     : string[12];
    sBirthDay    : string[10];
    sMobilePhone : string[13];
    sMemo        : string[20];
    sMemo2       : string[20];
  end;

  { TAccountDBRecord }
  PAccountDBRecord = ^TAccountDBRecord;
  TAccountDBRecord = packed record
    Header        : TIDRecordHeader;
    UserEntry     : TUserEntry;
    UserEntryAdd  : TUserEntryAdd;
    nErrorCount   : Integer;
    dwActionTick  : LongWord;
    N             : array[0..38] of Byte;
  end;

  { TMapFlag }
  PMapFlag = ^TMapFlag;
  TMapFlag = record
    boSAFE               : Boolean;
    boDARK               : Boolean;
    boFIGHT              : Boolean;
    boFIGHT3             : Boolean;
    boDAY                : Boolean;
    boQUIZ               : Boolean;
    boNORECONNECT        : Boolean;
    boMUSIC              : Boolean;
    boEXPRATE            : Boolean;
    boPKWINLEVEL         : Boolean;
    boPKWINEXP           : Boolean;
    boPKLOSTLEVEL        : Boolean;
    boPKLOSTEXP          : Boolean;
    boDECHP              : Boolean;
    boINCHP              : Boolean;
    boDECGAMEGOLD        : Boolean;
    boDECGAMEPOINT       : Boolean;
    boINCGAMEGOLD        : Boolean;
    boINCGAMEPOINT       : Boolean;
    boRUNHUMAN           : Boolean;
    boRUNMON             : Boolean;
    boNEEDHOLE           : Boolean;
    boNORECALL           : Boolean;
    boNOGUILDRECALL      : Boolean;
    boNODEARRECALL       : Boolean;
    boNOMASTERRECALL     : Boolean;
    boNORANDOMMOVE       : Boolean;
    boNODRUG             : Boolean;
    boMINE               : Boolean;
    boNOPOSITIONMOVE     : Boolean;
    boNoManNoMon         : Boolean;
    nL                   : Integer;
    nNEEDSETONFlag       : Integer;
    nNeedONOFF           : Integer;
    nMUSICID             : Integer;
    nPKWINLEVEL          : Integer;
    nEXPRATE             : Integer;
    nPKWINEXP            : Integer;
    nPKLOSTLEVEL         : Integer;
    nPKLOSTEXP           : Integer;
    nDECHPPOINT          : Integer;
    nDECHPTIME           : Integer;
    nINCHPPOINT          : Integer;
    nINCHPTIME           : Integer;
    nDECGAMEGOLD         : Integer;
    nDECGAMEGOLDTIME     : Integer;
    nDECGAMEPOINT        : Integer;
    nDECGAMEPOINTTIME    : Integer;
    nINCGAMEGOLD         : Integer;
    nINCGAMEGOLDTIME     : Integer;
    nINCGAMEPOINT        : Integer;
    nINCGAMEPOINTTIME    : Integer;
    sReConnectMap        : String;
    sMUSICName           : String;
    boUnAllowStdItems    : Boolean;
    sUnAllowStdItemsText : String;
    sUnAllowMagicText    : string;
    boNOTALLOWUSEMAGIC   : Boolean;
    boAutoMakeMonster    : Boolean;
    boFIGHTPK            : Boolean;
    boNOHUMNOMON         : Boolean;
  end;

  { TUserLevelSort }
  PUserLevelSort = ^TUserLevelSort;
  TUserLevelSort = record
    nIndex   : Integer;
    wLevel   : Word;
    sChrName : string[ACTORNAMELEN];
  end;

  { THeroLevelSort }
  PHeroLevelSort = ^THeroLevelSort;
  THeroLevelSort = record
    nIndex    : Integer;
    wLevel    : Word;
    sChrName  : string[ACTORNAMELEN];
    sHeroName : string[ACTORNAMELEN];
  end;

  { TUserMasterSort }
  PUserMasterSort = ^TUserMasterSort;
  TUserMasterSort = record
    nIndex       : Integer;
    nMasterCount : Integer;
    sChrName     : string[ACTORNAMELEN];
  end;

  { TChrMsg }
  PChrMsg = ^TChrMsg;
  TChrMsg = record
    Ident   : Integer;
    x       : Integer;
    y       : Integer;
    dir     : Integer;
    State   : Integer;
    feature : Integer;
    saying  : String;
    sound   : Integer;
  end;
  
  { TActorMessage }
  PActorMessage = ^TActorMessage;
  TActorMessage = record
    amIdent   : Integer;
    amX       : Integer;
    amY       : Integer;
    amDir     : Integer;
    amState   : Integer;
    amFeature : Integer;
    amSaying  : String;
    amSound   : Integer;
  end;  
  
  { THealthActionStatus }
  PHealthActionStatus = ^THealthActionStatus;
  THealthActionStatus = record
    hasStatus       : Byte;         //0=MISS 1=ADD 2=DEC
    hasValue        : Integer;       
    hasFrameTime    : LongWord;
    hasCurrentFrame : Integer;
  end;  

  { TRegInfo }
  PRegInfo = ^TRegInfo;
  TRegInfo = record
    sKey        : string;
    sServerName : string;
    sRegSrvIP   : string[15];
    nRegPort    : Integer;
  end;

  { TDropItem }
  PDropItem = ^TDropItem;
  TDropItem = record
    Name            : string;
    Looks           : Integer;
    AniCount        : Byte;
    Reserved        : Byte;
    Throw  : Byte;
    s         : TStdItem;
    c : TClientItem;
    Count           : Word;
    OfBaseObject    : TObject;
    DropBaseObject  : TObject;
    dwCanPickUpTick : LongWord;
    UserItem        : TUserItem;
    btValue   : array [0.. 19] of Integer;
    x: Integer;
    y: Integer;
    id: Integer;
    FlashTime: DWord;
    FlashStepTime: DWord;
    FlashStep: Integer;
    BoFlash: Boolean;
  end;


  { TUserCharacterInfo }
  PUserCharacterInfo = ^TUserCharacterInfo;
  TUserCharacterInfo = record
    Name  : string[19];
    Job   : Byte;
    HAIR  : Byte;
    Level : Word;
    sex   : Byte;
  end;

  { TClientGoods }
  PClientGoods = ^TClientGoods;
  TClientGoods = record
    Name    : String;
    SubMenu : Integer;
    Price   : Integer;
    Stock   : Integer;
    Grade   : Integer;
    looks   : Integer;
    throw   : Byte;
    count   : Word;
  end;

  { TClientConf }
  PClientConf = ^TClientConf;
  TClientConf = record
    boClientCanSet   : Boolean;
    boRUNHUMAN       : Boolean;
    boRUNMON         : Boolean;
    boRunNpc         : Boolean;
    boWarRunAll      : Boolean;
    btDieColor       : Byte;
    wSpellTime       : Word;
    wHitIime         : Word;
    wItemFlashTime   : Word;
    btItemSpeed      : Byte;
    boCanStartRun    : Boolean;
    boParalyCanRun   : Boolean;
    boParalyCanWalk  : Boolean;
    boParalyCanHit   : Boolean;
    boParalyCanSpell : Boolean;
    boShowRedHPLable : Boolean;
    boShowHPNumber   : Boolean;
    boShowJobLevel   : Boolean;
    boDuraAlert      : Boolean;
    boMagicLock      : Boolean;
    boAutoPuckUpItem : Boolean;
  end;

  { TShowRemoteMessage }
  PShowRemoteMessage = ^TShowRemoteMessage;
  TShowRemoteMessage = record
    btMessageType   : Byte;
    boShow          : Boolean;
    BeginDateTime   : TDateTime;
    EndDateTime     : TDateTime;
    dwShowTime      : LongWord;
    dwShowTick      : LongWord;
    boSuperUserShow : Boolean;
    sMsg            : String;
  end;

{$ENDREGION}

var
 (****************************************************
  *        Client Var settings                       *
  ****************************************************)
  FSoundFilePath               : String  = 'Sound\';
  FMapFilePath                 : String  = 'Map\';
  FTextureFilePath             : String  = 'Data\';
  FScreen_Width                : Integer = 800; //1024
  FScreen_Height               : Integer = 600; // 768


 (****************************************************
  *        Global Var settings                       *
  ****************************************************)
  FGameServerName              : String  = 'TestServer';

 (****************************************************
  *        Global Game Language settings             *
  ****************************************************)
  FGameLanguage                : Integer = C_LANGUAGE_ENGLISH;

 (****************************************************
  *        Log Server settings                       *
  ****************************************************)
  FLogServerBaseDir            : String  = '.\LogBase';
  FLogServerConfigDir          : String  = '.\Config';
  FLogServerLogFileName        : String  = '\LogData.ini';
  FLogServerCaption            : String  = 'Log Server';
  FLogServerPort               : Integer = 10000;
  FLogStartNowMessage          : String  = ' - Log Server Started now..';
  FLogStartOkMessage           : String  = ' - Log Server Started Ok..';

 (****************************************************
  *        Game Center settings                      *
  ****************************************************)
  GGameCenterHandle            : THandle;

 (****************************************************
  *        Global Option Settings                    *
  ****************************************************)
  GGame_Option                 : TGameOptionSet;

function IfThenInt(AValue: Boolean; const ATrue: Integer; const AFalse: Integer): Integer;
function APPRfeature(cfeature: Integer): Word;
function RACEfeature(cfeature: Integer): Byte;
function HAIRfeature(cfeature: Integer): Byte;
function DRESSfeature(cfeature: Integer): Byte;
function WEAPONfeature(cfeature: Integer): Byte;
function Horsefeature(cfeature: Integer): Byte;
function Effectfeature(cfeature: Integer): Byte;
function Colorfeature(cfeature: Integer): Byte;
function MakeHumanFeature(btRaceImg, btDress, btWeapon, btHair: Byte): Integer;
function MakeMonsterFeature(btRaceImg, btWeapon: Byte; wAppr: Word): Integer;

implementation

function IfThenInt(AValue: Boolean; const ATrue: Integer; const AFalse: Integer): Integer;
begin
  if AValue then
    Result := ATrue
  else Result := AFalse;
end;

function WEAPONfeature(cfeature: Integer): Byte;
begin
  Result := HiByte(LoWord(cfeature));
end;

function DRESSfeature(cfeature: Integer): Byte;
begin
  Result := HiByte(HiWord(cfeature));
end;

function APPRfeature(cfeature: Integer): Word;
begin
  Result := HiWord(cfeature);
end;

function HAIRfeature(cfeature: Integer): Byte;
begin
  Result := LoByte(HiWord(cfeature));
end;

function RACEfeature(cfeature: Integer): Byte;
begin
  Result := Byte(cfeature);
end;

function Horsefeature(cfeature: Integer): Byte;
begin
  Result := LoByte(LoWord(cfeature));
end;

function Effectfeature(cfeature: Integer): Byte;
begin
  Result := HiByte(LoWord(cfeature));
end;

function Colorfeature(cfeature: Integer): Byte;
begin
  Result := LoByte(HiWord(cfeature));
end;

function MakeHumanFeature(btRaceImg, btDress, btWeapon, btHair: Byte): Integer;
begin
  Result := MakeLong(MakeWord(btRaceImg, btWeapon), MakeWord(btHair, btDress));
end;

function MakeMonsterFeature(btRaceImg, btWeapon: Byte; wAppr: Word): Integer;
begin
  Result := MakeLong(MakeWord(btRaceImg, btWeapon), wAppr);
end;

initialization
begin
  ZeroMemory(@GGame_Option, SizeOf(TGameOptionSet));
end;

end.

