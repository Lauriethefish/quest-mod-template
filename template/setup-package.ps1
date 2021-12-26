# This is a nice json formater I found here: https://stackoverflow.com/a/55384556
function Format-Json([Parameter(Mandatory, ValueFromPipeline)][String] $json) {
    $indent = 0;
    ($json -Split "`n" | % {
        if ($_ -match '[\}\]]\s*,?\s*$') {
            # This line ends with ] or }, decrement the indentation level
            $indent--
        }
        $line = ("`t" * $indent) + $($_.TrimStart() -replace '":  (["{[])', '": $1' -replace ':  ', ': ')
        if ($_ -match '[\{\[]\s*$') {
            # This line ends with [ or {, increment the indentation level
            $indent++
        }
        $line
    }) -Join "`n"
}

# Remove existing files, just to be safe
& qpm-rust clear *>$null

$filesToRemove = @("extern.cmake", "qpm_defines.cmake", "mod.json", "mod.template.json")
foreach ($file in $filesToRemove) {
	Remove-Item $file -ErrorAction Ignore
}

# Remove Build Folder
Remove-Item -LiteralPath "build" -Force -Recurse -ErrorAction Ignore

# Setup qpm.json
& qpm-rust package create "#{name}" "0.1.0" --id "#{id}" --overrideSoName "lib#{id}.so"

# Setup mod.template.json
& qpm-rust qmod create --author "#{author}" --description "#{description}" --packageID "com.beatgames.beatsaber" --packageVersion "1.17.1" --qpversion "0.1.1"

# Adds BS Hook and modloader
& qpm-rust dependency add "beatsaber-hook" -v "=2.3.2"
& qpm-rust dependency add "modloader" -v "=1.2.3"

# Manually add the "extraFiles" param to bs hook cus red is bad
$qpmJson = Get-Content qpm.json | ConvertFrom-Json

$qpmJson.dependencies[0].additionalData = @{"extraFiles" = @("src/inline-hook")}
$qpmJson | ConvertTo-Json -Depth 100 | Format-Json | set-content "qpm.json"

# Restore Dependencies
# Restoring will also create the "extern.cmake" and "qpm_definies.cmake"
& qpm-rust restore

echo "Successfully Setup package `"#{id}`"!"