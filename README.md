# Windows-win-license-manager
An interactive PowerShell script for managing Windows activation, product keys, and KMS server configuration via slmgr.

Windows License Manager (win-license-manager)

Ein interaktives PowerShell-Tool zur einfachen Verwaltung von Windows-Aktivierungen, Produktschlüsseln und KMS-Server-Verbindungen.

📝 Beschreibung

Das Windows License Manager Skript stellt eine benutzerfreundliche Textoberfläche (CLI-Menü) bereit, um das Windows-eigene Befehlszeilenwerkzeug slmgr.vbs (Software Licensing Management Tool) komfortabel und ohne ständiges Auswendiglernen von Parametern zu bedienen.

Es richtet sich an Systemadministratoren, IT-Techniker sowie erfahrene Anwender, die Windows-Lizenzen und KMS-Server in Enterprise- oder Testumgebungen verwalten müssen.

✨ Funktionen

Lizenzstatus abfragen:

Grundlegende Lizenzinformationen anzeigen (/dli).

Detaillierte Diagnoseberichte erstellen (/dlv).

Verbleibende Lizenzdauer bzw. Ablaufdatum anzeigen (/xpr).

Produktschlüssel-Verwaltung:

Neuen Produktschlüssel installieren (/ipk).

Aktuellen Schlüssel aus dem System entfernen (/upk).

Produktschlüssel aus der Windows-Registry löschen (/cpky), um Diebstahl durch Malware zu verhindern.

Aktivierung & Testzeitraum:

Sofortige Online-Aktivierung ausführen (/ato).

Testzeitraum (Rearm-Count) zurücksetzen (/rearm).

KMS-Server-Verwaltung:

Manuelle Zuweisung eines KMS-Servers (/skms).

KMS-Server-Zuweisung löschen und DNS-Autodiscovery aktivieren (/ckms).

⚙️ Voraussetzungen

Betriebssystem: Windows 10, Windows 11, Windows Server 2016 / 2019 / 2022 / 2025

Berechtigungen: Administratorrechte (Das Skript prüft beim Start automatisch, ob es als Administrator ausgeführt wird).

PowerShell: PowerShell 5.1 oder höher.

🚀 Installation

Klonen Sie das Repository oder laden Sie die ZIP-Datei herunter:

git clone https://github.com/Yousof/win-license-manager.git


Navigieren Sie in das Projektverzeichnis:

cd win-license-manager


💻 Verwendung

Öffnen Sie die PowerShell als Administrator (Rechtsklick -> Als Administrator ausführen).

Falls die Ausführungsrichtlinie das Ausführen von Skripten blockiert, führen Sie einmalig folgenden Befehl aus:

Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope Process


Starten Sie das Skript:

.\win-license-manager.ps1


📋 Menüoptionen

==========================================================
            Windows License Manager (slmgr)               
            Autor: Yousof | Neisitech.de                  
==========================================================

 --- 1. LIZENZSTATUS PRÜFEN ---
  1) Grundlegende Lizenzinfo (/dli)
  2) Detaillierte Lizenzinfo (/dlv)
  3) Ablaufdatum anzeigen (/xpr)

 --- 2. PRODUKT-KEY VERWALTEN ---
  4) Produkt-Schlüssel installieren (/ipk)
  5) Produkt-Schlüssel deinstallieren (/upk)
  6) Produkt-Schlüssel aus Registry löschen (/cpky)

 --- 3. AKTIVIERUNG & TIMERS ---
  7) Windows jetzt aktivieren (/ato)
  8) Testzeitraum zurücksetzen (/rearm)

 --- 4. KMS-SERVER STEUERUNG ---
  9) KMS-Server manuell festlegen (/skms)
 10) KMS-Server zurücksetzen auf DNS (/ckms)

  0) Beenden


💡 Beispiele

KMS-Server für Firmennetzwerk setzen:

Skript starten (.\win-license-manager.ps1).

Option 9 wählen.

KMS-Serveradresse eingeben: kms.domain.local:1688.

Option 7 wählen, um Windows sofort über den neuen KMS-Server zu aktivieren.

⚠️ Hinweise

System-Neustart bei Rearm: Nach dem Zurücksetzen des Testzeitraums (/rearm) ist in der Regel ein Neustart des Computers erforderlich, damit die Änderung wirksam wird.

Rechte-Prüfung: Das Skript bricht automatisch ab, wenn es nicht mit erhöhten Rechten (Als Administrator) gestartet wurde.

👤 Autor

Yousof
Website: Neisitech.de
