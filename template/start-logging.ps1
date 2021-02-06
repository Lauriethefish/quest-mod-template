$timestamp = Get-Date -Format "MM-dd HH:mm:ss.fff"
$bspid = adb shell pidof com.beatgames.beatsaber
while ([string]::IsNullOrEmpty($bspid)) {
    Start-Sleep -Milliseconds 100
    $bspid = adb shell pidof com.beatgames.beatsaber
}
adb logcat -T "$timestamp" --pid $bspid | Select-String -pattern "(QuestHook|modloader|AndroidRuntime)"
