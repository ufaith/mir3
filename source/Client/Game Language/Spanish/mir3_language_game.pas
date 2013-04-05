(******************************************************************************
 *   LomCN Mir3 Spanish Game Language LGU File 2013                           *
 *                                                                            *
 *   Web       : http://www.lomcn.co.uk                                       *
 *   Version   : 0.0.0.1                                                      *
 *                                                                            *
 *   - File Info -                                                            *
 *                                                                            *
 *   It holds the mir3 game spanish language strings.                         *
 *                                                                            *
 ******************************************************************************
 * Change History                                                             *
 *                                                                            *
 *  - 0.0.0.1 [2013-04-05] Elamo : first init                                 *
 *                                                                            *
 *                                                                            *
 *                                                                            *
 *                                                                            *
 ******************************************************************************
 * :Info:                                                                     *
 * The Maximum of String Literale is 255 so you need to add ' + '             *
 * at the end of 255 Char...                                                  *
 * The String it self can have a length of 1024                               *
 *****************************************************************************)

unit mir3_language_game;

interface

uses Windows, SysUtils, Classes;

function GetGameLine(): Integer; stdcall;
function GetGameString(ID: Integer; Buffer: PChar): Integer; stdcall;

implementation

function GetGameLine(): Integer; stdcall;
begin
  Result := 2000;
end;

function GetGameString(ID: Integer; Buffer: PChar): Integer; stdcall;
var
  Value : string;
begin
  case ID of
    (*******************************************************************
    *                     Login, Server Selection.                     *
    *******************************************************************)
    1 : Value := 'Iniciar Sesión';                                                              // Button
    2 : Value := 'Salir';                                                                // Button
    3 : Value := 'Registrar Cuenta';                                                         // Button URL
    4 : Value := 'Cambiar Contraseña';                                                     // Button URL
    5 : Value := 'ID                            CONTRASEÑA';                            // Button
    6 : Value := 'Iniciar Sesión (L)';                                                          // [1] Hint
    7 : Value := 'Salir (X)';                                                            // [2] Hint
    8 : Value := 'Registrar Cuenta (N)';                                                     // [3] Hint
    9 : Value := 'Cambiar Contraseña (P)';                                                 // [4] Hint
    10: Value := 'Has sido desconectado.';                                         // Infoboard
    11: Value := 'El server esta actualmente'+#10#13+'cerrado por mantenimiento.';              // Infoboard
    12: Value := 'No se ha podido establecer la conexión con el servidor.'+#10#13+'El servidor es inaccesible.';   // Infoboard
    13: Value := '¿Estas seguro de que deseas salir?';
    14: Value := 'Reservado';
    15: Value := 'Reservado';
    { SM_LOGIN_PASSWORD_FAIL }
    16: Value := 'Tu usuario y/o contraseña no es correcto'      +#10#13+'Por favor intentalo de nuevo.';
    17: Value := 'Has intentado iniciar sesión tres veces '     +#10#13+'con unos datos de cuenta invalidos.'           +#10#13+'Por favor intentalo de nuevo.';//'Please restart the game client.';
    18: Value := 'No ha sido posible acceder a la'  +#10#13+'información de su cuenta.'  +#10#13+'Por favor intentalo de nuevo.';
    19: Value := 'Su cuenta ha sido bloqueada.'        +#10#13+'Por favor visita www.lomcn.co.uk'+#10#13+'para más información.';
    20: Value := 'Tu suscripción ha terminado.'    +#10#13+'Por favor visita www.lomcn.co.uk'+#10#13+'para más información.';
    21: Value := '¡Ha ocurrido un error desconocido!'          +#10#13+'Por favor visita www.lomcn.co.uk'+#10#13+'para más información.';
    22: Value := 'Reservado';
    23: Value := 'Reservado';
    24: Value := 'Reservado';
    25: Value := 'Reservado';
    { SM_LOGIN_PASSWORD_OK Verify Subscription }
    26: Value := '¡Tu suscripción termina hoy!'     +#10#13+'Por favor visita www.lomcn.co.uk'+#10#13+'para más información.';
    27: Value := 'Tu suscripción termina en'     +#10#13+'%d dias.';
    28: Value := 'Tu acceso por IP expira en'     +#10#13+'%d dias.';            //'Your IP in use has remaining'         +#10#13+' %d days to access.';
    29: Value := '¡Tu acceso por IP expira hoy!';                                              //'Your IP in use expires today.';
    30: Value := 'Tu acceso por IP expira en'     +#10#13+'%d horas.';           //'Your IP in use has remaining'         +#10#13+' %d hours to access.';
    31: Value := 'Tu cuenta sera valida durante'    +#10#13+'%d horas más.';                   //'Your ID in use has remaining'         +#10#13+' %d hours to access.';
    32: Value := 'Reservado';
    33: Value := 'Reservado';
    34: Value := 'Reservado';
    35: Value := 'Reservado';
    36: Value := 'Reservado';
    37: Value := 'Reservado';
    38: Value := 'Reservado';
    39: Value := 'Reservado';
    40: Value := 'Reservado';
    (*******************************************************************
    *               Character Selection / Creation                     *
    *******************************************************************)
    41: Value := 'Cargando la información de los personajes, por favor espere.';
    42: Value := 'Seleccionar Guerrero';
    43: Value := 'Seleccionar Mago';
    44: Value := 'Seleccionar Taoista';
    45: Value := 'Seleccionar Asesino';
    46: Value := 'Confirmar';
    47: Value := 'Cancelar';
    48: Value := 'Nombre';
    49: Value := 'Nivel';
    50: Value := 'Clase';
    51: Value := 'Oro';
    52: Value := 'Exp';
    53: Value := '[ ';
    54: Value := ' ]';
    55: Value := 'Hombre';
    56: Value := 'Mujer';
    57: Value := 'Guerrero';
    58: Value := 'Mago';
    59: Value := 'Taoista';
    60: Value := 'Asesino';
    { Information about Warriors }
    61: Value := 'Los guerreros son una clase de gran fuerza y vitalidad. No son fácilmente   ' + #10#13 +
                 'de matar en combate y tienen la ventaja de ser capaces de utilizar una gran ' + #10#13 +
                 'variedad de armas y armaduras muy pesadas. Los guerreros son muy fuertes en ' + #10#13 +
                 'ataques a corta distancia, pero débiles en larga distancia. La gran         ' + #10#13 +
                 'variedad de equipo que se ha desarrollado especificamente para guerreros    ' + #10#13 +
                 'complementa su debilidad en ataques a larga distancia. Son muy recomendados ' + #10#13 +
                 'para principiantes por la simplicidad de sus ataques pero de gran fuerza    ';
    { Information about Wizards }
    62: Value := 'Los magos son una clase de baja fuerza fisica y vitalidad, pero tienen la   ' + #10#13 +
                 'habilidad de utilizar poderosos hechizos. Sus hechizos ofensivos son muy    ' + #10#13 +
                 'eficaces pero el tiempo que se tarda en volver a lanzar los conjuros lo     ' + #10#13 +
                 'pueden dejar vulnerable en un contraaque del enemigo. Por eso un mago       ' + #10#13 +
                 'siempre debe lanzar sus hechizos desde una distancia segura. Al ser una     ' + #10#13 +
                 'fisicamente debil, la hace al principio dificil de entrenar. Pero se        ' + #10#13 +
                 'convierten en personajes poderosos a medida que van aprendiendo hechizos.   ' + #10#13 +
                 'Debido a su cantidad de ventajes y desventajas es necesario tener cierta    ' + #10#13 +
				 'atención y destreza para sacarle el máximo partido a su poder.              ';
    { Information about Taoists }
    63: Value := 'Los taoístas estan entre los guerreros y magos en terminos de resistencia  y' + #10#13 +
                 'supervivencia, pero no así su fuerza directa contra enemigos, su verdadero  ' + #10#13 +
                 'poder esta en apoyar a los demás. Sus habilidades especiales son la de curar' + #10#13 +
                 'y proteger a los demás. También pueden invocar a criaturas poderosas para   ' + #10#13 +
                 'ayudarles, y tienen pocas opciones ofensivas balanceadas. A pesar de que los' + #10#13 +
                 'taoístas tienen muchas habilidades, su falta de fuerza física los hace muy  ' + #10#13 +
                 'complicados de entrenar. Siempre debe colaborar para luchar con otros.';
    { Information about Assassins }
    64:Value :=  'Los asesinos pertenecen a una organización secreta y su historia es           ' + #10#13 +
                 'relativamente desconicida. Son físicamente débiles, pero son capaces de       ' + #10#13 +
                 'esconderse y de realizar ataques sin ser vistos. Son muy eficaces realizando  ' + #10#13 +
                 'muertes realmente rápidas. Sin embargo deben tener cuidado con enfretamientos ' + #10#13 +
                 'multiples ya que su defensa es menor comparada con el resto de personajes.    ' + #10#13 +
                 'characters. Los asesinos son recomendados para jugadores con experiencia ya   ' + #10#13 +
                 'requiere de movimientos inteligentes, decisiones astutas y pensamiento rápido.';
    65: Value := 'Personaje eliminado.';             
    66: Value := 'Los personajes eliminado no pueden ser ' + #10#13 +
                 'recuperados y no se podra crear otro '   + #10#13 +
                 'con el mismo nombre durante un tiempo.'  + #10#13 +
                 'Si estas seguro continua, escribe tu contraseña'    + #10#13 +
                 'y pulsa el botón Sí';     // 'Yes' sounds awkward but what does the button actually say? It should probably say "Confirm"   Coly: I can use a Text Button with own Text...
    67: Value := 'No puedes crear más de %d personajes.';
    68: Value := 'Por favor crea un personaje primero.';// by'+ #10#13 +'clicking the New Character button.';
    69: Value := 'No se ha podido acceder a la información de los personajes.';
    70: Value := 'El personaje ya existe con este nombre.';
    71: Value := 'No puedes crear otro personaje.';
    72: Value := 'La creación del personaje ha fallado - Código de error: 4';
    73: Value := 'Ha ocurrido un error desconocido.'+#10#13+'Por favor visita www.lomcn.co.uk'+#10#13+'para más información.';
    74: Value := 'Ha ocurrido un error al borrar'      + #10#13 +'tu personaje.';
    75: Value := 'Reservado';
    76: Value := 'Reservado';
    77: Value := 'Reservado';
    78: Value := 'Reservado';
    79: Value := 'Reservado';
    80: Value := 'Reservado';
    (*******************************************************************
    *                        InGame Text                               *
    *******************************************************************)
    {Menu Bar}
    81: Value := 'Configuración';
    82: Value := 'Chat';
    83: Value := 'Mensajes';
    84: Value := 'Grupo';
    85: Value := 'Clan';
    86: Value := 'Avatar';
    87: Value := 'Siege';
    88: Value := 'Auto-Features';
    89: Value := 'Salir';
    90: Value := 'Cerrar';
    91..100 : Value := 'Reservado';
    {Game Settings}
    101: Value := 'Basico';
    102: Value := 'Permitir'; // not great, but I can't find another word that's short enough    Coly: give me some words and I test it...
    103: Value := 'Chat';
    104: Value := 'Visual';
    { Page 1 Basic }
    105: Value := 'Modo Ataque (All)';
    106: Value := 'Modo Ataque (Peaceful)';
    107: Value := 'Modo Ataque (Lover)'; //(Dear)'; - Lover, Partner, Spouse, Couple, Marriage
    108: Value := 'Modo Ataque (Master)';
    109: Value := 'Modo Ataque (Group)';
    110: Value := 'Modo Ataque (Guild)';
    111: Value := 'Modo Ataque (Red vs. White)';
    112: Value := 'Resevado';
    113: Value := 'Resevado';
    114: Value := 'Cambiar modo de ataque';           // Hint for Attack Mode
    116: Value := 'Modo Ataque Normal';
    117: Value := 'Cambiar modo de ataque';             // Hint for Attack Mode
    118: Value := 'Música de fondo';
    119: Value := '[ Música Fondo On/Off ]';  // Hint Background Music
    120: Value := 'Efectos de Sonido';
    121: Value := '[ Efectos Sonido On/Off ]';     // Hint Sound Effects
    122: Value := 'Dirección (Estéreo) Sonido';
    123: Value := '[ Dirección Sonido On/Off ]';          // Hint Sound Effects
    124: Value := 'Recogida Automática';
    125: Value := '[ Recogida Automática On/Off ]'; // Hint Sound Effects
    126: Value := 'Mostrar los nombres de los objetos tirados';
    127: Value := '[ Mostrar Nombre Objetos Tirados On/Off ]'; // Hint Sound Effects
    { Page 2 Permissions }
    128: Value := 'Permitir Invitaciones de Grupo';
    129: Value := '[ Permitir Invitaciones de Grupo On/Off ]';
    130: Value := 'Permitir Invitaciones de Clanes';
    131: Value := '[ Permitir Invitaciones de Clanes On/Off ]';
    132: Value := 'Permitir Resurección';
    133: Value := '[ Permitir Resurección On/Off ]';
    134: Value := 'Permitir desplazamiento';
    135: Value := '[ Permitir desplazamiento On/Off ]';
    136: Value := 'Permitir Comerciar';
    137: Value := '[ Pertimir Comerciar On/Off ]';
    138: Value := 'Mostrar Sangre';                      // I have no idea what this is.  Coly: It is for  blood spatter (we have Textures for it (Only From 18 years up))
    139: Value := '[ Mostrar Sangre On/Off ]';
    140: Value := 'Reservado';
    141: Value := 'Insinuar reservado';
    142: Value := 'Reservado';
    143: Value := 'Insinuar reservado';
    144: Value := 'Reservado';
    145: Value := 'Insinuar reservado';
    146: Value := 'Reservado';
    147: Value := 'Insinuar reservado';
    { Page 3 Chatting }
    148: Value := 'Susurro';
    149: Value := '[ Escuchar susurros On/Off ]';
    150: Value := 'Gritos';
    151: Value := '[ Escuchar gritos On/Off ]';
    152: Value := 'Reservado';
    153: Value := 'Insinuar Reservado';
    154: Value := 'Mensajes Clan';
    155: Value := '[ Escuchar Mensajes Clan On/Off ]';
    156: Value := 'Bloquear susurro de usuarios';
    158: Value := '[ Bloquear susurro de usuarios ]';    // Should it be "User %s"?  Coly: no idea, if so we need to add it
    157: Value := 'Reservado'; //<-- Hint for "Whispering from User blocked"
    159: Value := 'Reservado';
    160: Value := 'Insinuar reservado';
    161: Value := 'Reservado';
    162: Value := 'Insinuar reservado';
    163: Value := 'Reservado';
    164: Value := 'Insinuar reservado';
    165: Value := 'Reservado';
    166: Value := 'Insinuar reservado';
    167: Value := 'Reservado';
    168: Value := 'Insinuar reservado';
    { Page 4 Visual }
    169: Value := 'HP Cambiar Indicador';
    170: Value := '[ HP Cambiar Indicador On/Off ]';
    171: Value := 'Mostrar Graficos Magias';
    172: Value := '[ Graficos Magias On/Off ]';
    173: Value := 'Mostrar sombras brillantes';
    174: Value := '[ Sombras Brillantes On/Off ]';
    175: Value := 'Mostrar graficos del casco';
    176: Value := '[ Graficos Casco On/Off ]';
    177: Value := 'Mostrar efectos de monstruos';
    178: Value := '[ Montruos Efectos On/Off ]';
    179: Value := 'Mostrar colores teñidos del pelo';
    180: Value := '[ Colores Teñidos Pelo On/Off ]';
    181: Value := 'Mostrar Avatar';
    182: Value := '[ Avatar On/Off ]';
    183: Value := 'Mostrar Monstruos en el Mini-mapa';  // The text is a bit to long
    184: Value := '[ Mostruos en el Mini-mapa On/Off ]';
    185: Value := 'Mostrar HP Personaje';
    186: Value := '[ Mostrar HP Personaje On/Off ]';
    187: Value := 'Mostrar HP Monstruo';
    188: Value := '[ Mostrar HP Monstruo On/Off ]';
    189: Value := 'Reservado';
    { Exit Window }
    190: Value := 'Salir';
    191: Value := 'Salir del juego.';
    192: Value := 'Cerrar sesión';
    193: Value := 'Cerrar sesión y seleccionar un nuevo personaje.';
    194: Value := '¿Estas seguro que deseas salir?';
    195: Value := 'Cancelar';
    { Belt Window }
    196: Value := 'Girar';         //Hint
    197: Value := 'Cerrar';          //Hint
    198: Value := 'Reservado';
    199: Value := 'Reservado';
    200: Value := 'Reservado';
    { Mini Map }
    201: Value := ''; //Hint
    202: Value := ''; //Hint
    203: Value := ''; //Hint
    204: Value := ''; //Hint
    205: Value := 'No Mini-mapa';
    206: Value := 'No hay mapa disponible!';
    207: Value := 'No se usa';
    208..210: Value := 'Reservado';
    { Body Window }
    211: Value := 'Nivel';
    212: Value := 'Experiencia';
    213: Value := 'Puntos Vitalidad (HP)';
    214: Value := 'Puntos Energia (MP)';
    215: Value := 'Peso Bolsa';
    216: Value := 'Peso Cuerpo';
    217: Value := 'Peso Mano';
    218: Value := 'Preción';
    219: Value := 'Agilidad';
    220: Value := 'Ele(Atk)';
    221: Value := 'Ele(Def)';
    222: Value := 'Ele(Wkn)';
    223: Value := 'Elemento Atk (Attack)';     //Hint
    224: Value := 'Elemento Def (Defence)';          //Hint
    225: Value := 'Elemento Wkn (Weakness)';         //Hint
    226: Value := 'Elemento Fire (Attack)';    //Hint
    227: Value := 'Elemento Fire (Defence)';         //Hint
    228: Value := 'Elemento Fire (Weakness)';        //Hint
    229: Value := 'Elemento Ice (Attack)';     //Hint
    230: Value := 'Elemento Ice (Defence)';          //Hint
    231: Value := 'Elemento Ice (Weakness)';         //Hint
    232: Value := 'Elemento Thunder (Attack)'; //Hint
    233: Value := 'Elemento Thunder (Defence)';      //Hint
    234: Value := 'Elemento Thunder (Weakness)';     //Hint
    235: Value := 'Elemento Wind (Attack)';    //Hint
    236: Value := 'Elemento Wind (Defence)';         //Hint
    237: Value := 'Elemento Wind (Weakness)';        //Hint
    238: Value := 'Elemento Holy (Attack)';    //Hint
    239: Value := 'Elemento Holy (Defence)';         //Hint
    240: Value := 'Elemento Holy (Weakness)';        //Hint
    241: Value := 'Elemento Dark (Attack)';    //Hint
    242: Value := 'Elemento Dark (Defence)';         //Hint
    243: Value := 'Elemento Dark (Weakness)';        //Hint
    244: Value := 'Elemento Phantom (Attack)'; //Hint
    245: Value := 'Elemento Phantom (Defence)';      //Hint
    246: Value := 'Elemento Phantom (Weakness)';     //Hint
    247..250: Value := 'Reservado';
    { Group Window }
    251: Value := 'Grupo';
    252: Value := 'Cerrar ventana de grupo';             //Hint
    253: Value := 'Añadir miembro al grupo';            //Hint
    254: Value := 'Borrar miembro del grupo';       //Hint
    255: Value := 'Crear un grupo';                 //Hint
    256: Value := 'Permitir invitaciones al grupo';        //Hint

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

    1071..2000: Value := 'Reservado';
    else Value := 'No soportado';
  end;

  ////////////////////////////////////////////////////////////////////////////
  ///

  if Assigned(Buffer) then
    CopyMemory(Buffer, PChar(Value), Length(Value));
  Result := Length(Value);
end;

end.
