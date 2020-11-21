& $PSScriptRoot/build.ps1
& adb push libs/arm64-v8a/lib#{id}_0_1_0.so /sdcard/Android/data/com.beatgames.beatsaber/files/mods/lib#{id}_0_1_0.so
& adb shell am force-stop com.beatgames.beatsaber
