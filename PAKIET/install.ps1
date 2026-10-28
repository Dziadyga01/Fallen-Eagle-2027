param([string]$ModPath = "")
$ErrorActionPreference = 'Stop'
$here = Split-Path -Parent $MyInvocation.MyCommand.Path
if (-not $ModPath) {
  $homeDocs = [Environment]::GetFolderPath('MyDocuments')
  $candidates = @(
    (Join-Path $homeDocs 'Paradox Interactive\Hearts of Iron IV\mod\Fallen-Eagle-2027'),
    (Join-Path $env:USERPROFILE 'Documents\Paradox Interactive\Hearts of Iron IV\mod\Fallen-Eagle-2027'),
    (Join-Path $env:USERPROFILE 'OneDrive\Documents\Paradox Interactive\Hearts of Iron IV\mod\Fallen-Eagle-2027')
  )
  $ModPath = $candidates | Where-Object {
    Test-Path (Join-Path $_ 'common\national_focus\pl2027_TR2_romanowski_tree.txt')
  } | Select-Object -First 1
}
if (-not $ModPath) {
  throw 'Nie znaleziono moda. Podaj sciezke: powershell -ExecutionPolicy Bypass -File .\install.ps1 -ModPath "C:\...\Fallen-Eagle-2027"'
}
$target = Join-Path $ModPath 'common\national_focus\pl2027_TR2_romanowski_tree.txt'
if (-not (Test-Path $target)) { throw "Brak pliku: $target" }
$fragment = [IO.File]::ReadAllText((Join-Path $here 'NOWE_DRZEWKO_FRAGMENT.txt'), [Text.Encoding]::UTF8)
$original = [IO.File]::ReadAllText($target, [Text.Encoding]::UTF8)
if (-not $original.Contains('id = TR2_rom_final')) { throw 'Nie znaleziono TR2_rom_final, nic nie zmieniono.' }
if ($original -notmatch 'focus_tree\s*=\s*\{' ) { throw 'Nieprawidlowa struktura pliku: focus_tree.' }
$backupDir = Join-Path $ModPath 'backups_MRX_story'
New-Item -Force -ItemType Directory -Path $backupDir | Out-Null
$backup = Join-Path $backupDir ('pl2027_TR2_romanowski_tree.' + (Get-Date -Format 'yyyyMMdd_HHmmss_fff') + '.bak')
Copy-Item -LiteralPath $target -Destination $backup

# Usun tylko dokladnie oznaczone sekcje z poprzedniego i obecnego dodatku.
$patterns = @(
  '(?s)\s*# BEGIN TR2_MR_PERSONAL_EXTENSION.*?# END TR2_MR_PERSONAL_EXTENSION\s*',
  '(?s)\s*# BEGIN MRX_STORY_CAMPAIGN_V2.*?# END MRX_STORY_CAMPAIGN_V2\s*'
)
$working = $original
foreach ($pattern in $patterns) { $working = [regex]::Replace($working, $pattern, "`r`n") }
$last = $working.LastIndexOf('}')
if ($last -lt 0) { throw 'Brak klamry zamykajacej drzewko.' }
$merged = $working.Substring(0,$last) + "`r`n" + $fragment + "`r`n" + $working.Substring($last)
if ([regex]::Matches($merged, 'id\s*=\s*MRX_w_nocy').Count -ne 1) {
  throw 'Wykryto podwojony start kampanii. Nie nadpisano pliku.'
}
[IO.File]::WriteAllText($target, $merged, [Text.UTF8Encoding]::new($false))

# Kopie tylko plikow ze starej wersji dodatku (nie plikow podstawowych moda).
$oldRel = @(
 'events\pl2027_mr_personal.txt',
 'common\decisions\pl2027_mr_personal.txt',
 'common\ideas\pl2027_mr_personal.txt',
 'common\decisions\categories\pl2027_mr_personal.txt',
 'localisation\polish\pl2027_mr_personal_l_polish.yml',
 'localisation\english\pl2027_mr_personal_l_english.yml'
)
foreach($rel in $oldRel) {
  $p = Join-Path $ModPath $rel
  if (Test-Path $p) {
    $dest = Join-Path $backupDir $rel
    New-Item -ItemType Directory -Force -Path (Split-Path -Parent $dest) | Out-Null
    Copy-Item -LiteralPath $p -Destination $dest -Force
    Remove-Item -LiteralPath $p -Force
  }
}
$src = Join-Path $here 'MOD_FILES'
Get-ChildItem -LiteralPath $src -File -Recurse | ForEach-Object {
  $relative = $_.FullName.Substring($src.Length + 1)
  $dest = Join-Path $ModPath $relative
  New-Item -ItemType Directory -Force -Path (Split-Path -Parent $dest) | Out-Null
  Copy-Item -LiteralPath $_.FullName -Destination $dest -Force
}
Write-Host ('Zainstalowano MRX: 59 fokusow. Backup: ' + $backup)
