<#
 .Title
  migAz - Implementacion de Alone Corp.

 .Author
  Alejandro Almeida | @alejandrolmeida | Intelequia Software Solutions

#>

# 1. Login  ------------------------------------------>

	Login-AzureRmAccount -SubscriptionId "00000000-0000-0000-000000000000" 
	Select-AzureRmSubscription -SubscriptionId "00000000-0000-0000-000000000000"

# 2. Get RG ------------------------------------------>

	Get-AzureRmResourceGroup -Name "alonecorp-migaz" -Location "northeurope"

# 3. Clone VHD --------------------------------------->

	& 'C:\MigAz v2.1.0.0\BlobCopy.ps1' -ResourcegroupName "alonecorp-migaz" `
		-DetailsFilePath "C:\MigAz v2.1.0.0\alonecorp\copyblobdetails.json" -StartType StartBlobCopy
    
	& 'C:\MigAz v2.1.0.0\BlobCopy.ps1' -ResourcegroupName "alonecorp-migaz" `
		-DetailsFilePath "C:\MigAz v2.1.0.0\alonecorp\copyblobdetails.json" -StartType MonitorBlobCopy

# 4. Deploy JSON Template ---------------------------->

	New-AzureRmResourceGroupDeployment -TemplateFile "C:\MigAz v2.1.0.0\alonecorp\export.json" -ResourceGroupName "alonecorp-migaz"
