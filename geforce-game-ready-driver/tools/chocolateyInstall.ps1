﻿$ErrorActionPreference = 'Stop';
$packageArgs = @{
	packageName    = 'geforce-game-ready-driver'
	fileType       = 'EXE'
	url64          = 'https://us.download.nvidia.com/Windows/440.97/440.97-desktop-win10-64bit-international-whql.exe'
	checksum64     = '7e15ed810126bf300784a6825f7f69e19e603215b05f5a0d618bd62212816d75'
	checksumType64 = 'sha256'
	silentArgs     = '-s -noreboot'
	validExitCodes = @(0,1)
	softwareName   = 'NVIDIA Graphics Driver*'
}

If ( [System.Environment]::OSVersion.Version.Major -ne '10' ) {
	$packageArgs['url64']      = 'https://us.download.nvidia.com/Windows/440.97/440.97-desktop-win8-win7-64bit-international-whql.exe'
	$packageArgs['checksum64'] = 'f0a666c18bb0e5a187f0637dcab1e5cd5b8b7cd896a0f5d672a8877492689039'
}

$pp = Get-PackageParameters
If ($pp['dch'] -eq 'true') {
	$packageArgsDCHURL      = 'https://us.download.nvidia.com/Windows/440.97/440.97-desktop-win10-64bit-international-dch-whql.exe'
	$packageArgsDCHChecksum = '8cc5f7a5d6396b933961a392621fd56ae2cf391fb99b2e717327a142c39a74f5'
	$packageArgs['url64']      = $packageArgsDCHURL
	$packageArgs['checksum64'] = $packageArgsDCHChecksum
}

If ( -not (Get-OSArchitectureWidth -compare 64) ) {
	Write-Warning "NVIDIA has ended support for 32bit operating systems."
	Write-Warning "32 bit users should specify version 391.35."
	Write-Warning "Security patches for 32bit may be available on geforce.com"
	Write-Error "32 bit no longer supported."
}

Install-ChocolateyPackage @packageArgs

Write-Host "The package 'nvidia-display-driver' is also available for those who don't want or need the extra software bundled with the conventional geforce package."
