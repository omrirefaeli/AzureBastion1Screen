$file = gci -LiteralPath $env:TEMP -Filter "conn_*.rdp" | Sort-Object LastWriteTime -Descending | select -first 1 
$content  = Get-Content $file.FullName
$filtered_content = $content | Where-Object { $_ -notmatch "use multimon" }
$name = $filtered_content | Where-Object { $_ -match "full address:.*?:(.*):" } 
$name = "$env:TEMP\$($Matches[1])_$($(Select-String -InputObject $File.Name -Pattern "conn_(\w*).rdp").Matches.Groups[1].Value).rdp"
$filtered_content | Set-Content -Path $name
 & 'mstsc.exe' $name
