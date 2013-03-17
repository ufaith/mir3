(*******************************************************************
 *   LomCN Mir3 file manager constantes core File 2012             *
 *                                                                 *
 *   Web       : http://www.lomcn.co.uk                            *
 *   Version   : 0.0.0.1                                           *
 *                                                                 *
 *   - File Info -                                                 *
 *                                                                 *
 *   This file holds all Texture consts                            *
 *                                                                 *
 *                                                                 *
 *                                                                 *
 *******************************************************************
 * Change History                                                  *
 *                                                                 *
 *  - 0.0.0.1 [2012-10-10] Coly : fist init                        *
 *                                                                 *
 *                                                                 *
 *                                                                 *
 *                                                                 *
 *******************************************************************
 *  - TODO List for this *.pas file -                              *
 *-----------------------------------------------------------------*
 *  if a todo finished, then delete it here...                     *
 *  if you find a global TODO thats need to do, then add it here.. *
 *-----------------------------------------------------------------*
 *                                                                 *
 *  - TODO : -all -fill *.pas header information                   *
 *                 (how to need this file etc.)                    *
 *                                                                 *
 *******************************************************************)
 unit mir3_game_file_manager_const;

interface

const
  MAX_FILE_MAPPING                = 350; // Maximum of texture files thats we need to map

  MAP_PHAT                        = '.\map\';
  LIB_PHAT                        = '.\lib\';
  LOG_PHAT                        = '.\log\';
  SOUND_PHAT                      = '.\sound\';
  MAP_TEXTURE_PHAT_DATA           = '.\data\';
  MAP_TEXTURE_PHAT_WOOD           = '.\data\wood\';
  MAP_TEXTURE_PHAT_SAND           = '.\data\sand\';
  MAP_TEXTURE_PHAT_SNOW           = '.\data\snow\';
  MAP_TEXTURE_PHAT_FOREST         = '.\data\forest\';

  //TODO : Test Client for Wil / WTL ext... if wil set wil if wtl set wtl

  (* Basis Texture file Consts *)
  MAP_TEXTURE_TILESC              = 'Tilesc.wil';
  MAP_TEXTURE_TILES30C            = 'Tiles30c.wil';
  MAP_TEXTURE_TILES5C             = 'Tiles5c.wil';
  MAP_TEXTURE_SMTILESC            = 'Smtilesc.wil';
  MAP_TEXTURE_HOUSESC             = 'Housesc.wil';
  MAP_TEXTURE_CLIFFSC             = 'Cliffsc.wil';
  MAP_TEXTURE_DUNGEONSC           = 'Dungeonsc.wil';
  MAP_TEXTURE_INNERSC             = 'Innersc.wil';
  MAP_TEXTURE_FUNITURESC          = 'Furnituresc.wil';
  MAP_TEXTURE_WALLSC              = 'Wallsc.wil';
  MAP_TEXTURE_SMOBJECTSC          = 'SmObjectsc.wil';
  MAP_TEXTURE_ANIMATIONSC         = 'Animationsc.wil';
  MAP_TEXTURE_OBJECT1C            = 'Object1c.wil';
  MAP_TEXTURE_OBJECT2C            = 'Object2c.wil';
  MAP_TEXTURE_FREEUSER            = 'freeuser.wil';
  { Game Textures }
  GAME_TEXTURE_INTERFACE1C        = 'Interface1c.wil';
  GAME_TEXTURE_INTERFACE1C_INT    = 80;
  GAME_TEXTURE_PROGUSE            = 'ProgUse.wil';
  GAME_TEXTURE_PROGUSE_INT        = 81;
  GAME_TEXTURE_GAMEINTER          = 'GameInter.wil';
  GAME_TEXTURE_GAMEINTER_INT      = 82;
  GAME_TEXTURE_GAMEINTER1         = 'GameInter1.wil';
  GAME_TEXTURE_GAMEINTER1_INT     = 83;
  GAME_TEXTURE_GAMEINTER2         = 'GameInter2.wil';
  GAME_TEXTURE_GAMEINTER2_INT     = 84;
  GAME_TEXTURE_NPC                = 'NPC.wil';
  GAME_TEXTURE_NPC_INT            = 85;
  GAME_TEXTURE_NPCFACE            = 'NPCface.wil';
  GAME_TEXTURE_NPCFACE_INT        = 86;
  GAME_TEXTURE_MICON              = 'MIcon.wil';
  GAME_TEXTURE_MICON_INT          = 87;
  GAME_TEXTURE_MAPICON            = 'MapIcon.wil';
  GAME_TEXTURE_MAPICON_INT        = 88;
  GAME_TEXTURE_MMAP               = 'Mmap.wil';
  GAME_TEXTURE_MMAP_INT           = 89;
  GAME_TEXTURE_FMMAP              = 'Fmmap.wil';
  GAME_TEXTURE_FMMAP_INT          = 90;
  GAME_TEXTURE_INVENTORY          = 'Inventory.wil';
  GAME_TEXTURE_INVENTORY_INT      = 91;
  GAME_TEXTURE_STOREITEM          = 'Storeitem.wil';
  GAME_TEXTURE_STOREITEM_INT      = 92;
  GAME_TEXTURE_EQUIP              = 'Equip.wil';
  GAME_TEXTURE_EQUIP_INT          = 93;
  GAME_TEXTURE_GROUND             = 'Ground.wil';
  GAME_TEXTURE_GROUND_INT         = 94;
  GAME_TEXTURE_PEQUIPH1           = 'PEquipH1.wil';        //Pet
  GAME_TEXTURE_PEQUIPH1_INT       = 95;                    //Pet
  GAME_TEXTURE_PEQUIPB1           = 'PEquipB1.wil';        //Pet
  GAME_TEXTURE_PEQUIPB1_INT       = 96;                    //Pet
  { Human Body }
  HUMAN_TEXTURE_M_HUM_1           = 'M-Hum.wil';
  HUMAN_TEXTURE_WM_HUM_1          = 'WM-Hum.wil';
  HUMAN_TEXTURE_M_HUM_2           = 'M-HumA.wil';
  HUMAN_TEXTURE_WM_HUM_2          = 'WM-HumA.wil';
  HUMAN_TEXTURE_M_HUM_3           = 'M-HumEx1.wil';
  HUMAN_TEXTURE_WM_HUM_3          = 'WM-HumEx1.wil';
  HUMAN_TEXTURE_M_HUM_4           = 'M-HumAEx1.wil';
  HUMAN_TEXTURE_WM_HUM_4          = 'WM-HumAEx1.wil';
  HUMAN_TEXTURE_M_HUM_5           = 'M-HumEx2.wil';
  HUMAN_TEXTURE_WM_HUM_5          = 'WM-HumEx2.wil';
  HUMAN_TEXTURE_M_HUM_6           = 'M-HumAEx2.wil';
  HUMAN_TEXTURE_WM_HUM_6          = 'WM-HumAEx2.wil';
  { Human Wings }
  HUMAN_TEXTURE_M_SHUM_1          = 'M-SHum.wil';
  HUMAN_TEXTURE_WM_SHUM_1         = 'WM-SHum.wil';
  HUMAN_TEXTURE_M_SHUM_2          = 'M-SHumEx1.wil';
  HUMAN_TEXTURE_WM_SHUM_2         = 'WM-SHumEx1.wil';
  { Human Hair }
  HUMAN_TEXTURE_M_HAIR_1          = 'M-Hair.wil';
  HUMAN_TEXTURE_WM_HAIR_1         = 'WM-Hair.wil';
  HUMAN_TEXTURE_M_HAIR_2          = 'M-HairA.wil';
  HUMAN_TEXTURE_WM_HAIR_2         = 'WM-HairA.wil';
  HUMAN_TEXTURE_M_HAIR_3          = 'M-HairEx1.wil';
  HUMAN_TEXTURE_WM_HAIR_3         = 'WM-HairEx1.wil';
  HUMAN_TEXTURE_M_HAIR_4          = 'M-HairAEx1.wil';
  HUMAN_TEXTURE_WM_HAIR_4         = 'WM-HairAEx1.wil';
  { Human Helmet }
  HUMAN_TEXTURE_M_HELMET_1        = 'M-Helmet1.wil';
  HUMAN_TEXTURE_WM_HELMET_1       = 'WM-Helmet1.wil';
  HUMAN_TEXTURE_M_HELMET_2        = 'M-Helmet2.wil';
  HUMAN_TEXTURE_WM_HELMET_2       = 'WM-Helmet2.wil';
  HUMAN_TEXTURE_M_HELMET_3        = 'M-Helmet3.wil';
  HUMAN_TEXTURE_WM_HELMET_3       = 'WM-Helmet3.wil';
  HUMAN_TEXTURE_M_HELMET_4        = 'M-HelmetA1.wil';
  HUMAN_TEXTURE_WM_HELMET_4       = 'WM-HelmetA1.wil';
  HUMAN_TEXTURE_M_HELMET_5        = 'M-HelmetA2.wil';
  HUMAN_TEXTURE_WM_HELMET_5       = 'WM-HelmetA2.wil';
  HUMAN_TEXTURE_M_HELMET_6        = 'M-HelmetA3.wil';
  HUMAN_TEXTURE_WM_HELMET_6       = 'WM-HelmetA3.wil';
  { Human Weapon }
  HUMAN_TEXTURE_M_WEAPON_1        = 'M-Weapon1.wil';
  HUMAN_TEXTURE_WM_WEAPON_1       = 'WM-Weapon1.wil';
  HUMAN_TEXTURE_M_WEAPON_2        = 'M-Weapon2.wil';
  HUMAN_TEXTURE_WM_WEAPON_2       = 'WM-Weapon2.wil';
  HUMAN_TEXTURE_M_WEAPON_3        = 'M-Weapon3.wil';
  HUMAN_TEXTURE_WM_WEAPON_3       = 'WM-Weapon3.wil';
  HUMAN_TEXTURE_M_WEAPON_4        = 'M-Weapon4.wil';
  HUMAN_TEXTURE_WM_WEAPON_4       = 'WM-Weapon4.wil';
  HUMAN_TEXTURE_M_WEAPON_5        = 'M-Weapon5.wil';
  HUMAN_TEXTURE_WM_WEAPON_5       = 'WM-Weapon5.wil';
  HUMAN_TEXTURE_M_WEAPON_6        = 'M-Weapon6.wil';
  HUMAN_TEXTURE_WM_WEAPON_6       = 'WM-Weapon6.wil';
  HUMAN_TEXTURE_M_WEAPON_7        = 'M-Weapon7.wil';
  HUMAN_TEXTURE_WM_WEAPON_7       = 'WM-Weapon7.wil';
  HUMAN_TEXTURE_M_WEAPON_8        = 'M-Weapon8.wil';
  HUMAN_TEXTURE_WM_WEAPON_8       = 'WM-Weapon8.wil';
  HUMAN_TEXTURE_M_WEAPON_9        = 'M-Weapon9.wil';
  HUMAN_TEXTURE_WM_WEAPON_9       = 'WM-Weapon9.wil';
  HUMAN_TEXTURE_M_WEAPON_10       = 'M-Weapon10.wil';
  HUMAN_TEXTURE_WM_WEAPON_10      = 'WM-Weapon10.wil';
  HUMAN_TEXTURE_M_WEAPON_11       = 'M-Weapon11.wil';
  HUMAN_TEXTURE_WM_WEAPON_11      = 'WM-Weapon11.wil';
  HUMAN_TEXTURE_M_WEAPON_12       = 'M-Weapon12.wil';
  HUMAN_TEXTURE_WM_WEAPON_12      = 'WM-Weapon12.wil';
  { Human Weapon Assassin }
  HUMAN_TEXTURE_M_WEAPON_A1       = 'M-WeaponA1.wil';
  HUMAN_TEXTURE_WM_WEAPON_A1      = 'WM-WeaponA1.wil';
  HUMAN_TEXTURE_M_WEAPON_A2       = 'M-WeaponA2.wil';
  HUMAN_TEXTURE_WM_WEAPON_A2      = 'WM-WeaponA2.wil';
  HUMAN_TEXTURE_M_WEAPON_ADL1     = 'M-WeaponADL1.wil';
  HUMAN_TEXTURE_WM_WEAPON_ADL1    = 'WM-WeaponADL1.wil';
  HUMAN_TEXTURE_M_WEAPON_ADL2     = 'M-WeaponADL2.wil';
  HUMAN_TEXTURE_WM_WEAPON_ADL2    = 'WM-WeaponADL2.wil';
  HUMAN_TEXTURE_M_WEAPON_ADR1     = 'M-WeaponADR1.wil';
  HUMAN_TEXTURE_WM_WEAPON_ADR1    = 'WM-WeaponADR1.wil';
  HUMAN_TEXTURE_M_WEAPON_ADR2     = 'M-WeaponADR2.wil';
  HUMAN_TEXTURE_WM_WEAPON_ADR2    = 'WM-WeaponADR2.wil';
  HUMAN_TEXTURE_M_WEAPON_AOH1     = 'M-WeaponAOH1.wil';
  HUMAN_TEXTURE_WM_WEAPON_AOH1    = 'WM-WeaponAOH1.wil';
  HUMAN_TEXTURE_M_WEAPON_AOH2     = 'M-WeaponAOH2.wil';
  HUMAN_TEXTURE_WM_WEAPON_AOH2    = 'WM-WeaponAOH2.wil';
  HUMAN_TEXTURE_M_WEAPON_AOH3     = 'M-WeaponAOH3.wil';
  HUMAN_TEXTURE_WM_WEAPON_AOH3    = 'WM-WeaponAOH3.wil';

  MONSTER_TEXTURE_HORSE_1         = 'Horse.wil';
  MONSTER_TEXTURE_HORSE_2         = 'Horse_Golden.wil';
  MONSTER_TEXTURE_HORSE_3         = 'Horse_Iron.wil';
  MONSTER_TEXTURE_HORSE_4         = 'Horse_Silver.wil';
  MONSTER_TEXTURE_HORSE_Shadow    = 'HorseS.wil';

  MAGIC_TEXTURE_1                 = 'Magic.wil';
  MAGIC_TEXTURE_2                 = 'MagicEX.wil';
  MAGIC_TEXTURE_3                 = 'MagicEx2.wil';
  MAGIC_TEXTURE_4                 = 'MagicEx3.wil';
  MAGIC_TEXTURE_5                 = 'MagicEx4.wil';
  MAGIC_TEXTURE_6                 = 'MagicEx5.wil';

  MAGIC_MONSTER_TEXTURE_1         = 'MonMagic.wil';
  MAGIC_MONSTER_TEXTURE_2         = 'MonMagicEx.wil';
  MAGIC_MONSTER_TEXTURE_3         = 'MonMagicEx2.wil';
  MAGIC_MONSTER_TEXTURE_4         = 'MonMagicEx3.wil';
  MAGIC_MONSTER_TEXTURE_5         = 'MonMagicEx4.wil';
  MAGIC_MONSTER_TEXTURE_6         = 'MonMagicEx5.wil';
  MAGIC_MONSTER_TEXTURE_7         = 'MonMagicEx6.wil';
  MAGIC_MONSTER_TEXTURE_8         = 'MonMagicEx7.wil';
  MAGIC_MONSTER_TEXTURE_9         = 'MonMagicEx8.wil';
  MAGIC_MONSTER_TEXTURE_10        = 'MonMagicEx9.wil';
  MAGIC_MONSTER_TEXTURE_11        = 'MonMagicEx10.wil';

  MAX_MONSTER_FILE                = 49;
  MONSTER_TEXTURE_NORMAL          = 'Mon-%d.wil';
  MONSTER_TEXTURE_SHADOW          = 'MonS-%d.wil';

  { Video and Video Sound Files }
  VIDEO_GAME_START                = 'Wemade.dat';
  VIDEO_GAME_CREATE_CHAR          = 'CreateChr.dat';
  VIDEO_GAME_START_GAME           = 'StartGame.dat';
  VIDEO_SOUND_CREATE_CHAR         = 'CreateChr.wav';
  VIDEO_SOUND_START_GAME          = 'StartGame.wav';

  CONFIG_USER_FILE                = 'Mir3Client.conf';
  LOG_MIR3_CLIENT                 = 'Mir3Client.log';
  FONT_FILE                       = 'Mir3FontData.mfd';

implementation

end.
