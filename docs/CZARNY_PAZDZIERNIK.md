# Scenariusz I: Upadek Rzeczypospolitej / Czarny Październik (1.10.2026)

Generator: `f_cpz.py`. Zdarzenia: `events/pl2027_cpz.txt` (przestrzeń `cpz`). Efekty: `common/scripted_effects/pl2027_cpz_effects.txt` (start, tydzień, ocalenie) i `pl2027_cpz_rozpad_effects.txt` (uwalnianie państw, etapy województw, wojna domowa, Godzina Zero). Źródła zdarzeń historycznych: `docs/TK_2026_LIVELOG.md`.

## Dwie niezależne daty startowe
- **1.10.2026** (nowa zakładka): `on_startup` dla daty przed 2027 r. uruchamia `CPZ_start`.
  - Niemcy uwalniają Pomorze, Śląsk, Poznań, Czechy i Litwę.
  - **Rzeczpospolita (POL) wciela wszystkie polskie państwa regionalne, łącznie z frakcjami Warszawy.** Żadne z nich nie ma ziem na starcie, Warszawa nie jest podzielona.
  - Polska dostaje rdzenie na wszystkich stanach. Rdzenie państw regionalnych zostają – na nich opiera się późniejsze uwalnianie.
  - Wojsko Polskie wczytuje się z `history/units/POL_2026.txt` (45 brygad). Jednostki państw regionalnych znikają przy wcieleniu, a każde państwo dostaje swoje z powrotem przy uwolnieniu.
  - Rząd Donalda Tuska (postać `CPZ_donald_tusk`), wspólne drzewko Rzeczypospolitej `POL_cpz_kryzys_tree` (95 fokusów, opis niżej), harmonogram zdarzeń 30–31.10.
- **11.11.2027** (dotychczasowa zakładka): bez zmian w działaniu.
- **Dwie daty w plikach historii (od 0.10.2)**, żeby już ekran wyboru państwa pokazywał jedną Polskę:
  - wpisy bez daty to stan na 1.10.2026: stany państw regionalnych należą do POL (`owner = POL`, `add_core_of = POL`);
  - blok `2027.11.11 = { owner = <TAG> remove_core_of = POL }` przywraca podział z 11.11.2027;
  - jednostki państw regionalnych (`oob`) i niemieccy podwładni (`puppet`) siedzą w blokach `2027.11.11`.
  - Wcielanie w `CPZ_start` zostało jako zabezpieczenie (z warunkiem `country_exists`).

## Wskaźniki (zmienne globalne `CPZ_*`, 0–100)
- kryzys konstytucyjny (progi: 0–24 / 25–49 / 50–74 / 75–89 / 90–100)
- poparcie dla rządu
- poparcie dla obozu prezydencko-opozycyjnego
- lojalność policji
- lojalność wojska
- stabilność koalicji
- napięcie społeczne
- nastroje separatystyczne w regionach

Panel „Kryzys konstytucyjny” zawiera decyzje dotyczące demonstracji, policji, mediów, instytucji, negocjacji i wojska.

## Rozpad województw (nowa mechanika)
- **Etap I** – osłabienie władzy centralnej: kryzys ≥ 50 albo separatyzm ≥ 35 (`cpz.300`).
- **Etap II** – tymczasowe administracje wojewódzkie: kryzys ≥ 65, separatyzm ≥ 45 albo wojna domowa (`cpz.301`). Od teraz co tydzień najwyżej jedno województwo przechodzi do następnego etapu:
  - 0 → 1: tymczasowa administracja (`cpz.320–328`);
  - 1 → 2: **etap III** – kryzys regionalny z decyzją gracza (`cpz.330–338`): negocjacje spowalniają rozpad województwa, komisarz go przyspiesza;
  - 2 → 3: **etap IV** – dwa największe państwa województwa stają się regionami autonomicznymi (podwładnymi Rzeczypospolitej, `CPZ_autonomia_<TAG>`, `cpz.340–348`);
  - 3 → 4: **etap V** – miasta i mniejsze regiony ogłaszają niepodległość po jednym, z szansą 55% na tydzień. W województwach z ponad 10 państwami (kujawsko-pomorskie, mazowieckie) są dwa naraz, w czasie wojny lub dla wybranego województwa szansa jest podwójna. Na końcu regiony autonomiczne zrywają z Warszawą (`cpz.350/351`).
- **Uwolnienie** (`CPZ_uwolnij_<TAG>`): `release` z każdego państwa, które ma rdzenie danego regionu. Potem:
  - przywódcy, ustrój i jednostki wracają z pliku historii (świat 11.11.2027);
  - Eurokomisariaty trafiają pod Niemcy;
  - jeśli gracz wybrał to państwo, przejmuje je.
- **Warszawa** (wojna domowa albo kryzys ≥ 85): Policja, Straż Marszałkowska, Mafia Pruszkowska, Kibice Legii, Praga, Wojsko, Zieloni, Tęczowa Republika i Kancelaria Prezydenta. Każda frakcja ma osobny warunek (`cpz.600–608`).
- **Etap VI – Godzina Zero** (`cpz.800/801`): następuje 10.11.2027, po 180 dniach wojny domowej albo po usamodzielnieniu się 75% państw. Wtedy:
  - pozostałe państwa zostają uwolnione;
  - gracz przechodzi do Sejmu (Straż Marszałkowska), Kancelarii Prezydenta albo wybranego państwa;
  - uruchamia się `PL2027_start_regionalny`, a dalej działają lokalne wojny, sojusze i drzewka świata 11.11.2027.

Symulacja modelu tygodniowego (skrypt Pythona, nie silnik gry, 200 przebiegów) daje Godzinę Zero średnio ok. 44 tygodnie po etapie II. Województwo kujawsko-pomorskie rozpada się w całości przed Godziną Zero w 184 na 200 przebiegów bez wojny i w 200 na 200 z wojną.

## Wojna domowa
- Dwa ośrodki władzy (`cpz.490`) przy kryzysie ≥ 80 i słabej lojalności służb, przewadze obozu prezydenckiego albo zerwanych rozmowach. Po ścieżce siły wystarcza kryzys ≥ 75.
- `start_civil_war` dopiero wtedy wyodrębnia „Rzeczpospolitą Polską (obóz prezydencki)” (ideologia konserwatywna, stolica w Belwederze, przywódca Karol Nawrocki):
  - wielkość zależy od poparcia obozu prezydenckiego (30/40/50% stanów, tylko z regionów o prawicowych rządach);
  - armia, flota i lotnictwo zależą od lojalności wojska (20/35/50%).
- Konfederacja Północna i Korona Polska mogą zostać neutralne (po 50%).
- „Kto ma prawo rządzić Polską?” (`cpz.500`):
  - A – rząd;
  - B – obóz prezydencki (`change_tag_from`);
  - C – wybór województwa (lub Warszawy), potem państwa. Gdy państwo uzyska niepodległość (najpóźniej po 45 dniach albo od razu po fokusie A10, `cpz.560`), gracz je przejmuje.
- Koniec wojny (`on_civil_war_end`):
  - zwycięstwo rządu → `cpz.520`;
  - zwycięstwo obozu prezydenckiego → `cpz.521` (rozpad przyspiesza).

## Ratowanie Rzeczypospolitej
- Okrągły stół (decyzja) wymaga wszystkich poniższych warunków:
  - kryzys < 65;
  - koalicja ≥ 45;
  - wojsko ≥ 55;
  - policja ≥ 45;
  - wcześniejsza mediacja, projekt ustawy albo kompromis w nocy 30/31.10;
  - brak wojny.
- Udane rozmowy (albo fokus S02) ustawiają stabilizację: kryzys, napięcie i separatyzm spadają, a etapy rozpadu stoją w miejscu.
- Ostatni fokus gałęzi B, „Rzeczpospolita przetrwała”, wciela regiony autonomiczne i kończy scenariusz bez rozpadu. Potem działa gałąź H (odbudowa).

## Ograniczenia silnika
- Skrypt nie może pauzować gry ani zmieniać prędkości. Zdarzenie „Nadchodzi przesilenie” zaleca prędkość 1 i włączenie pauzy przy zdarzeniach w ustawieniach.
- Czas w HOI4 liczy się w pełnych godzinach.

## Drzewko Rzeczypospolitej (od 0.10.3)
Plik: `common/national_focus/pl2027_POL_cpz_kryzys_tree.txt`, generator: `f_cpz_drzewo.py`. Jedno drzewko dla Polski 1.10.2026 – 95 fokusów:

| Gałąź | Fokusy | Kto widzi | Odblokowanie |
|---|---|---|---|
| A. Polska przed kryzysem (P01–P15) | 15 | rząd | od startu; po P01 trzy kierunki: polityka, bezpieczeństwo, administracja |
| B. Uratowanie Polski (S01–S10) | 10 | rząd | brak wojny, kryzys < 60, otwarty kanał rozmów; S10 wymaga kryzysu < 25 |
| C. Wspólne fokusy wojenne (W01–W08) | 8 | obie strony | wojna domowa |
| D. Rząd Donalda Tuska (G01–G16) | 16 | rząd | wojna domowa; G15–G16 po wygranej rządu |
| E. Obóz prezydencko-opozycyjny (O01–O16) | 16 | tylko państwo z wojny domowej | wojna domowa; O15–O16 po wygranej obozu |
| F. Rozpad Rzeczypospolitej (R01–R12) | 12 | rząd (AI ich nie wybiera) | kolejne etapy rozpadu; R12 przy 40 niepodległych państwach |
| G. Tymczasowa administracja regionalna (A01–A10) | 10 | rząd | ścieżka C (wybór województwa i państwa) |
| H. Odbudowa zjednoczonej Polski (Z01–Z08) | 8 | rząd | po S10 albo G16 |

- Widoczność gałęzi: `allow_branch` z flagą `CPZ_oboz_prez`. Państwo z wojny domowej dostaje to samo drzewko (flaga ustawiana przed `load_focus_tree`).
- Drzewko wybiera się samo dla POL przed 2027 r. (waga w bloku `country`) i jest dodatkowo wczytywane w `CPZ_start` i w zdarzeniu `cpz.1`. W scenariuszu 11.11.2027 Polska dostaje dawne drzewko.
- Fokus P15 odblokowuje opcję E w zdarzeniu „PREZYDENT POD TRYBUNAŁEM!”.
- Fokusy G-gałęzi ustawiają flagi `CPZ_g_*`; efekt `CPZ_premie_regionu` daje je nowemu państwu, gdy gracz je przejmuje. A10 przejmuje państwo od razu (inaczej najpóźniej po 45 dniach).

## Nowe wskaźniki i mechaniki (0.10.3)
- Lojalność administracji (`CPZ_administracja`, start 60) i rezerwy państwowe (`CPZ_rezerwy`, start 20, decyzja „Uruchomić rezerwy państwowe”).
- Lojalność dziewięciu regionów (`CPZ_lo_<województwo>`, średnio ok. 68). Województwo przechodzi do kolejnego etapu rozpadu tylko przy lojalności poniżej 65 (nie dotyczy województwa wybranego przez gracza). Co tydzień lojalność spada przy wysokim napięciu regionalnym, kryzysie > 74 i w czasie wojny, a rośnie przy stabilizacji.
- Partie koalicji: KO, PSL, Polska 2050, Lewica (`CPZ_p_*`). Spójność koalicji to ich średnia. Partia poniżej 25 wychodzi z koalicji (`cpz.450–452`), decyzje „Ustępstwa dla partii…” podnoszą poparcie jednej partii.
- Jedność obozu prezydencko-opozycyjnego (`CPZ_jednosc`) – PiS, Konfederacja i reszta nie są automatycznie jednością.
- Balance of Power „Władza w Rzeczypospolitej” (`common/bop/pl2027_cpz_bop.txt`): rząd ↔ obóz prezydencki; co tydzień przesuwa się w stronę obozu z większym poparciem.
- Duchy narodowe na starcie: Kryzys konstytucyjny, Podzielone społeczeństwo, Spór o legalność instytucji, Polska gospodarka 2026, Struktury państwa. Zmieniają się z kryzysem (gospodarka i struktury słabną, porozumienie usuwa spór, odbudowa daje „Kraj do odbudowy” i „Rzeczpospolita odrodzona”).
- Wartości startowe: kryzys 30, wojsko 60, policja 65, napięcie 35, stabilność ok. 47%.
- Wojna domowa: kryzys ≥ 80 i rozłam w służbach, przewaga obozu prezydenckiego albo zerwane rozmowy; porozumienie z prezydentem (S05) ją blokuje.

## Zmiany 0.10.7
- **11.11.2027 zawsze świat rozbitej Polski:** od 7.11.2027 Godzina Zero uruchamia się zawsze, także po ocaleniu Rzeczypospolitej (`on_daily_POL`).
- **Chaos:** od etapu I co tydzień 40% szans na jedno z 12 zdarzeń losowych (`cpz.900–911`), w czasie wojny domowej dodatkowo 6 zdarzeń wojennych (`cpz.920–925`). Każde raz na grę.
- **AI:** komputerowa Rzeczpospolita nie wybiera drogi ocalenia (gałąź B i okrągły stół prawie nigdy), częściej wybiera siłę pod Trybunałem i fokusy rozpadu; gdy Polską steruje AI, od etapu I kryzys i napięcie regionalne rosną dodatkowo o 1 tygodniowo, a lojalność województw spada.
- **Super-wydarzenia** w systemie autora (`f_cpz_se.py`): noc w Trybunale, pierwsze państwo, wojna domowa, rozpad Warszawy, zwycięstwo rządu, zwycięstwo Belwederu, ocalenie, koniec Rzeczypospolitej.
- **Ilustracje:** lista w `docs/GRAFIKI_CZARNY_PAZDZIERNIK.md`; plik w `gfx/event_pictures/cpz/` zastępuje ilustrację zastępczą przy następnym zbudowaniu.
- Źródła usunięte z okien zdarzeń (zostają w `docs/TK_2026_LIVELOG.md`), wyróżnienia białe zamiast żółtych i szarych.
