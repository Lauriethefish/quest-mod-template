# Builds a .zip file for loading with BMBF
& $PSScriptRoot/build.ps1

Compress-Archive -Path "./libs/arm64-v8a/lib#{id}_0_1_0.so", "./libs/arm64-v8a/libbeatsaber-hook_0_8_4.so", "./bmbfmod.json" -DestinationPath "./#{id}_v0.1.0.zip" -Update
