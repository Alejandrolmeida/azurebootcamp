<#
 .Title
  migAz - Implementacion de Enterprise Corp.

 .Author
  Alejandro Almeida | @alejandrolmeida | Intelequia Software Solutions

#>

# 1. Login  ------------------------------------------>

	Login-AzureRmAccount -SubscriptionId "00000000-0000-0000-000000000000" 
	Select-AzureRmSubscription -SubscriptionId "00000000-0000-0000-000000000000"

# 2. Get RG ------------------------------------------>

	New-AzureRmResourceGroup -Name "EnterpriseCorp-migaz" -Location "northeurope"

# 3. Deploy JSON Template ---------------------------->

	New-AzureRmResourceGroupDeployment -TemplateFile "C:\MigAz v2.1.0.0\EnterpriseCorp\export.json" -ResourceGroupName "EnterpriseCorp-migaz"

# 4. Clone VHD --------------------------------------->

	& 'C:\MigAz v2.1.0.0\BlobCopy.ps1' -ResourcegroupName "EnterpriseCorp-migaz" `
		-DetailsFilePath "C:\MigAz v2.1.0.0\EnterpriseCorp\copyblobdetails.json" -StartType StartBlobCopy
    
	& 'C:\MigAz v2.1.0.0\BlobCopy.ps1' -ResourcegroupName "EnterpriseCorp-migaz" `
		-DetailsFilePath "C:\MigAz v2.1.0.0\EnterpriseCorp\copyblobdetails.json" -StartType MonitorBlobCopy

# 4. Deploy JSON Template ---------------------------->

	New-AzureRmResourceGroupDeployment -TemplateFile "C:\MigAz v2.1.0.0\EnterpriseCorp\export.json" -ResourceGroupName "EnterpriseCorp-migaz"
