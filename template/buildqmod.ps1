Param(
    [Parameter(Mandatory=$false)]
    [String] $qmodName="",

    [Parameter(Mandatory=$false)]
    [Switch] $clean,

    [Parameter(Mandatory=$false)]
    [Switch] $help
)

if ($help -eq $true) {
    Write-Output "`"BuildQmod <qmodName>`" - Copiles your mod into a `".so`" or a `".a`" library and creates a .qmod file with it, its dependencies, and your mod.json."
    Write-Output "`n-- Arguments --`n"

    Write-Output "-Clean `t Deletes the `"build`" folder, so that the entire library is rebuilt"
    Write-Output "-QmodName `t The file name of your qmod"

    exit
}

& $PSScriptRoot/build.ps1 -clean:$clean

if ($LASTEXITCODE -ne 0) {
    Write-Output "Failed to build, exiting..."
    exit $LASTEXITCODE
}

& $PSScriptRoot/createqmod.ps1 -qmodName:$qmodName
