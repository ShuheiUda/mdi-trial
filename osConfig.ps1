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

#サーバーを再起動します
Restart-Computer 