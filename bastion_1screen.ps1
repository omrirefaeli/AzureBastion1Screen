$now = Get-Date
$bastion_name = "<enter bastion name>" # az network bastion list
$resource_group = "<enter resource group>"
#
$vmname = "<machine name>" ### Change Machine Name here
#
$machine  = "/subscriptions/<subscription ID>/resourceGroups/$resource_group/providers/Microsoft.Compute/virtualMachines/$vmname" #Virtual Machine --> Overview --> JSON View


$command = "az network bastion rdp --name $bastion_name --resource-group $resource_group --target-resource-id $machine --configure"
Write-Host $command
Start-Process -FilePath "cmd.exe" -ArgumentList "/c $command" -WindowStyle Hidden 
while ($true -and (Get-Date) -lt $now.AddSeconds(30))
{
    $file = gci -LiteralPath $env:TEMP -Filter "conn_*.rdp" | Where-Object { $_.CreationTime -gt $now } | Sort-Object LastWriteTime -Descending | select -first 1 
    if ($file -ne $null)
    {
        start-sleep -Milliseconds 500
        $file_name = $file.Name
        $content  = Get-Content $file.FullName
        $filtered_content = $content | Where-Object { $_ -notmatch "use multimon" }
        $name = $filtered_content | Where-Object { $_ -match "full address:.*?:(.*):" } 
        $new_path = "$env:TEMP\$($Matches[1])_$($(Select-String -InputObject $File.Name -Pattern "conn_(\w*).rdp").Matches.Groups[1].Value).rdp"
        $filtered_content | Set-Content -Path $new_path
        Get-CimInstance Win32_Process | Where-Object { $_.CommandLine -match "mstsc\.exe\s+?/edit.*$file_name.*" } | ForEach-Object { Stop-Process -Id $_.ProcessId -Force }
        & 'mstsc.exe' $new_path
        break
    }
}
