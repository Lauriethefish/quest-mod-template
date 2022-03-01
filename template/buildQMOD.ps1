Param(
    [String] $qmodname="",

    [Parameter(Mandatory=$false)]
    [Switch] $clean,

    [Parameter(Mandatory=$false)]
    [Switch] $help
)

if ($help -eq $true) {
    echo "`"BuildQmod <qmodName>`" - Copiles your mod into a `".so`" or a `".a`" library"
    echo "`n-- Parameters --`n"
    echo "qmodName `t The file name of your qmod"

    echo "`n-- Arguments --`n"

    echo "-Clean `t`t Performs a clean build on both your library and the qmod"

    exit
}

if ($qmodName -eq "")
{
    echo "Give a proper qmod name and try again"
    exit
}

& $PSScriptRoot/build.ps1 -clean:$clean

if ($LASTEXITCODE -ne 0) {
    echo "Failed to build, exiting..."
    exit $LASTEXITCODE
}

echo "Creating qmod from mod.json"

$schemaUrl = "https://raw.githubusercontent.com/Lauriethefish/QuestPatcher.QMod/main/QuestPatcher.QMod/Resources/qmod.schema.json"
Invoke-WebRequest $schemaUrl -OutFile ./mod.schema.json

$mod = "./mod.json"
$schema = "./mod.schema.json"
$modJsonRaw = Get-Content $mod -Raw
$modJson = $modJsonRaw | ConvertFrom-Json
$modSchemaRaw = Get-Content $schema -Raw

Remove-Item ./mod.schema.json

echo "Validating mod.json..."
if(!($modJsonRaw | Test-Json -Schema $modSchemaRaw)) {
    exit
}

$filelist = @($mod)

$cover = "./" + $modJson.coverImage
if ((-not ($cover -eq "./")) -and (Test-Path $cover))
{ 
    $filelist += ,$cover
}

foreach ($mod in $modJson.modFiles)
{
    $path = "./build/" + $mod
    if (-not (Test-Path $path))
    {
        $path = "./extern/libs/" + $mod
    }
    $filelist += $path
}

foreach ($lib in $modJson.libraryFiles)
{
    $path = "./extern/libs/" + $lib
    if (-not (Test-Path $path))
    {
        $path = "./build/" + $lib
    }
    $filelist += $path
}

$zip = $qmodName + ".zip"
$qmod = $qmodName + ".qmod"

if ((-not ($clean.IsPresent)) -and (Test-Path $qmod))
{
    echo "Making Clean Qmod"
    Move-Item $qmod $zip -Force
}

Compress-Archive -Path $filelist -DestinationPath $zip -Update
Move-Item $zip $qmod -Force