==========================================================

Windows License Manager (slmgr-GUI)

Autor: Yousof

Website: Neisitech.de

==========================================================

<#
.SYNOPSIS
Ein interaktives PowerShell-Skript zur vereinfachten Verwaltung von Windows-Lizenzen und KMS-Einstellungen über slmgr.vbs.
.DESCRIPTION
Dieses Skript bietet ein benutzerfreundliches Konsolenmenü zur Steuerung des Windows Software Licensing Management Tools (slmgr).
#>

Prüfen, ob das Skript als Administrator ausgeführt wird

function Test-IsAdmin {
$identity = [Security.Principal.WindowsIdentity]::GetCurrent()
$principal = New-Object Security.Principal.WindowsPrincipal($identity)
return $principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}

if (-not (Test-IsAdmin)) {
Write-Host "" -ForegroundColor Red
Write-Host " FEHLER: Dieses Skript erfordert Administratorrechte!" -ForegroundColor Red
Write-Host " Bitte starten Sie die PowerShell als Administrator." -ForegroundColor Yellow
Write-Host "" -ForegroundColor Red
Write-Host ""
Read-Host "Drücken Sie die Eingabetaste zum Beenden..."
exit
}

--- Hilfsfunktionen ---

function Show-Header {
Clear-Host
Write-Host "" -ForegroundColor Cyan
Write-Host "            Windows License Manager (slmgr)               " -ForegroundColor Yellow
Write-Host "            Autor: Yousof | Neisitech.de                  " -ForegroundColor Gray
Write-Host "" -ForegroundColor Cyan
Write-Host ""
}

function Pause-Console {
Write-Host ""
Write-Host "----------------------------------------------------------" -ForegroundColor Gray
Read-Host "Drücken Sie die Eingabetaste, um zum Hauptmenü zurückzukehren..."
}

--- Hauptmenü Funktionen ---

1. Lizenzstatus prüfen

function Show-LicenseInfoBasic {
Show-Header
Write-Host "[1.1] Grundlegende Lizenzinformationen (/dli)..." -ForegroundColor Cyan
cscript //nologo C:\Windows\System32\slmgr.vbs /dli
Pause-Console
}

function Show-LicenseInfoDetailed {
Show-Header
Write-Host "[1.2] Detaillierte Lizenzinformationen (/dlv)..." -ForegroundColor Cyan
cscript //nologo C:\Windows\System32\slmgr.vbs /dlv
Pause-Console
}

function Show-LicenseExpiration {
Show-Header
Write-Host "[1.3] Ablaufdatum der Lizenz prüfen (/xpr)..." -ForegroundColor Cyan
slmgr.vbs /xpr
Pause-Console
}

2. Produkt-Key verwalten

function Install-ProductKey {
Show-Header
Write-Host "[2.1] Produkt-Schlüssel installieren (/ipk)" -ForegroundColor Cyan
$key = Read-Host "Geben Sie den 25-stelligen Produktschlüssel ein (XXXXX-XXXXX-XXXXX-XXXXX-XXXXX)"
if ([string]::IsNullOrWhiteSpace($key)) {
Write-Host "Eingabe abgebrochen. Kein Schlüssel eingegeben." -ForegroundColor Red
} else {
slmgr.vbs /ipk $key
}
Pause-Console
}

function Uninstall-ProductKey {
Show-Header
Write-Host "[2.2] Produkt-Schlüssel deinstallieren (/upk)" -ForegroundColor Yellow
$confirm = Read-Host "Möchten Sie den aktuellen Produktschlüssel wirklich entfernen? (J/N)"
if ($confirm -eq "J" -or $confirm -eq "j") {
slmgr.vbs /upk
} else {
Write-Host "Vorgang abgebrochen." -ForegroundColor Green
}
Pause-Console
}

function Clear-ProductKeyFromRegistry {
Show-Header
Write-Host "[2.3] Produkt-Schlüssel aus Registry löschen (/cpky)" -ForegroundColor Yellow
Write-Host "Dies verhindert das Auslesen des Keys aus der Registry durch Schadsoftware." -ForegroundColor Gray
slmgr.vbs /cpky
Pause-Console
}

3. Aktivierung durchführen & erneuern

function Activate-WindowsOnline {
Show-Header
Write-Host "[3.1] Online-Aktivierung durchführen (/ato)..." -ForegroundColor Cyan
slmgr.vbs /ato
Pause-Console
}

function Reset-RearmStatus {
Show-Header
Write-Host "[3.2] Evaluierungszeitraum zurücksetzen (/rearm)" -ForegroundColor Yellow
$confirm = Read-Host "Möchten Sie den Testzeitraum zurücksetzen? (J/N)"
if ($confirm -eq "J" -or $confirm -eq "j") {
slmgr.vbs /rearm
Write-Host "Hinweis: Ein Neustart des Systems ist im Anschluss erforderlich!" -ForegroundColor Red
} else {
Write-Host "Vorgang abgebrochen." -ForegroundColor Green
}
Pause-Console
}

4. KMS-Server-Steuerung

function Set-KmsServer {
Show-Header
Write-Host "[4.1] KMS-Server manuell setzen (/skms)" -ForegroundColor Cyan
$server = Read-Host "Geben Sie den Servernamen oder die IP-Adresse des KMS-Servers ein (optional mit Port, z. B. kms.domain.local:1688)"
if ([string]::IsNullOrWhiteSpace($server)) {
Write-Host "Eingabe abgebrochen." -ForegroundColor Red
} else {
slmgr.vbs /skms $server
}
Pause-Console
}

function Clear-KmsServer {
Show-Header
Write-Host "[4.2] KMS-Server-Einstellung löschen (/ckms)" -ForegroundColor Cyan
Write-Host "Setzt die KMS-Erkennung wieder auf automatische Ermittlung via DNS zurück." -ForegroundColor Gray
slmgr.vbs /ckms
Pause-Console
}

--- Hauptschleife (Menüführung) ---

do {
Show-Header
Write-Host " --- 1. LIZENZSTATUS PRÜFEN ---" -ForegroundColor Green
Write-Host "  1) Grundlegende Lizenzinfo (/dli)"
Write-Host "  2) Detaillierte Lizenzinfo (/dlv)"
Write-Host "  3) Ablaufdatum anzeigen (/xpr)"
Write-Host ""
Write-Host " --- 2. PRODUKT-KEY VERWALTEN ---" -ForegroundColor Green
Write-Host "  4) Produkt-Schlüssel installieren (/ipk)"
Write-Host "  5) Produkt-Schlüssel deinstallieren (/upk)"
Write-Host "  6) Produkt-Schlüssel aus Registry löschen (/cpky)"
Write-Host ""
Write-Host " --- 3. AKTIVIERUNG & TIMERS ---" -ForegroundColor Green
Write-Host "  7) Windows jetzt aktivieren (/ato)"
Write-Host "  8) Testzeitraum zurücksetzen (/rearm)"
Write-Host ""
Write-Host " --- 4. KMS-SERVER STEUERUNG ---" -ForegroundColor Green
Write-Host "  9) KMS-Server manuell festlegen (/skms)"
Write-Host " 10) KMS-Server zurücksetzen auf DNS (/ckms)"
Write-Host ""
Write-Host "  0) Beenden" -ForegroundColor Red
Write-Host ""

$choice = Read-Host "Bitte wählen Sie eine Option (0-10)"

switch ($choice) {
    "1"  { Show-LicenseInfoBasic }
    "2"  { Show-LicenseInfoDetailed }
    "3"  { Show-LicenseExpiration }
    "4"  { Install-ProductKey }
    "5"  { Uninstall-ProductKey }
    "6"  { Clear-ProductKeyFromRegistry }
    "7"  { Activate-WindowsOnline }
    "8"  { Reset-RearmStatus }
    "9"  { Set-KmsServer }
    "10" { Clear-KmsServer }
    "0"  { Show-Header; Write-Host "Skript beendet. Auf Wiedersehen!" -ForegroundColor Green; Start-Sleep -Seconds 1; exit }
    default { Write-Host "Ungültige Auswahl! Bitte erneut versuchen." -ForegroundColor Red; Start-Sleep -Seconds 1 }
}


} while ($true)
