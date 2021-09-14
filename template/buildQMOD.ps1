$stopwatch =  [system.diagnostics.stopwatch]::StartNew()

# Builds a .qmod file for loading with QuestPatcher
$NDKPath = Get-Content $PSScriptRoot/ndkpath.txt

$Version = "0.1.4"

$buildScript = "$NDKPath/build/ndk-build"
if (-not ($PSVersionTable.PSEdition -eq "Core")) {
    $buildScript += ".cmd"
}

$ArchiveName = "ImageCoverExpander-$Version.qmod"
$TempArchiveName = "ImageCoverExpander-$Version.qmod.zip"

& $buildScript NDK_PROJECT_PATH=$PSScriptRoot APP_BUILD_SCRIPT=$PSScriptRoot/Android.mk NDK_APPLICATION_MK=$PSScriptRoot/Application.mk

$stopwatch.Stop()
$timeElapsed = [math]::Round($stopwatch.Elapsed.TotalSeconds,3)
Write-Output "SO build completed in $timeElapsed seconds"
$stopwatch.Start()

Compress-Archive -Path "./libs/arm64-v8a/libImageCoverExpander.so", "./libs/arm64-v8a/libbeatsaber-hook_2_3_0.so", "imagecoverexpander.png", "./mod.json" -DestinationPath $TempArchiveName -Force
Move-Item $TempArchiveName $ArchiveName -Force

$stopwatch.Stop()
$timeElapsed = [math]::Round($stopwatch.Elapsed.TotalSeconds,3)
Write-Output "QMOD build completed in $imeElapsed seconds"
