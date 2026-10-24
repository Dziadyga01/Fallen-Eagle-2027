param(
    [Parameter(Mandatory = $true)]
    [string]$RepoPath
)
$ErrorActionPreference = 'Stop'
if (-not (Test-Path (Join-Path $RepoPath '.git'))) {
    throw "Nie znaleziono repozytorium Git w: $RepoPath"
}
$source = Join-Path $PSScriptRoot 'gfx\leaders\PL2027'
$destination = Join-Path $RepoPath 'gfx\leaders\PL2027'
if (-not (Test-Path $source)) { throw "Brak katalogu portretow w paczce." }
if (-not (Test-Path $destination)) { New-Item -ItemType Directory -Path $destination | Out-Null }
# Pobierz commit z lokalizacjami. Nie nadpisuj zadnych niezapisanych zmian.
git -C $RepoPath pull --ff-only
if ($LASTEXITCODE -ne 0) { throw 'Git pull nie powiodl sie. Sprawdz lokalne zmiany.' }
Copy-Item -Path (Join-Path $source '*.dds') -Destination $destination -Force
git -C $RepoPath add -- gfx/leaders/PL2027
if ($LASTEXITCODE -ne 0) { throw 'Git add nie powiodl sie.' }
git -C $RepoPath diff --cached --quiet
if ($LASTEXITCODE -eq 0) {
    Write-Host 'Portrety sa juz aktualne w repozytorium.'
    exit 0
}
git -C $RepoPath commit -m 'feat: add portraits for regional leaders'
if ($LASTEXITCODE -ne 0) { throw 'Git commit nie powiodl sie.' }
git -C $RepoPath push origin HEAD:main
if ($LASTEXITCODE -ne 0) { throw 'Git push nie powiodl sie.' }
Write-Host 'Gotowe. Portrety wyslane na GitHub.'
