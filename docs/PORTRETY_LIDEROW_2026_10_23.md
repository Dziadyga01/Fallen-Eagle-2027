# Portrety liderów — aktualizacja 23.10.2026

Przygotowano 30 obrazów DDS na podstawie 15 przesłanych plików PNG (14 różnych osób, ponieważ Michał Romanowski ma dwa sloty w `common/characters/pl2027_leaders.txt`).

**Uwaga:** ten commit zmienia lokalizację/nazwy. Same pliki DDS należy dostarczyć oddzielnie jako binarne pliki w `gfx/leaders`, bez zmieniania definicji postaci. Ich gotowa paczka instalacyjna została przygotowana poza repozytorium.

## Dokładne przypisania

| Państwo / rola | Tag | ID postaci | Osoba |
|---|---|---|---|
| Związek Mazurski | MAZ | `MAZ_leader` | Stanisław Mazur |
| Republika Warmińsko-Mazurska | WMZ | `WMZ_leader` | Robert Szewczyk |
| Zjednoczona Polska Prawica | PRW | `PRW_leader` | Przemysław Czarnek |
| Wolna Komuna Toruńska | TRN | `TRN_maksim_krevienko` | Maksim Krevienko |
| Toruński Komitet Obywatelski | TRN | `TRN_katarzyna_kowalczyk` | Katarzyna Kowalczyk |
| Toruń dla Mieszkańców | TRN | `TRN_michal_romanowski` | Michał Romanowski |
| Dodatkowy slot po wygranej | TRN | `TRN_michal_romanowski_lider` | Michał Romanowski |
| Świecie | SWC | `SWC_leader` | Krzysztof Kułakowski |
| Otwock | OTW | `OTW_leader` | Jarosław Tomasz Margielski |
| Skonfederowana Polska | NNA | `NNA_leader` | Sławomir Mentzen |
| Korona Polska | KKR | `KKR_leader` | Grzegorz Braun |
| Zakon Krzyżacki | ZKR | `ZKR_leader` | Frank Bayard |
| Suwałki | SUW | `SUW_leader` | Czesław Renkiewicz |
| Łysomice | LYS | `LYS_leader` | Piotr Kowal |
| Lubicz | LUB | `LUB_leader` | Zbigniew Bombolewski |

Wszystkie istniejące definicje postaci zawierają ścieżki `gfx/leaders/<folder>/<ID>.dds` i `<ID>_small.dds`. Użyj obrazów o wymiarach 156x210 oraz 65x67 px.

Dla Świecia wybrano ostrzejszy z dwóch przesłanych portretów Kułakowskiego; drugi jest zachowany jako alternatywa.

Nazwę państwa pod tagiem NNA zmieniono w polskojęzycznych etykietach pliku `localisation/english/replace/pl2027_countries_l_english.yml` z „Konfederacja Północna” na „Skonfederowana Polska” bez zmiany tagu NNA.
