& $PSScriptRoot/build.ps1
& adb push libs/arm64-v8a/lib#{id}.so /sdcard/Android/data/com.beatgames.beatsaber/files/mods/lib#{id}.so
& adb shell am force-stop com.beatgames.beatsaber
