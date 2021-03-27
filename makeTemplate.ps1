Remove-Item template.zip
Compress-Archive template/* template.zip
Write-Output "Template saved to template.zip"