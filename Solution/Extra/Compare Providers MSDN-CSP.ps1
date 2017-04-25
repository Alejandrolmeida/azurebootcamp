# Get MSDN Providers
$SubscriptionName = "MSDN - Alejandro Almeida"
$SubscriptionId = "00000000-0000-0000-000000000000"
$TenantId = "00000000-0000-0000-000000000000"
Login-AzureRmAccount -SubscriptionId $SubscriptionId -TenantId $TenantId
$providerListMSDN = Get-AzureRmResourceProvider -ListAvailable | where {$_.ProviderNamespace -like "microsoft*"} 

# Get CSP Providers
$SubscriptionName = "Azure Global Bootcamp"
$SubscriptionId = "00000000-0000-0000-000000000000"
$TenantId = "00000000-0000-0000-000000000000"
Login-AzureRmAccount -SubscriptionId $SubscriptionId -TenantId $TenantId
$providerListCSP = Get-AzureRmResourceProvider -ListAvailable | where {$_.ProviderNamespace -like "microsoft*"} 

# Creamos una tabla para guardar los resultados 
$table = New-Object system.Data.DataTable “CSP-MSDN-Compare”
$col1 = New-Object system.Data.DataColumn "ProviderNamespace",([string])
$col2 = New-Object system.Data.DataColumn "CSP",([boolean])
$col3 = New-Object system.Data.DataColumn "MSDN",([boolean])
$table.columns.add($col1)
$table.columns.add($col2)
$table.columns.add($col3)

# Buscamos los proveedores que existen en MSDN y los comparamos con CSP
$providerListMSDN | ForEach-Object {
    $row = $table.NewRow()
    $row.ProviderNamespace = $_.ProviderNamespace
    $row.CSP = $true 
   
    $enc = $providerListCSP | where {$_.ProviderNamespace -like $row.ProviderNamespace}
    if ($enc.Length -gt 0) {
        $row.MSDN = $true        
        Write-Host $row.ProviderNamespace -foregroundcolor cyan
    }else{
        $row.MSDN = $false
        Write-Host $row.ProviderNamespace -foregroundcolor red
    }

    $table.Rows.Add($row)
}

$table | Export-Csv -Path "C:\Global Azure BootCamp 2007\Providers-CSP-MSDN.csv" -Encoding ascii -NoTypeInformation

$result = $table | where { $_.MSDN -eq $false}
Write-Host "Total de servicios no disponibles en CSP:" $result.Count -ForegroundColor DarkYellow


$computeTypes = (Get-AzureRmResourceProvider -ProviderNamespace Microsoft.Storage).ResourceTypes 
$computeTypes | Format-Table


