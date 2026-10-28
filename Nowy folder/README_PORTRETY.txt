THE FALLEN EAGLE: 2027 — NAPRAWA LIDERÓW (25.10.2026)
===================================================

W zestawie:
- 802 pliki z poprzedniego archiwum leaders.rar, bez nadpisania oryginału;
- wszystkie stare obrazy rozdzielone na indywidualne katalogi postaci;
- 47 portretów bezpośrednio podmienionych na podpisane zdjęcia;
- 27 osobnych dodatkowych portretów, które nie nadpisują bieżących władz;
- 9 nierozstrzygniętych plików w katalogu DO_WERYFIKACJI;
- MAPOWANIE_LIDEROW.csv, MANIFEST_PRZENIESIEN.json i PRZYPISANIA.json;
- instalator systemu Windows oraz uniwersalny skrypt Python 3.

Przykładowa struktura:
 gfx/leaders/PL2027/SUW_leader/SUW_leader.dds
 gfx/leaders/PL2027/SUW_leader/SUW_leader_small.dds
 gfx/leaders/TRN/TRN_michal_romanowski/TRN_michal_romanowski.dds
 gfx/leaders/TRN/TRN_michal_romanowski/TRN_michal_romanowski_small.dds

WYMAGANIA: Python 3.9+ (do instalacji; gra nie potrzebuje Pythona).

INSTRUKCJA
1. Zamknij grę.
2. Rozpakuj CAŁE archiwum ZIP do osobnego folderu.
3. Otwórz INSTALUJ_PORTRETY.bat.
4. Wskaż folder główny moda, w którym znajdują się katalogi common i gfx.
5. Instalator skopiuje obrazy, zmieni ścieżki we wszystkich plikach tekstowych
   moda oraz przeniesie stare grafiki do folderu _BACKUP_LIDERZY_[data].
6. Sprawdź grę, portrety, log error.log i ewentualne zmiany w GitHub Desktop.

Niektóre zdjęcia mają tylko nazwę stanowiska bez imienia i nazwiska.
Przypisano je do ról, a nie do odgadniętej na podstawie twarzy osoby.
Portret "zalewski.png" celowo znajduje się w DO_WERYFIKACJI: gra ma
Michała Zaleskiego, ale podobne brzmienie nazwisk nie potwierdza tożsamości.

Żadne nierozstrzygnięte zdjęcie NIE zastępuje obecnego przywódcy.
Alternatywne portrety znajdują się w odrębnych folderach i mogą wymagać
ręcznego dopisania danej postaci w common/characters.

Wszystkie potwierdzone nazwiska do zmiany w ekranie państwa są poprawiane
osobno przez plik lokalizacji w aktualizacji GitHub; instalator zajmuje się
folderami, obrazami i odniesieniami do ścieżek.

UWAGA: nie wrzucaj zmian do MAIN bez przetestowania moda. Jeśli korzystasz
z repozytorium, po instalacji sprawdź `git status`, dodaj zasoby i przetestuj.
