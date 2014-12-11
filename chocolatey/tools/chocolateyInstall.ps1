# Remove old apm shim
$apmPath = Join-Path $nugetExePath "apm.bat"
if (Test-Path ($apmPath)) {Remove-Item $apmPath -force}

# Run installer
$packageName = 'Atom'
$url = 'https://atom.io/download/windows'
$installerType = 'exe'
$silentArgs = ''

Install-ChocolateyPackage $packageName $installerType $silentArgs $url
