(******************************************************************************
 *   LomCN Mir3 Polish Game Language LGU File 2013                            *
 *                                                                            *
 *   Web       : http://www.lomcn.org                                         *
 *   Version   : 0.0.0.1                                                      *
 *                                                                            *
 *   - File Info -                                                            *
 *                                                                            *
 *   It holds the mir3 game polish language strings.                          *
 *                                                                            *
 ******************************************************************************
 * Change History                                                             *
 *                                                                            *
 *  - 0.0.0.1 [2013-04-05] Coly : first init                                  *
 *  - 0.0.0.2 [2013-04-07] budyniowski: translation                           *
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
 * !!! Attention, only the English language files are                         * 
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
    1 : Value := 'Zaloguj Siê';                                                              // Button
    2 : Value := 'Wyjœcie';                                                                // Button
    3 : Value := 'Nowe Konto';                                                         // Button URL
    4 : Value := 'Zmiana Has³a';                                                     // Button URL
    5 : Value := 'LOGIN                                   HAS£O¦CE¦';                // Button
    6 : Value := 'Zaloguj Siê (L)';                                                          // [1] Hint
    7 : Value := 'Wyjœcie (X)';                                                            // [2] Hint
    8 : Value := 'Nowe Konto (N)';                                                     // [3] Hint
    9 : Value := 'Zmiana Has³a (P)';                                                 // [4] Hint
    10: Value := 'Zosta³eœ od³¹czony.';                                         // Infoboard
    11: Value := 'Serwer jest niedostêpny poniewa¿\trwaj¹ prace konserwacyjne.';                       // Infoboard
    12: Value := 'Nie mo¿na po³¹czyæ z serwerem.\Serwer jest nieosi¹galny.';            // Infoboard
    13: Value := 'Czy na pewno chcesz wyjœæ?';
    14: Value := 'Reserved';
    15: Value := 'Reserved';
    { SM_LOGIN_PASSWORD_FAIL }
    16: Value := 'Twój login lub has³o s¹ niepoprawne.\Proszê spróbuj ponownie.';
    17: Value := 'Wprowadzono b³êdne dane logowania\trzy razy.\Proszê spróbuj ponownie póŸniej.';
    18: Value := 'Nie mo¿na uzyskaæ informacji o koncie.\Proszê spróbuj ponownie póŸniej.';
    19: Value := 'Twoje konto zosta³o zablokowane.\WejdŸ na stronê www.lomcn.org\po wiêcej informacji.';
    20: Value := 'Twój abonament wygas³.\WejdŸ na stronê www.lomcn.org\po wiêcej informacji.';
    21: Value := 'Wyst¹pi³y nieznane b³êdy!\WejdŸ na stronê www.lomcn.org\po wiêcej informacji.';
    22: Value := 'Reserved';
    23: Value := 'Reserved';
    24: Value := 'Reserved';
    25: Value := 'Reserved';
    { SM_LOGIN_PASSWORD_OK Verify Subscription }
    26: Value := 'Dzisiaj wygasa twój abonament!\WejdŸ na stronê http://www.lomcn.org\po wiêcej informacji.';
    27: Value := 'Twój abonament wygaœnie za\ %d dni.';
    28: Value := 'Dostêp z twojego IP bêdzie wa¿ny przez\nastêpnych %d dni.';
    29: Value := 'Dzisiaj wygasa dostêp z twojego IP!';
    30: Value := 'Dostêp z twojego IP bêdzie wa¿ny przez\nastêpnych %d godzin.';
    31: Value := 'Twój login bêdzie wa¿ny przez\nastêpnych %d godzin.';
    32: Value := 'Reserved';
    33: Value := 'Reserved';
    34: Value := 'Reserved';
    35: Value := 'Reserved';
    36: Value := 'Reserved';
    37: Value := 'Reserved';
    38: Value := 'Reserved';
    39: Value := 'Reserved';
    40: Value := 'Reserved';
    (*******************************************************************
    *               Character Selection / Creation                     *
    *******************************************************************)
    41: Value := 'Wczytywanie informacji o postaci, proszê czekaj...';
    42: Value := 'Wybierz Wojownika';
    43: Value := 'Wybierz Czarodzieja';
    44: Value := 'Wybierz Taoistê';
    45: Value := 'Wybierz Skrytobójcê';
    46: Value := 'PotwierdŸ';
    47: Value := 'Anuluj';
    48: Value := 'Imiê';
    49: Value := 'Poziom';
    50: Value := 'Klasa';
    51: Value := 'Z³oto';
    52: Value := 'Exp';
    53: Value := 'Reserved';
    54: Value := 'Reserved';
    55: Value := 'Mê¿czyzna';
    56: Value := 'Kobieta';
    57: Value := 'Wojownik';
    58: Value := 'Czarodziej';
    59: Value := 'Taoista';
    60: Value := 'Skrytobójca';
    { Information about Warriors }
    61: Value := '¦Y05¦¦C1D1AD69¦¦C23A3A3A¦ [%s Wojownik]¦CE¦\¦Y08¦'             // SE: Better to have gender first
               + ' Wojownicy s³yn¹ ze swojej ogromnej si³y i witalnoœci. Nie jest ³atwo\'
               + ' pokonaæ ich w boju, a ich dodatkowym atutem jest mo¿liwoœæ u¿ywania\'
               + ' ciê¿kiego orê¿a oraz zbroi. Wojownicy s¹ niezrównani w zwarciu, natomiast\'
               + ' s³abo sobie radz¹ z odpieraniem ataków dystansowych. Ró¿norodnoœci ekwipunku\'
               + ' zaprojektowanego specjalnie dla Wojowników umo¿liwia wyrównanie jego szans\'
               + ' w walce z przeciwnikami dystansowymi. Wojownik jest dobr¹ klas¹ dla\'
               + ' pocz¹tkuj¹cych ze wzglêdu na jego proste lecz potê¿ne umiejêtnoœci.\';
    { Information about Wizards }
    62: Value := '¦Y05¦¦C1D1AD69¦¦C23A3A3A¦ [%s Czarodziej]¦CE¦\¦Y08¦'
               + ' Czarodzieje posiadaj¹ ma³o si³y oraz wytrzyma³oœci, ale potrafi¹ u¿ywaæ\'
               + ' potê¿nej magii. Ich zaklêcia bojowe s¹ bardzo skuteczne, ale czas potrzebny\'
               + ' na inkantacjê ods³ania Czarodzieja na ewentualny kontratak ze strony wroga.\'
               + ' Dlatego, graj¹c Czarodziejem musisz zawsze d¹¿yæ do tego aby atakowaæ wrogów\'
               + ' z bezpiecznej odleg³oœci. Czarodzieje s¹ s³abi fizycznie, dlatego ciê¿ko jest\'
               + ' ich trenowaæ we wczesnych etapach gry, natomiast staj¹ siê bardzo potê¿ni\'
               + ' kiedy tylko naucz¹ siê bardziej zaawansowanych zaklêæ. Ze wzglêdu na liczne\'
               + ' zalety i wady, gra Czarodziejem wymaga du¿o uwagi i umiejêtnoœci.\';
    { Information about Taoists }
    63: Value := '¦Y05¦¦C1D1AD69¦¦C23A3A3A¦ [%s Taoista]¦CE¦\¦Y08¦'
               + ' Taoiœci s¹ uosobieniem równowagi miêdzy si³¹ a witalnoœci¹, ale zamiast\'
               + ' bezpoœrednio anga¿owaæ siê w walkê z wrogiem, wol¹ trzymaæ siê z boku,\'
               + ' poniewa¿ ich prawdziw¹ si³¹ jest wspieranie innych klas. Ich podstawowe\'
               + ' zaklêcia s³u¿¹ do leczenia i ochrony towarzyszy broni. Mog¹ oni równie¿\'
               + ' przyzywaæ do pomocy potê¿ne chowañce, oraz rzucaæ kilka dobrze wywa¿onych\'
               + ' zaklêæ bojowych. Pomimo wielu przydatnych umiejêtnoœci, brak tê¿yzny fizycznej\'
               + ' czyni Taoistów trudnymi do wyszkolenia. Najlepiej radz¹ sobie oni w towarzystwie\'
			   + ' jednej z pozosta³ych klas postaci.\';
    { Information about Assassins }
    64: Value :=  '¦Y05¦¦C1D1AD69¦¦C23A3A3A¦ [%s Skrytobójca]¦CE¦\¦Y08¦'
               + '¦C1D1AD69¦¦C2C19D59¦ Skrytobójcy s¹ cz³onkami tajemniczej organizacji a ich historia jest prawie\'
               + ' ca³kowicie nieznana. S¹ oni s³abi fizycznie ale potrafi¹ siê doskonale\'
               + ' kamuflowaæ oraz atakowaæ pozostaj¹c w ukryciu, oczywiœcie s¹ równie¿ œwietni\'
               + ' w szybkim odbieraniu ¿ycia. Jednak¿e musz¹ oni unikaæ anga¿owania siê w walkê\'
               + ' przeciwko wielu przeciwnikom poniewa¿ maj¹ oni mniej umiejêtnoœci obronnych od\'
               + ' innych postaci. Gra Skrytobójc¹ jest zalecana dla doœwiadczonych graczy, gdy¿\'
               + ' wymaga wprawnych ruchów, sprytnych decyzji oraz szybkiego myœlenia.¦CE¦\';
    65: Value := 'Postaæ usuniêta.';
    66: Value := 'Usuniêtych postaci nie mo¿na przywróciæ, i\'
               + 'nie mo¿na stworzyæ postaci z t¹ sam¹ nazw¹\'
               + 'przez jakiœ czas. Je¿eli na pewno chcesz\'
               + 'usun¹æ postaæ, wprowadŸ has³o i naciœnij\'
               + 'przycisk "PotwierdŸ".';  
    67: Value := 'Nie mo¿esz stworzyæ wiêcej ni¿ %d postaci.';
    68: Value := 'Proszê stwórz najpierw postaæ.';
    69: Value := 'Nie mo¿na uzyskaæ dostêpu do informacji o postaci.';
    70: Value := 'Postaæ o tym imieniu ju¿ istnieje.';
    71: Value := 'Nie mo¿esz stworzyæ nastêpnej postaci.';
    72: Value := 'B³¹d tworzenia postaci - Kod b³êdu 4';
    73: Value := 'Mia³ miejsce nieznany b³¹d.\WejdŸ na stronê www.lomcn.org\po wiêcej informacji.';
    74: Value := 'Wykryto b³¹d przy usuwaniu\twojej postaci.';
    75: Value := 'Rozpocznij Grê¦CE¦';
    76: Value := 'Nowa Postaæ¦CE¦';
    77: Value := 'Usuñ Postaæ¦CE¦';
    78: Value := 'Wyjœcie¦CE¦';
    79: Value := 'Reserved';
    80: Value := 'Reserved';
    (*******************************************************************
    *                        InGame Text                               *
    *******************************************************************)
    {Menu Bar}
    81: Value := 'Ustawienia';
    82: Value := 'Chat';
    83: Value := 'Wiadomoœæ';
    84: Value := 'Grupa';
    85: Value := 'Gildia';
    86: Value := 'Avatar';
    87: Value := 'Oblê¿enie';
    88: Value := 'Ustawienia-Auto';
    89: Value := 'Wyjœcie';
    90: Value := 'Zamknij';
    91..100 : Value := 'Reserved';
    {Game Settings}
    101: Value := 'Podstawowe';
    102: Value := 'Bezpieczeñstwo';
    103: Value := 'Chat';
    104: Value := 'Graficzne';
    { Page 1 Basic }
    105: Value := 'Tryb Ataku: Wszyscy';
    106: Value := 'Tryb Ataku: Pokojowy';
    107: Value := 'Tryb Ataku: Ma³¿eñstwo'; //(Kochanie)'; - Kochanek, Partner, Ma³¿onek, Para
    108: Value := 'Tryb Ataku: Mistrz-Uczeñ';
    109: Value := 'Tryb Ataku: Grupowy';
    110: Value := 'Tryb Ataku: Gildiowy';
    111: Value := 'Tryb Ataku: Czerwony Kontra Biali';
    112: Value := 'Reserved';
    113: Value := 'Reserved';
    114: Value := 'Zmiana Pozycji Ataku';                   // Hint for Atak Mode
    116: Value := 'Normalna Pozycja Ataku';
    117: Value := 'Zmiana Pozycji Ataku';                   // Hint for Atak Mode
    118: Value := 'Muzyka W Tle';
    119: Value := '[ W³¹cz/Wy³¹cz Muzykê W Tle ]';            // Hint Background Music
    120: Value := 'Efekty DŸwiêkowe';
    121: Value := '[ W³¹cz/Wy³¹cz Efekty DŸwiêkowe ]';               // Hint Sound Effects
    122: Value := 'DŸwiêk Stereo';
    123: Value := '[ W³¹cz Wy³¹cz DŸwiêk Stereo ]';           // Hint Sound Effects
    124: Value := 'Automatyczne Podnoszenia';
    125: Value := '[ W³¹cz/Wy³¹cz Automatyczne Podnoszenie ]';           // Hint Sound Effects
    126: Value := 'Poka¿ Nazwy Upuszczonych Przedmiotów';
    127: Value := '[ W³¹cz/Wy³¹cz Pokazywanie Nazw Upuszczonych Przedmiotów]'; // Hint Sound Effects
    { Page 2 Permissions }
    128: Value := 'Dopuœæ Zaproszenia Do Grupy';
    129: Value := '[ W³¹cz/Wy³¹cz Zaproszenia Do Grupy ]';
    130: Value := 'Dopuœæ Zaproszenia Do Gildii';
    131: Value := '[ W³¹cz/Wy³¹cz Zaproszenia Do Gildii ]';
    132: Value := 'Dopuœæ Wskrzeszanie';
    133: Value := '[ W³¹cz/Wy³¹cz Wskrzeszanie ]';
    134: Value := 'Dopuœæ Przywo³anie';
    135: Value := '[ W³¹cz/Wy³¹cz Przywo³anie ]';
    136: Value := 'Dopuœæ Handel';
    137: Value := '[ W³¹cz/Wy³¹cz Handel ]';
    138: Value := 'Efekty Rozlewu Krwi (18+)'; // Fixed
    139: Value := '[ W³¹cz/Wy³¹cz Efekty Rozlewu Krwi ]';
    140: Value := 'Reserved';
    141: Value := 'hint reserved';
    142: Value := 'Reserved';
    143: Value := 'hint reserved';
    144: Value := 'Reserved';
    145: Value := 'hint reserved';
    146: Value := 'Reserved';
    147: Value := 'hint reserved';
    { Page 3 Chatting }
    148: Value := 'Szeptanie';
    149: Value := '[ W³¹cz/Wy³¹cz Nas³uchiwanie Szeptów ]';
    150: Value := 'Okrzyki';
    151: Value := '[ W³¹cz/Wy³¹cz Nas³uchiwanie Okrzyków ]';
    152: Value := 'Reserved';
    153: Value := 'hint reserved';
    154: Value := 'Wiadomoœci Gildiowe';
    155: Value := '[ W³¹cz/Wy³¹cz Nas³uchiwanie Wiadomoœci Gildiowych ]';
    156: Value := 'Zablokuj Szepty Od U¿ytkownika';
    157: Value := '[ Zablokowano Szepty Od U¿ytkownika %s ]';    // SE: it would be nice for the %s to let you know who is blocked - not necessary though | Coly: Prio 8 or so...
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
    169: Value := 'WskaŸnik Zmiany HP';
    170: Value := '[ W³¹cz/Wy³¹cz WskaŸnik Zmiany HP ]';
    171: Value := 'Wyœwietlanie Grafiki Zaklêæ';
    172: Value := '[ W³¹cz/Wy³¹cz Wyœwietlanie Grafiki Zaklêæ ]';
    173: Value := 'Wyœwietlanie Rozmytych Cieni';
    174: Value := '[ W³¹cz/Wy³¹cz Wyœwietlanie Rozmytych Cieni ]';
    175: Value := 'Wyœwietlanie Grafiki He³mu';
    176: Value := '[ W³¹cz/Wy³¹cz Wyœwietlanie Grafiki He³mu ]';
    177: Value := 'Wyœwietlanie Efektów Potworów';
    178: Value := '[ W³¹cz/Wy³¹cz Wyœwietlanie Efektów Potworów ]';
    179: Value := 'Wyœwietlanie Koloru Przefarbowanych W³osów';
    180: Value := '[ W³¹cz/Wy³¹cz Wyœwietlanie Koloru Przefarbowanych W³osów ]';
    181: Value := 'Wyœwietlanie Avatara';
    182: Value := '[ W³¹cz/Wy³¹cz Wyœwietlanie Avatara ]';
    183: Value := 'Poka¿ Potwory Na Mini-Mapie';  
    184: Value := '[ W³¹cz/Wy³¹cz Wyœwietlanie Potworów Na Mini-Mapie ]';
    185: Value := 'Wyœwietlanie WskaŸnika HP Gracza';
    186: Value := '[ W³¹cz/Wy³¹cz WskaŸnik HP Gracza ]';
    187: Value := 'Wyœwietlanie WskaŸnika HP Potworów';
    188: Value := '[ W³¹cz/Wy³¹cz WskaŸnik HP Potworów ]';
    189: Value := 'Reserved';
    { Exit Window }
    190: Value := 'Wyjœcie';
    191: Value := 'Opuœæ grê.';
    192: Value := 'Wyloguj siê';
    193: Value := 'Wyloguj siê i wybierz inn¹ postaæ.';
    194: Value := 'Jesteœ pewien, ¿e chcesz wyjœæ?';
    195: Value := 'Anuluj';
    { Belt Window }
    196: Value := 'Odwróæ';         //Hint
    197: Value := 'Zamknij';          //Hint
    198: Value := 'Reserved';
    199: Value := 'Reserved';
    200: Value := 'Reserved';
    { Mini Map }
    201: Value := ''; //Hint
    202: Value := ''; //Hint
    203: Value := ''; //Hint
    204: Value := ''; //Hint
    205: Value := 'Brak Mini-Mapy';
    206: Value := 'Brak Dostêpnej Mapy!';
    207: Value := 'Nie u¿ywane';
    208..210: Value := 'Reserved';
    { Body Window }
    211: Value := 'Poziom';
    212: Value := 'Doœwiadczenie';
    213: Value := 'Punkty Zdrowia (HP)';
    214: Value := 'Punkty Many (MP)';
    215: Value := 'Ciê¿ar Ekwipunku';
    216: Value := 'Ciê¿ar Zbroi';
    217: Value := 'Ciê¿ar Orê¿a';
    218: Value := 'Celnoœæ';
    219: Value := 'Zwinnoœæ';
    220: Value := 'Prw(Atk)';
    221: Value := 'Prw(Obr)';
    222: Value := 'Prw(S³a)';
    223: Value := 'Pierwiastek Atk (Atak)';           //Hint
    224: Value := 'Pierwiastek Obr (Obrona)';          //Hint
    225: Value := 'Pierwiastek S³a (S³aboœæ)';         //Hint
    226: Value := 'Pierwiastek Ognia (Atak)';          //Hint
    227: Value := 'Pierwiastek Ognia (Obrona)';         //Hint
    228: Value := 'Pierwiastek Ognia (S³aboœæ)';        //Hint
    229: Value := 'Pierwiastek Lodu (Atak)';           //Hint
    230: Value := 'Pierwiastek Lodu (Obrona)';          //Hint
    231: Value := 'Pierwiastek Lodu (S³aboœæ)';         //Hint
    232: Value := 'Pierwiastek Grzmotu (Atak)';       //Hint
    233: Value := 'Pierwiastek Grzmotu (Obrona)';      //Hint
    234: Value := 'Pierwiastek Grzmotu (S³aboœæ)';     //Hint
    235: Value := 'Pierwiastek Wiatru (Atak)';          //Hint
    236: Value := 'Pierwiastek Wiatru (Obrona)';         //Hint
    237: Value := 'Pierwiastek Wiatru (S³aboœæ)';        //Hint
    238: Value := 'Pierwiastek Œwiêty (Atak)';          //Hint
    239: Value := 'Pierwiastek Œwiêty (Obrona)';         //Hint
    240: Value := 'Pierwiastek Œwiêty (S³aboœæ)';        //Hint
    241: Value := 'Pierwiastek Mroczny (Atak)';          //Hint
    242: Value := 'Pierwiastek Mroczny (Obrona)';         //Hint
    243: Value := 'Pierwiastek Mroczny (S³aboœæ)';        //Hint
    244: Value := 'Pierwiastek Widmowy (Atak)';       //Hint
    245: Value := 'Pierwiastek Widmowy (Obrona)';      //Hint
    246: Value := 'Pierwiastek Widmowy (S³aboœæ)';     //Hint
    247..250: Value := 'Reserved';
    { Group Window }
    251: Value := 'Grupa';
    252: Value := 'Zamknij Okno Grupy';             //Hint
    253: Value := 'Dodaj Cz³onka Grupy';            //Hint
    254: Value := 'Usuñ Cz³onka Grupy';     //Hint
    255: Value := 'Utwórz Grupê';                 //Hint
    256: Value := 'Dopuœæ Zaproszenia Do Grupy';        //Hint
    257..260: Value := 'Reserved';
    { Magic Window }
    261: Value := ' Ognia  ';                            //Hint
    262: Value := ' Lodu  ';                             //Hint
    263: Value := ' B³yskawicy  ';                       //Hint
    264: Value := ' Wiatru  ';                            //Hint
    265: Value := ' Œwiêty  ';                            //Hint
    266: Value := ' Mroczny  ';                            //Hint
    267: Value := ' Widmowy  ';                         //Hint
    268: Value := ' Fizyczny ';//'Sztuka Walki';         //Hint
    269: Value := 'Zamknij Okno';//'Zamknij Okno Zaklêæ';//Hint
    270: Value := ' Okrucieñstwa  ';                        //Hint - SE: I have no idea what these 3 should actually be...
    271: Value := ' Zabójczy  ';                            //Hint - ??
    272: Value := ' Zamachu  ';                     //Hint - ??

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
    CopyMemory(Buffer, PChar(Value), Length(Value));
  Result := Length(Value);
end;

end.
