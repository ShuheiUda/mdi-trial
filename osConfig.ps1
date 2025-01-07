# Start Logging
Start-Transcript -Path C:\deploy-log.txt
$DebugPreference = "Continue"

# Create Tools Directory if it does not exist
$toolsDir = "C:\Tools"
if ((Test-Path -Path $toolsDir) -eq $false) {New-Item -Path C:\ -Name Tools -ItemType Directory}

# Exclude the C:\tools folder from Windows Defender scans
Add-MpPreference -ExclusionPath "C:\tools"

# Remove only .zip files from the specified folder
Get-ChildItem -Path $toolsDir -Filter *.zip -Recurse | Remove-Item -Force

#日本語の言語パックインストール
Install-Language ja-JP -CopyToSettings

#表示言語を日本語に変更する
Set-systemPreferredUILanguage ja-JP

#UIの言語を日本語で上書きします
Set-WinUILanguageOverride -Language ja-JP

#時刻/日付の形式をWindowsの言語と同じにします
Set-WinCultureFromLanguageListOptOut -OptOut $False

#タイムゾーンを東京にします
Set-TimeZone -id "Tokyo Standard Time"

#ロケーションを日本にします
Set-WinHomeLocation -GeoId 0x7A

#システムロケールを日本にします
Set-WinSystemLocale -SystemLocale ja-JP

#ユーザーが使用する言語を日本語にします
Set-WinUserLanguageList -LanguageList ja-JP,en-US -Force

#入力する言語を日本語で上書きします
Set-WinDefaultInputMethodOverride -InputTip "0411:00000411"

#ようこそ画面と新しいユーザーの設定をコピーします
Copy-UserInternationalSettingsToSystem -welcomescreen $true -newuser $true

# Create a PSCredential object using the domain user and secure password
$credential = New-Object System.Management.Automation.PSCredential("Administrator", (ConvertTo-SecureString "P@ssw0rd!" -AsPlainText -Force))

# Join the computer to the domain
Add-Computer -DomainName "contoso.com" -Credential $credential -Restart

#サーバーを再起動します
Restart-Computer

# Stop Logging
Stop-Transcript