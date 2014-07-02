$dest = $(Split-Path -parent $MyInvocation.MyCommand.Definition)

. $(Join-Path $dest "functions.ps1")

# Install zip
$packageName = 'Atom' # arbitrary name for the package, used in messages
$url = 'https://github.com/atom/atom/releases/download/v0.106.0/Atom.zip' # download url
$url64 = $url # 64bit URL here or just use the same as $url
Install-ChocolateyZipPackage "$packageName" "$url" "$dest" "$url64"

# Install desktop shortcut
$desktop = $([System.Environment]::GetFolderPath([System.Environment+SpecialFolder]::DesktopDirectory))
$desktopLink = Join-Path $desktop "$packageName.lnk"
Install-ChocolateyShortcut -shortcutFilePath $desktopLink -targetPath "$dest\Atom.exe"

# Install start menu shortcut
$startMenu = $([System.Environment]::GetFolderPath([System.Environment+SpecialFolder]::Programs))
$githubStartMenuGroup = Join-Path $desktop "GitHub, Inc"
New-Item $githubStartMenuGroup -type directory -force
$startMenuLink = Join-Path $githubStartMenuGroup "$packageName.lnk"
Install-ChocolateyShortcut -shortcutFilePath $startMenuLink -targetPath "$dest\Atom.exe"

# Install explorer menu shortcut
Install-ChocolateyExplorerMenuItem "Atom" "Open with Atom" "$dest\Atom.exe" "file"

# Install apm shortcut
Install-BinFile "apm" "$dest\resources\app\apm\node_modules\atom-package-manager\bin\apm.cmd"
