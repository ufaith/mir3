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
 *  - 0.0.0.2 [2013-04-06] Ashran : translated, needs in-game checking!       *
 *                                                                            *
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
 *                                                                            *
 * !!! Attention, only the Spanish language files are                         * 
 * !!! matched by the development team, not other languages??.                *
 *                                                                            * 
 ******************************************************************************)

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
<<<<<<< .mine
    1 : Value := 'Entrar';                                                              // Button
    2 : Value := 'Salir';                                                                // Button
    3 : Value := 'Nueva cuenta';                                                         // Button URL
    4 : Value := 'Cambiar contraseña';                                                     // Button URL
    5 : Value := 'ID                                      CONTRASEÑA¦CE¦';                // Button
    6 : Value := 'Entrar (L)';                                                          // [1] Hint
    7 : Value := 'Salir (X)';                                                            // [2] Hint
    8 : Value := 'Nueva cuenta (N)';                                                     // [3] Hint
    9 : Value := 'Cambiar contraseña (P)';                                                 // [4] Hint
    10: Value := 'Has sido desconectado.';                                         // Infoboard
    11: Value := 'El servidor está\desconectado por mantenimiento.';                       // Infoboard
    12: Value := 'No se puede conectar al servidor.\El servidor es inalcanzable.';            // Infoboard
    13: Value := '¿Seguro que quieres salir?';
    14: Value := 'Reserved';
    15: Value := 'Reserved';
=======
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
>>>>>>> .r31
    { SM_LOGIN_PASSWORD_FAIL }
<<<<<<< .mine
    16: Value := 'Tu ID o contraseña es incorrecto.\Inténtalo otra vez.';
    17: Value := 'Has introducido datos\erróneos tres veces.\Inténtalo más tarde.';
    18: Value := 'No se puede acceder a la información de la cuenta.\Inténtalo otra vez.';
    19: Value := 'Tu cuenta ha sido deshabilitada.\Visita www.lomcn.org\para más detalles.';
    20: Value := 'Tu subscripción ha caducado.\Visita www.lomcn.org\para más detalles.';
    21: Value := '¡Han ocurrido errores desconocidos!\Visita www.lomcn.org\para más detalles.';
    22: Value := 'Reserved';
    23: Value := 'Reserved';
    24: Value := 'Reserved';
    25: Value := 'Reserved';
=======
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
>>>>>>> .r31
    { SM_LOGIN_PASSWORD_OK Verify Subscription }
<<<<<<< .mine
    26: Value := '¡Tu subscripción caduca hoy!\Visita http://www.lomcn.org\para más detalles.';
    27: Value := 'Tu subscripción caducará en\ %d días.';
    28: Value := 'El acceso de tu IP será válido por\otros %d días.';
    29: Value := '¡El acceso de tu IP caduca hoy!';
    30: Value := 'El acceso de tu IP será válido por\otras %d horas.';
    31: Value := 'Tu ID será válido por otras\ %d horas.';
    32: Value := 'Reserved';
    33: Value := 'Reserved';
    34: Value := 'Reserved';
    35: Value := 'Reserved';
    36: Value := 'Reserved';
    37: Value := 'Reserved';
    38: Value := 'Reserved';
    39: Value := 'Reserved';
    40: Value := 'Reserved';
=======
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
>>>>>>> .r31
    (*******************************************************************
    *               Character Selection / Creation                     *
    *******************************************************************)
<<<<<<< .mine
    41: Value := 'Cargando la información de los personajes. Por favor, espera.';
    42: Value := 'Seleccionar Guerrero';
    43: Value := 'Seleccionar Mago';
    44: Value := 'Seleccionar Taoísta';
    45: Value := 'Seleccionar Asesino';
    46: Value := 'Confirmar';
    47: Value := 'Cancelar';
    48: Value := 'Nombre';
    49: Value := 'Nivel';
    50: Value := 'Clase';
    51: Value := 'Oro';
    52: Value := 'Exp.';
=======
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
>>>>>>> .r31
<<<<<<< .mine
    53: Value := 'Reserved';
    54: Value := 'Reserved';
    55: Value := 'Hombre';
    56: Value := 'Mujer';
    57: Value := 'Guerrero';
    58: Value := 'Mago';
    59: Value := 'Taoísta';
    60: Value := 'Asesino';
=======
    53: Value := '[ ';
    54: Value := ' ]';
    55: Value := 'Hombre';
    56: Value := 'Mujer';
    57: Value := 'Guerrero';
    58: Value := 'Mago';
    59: Value := 'Taoista';
    60: Value := 'Asesino';
>>>>>>> .r31
    { Information about Warriors }
<<<<<<< .mine
    61: Value := '¦Y05¦¦C1D1AD69¦¦C23A3A3A¦ [%s Guerrero]¦CE¦\¦Y08¦'             // SE: Better to have gender first
    					 + ' Los Guerreros son excelentes en ataque cuerpo a cuerpo debido a su poder y\'
    					 + ' resistencia. Éstos pueden aprender varios estilos de artes marciales: desde\'
    					 + ' el básico Swordmanship al poderoso BladeStorm. Llegan a ser realmente formidables\'
    					 + ' cuando unen todos sus poderes, aunque son débiles si son atacados a distancia.\'
    					 + ' Son fáciles de manejar y consiguen subir antes de nivel al principio.\';
=======
    61: Value := 'Los guerreros son una clase de gran fuerza y vitalidad. No son fácilmente   ' + #10#13 +
                 'de matar en combate y tienen la ventaja de ser capaces de utilizar una gran ' + #10#13 +
                 'variedad de armas y armaduras muy pesadas. Los guerreros son muy fuertes en ' + #10#13 +
                 'ataques a corta distancia, pero débiles en larga distancia. La gran         ' + #10#13 +
                 'variedad de equipo que se ha desarrollado especificamente para guerreros    ' + #10#13 +
                 'complementa su debilidad en ataques a larga distancia. Son muy recomendados ' + #10#13 +
                 'para principiantes por la simplicidad de sus ataques pero de gran fuerza    ';
>>>>>>> .r31
    { Information about Wizards }
<<<<<<< .mine
    62: Value := '¦Y05¦¦C1D1AD69¦¦C23A3A3A¦ [%s Mago]¦CE¦\¦Y08¦'
    					 + ' Los Magos pueden lanzar variados hechizos, por lo que son interesantes y\'
    					 + ' divertidos. Son buenos en combate a distancia pero muy limitados en combate\'
    					 + ' cuerpo a cuerpo debido a su debilidad física. En niveles superiores pueden\'
    					 + ' ser muy poderosos con sus fantásticas artes, aunque deben estar en todo\'
    					 + ' momento atentos a su cantidad de vida, por lo que su manejo es complicado\'
    					 + ' en sus inicios.\';
=======
    62: Value := 'Los magos son una clase de baja fuerza fisica y vitalidad, pero tienen la   ' + #10#13 +
                 'habilidad de utilizar poderosos hechizos. Sus hechizos ofensivos son muy    ' + #10#13 +
                 'eficaces pero el tiempo que se tarda en volver a lanzar los conjuros lo     ' + #10#13 +
                 'pueden dejar vulnerable en un contraaque del enemigo. Por eso un mago       ' + #10#13 +
                 'siempre debe lanzar sus hechizos desde una distancia segura. Al ser una     ' + #10#13 +
                 'fisicamente debil, la hace al principio dificil de entrenar. Pero se        ' + #10#13 +
                 'convierten en personajes poderosos a medida que van aprendiendo hechizos.   ' + #10#13 +
                 'Debido a su cantidad de ventajes y desventajas es necesario tener cierta    ' + #10#13 +
				 'atención y destreza para sacarle el máximo partido a su poder.              ';
>>>>>>> .r31
    { Information about Taoists }
<<<<<<< .mine
    63: Value := '¦Y05¦¦C1D1AD69¦¦C23A3A3A¦ [%s Taoísta]¦CE¦\¦Y08¦'
               + ' Los Taoístas tienen habilidades físicas y espirituales. Estudian la vida y\'
               + ' la muerte, así que tienen grandes conocimientos de medicina y técnicas de\'
               + ' apoyo a las demás clases. Sus primeras técnicas son la curación y el uso de\'
               + ' distintos tipos de veneno. Los usuarios inexpertos tardarán en aprender su\'
               + ' funcionamiento al tener que usar diferentes objetos especiales, pero llegan\'
               + ' a convertirse en personajes indispensables para los demás.\';
=======
    63: Value := 'Los taoístas estan entre los guerreros y magos en terminos de resistencia  y' + #10#13 +
                 'supervivencia, pero no así su fuerza directa contra enemigos, su verdadero  ' + #10#13 +
                 'poder esta en apoyar a los demás. Sus habilidades especiales son la de curar' + #10#13 +
                 'y proteger a los demás. También pueden invocar a criaturas poderosas para   ' + #10#13 +
                 'ayudarles, y tienen pocas opciones ofensivas balanceadas. A pesar de que los' + #10#13 +
                 'taoístas tienen muchas habilidades, su falta de fuerza física los hace muy  ' + #10#13 +
                 'complicados de entrenar. Siempre debe colaborar para luchar con otros.';
>>>>>>> .r31
    { Information about Assassins }
<<<<<<< .mine
    64: Value :=  '¦Y05¦¦C1D1AD69¦¦C23A3A3A¦ [%s Asesino]¦CE¦\¦Y08¦'
               + '¦C1D1AD69¦¦C2C19D59¦ Los Asesinos son miembros de una organización secreta y su historia es relativamente\'
               + ' desconocida. Son débiles físicamente, pero pueden esconderse y realizar\'
               + ' ataques mientras los demás no pueden verlos. También son excelentes en\'
               + ' matar rápidamente. Sin embargo tienen que ir con mucho cuidado a no\'
               + ' encontrarse con múltiples adversarios, ya que tienen menos técnicas\'
               + ' defensivas que los otros personajes. Los Asesinos son recomendados\'
               + ' para jugadores experimentados, porque necesitan movimientos ágiles,\'
               + ' astucia en las decisiones y pensamiento rápido.\';
    65: Value := 'Personaje borrado.';
    66: Value := 'Los personajes borrados no pueden ser\'
    					 + 'recuperados y no podrás crear otro personaje'\
    					 + 'con el mismo nombre por un tiempo. Si quieres'\
    					 + 'continuar, introduce tu contraseña'\
    					 + 'y pulsa el botón de "Confirmar".';
    67: Value := 'No puedes crear más de %d personajes.';
    68: Value := 'Debes crear un personaje antes.';
    69: Value := 'No se pudo acceder a la información de los personajes.';
    70: Value := 'Ya existe un personaje con este nombre.';
    71: Value := 'No puedes crear otro personaje.';
    72: Value := 'Error en la creación de personajes - código 4';
    73: Value := 'Han ocurrido errores desconocidos.\Visita www.lomcn.org\para más detalles.';
    74: Value := 'Ha habido un error borrando\tu personaje.';
    75: Value := 'Jugar¦CE¦';
    76: Value := 'Nuevo personaje¦CE¦';
    77: Value := 'Borrar personaje¦CE¦';
    78: Value := 'Salir¦CE¦';
    79: Value := 'Reserved';
    80: Value := 'Reserved';
=======
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
>>>>>>> .r31
    (*******************************************************************
    *                        InGame Text                               *
    *******************************************************************)
    {Menu Bar}
<<<<<<< .mine
    81: Value := 'Opciones';
=======
    81: Value := 'Configuración';
>>>>>>> .r31
    82: Value := 'Chat';
<<<<<<< .mine
    83: Value := 'Mail';
    84: Value := 'Grupo';
    85: Value := 'Clan';
=======
    83: Value := 'Mensajes';
    84: Value := 'Grupo';
    85: Value := 'Clan';
>>>>>>> .r31
    86: Value := 'Avatar';
<<<<<<< .mine
    87: Value := 'Asedio';
    88: Value := 'Auto';
    89: Value := 'Salir';
    90: Value := 'Cerrar';
    91..100 : Value := 'Reserved';
=======
    87: Value := 'Siege';
    88: Value := 'Auto-Features';
    89: Value := 'Salir';
    90: Value := 'Cerrar';
    91..100 : Value := 'Reservado';
>>>>>>> .r31
    {Game Settings}
<<<<<<< .mine
    101: Value := 'General';
    102: Value := 'Permisos';
=======
    101: Value := 'Basico';
    102: Value := 'Permitir'; // not great, but I can't find another word that's short enough    Coly: give me some words and I test it...
>>>>>>> .r31
    103: Value := 'Chat';
    104: Value := 'Imagen';
    { Page 1 Basic }
<<<<<<< .mine
    105: Value := 'Modo de ataque (Todos)';
    106: Value := 'Modo de ataque (Pacífico)';
    107: Value := 'Modo de ataque (Pareja)'; //(Dear)'; - Lover, Partner, Spouse, Couple, Marriage
    108: Value := 'Modo de ataque (Maestro)';
    109: Value := 'Modo de ataque (Grupo)';
    110: Value := 'Modo de ataque (Clan)';
    111: Value := 'Modo de ataque (Asesinos)';
    112: Value := 'Reserved';
    113: Value := 'Reserved';
    114: Value := 'Cambiar modo de ataque';                   // Hint for Attack Mode
    116: Value := 'Modo de ataque normal';
    117: Value := 'Cambiar modo de ataque';                   // Hint for Attack Mode
    118: Value := 'Música de fondo';
    119: Value := '[ Música de fondo: On/Off ]';            // Hint Background Music
    120: Value := 'Efectos de sonido';
    121: Value := '[ Efectos de sonido: On/Off ]';               // Hint Sound Effects
    122: Value := 'Sonido direccional (stereo)';
    123: Value := '[ Sonido direccional: On/Off ]';           // Hint Sound Effects
    124: Value := 'Auto-recoger objetos';
    125: Value := '[ Auto-recoger objetos: On/Off ]';           // Hint Sound Effects
    126: Value := 'Mostrar nombre de drops';
    127: Value := '[ Mostrar nombre de drops: On/Off ]'; // Hint Sound Effects
=======
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
>>>>>>> .r31
    { Page 2 Permissions }
<<<<<<< .mine
    128: Value := 'Permitir unión a grupo';
    129: Value := '[ Permitir unión a grupo: On/Off ]';
    130: Value := 'Permitir unión a clan';
    131: Value := '[ Permitir unión a clan: On/Off ]';
    132: Value := 'Permitir resurrección';
    133: Value := '[ Permitir resurrección: On/Off ]';
    134: Value := 'Permitir recall';
    135: Value := '[ Permitir recall: On/Off ]';
    136: Value := 'Permitir comercio';
    137: Value := '[ Permitir comercio: On/Off ]';
    138: Value := 'Mostrar sangre (18+)'; // Fixed
    139: Value := '[ Mostrar sangre: On/Off ]';
    140: Value := 'Reserved';
    141: Value := 'hint reserved';
    142: Value := 'Reserved';
    143: Value := 'hint reserved';
    144: Value := 'Reserved';
    145: Value := 'hint reserved';
    146: Value := 'Reserved';
    147: Value := 'hint reserved';
=======
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
>>>>>>> .r31
    { Page 3 Chatting }
<<<<<<< .mine
    148: Value := 'Permitir mensajes privados';
    149: Value := '[ Permitir mensajes privados: On/Off ]';
    150: Value := 'Permitir grito';
    151: Value := '[ Permitir grito: On/Off ]';
    152: Value := 'Reserved';
    153: Value := 'hint reserved';
    154: Value := 'Permitir mensajes de clan';
    155: Value := '[ Permitir mensajes de clan: On/Off ]';
    156: Value := 'Bloquear privados de un jugador';
    157: Value := '[ Privados de un jugador bloqueados ]';    // SE: it would be nice for the %s to let you know who is blocked - not necessary though | Coly: Prio 8 or so...
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
=======
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
>>>>>>> .r31
    { Page 4 Visual }
<<<<<<< .mine
    169: Value := 'Mostrar HP';
    170: Value := '[ Mostrar HP: On/Off ]';
    171: Value := 'Mostrar efectos de magias';
    172: Value := '[ Mostrar efectos de magias: On/Off ]';
    173: Value := 'Mejorar sombras';
    174: Value := '[ Mejorar sombras: On/Off ]';
    175: Value := 'Mostrar casco';
    176: Value := '[ Mostrar casco: On/Off ]';
    177: Value := 'Mostrar efectos de criaturas';
    178: Value := '[ Mostrar efectos de criaturas: On/Off ]';
    179: Value := 'Mostrar cabello teñido';
    180: Value := '[ Mostrar cabello teñido: On/Off ]';
    181: Value := 'Mostrar avatar';
    182: Value := '[ Avatar: On/Off ]';
    183: Value := 'Mostrar criaturas en minimapa';  
    184: Value := '[ Mostrar criaturas en minimapa: On/Off ]';
    185: Value := 'Mostrar barra de HP de los jugadores';
    186: Value := '[ Barra de HP de los jugadores: On/Off ]';
    187: Value := 'Mostrar barra de HP de las critaturas';
    188: Value := '[ Barra de HP de las criaturas: On/Off ]';
    189: Value := 'Reserved';
=======
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
>>>>>>> .r31
    { Exit Window }
<<<<<<< .mine
    190: Value := 'Salir';
    191: Value := 'Salir del juego.';
    192: Value := 'Log out';
    193: Value := 'Salir y seleccionar otro personaje.';
    194: Value := '¿Seguro que quieres salir?';
    195: Value := 'Cancelar';
=======
    190: Value := 'Salir';
    191: Value := 'Salir del juego.';
    192: Value := 'Cerrar sesión';
    193: Value := 'Cerrar sesión y seleccionar un nuevo personaje.';
    194: Value := '¿Estas seguro que deseas salir?';
    195: Value := 'Cancelar';
>>>>>>> .r31
    { Belt Window }
<<<<<<< .mine
    196: Value := 'Rotar';         //Hint
    197: Value := 'Cerrar';          //Hint
    198: Value := 'Reserved';
    199: Value := 'Reserved';
    200: Value := 'Reserved';
=======
    196: Value := 'Girar';         //Hint
    197: Value := 'Cerrar';          //Hint
    198: Value := 'Reservado';
    199: Value := 'Reservado';
    200: Value := 'Reservado';
>>>>>>> .r31
    { Mini Map }
    201: Value := ''; //Hint
    202: Value := ''; //Hint
    203: Value := ''; //Hint
    204: Value := ''; //Hint
<<<<<<< .mine
    205: Value := 'Sin minimapa';
    206: Value := '¡No disponible!';
    207: Value := 'Sin usar';
    208..210: Value := 'Reserved';
=======
    205: Value := 'No Mini-mapa';
    206: Value := 'No hay mapa disponible!';
    207: Value := 'No se usa';
    208..210: Value := 'Reservado';
>>>>>>> .r31
    { Body Window }
<<<<<<< .mine
    211: Value := 'Nivel';
    212: Value := 'Experiencia';
    213: Value := 'Puntos de salud (HP)';
    214: Value := 'Puntos de maná (MP)';
    215: Value := 'Peso en bolsa';
    216: Value := 'Peso en cuerpo';
    217: Value := 'Peso en mano';
    218: Value := 'Destreza';
    219: Value := 'Agilidad';
    220: Value := 'E(Att)';
    221: Value := 'E(Adv)';
    222: Value := 'E(Dis)';
    223: Value := 'Ataque con elemento';            //Hint
    224: Value := 'Defensa a elemento';             //Hint
    225: Value := 'Debilidad a elemento';           //Hint
    226: Value := 'Ataque con elemento fuego';           //Hint
    227: Value := 'Defensa a elemento fuego';            //Hint
    228: Value := 'Debilidad a elemento fuego';          //Hint
    229: Value := 'Ataque con elemento hielo';                  //Hint
    230: Value := 'Defensa a elemento hielo';                   //Hint
    231: Value := 'Debilidad a elemento hielo';                 //Hint
    232: Value := 'Ataque con elemento rayo';              //Hint
    233: Value := 'Defensa a elemento rayo';               //Hint
    234: Value := 'Debilidad a elemento rayo';             //Hint
    235: Value := 'Ataque con elemento viento';             //Hint
    236: Value := 'Defensa a elemento viento';              //Hint
    237: Value := 'Debilidad a elemento viento';            //Hint
    238: Value := 'Ataque con elemento sagrado';            //Hint
    239: Value := 'Defensa a elemento sagrado';             //Hint
    240: Value := 'Debilidad a elemento sagrado';           //Hint
    241: Value := 'Ataque con elemento oscuro';             //Hint
    242: Value := 'Defensa a elemento oscuro';              //Hint
    243: Value := 'Debilidad a elemento oscuro';            //Hint
    244: Value := 'Ataque con elemento ilusión';           //Hint
    245: Value := 'Defensa a elemento ilusión';            //Hint
    246: Value := 'Debilidad a elemento ilusión';          //Hint
    247..250: Value := 'Reserved';
=======
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
>>>>>>> .r31
    { Group Window }
<<<<<<< .mine
    251: Value := 'Grupo';
    252: Value := 'Cerrar';             //Hint
    253: Value := 'Añadir miembro';            //Hint
    254: Value := 'Quitar miembro';     //Hint
    255: Value := 'Crear un grupo';                 //Hint
    256: Value := 'Permitir unión a grupo';        //Hint
    257..260: Value := 'Reserved';
    { Magic Window }
    261: Value := ' Fuego  ';                            //Hint
    262: Value := ' Hielo  ';                             //Hint
    263: Value := ' Rayo  ';                       //Hint
    264: Value := ' Viento  ';                            //Hint
    265: Value := ' Sagrado  ';                            //Hint
    266: Value := ' Oscuro  ';                            //Hint
    267: Value := ' Ilusión  ';                         //Hint
    268: Value := ' Técnicas ';//'Martial Art';         //Hint
    269: Value := 'Cerrar';//'Close Magic Window';//Hint
    270: Value := ' Atrocity  ';                        //Hint - SE: I have no idea what these 3 should actually be...
    271: Value := ' Assa  ';                            //Hint - ??
    272: Value := ' Assassinate  ';                     //Hint - ??
=======
    251: Value := 'Grupo';
    252: Value := 'Cerrar ventana de grupo';             //Hint
    253: Value := 'Añadir miembro al grupo';            //Hint
    254: Value := 'Borrar miembro del grupo';       //Hint
    255: Value := 'Crear un grupo';                 //Hint
    256: Value := 'Permitir invitaciones al grupo';        //Hint
>>>>>>> .r31

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
