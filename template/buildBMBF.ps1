# Builds a .zip file for loading with BMBF
& $PSScriptRoot/build.ps1

if ($?) {
    Compress-Archive -Path "./libs/arm64-v8a/lib#{id}.so", "./libs/arm64-v8a/libbeatsaber-hook_1_2_4.so", "./bmbfmod.json" -DestinationPath "./#{id}_v0.1.0.zip" -Update
}
