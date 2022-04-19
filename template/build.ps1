Param(
    [Parameter(Mandatory=$false)]
    [Switch] $clean,

    [Parameter(Mandatory=$false)]
    [Switch] $help

    [Parameter(Mandatory=$false)]
    [Switch]$release
)

if ($help -eq $true) {
    echo "`"Build`" - Copiles your mod into a `".so`" or a `".a`" library"
    echo "`n-- Arguments --`n"

    echo "-Clean `t`t Deletes the `"build`" folder, so that the entire library is rebuilt"
    echo "-release `t`t Generates a release build of your mod, otherwise it generates a debug build"
    exit
}

# if user specified clean, remove all build files
if ($clean.IsPresent)
{
    if (Test-Path -Path "build")
    {
        remove-item build -R
    }
}


if (($clean.IsPresent) -or (-not (Test-Path -Path "build")))
{
    $out = new-item -Path build -ItemType Directory
} 

$buildType = "Debug"
if ($release.IsPresent) {
    echo "Building release binary"
    $buildType = "RelWithDebInfo"
}
else {
    echo "Building debug binary"
}

& cmake -G "Ninja" -DCMAKE_BUILD_TYPE="$buildType" -B build
& cmake --build ./build
$ExitCode = $LastExitCode
exit $ExitCode