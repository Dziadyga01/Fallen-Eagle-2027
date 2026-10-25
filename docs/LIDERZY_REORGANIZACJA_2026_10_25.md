# Reorganizacja portretów liderów — 25.10.2026

## Cel

Naprawa zbiorczych katalogów `gfx/leaders` oraz ścieżek portretów w plikach `common/characters`. Każda postać otrzymuje własny katalog, np.:

```text
gfx/leaders/PL2027/MAZ_leader/MAZ_leader.dds
gfx/leaders/PL2027/MAZ_leader/MAZ_leader_small.dds
gfx/leaders/TRN/TRN_michal_romanowski/TRN_michal_romanowski.dds
gfx/leaders/TRN/TRN_michal_romanowski/TRN_michal_romanowski_small.dds
```

## Dane wejściowe

- `Liderzy.zip` — 83 podpisane pliki PNG.
- `leaders.rar`, `leaders(1).rar` — dwa **identyczne** archiwa RAR5, 863 pozycji, w tym 802 pliki obrazów.
- 47 podpisanych PNG nadaje się do bezpośredniej podmiany istniejących slotów liderów.
- 27 zdjęć zachowano jako odrębne portrety dodatkowe (nie są domyślnymi liderami).
- 9 zdjęć przeniesiono do grupy wymagającej weryfikacji. Portret `zalewski.png` nie nadpisuje Michała Zaleskiego bez potwierdzenia.

## Ważne: grafiki binarne poza GitHub

**Ta gałąź aktualizuje ścieżki i nazwy postaci. Portrety DDS NIE znajdują się jeszcze w repozytorium GitHub.**
Nie wolno scalać PR do `main` przed dograniem plików DDS, ponieważ nowe ścieżki wymagają rzeczywistych folderów.

Gotowa paczka binarna `The_Fallen_Eagle_2027_NAPRAWIENI_LIDERZY_2026_10_25.zip` została przekazana użytkownikowi jako załącznik w rozmowie ChatGPT. Jej zawartość obejmuje 879 plików graficznych PNG/DDS, manifest przekierowań, CSV, instalator Windows i wersję Python 3.

## Procedura

1. Rozpakuj ZIP poza folderem gry.
2. Zainstaluj do katalogu lokalnego repozytorium, np. uruchamiając `INSTALUJ_PORTRETY.bat`.
3. Instalator utworzy indywidualne foldery, zaktualizuje pozostałe odwołania tekstowe w modzie i wykona kopię bezpieczeństwa starych portretów.
4. Przetestuj w HOI4 co najmniej 15 liderów, których wcześniej błędnie wyświetlano.
5. Sprawdź `error.log`, następnie wykonaj `git add gfx/leaders common/characters localisation`, `git commit` i `git push` na osobnej gałęzi.
6. Scal ten PR dopiero po potwierdzeniu istnienia nowych portretów w gałęzi GitHub.

## Weryfikacja

- Sprawdzono 866 plików DDS: wszystkie otwierają się poprawnie.
- Dokładnie 433 pliki dużych portretów 156×210 i 433 miniatury 65×67.
- Instalatorem przetestowano przeniesienie obrazów, backup i poprawianie dwóch testowych ścieżek.
- Bez uruchomienia silnika HOI4 nie można zagwarantować pełnego działania wszystkich postaci.

## Niektóre potwierdzone przypisania

`PRW_leader` — Przemysław Czarnek; `KKR_leader` — Grzegorz Braun; `NNA_leader` — Sławomir Mentzen; `MLA_leader` — Piotr Jankowski; `CHJ_leader` — Arseniusz Finster; `KTN_leader` — Paweł Kulesza; `TUC_leader` — Tadeusz Kowalski; `NOT_leader` — Sławomir Napierała; `DAB_leader` — Radosław Ciechacki; `KRW_leader` — Patryk Mikołajewski.

## Uwagi

Tożsamości nieznanych postaci nie ustalano na podstawie samego podobieństwa twarzy. Dane oparto na podpisach przekazanych przez autora moda i tekstowej weryfikacji stanowisk. W przypadku dwóch osób związanych z OSD drugi portret pozostaje rezerwowy, dopóki nie powstanie odpowiednia mechanika wyboru lidera.

## Uzupełnienie: pięć obsad potwierdzonych przez autora (25.10.2026)

| Obraz wejściowy | Postać | Postać HOI4 | Rola w świecie moda |
|---|---|---|---|
| `zalewski.png` | Michał Zaleski | `TRN_michal_zaleski` | kandydat na prezydenta Torunia |
| `Donek.png` | Donald Tusk | `IVRP_lider_sejm` | tymczasowy przewodniczący Rady Sejmowej |
| `Krzysztof Gawkowski.png` | Krzysztof Gawkowski | `LWC_leader` | prezydent Łodzi, LWC |
| `Pokłanska.png` | Natalia Pokłońska | `ROS_poklonska` | alternatywna przywódczyni Rosji, ROS |
| `Łukasz Kwiatkowski.png` | Łukasz Kwiatkowski | `GRU_leader` | prezydent Grudziądza, GRU |

- Wszystkie pięć zdjęć trafiło do istniejących folderów postaci w paczce `The_Fallen_Eagle_2027_LIDERZY_POPRAWKI_5_OSOB_2026_10_25.zip` (156×210 + 65×67 px, DDS).
- `GRU_leader` zastępuje portret oraz nazwę Macieja Glamowskiego. Jego poprzedni portret zachowano w `DODATKOWI/GRU_maciej_glamowski` **bez przypisania do postaci**.
- `IVRP_lider_sejm` ma nowy opis stanowiska, a `ROS_droga_poklonskiej` rekrutuje i promuje `ROS_poklonska`. `LWC_leader` był już podpisany jako Gawkowski, lecz otrzymuje nowy obraz.
- Cztery pozostałe pliki (`czarzasty.png`, `Generał jakiś tam.png`, `feweks.png`, `Łukasz Walusiak.png`) zachowano **bez obsady**. Nie dodano ich jako polityków, doradców ani generałów.
- **Uwaga:** obrazów DDS nie wgrano do GitHuba; nadal potrzebna instalacja ZIP i wysłanie nowych obrazów na gałąź PR, zanim scalimy zmiany ze ścieżkami.
