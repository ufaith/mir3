(******************************************************************************
 *   LomCN Mir3 Polish Game Language LGU File 2013                            *
 *                                                                            *
 *   Web       : http://www.lomcn.org                                         *
 *   Version   : 0.0.0.5                                                      *
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
 *  - 0.0.0.3 [2013-04-08] budyniowski: change to UTF8 + little clean up      *
 *  - 0.0.0.4 [2013-04-11] budyniowski: fitting text to frames                *
 *  - 0.0.0.5 [2013-04-13] Coly : add utf8 code support                       *
 *                                                                            *
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
    1 : Value := 'ZALOGUJ SIĘ';                                                                        // Button
    2 : Value := 'WYJŚCIE';                                                                            // Button
    3 : Value := 'NOWE KONTO';                                                                         // Button URL
    4 : Value := 'ZMIANA HASŁA';                                                                       // Button URL
    5 : Value := 'ID                                        HASŁO¦CE¦';                                // Button
    6 : Value := 'Zaloguj Się (L)';                                                                    // [1] Hint
    7 : Value := 'Wyjście (X)';                                                                        // [2] Hint
    8 : Value := 'Nowe Konto (N)';                                                                     // [3] Hint
    9 : Value := 'Zmiana Hasła (P)';                                                                   // [4] Hint
    10: Value := 'Zostałeś odłączony.';                                                                // Infoboard
    11: Value := 'Serwer jest niedostępny ponieważ\trwają prace konserwacyjne.';                       // Infoboard
    12: Value := 'Nie można połączyć z serwerem.\Serwer jest nieosiągalny.';                           // Infoboard
    13: Value := 'Czy na pewno chcesz wyjść?';
    14: Value := 'Reserved';
    15: Value := 'Reserved';
    { SM_LOGIN_PASSWORD_FAIL }
    16: Value := 'Twój login lub hasło są niepoprawne.\Proszę spróbuj ponownie.';
    17: Value := 'Wprowadzono błędne dane logowania\trzy razy.\Proszę spróbuj ponownie później.';
    18: Value := 'Nie można uzyskać informacji o koncie.\Proszę spróbuj ponownie później.';
    19: Value := 'Twoje konto zostało zablokowane.\Wejdź na stronę www.lomcn.org\po więcej informacji.';
    20: Value := 'Twój abonament wygasł.\Wejdź na stronę www.lomcn.org\po więcej informacji.';
    21: Value := 'Wystąpiły nieznane błędy!\Wejdź na stronę www.lomcn.org\po więcej informacji.';
    22: Value := 'Reserved';
    23: Value := 'Reserved';
    24: Value := 'Reserved';
    25: Value := 'Reserved';
    { SM_LOGIN_PASSWORD_OK Verify Subscription }
    26: Value := 'Dzisiaj wygasa twój abonament!\Wejdź na stronę http://www.lomcn.org\po więcej informacji.';
    27: Value := 'Twój abonament wygaśnie za\ %d dni.';
    28: Value := 'Dostęp z twojego IP będzie ważny przez\następnych %d dni.';
    29: Value := 'Dzisiaj wygasa dostęp z twojego IP!';
    30: Value := 'Dostęp z twojego IP będzie ważny przez\następnych %d godzin.';
    31: Value := 'Twój login będzie ważny przez\następnych %d godzin.';
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
    41: Value := 'Wczytywanie informacji o postaci, proszę czekaj...';
    42: Value := 'Wybierz Wojownika';
    43: Value := 'Wybierz Czarodzieja';
    44: Value := 'Wybierz Taoistę';
    45: Value := 'Wybierz Skrytobójcę';
    46: Value := 'Potwierdź';
    47: Value := 'Anuluj';
    48: Value := 'Imię';
    49: Value := 'Poziom';
    50: Value := 'Klasa';
    51: Value := 'Złoto';
    52: Value := 'Exp';
    53: Value := 'Reserved';
    54: Value := 'Reserved';
    55: Value := 'Mężczyzna';
    56: Value := 'Kobieta';
    57: Value := 'Wojownik';
    58: Value := 'Czarodziej';
    59: Value := 'Taoista';
    60: Value := 'Skrytobójca';
    { Information about Warriors }
    61: Value := '¦Y05¦¦C1D1AD69¦¦C23A3A3A¦ [%s Wojownik]¦CE¦\¦Y08¦'             // SE: Better to have gender first
               + ' Wojownicy słyną ze swojej ogromnej siły i witalności. Nie jest łatwo pokonać\'
               + ' ich w boju, a ich dodatkowym atutem jest możliwość używania ciężkiego\'
               + ' oręża oraz zbroi. Wojownicy są niezrównani w zwarciu, natomiast słabo sobie\'
               + ' radzą z odpieraniem ataków dystansowych. Różnorodności ekwipunku\'
               + ' zaprojektowanego specjalnie dla Wojowników umożliwia wyrównanie jego\'
               + ' szans w walce z przeciwnikami dystansowymi. Wojownik jest dobrą klasą dla\'
               + ' początkujących ze względu na jego proste lecz potężne umiejętności.\';
    { Information about Wizards }
    62: Value := '¦Y05¦¦C1D1AD69¦¦C23A3A3A¦ [%s Czarodziej]¦CE¦\¦Y08¦'
               + ' Czarodzieje posiadają mało siły oraz wytrzymałości, ale potrafią używać\'
               + ' potężnej magii. Ich zaklęcia bojowe są bardzo skuteczne, ale czas potrzebny\'
               + ' na inkantację odsłania Czarodzieja na ewentualny kontratak ze strony wroga.\'
               + ' Dlatego, grając Czarodziejem musisz zawsze dążyć do tego aby atakować\'
               + ' z bezpiecznej odległości. Czarodzieje są słabi fizycznie, dlatego ciężko jest\'
               + ' ich trenować we wczesnych etapach gry, natomiast stają się bardzo potężni\'
               + ' kiedy tylko nauczą się bardziej zaawansowanych zaklęć. Ze względu na liczne\'
               + ' zalety i wady, gra Czarodziejem wymaga dużo uwagi i umiejętności.\';
    { Information about Taoists }
    63: Value := '¦Y05¦¦C1D1AD69¦¦C23A3A3A¦ [%s Taoista]¦CE¦\¦Y08¦'
               + ' Taoiści są uosobieniem równowagi między siłą a witalnością, ale zamiast\'
               + ' bezpośrednio angażować się w walkę z wrogiem, wolą trzymać się z boku,\'
               + ' ponieważ ich prawdziwą siłą jest wspieranie innych klas. Ich podstawowe\'
               + ' zaklęcia służą do leczenia i ochrony towarzyszy broni. Mogą oni również\'
               + ' przyzywać do pomocy potężne chowańce, oraz rzucać dobrze zbalansowane\'
               + ' zaklęcia bojowe. Pomimo wielu przydatnych umiejętności, brak tężyzny\'
               + ' fizycznej czyni Taoistów trudnymi do wyszkolenia. Najlepiej radzą sobie oni w\'
			   + ' towarzystwie jednej z pozostałych klas postaci.\';
    { Information about Assassins }
    64: Value :=  '¦Y05¦¦C1D1AD69¦¦C23A3A3A¦ [%s Skrytobójca]¦CE¦\¦Y08¦'
               + '¦C1D1AD69¦¦C2C19D59¦ Skrytobójcy są członkami tajemniczej organizacji a ich historia jest prawie\'
               + ' całkowicie nieznana. Są oni słabi fizycznie ale potrafią się doskonale\'
               + ' kamuflować oraz atakować pozostając w ukryciu, oczywiście są również\'
               + ' świetni w szybkim odbieraniu życia. Jednakże muszą oni unikać angażowania się\'
               + ' w walkę przeciwko wielu przeciwnikom ponieważ mają oni mniej umiejętności\'
               + ' obronnych od innych postaci. Gra Skrytobójcą jest zalecana dla\'
               + ' doświadczonych graczy, gdyż wymaga wprawnych ruchów, sprytnych decyzji\'
			   + ' oraz szybkiego myślenia.¦CE¦\';
    65: Value := 'Postać usunięta.';
    66: Value := 'Usuniętych postaci nie można przywrócić, i\'
               + 'nie można stworzyć postaci z tą samą nazwą\'
               + 'przez jakiś czas. Jeżeli na pewno chcesz\'
               + 'usunąć postać, wprowadź hasło i naciśnij\'
               + 'przycisk "Potwierdź".';  
    67: Value := 'Nie możesz stworzyć więcej niż %d postaci.';
    68: Value := 'Proszę stwórz najpierw postać.';
    69: Value := 'Nie można uzyskać dostępu do informacji o postaci.';
    70: Value := 'Postać o tym imieniu już istnieje.';
    71: Value := 'Nie możesz stworzyć następnej postaci.';
    72: Value := 'Błąd tworzenia postaci - Kod błędu 4';
    73: Value := 'Miał miejsce nieznany błąd.\Wejdź na stronę www.lomcn.org\po więcej informacji.';
    74: Value := 'Wykryto błąd przy usuwaniu\twojej postaci.';
    75: Value := 'Rozpocznij Grę¦CE¦';
    76: Value := 'Nowa Postać¦CE¦';
    77: Value := 'Usuń Postać¦CE¦';
    78: Value := 'Wyjście¦CE¦';
    79: Value := 'Potwierdź';
    80: Value := 'Reserved';
    (*******************************************************************
    *                        InGame Text                               *
    *******************************************************************)
    {Menu Bar}
    81: Value := 'Ustawienia';
    82: Value := 'Chat';
    83: Value := 'Wiadomość';
    84: Value := 'Grupa';
    85: Value := 'Gildia';
    86: Value := 'Avatar';
    87: Value := 'Oblężenie';
    88: Value := 'Ustawienia-Auto';
    89: Value := 'Wyjście';
    90: Value := 'Zamknij';
    91..100 : Value := 'Reserved';
    {Game Settings}
    101: Value := 'Ogólne';
    102: Value := 'Pryw.';
    103: Value := 'Chat';
    104: Value := 'Grafika';
    { Page 1 Basic }
    105: Value := 'Atak: Wszyscy';
    106: Value := 'Atak: Pokojowy';
    107: Value := 'Atak: Małżeństwo';                                          //(Kochanie)'; - Kochanek, Partner, Małżonek, Para
    108: Value := 'Atak: Mistrz-Uczeń';
    109: Value := 'Atak: Grupowy';
    110: Value := 'Atak: Gildiowy';
    111: Value := 'Atak: Czerwony vs. Biali';
    112: Value := 'Reserved';
    113: Value := 'Reserved';
    114: Value := 'Zmiana Pozycji Ataku';                                      // Hint for Atak Mode
    116: Value := 'Normalna Pozycja Ataku';
    117: Value := 'Zmiana Pozycji Ataku';                                      // Hint for Atak Mode
    118: Value := 'Muzyka W Tle';
    119: Value := '[ Włącz/Wyłącz Muzykę W Tle ]';                             // Hint Background Music
    120: Value := 'Efekty Dźwiękowe';
    121: Value := '[ Włącz/Wyłącz Efekty Dźwiękowe ]';                         // Hint Sound Effects
    122: Value := 'Dźwięk Stereo';
    123: Value := '[ Włącz/Wyłącz Dźwięk Stereo ]';                            // Hint Sound Effects
    124: Value := 'Automatyczne Podnoszenie';
    125: Value := '[ Włącz/Wyłącz Automatyczne Podnoszenie]';                 // Hint Sound Effects
    126: Value := 'Nazwy Przedmiotów';
    127: Value := '[ Włącz/Wyłącz Pokazywanie Nazw Upuszczonych Przedmiotów]'; // Hint Sound Effects
    { Page 2 Permissions }
    128: Value := 'Zaproszenia Do Grupy';
    129: Value := '[ Włącz/Wyłącz Zaproszenia Do Grupy ]';
    130: Value := 'Zaproszenia Do Gildii';
    131: Value := '[ Włącz/Wyłącz Zaproszenia Do Gildii ]';
    132: Value := 'Wskrzeszanie';
    133: Value := '[ Włącz/Wyłącz Wskrzeszanie ]';
    134: Value := 'Przywołanie';
    135: Value := '[ Włącz/Wyłącz Przywołanie ]';
    136: Value := 'Handel';
    137: Value := '[ Włącz/Wyłącz Handel ]';
    138: Value := 'Efekty Rozlewu Krwi (18+)'; // Fixed
    139: Value := '[ Włącz/Wyłącz Efekty Rozlewu Krwi ]';
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
    149: Value := '[ Włącz/Wyłącz Nasłuchiwanie Szeptów ]';
    150: Value := 'Okrzyki';
    151: Value := '[ Włącz/Wyłącz Nasłuchiwanie Okrzyków ]';
    152: Value := 'Reserved';
    153: Value := 'hint reserved';
    154: Value := 'Wiadomości Gildiowe';
    155: Value := '[ Włącz/Wyłącz Nasłuchiwanie Wiadomości Gildiowych ]';
    156: Value := 'Blokuj Szepty Od Użytkownika';
    157: Value := '[ Zablokowano Szepty Od Użytkownika %s ]';    // SE: it would be nice for the %s to let you know who is blocked - not necessary though | Coly: Prio 8 or so...
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
    169: Value := 'Wskaźnik Zmiany HP';
    170: Value := '[ Włącz/Wyłącz Wskaźnik Zmiany HP ]';
    171: Value := 'Grafika Zaklęć';
    172: Value := '[ Włącz/Wyłącz Wyświetlanie Grafiki Zaklęć ]';
    173: Value := 'Rozmyte Cienie';
    174: Value := '[ Włącz/Wyłącz Wyświetlanie Rozmytych Cieni ]';
    175: Value := 'Pokaż Hełm';
    176: Value := '[ Włącz/Wyłącz Wyświetlanie Grafiki Hełmu ]';
    177: Value := 'Efekty Potworów';
    178: Value := '[ Włącz/Wyłącz Wyświetlanie Efektów Potworów ]';
    179: Value := 'Kolor Włosów';
    180: Value := '[ Włącz/Wyłącz Wyświetlanie Koloru Przefarbowanych Włosów ]';
    181: Value := 'Wyświetlanie Avatara';
    182: Value := '[ Włącz/Wyłącz Wyświetlanie Avatara ]';
    183: Value := 'Potwory Na Mini-Mapie';  
    184: Value := '[ Włącz/Wyłącz Wyświetlanie Potworów Na Mini-Mapie ]';
    185: Value := 'Wskaźnik HP Graczy';
    186: Value := '[ Włącz/Wyłącz Wskaźnik HP Gracza ]';
    187: Value := 'Wskaźnik HP Potworów';
    188: Value := '[ Włącz/Wyłącz Wskaźnik HP Potworów ]';
    189: Value := 'Reserved';
    { Exit Window }
    190: Value := 'Wyjście';
    191: Value := 'Opuść grę.';
    192: Value := 'Wyloguj się';
    193: Value := 'Wyloguj się i wybierz inną postać.';
    194: Value := 'Jesteś pewien, że chcesz wyjść?';
    195: Value := 'Anuluj';
    { Belt Window }
    196: Value := 'Odwróć';           //Hint
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
    206: Value := 'Brak Dostępnej Mapy!';
    207: Value := 'Nie używane';
    208..210: Value := 'Reserved';
    { Body Window }
    211: Value := 'Poziom';
    212: Value := 'Doświadczenie';
    213: Value := 'Punkty Zdrowia (HP)';
    214: Value := 'Punkty Many (MP)';
    215: Value := 'Ciężar Ekwipunku';
    216: Value := 'Ciężar Zbroi';
    217: Value := 'Ciężar Oręża';
    218: Value := 'Celność';
    219: Value := 'Zwinność';
    220: Value := 'Prw(Atk)';
    221: Value := 'Prw(Obr)';
    222: Value := 'Prw(Sła)';
    223: Value := 'Pierwiastek Atk (Atak)';                 //Hint
    224: Value := 'Pierwiastek Obr (Obrona)';               //Hint
    225: Value := 'Pierwiastek Sła (Słabość)';              //Hint
    226: Value := 'Pierwiastek Ognia (Atak)';               //Hint
    227: Value := 'Pierwiastek Ognia (Obrona)';             //Hint
    228: Value := 'Pierwiastek Ognia (Słabość)';            //Hint
    229: Value := 'Pierwiastek Lodu (Atak)';                //Hint
    230: Value := 'Pierwiastek Lodu (Obrona)';              //Hint
    231: Value := 'Pierwiastek Lodu (Słabość)';             //Hint
    232: Value := 'Pierwiastek Grzmotu (Atak)';             //Hint
    233: Value := 'Pierwiastek Grzmotu (Obrona)';           //Hint
    234: Value := 'Pierwiastek Grzmotu (Słabość)';          //Hint
    235: Value := 'Pierwiastek Wiatru (Atak)';              //Hint
    236: Value := 'Pierwiastek Wiatru (Obrona)';            //Hint
    237: Value := 'Pierwiastek Wiatru (Słabość)';           //Hint
    238: Value := 'Pierwiastek Święty (Atak)';              //Hint
    239: Value := 'Pierwiastek Święty (Obrona)';            //Hint
    240: Value := 'Pierwiastek Święty (Słabość)';           //Hint
    241: Value := 'Pierwiastek Mroczny (Atak)';             //Hint
    242: Value := 'Pierwiastek Mroczny (Obrona)';           //Hint
    243: Value := 'Pierwiastek Mroczny (Słabość)';          //Hint
    244: Value := 'Pierwiastek Widmowy (Atak)';             //Hint
    245: Value := 'Pierwiastek Widmowy (Obrona)';           //Hint
    246: Value := 'Pierwiastek Widmowy (Słabość)';          //Hint
    247..250: Value := 'Reserved';
    { Group Window }
    251: Value := 'Grupa';
    252: Value := 'Zamknij Okno Grupy';                     //Hint
    253: Value := 'Dodaj Członka Grupy';                    //Hint
    254: Value := 'Usuń Członka Grupy';                     //Hint
    255: Value := 'Utwórz Grupę';                           //Hint
    256: Value := 'Dopuść Zaproszenia Do Grupy';            //Hint
    257..260: Value := 'Reserved';
    { Magic Window }
    261: Value := ' Ognia  ';                               //Hint
    262: Value := ' Lodu  ';                                //Hint
    263: Value := ' Błyskawicy  ';                          //Hint
    264: Value := ' Wiatru  ';                              //Hint
    265: Value := ' Święty  ';                              //Hint
    266: Value := ' Mroczny  ';                             //Hint
    267: Value := ' Widmowy  ';                             //Hint
    268: Value := ' Fizyczny ';//'Sztuka Walki';            //Hint
    269: Value := 'Zamknij Okno';//'Zamknij Okno Zaklęć';   //Hint
    270: Value := ' Okrucieństwa  ';                        //Hint - SE: I have no idea what these 3 should actually be...
    271: Value := ' Zabójczy  ';                            //Hint - ??
    272: Value := ' Zamachu  ';                             //Hint - ??

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
    lstrcpynW(Buffer, PWideChar(Value), lstrlenW(PWideChar(Value))+1);

  Result := lstrlenW(PWideChar(Value))+1;
end;

end.
