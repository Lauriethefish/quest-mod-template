Remove-Item quest-mod-template.zip -ErrorAction Ignore
Compress-Archive template/* quest-mod-template.zip
Write-Output "Template saved to quest-mod-template.zip"