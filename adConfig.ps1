# Create Tools Directory if it does not exist
$toolsDir = "C:\Tools"
if ((Test-Path -Path $toolsDir) -eq $false) {New-Item -Path C:\ -Name Tools -ItemType Directory}

# Sysinternals Suite
Invoke-WebRequest -OutFile "$toolsDir\SysinternalsSuite.zip" -Uri 'https://download.sysinternals.com/files/SysinternalsSuite.zip' 
New-Item -Path $toolsDir -Name "SysinternalsSuite" -ItemType Directory
Expand-Archive -Path "$toolsDir\SysinternalsSuite.zip" -DestinationPath "$toolsDir\SysinternalsSuite"

# NetSess
Invoke-WebRequest -OutFile "$toolsDir\NetSess.zip" -Uri 'https://www.joeware.net/downloads/dl2.php' -Method POST -Body @{download='NetSess.zip';email='';B1='Download Now'}
New-Item -Path $toolsDir -Name "NetSess" -ItemType Directory
Expand-Archive -Path "$toolsDir\NetSess.zip" -DestinationPath "$toolsDir\NetSess"

# ORADAD
Invoke-WebRequest -OutFile "$toolsDir\ORADAD.zip" -Uri 'https://github.com/ANSSI-FR/ORADAD/releases/download/3.3.206/ORADAD.zip'
New-Item -Path $toolsDir -Name "ORADAD" -ItemType Directory
Expand-Archive -Path "$toolsDir\ORADAD.zip" -DestinationPath "$toolsDir\ORADAD"

# adlogin.ps1
New-Item -Path $toolsDir -Name "ADLogin" -ItemType Directory
Invoke-WebRequest -OutFile "$toolsDir\ADLogin\adlogin.ps1" -Uri 'https://github.com/InfosecMatter/Minimalistic-offensive-security-tools/raw/refs/heads/master/adlogin.ps1'

# Userlist
Invoke-WebRequest -OutFile "$toolsDir\usernames.txt" -Uri 'https://raw.githubusercontent.com/jeanphorn/wordlist/refs/heads/master/usernames.txt'

# RockYou.txt
Invoke-WebRequest -OutFile "$toolsDir\RockYou.txt" -Uri 'https://github.com/brannondorsey/naive-hashcat/releases/download/data/rockyou.txt'

# Rubeus
New-Item -Path $toolsDir -Name "Rubeus" -ItemType Directory
Invoke-WebRequest -OutFile "$toolsDir\Rubeus\Rubeus.exe" -Uri "https://github.com/r3motecontrol/Ghostpack-CompiledBinaries/raw/refs/heads/master/dotnet%20v4.5%20compiled%20binaries/Rubeus.exe"

#PowerView
New-Item -Path $toolsDir -Name "PowerView" -ItemType Directory
Invoke-WebRequest -OutFile "$toolsDir\PowerView\PowerView.ps1" -Uri 'https://raw.githubusercontent.com/PowerShellMafia/PowerSploit/refs/heads/master/Recon/PowerView.ps1'

# Hashcat
Invoke-WebRequest -OutFile "$toolsDir\hashcat-6.2.6.7z" -Uri 'https://github.com/hashcat/hashcat/releases/download/v6.2.6/hashcat-6.2.6.7z'

# Mimikatz
Invoke-WebRequest -OutFile "$toolsDir\mimikatz.zip" -Uri 'https://github.com/gentilkiwi/mimikatz/releases/download/2.2.0-20220919/mimikatz_trunk.zip'
New-Item -Path $toolsDir -Name "Mimikatz" -ItemType Directory
Expand-Archive -Path "$toolsDir\mimikatz.zip" -DestinationPath "$toolsDir\Mimikatz"

# Unblocks all files from the internet in the Tools directory
Get-ChildItem -Recurse -Path $toolsDir | Unblock-File -Confirm:$false

# Remove only .zip files from the specified folder
Get-ChildItem -Path $toolsDir -Filter *.zip -Recurse | Remove-Item -Force

#AD のインストール
Install-WindowsFeature -name AD-Domain-Services -IncludeManagementTools

# AD の構成
Import-Module ADDSDeployment
$Password = ConvertTo-SecureString "PSSLab!PSSLab!" -AsPlainText -Force
Install-ADDSForest -CreateDnsDelegation:$false -DatabasePath "C:\WINDOWS\NTDS" -DomainMode "Win2025" -DomainName "contoso.com" -DomainNetbiosName "CONTOSO" -ForestMode "Win2025" -InstallDns:$true -LogPath "C:\WINDOWS\NTDS" -NoRebootOnCompletion:$false -SysvolPath "C:\WINDOWS\SYSVOL" -SafeModeAdministratorPassword $Password -Force:$true

#サーバーを再起動します
Restart-Computer 