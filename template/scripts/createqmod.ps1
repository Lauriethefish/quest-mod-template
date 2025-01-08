Param(
    [Parameter(Mandatory=$false)]
    [String] $qmodName="",

    [Parameter(Mandatory=$false)]
    [Switch] $help
)

if ($help -eq $true) {
    Write-Output "`"createqmod`" - Creates a .qmod file with your compiled libraries and mod.json."
    Write-Output "`n-- Arguments --`n"

    Write-Output "-QmodName `t The file name of your qmod"

    exit
}

$mod = "./mod.json"
$sharedQpmFilePath = "qpm.shared.json"
$defaultQpmFilePath = "qpm.json"

& $PSScriptRoot/validate-modjson.ps1
if ($LASTEXITCODE -ne 0) {
    exit $LASTEXITCODE
}
$modJson = Get-Content $mod -Raw | ConvertFrom-Json

# Check if qpm.shared.json exists, otherwise fallback to qpm.json
if (Test-Path $sharedQpmFilePath) {
    $qpmJson = (Get-Content $sharedQpmFilePath | ConvertFrom-Json).config
} elseif (Test-Path $defaultQpmFilePath) {
    $qpmJson = Get-Content $defaultQpmFilePath | ConvertFrom-Json
} else {
    Write-Error "Neither qpm.shared.json nor qpm.json exists."
    exit 1
}

if ($qmodName -eq "") {
    $qmodName = $qpmJson.workspace.qmodOutput
}

$filelist = @($mod)

$cover = "./" + $modJson.coverImage
if ((-not ($cover -eq "./")) -and (Test-Path $cover)) {
    $filelist += ,$cover
}

foreach ($mod in $modJson.modFiles) {
    $path = "./build/" + $mod
    if (-not (Test-Path $path)) {
        $path = "./extern/libs/" + $mod
    }
    if (-not (Test-Path $path)) {
        Write-Output "Error: could not find dependency: $path"
        exit 1
    }
    $filelist += $path
}

foreach ($mod in $modJson.lateModFiles) {
    $path = "./build/" + $mod
    if (-not (Test-Path $path)) {
        $path = "./extern/libs/" + $mod
    }
    if (-not (Test-Path $path)) {
        Write-Output "Error: could not find dependency: $path"
        exit 1
    }
    $filelist += $path
}


foreach ($lib in $modJson.libraryFiles) {
    $path = "./build/" + $lib
    if (-not (Test-Path $path)) {
        $path = "./extern/libs/" + $lib
    }
    if (-not (Test-Path $path)) {
        Write-Output "Error: could not find dependency: $path"
        exit 1
    }
    $filelist += $path
}

$zip = [guid]::NewGuid().ToString() + ".zip"
$qmod = $qmodName

Compress-Archive -Path $filelist -DestinationPath $zip -Update
Move-Item $zip $qmod -Force