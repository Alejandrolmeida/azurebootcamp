Login-AzureRmAccount -SubscriptionId "00000000-0000-0000-000000000000"
 
### Detenemos la VM antes de copiar el vhd
#$servicename = "alonecorp"
#$vmname = "Alone-VM01"
#Get-AzureVM -ServiceName $servicename -Name $vmname | Stop-AzureVM


### Source VHD (West US) - authenticated container ###
$srcUri = "https://enterprisecorp.blob.core.windows.net/vhds/enterprisecorp-WEB-OSDisk.vhd" 
 
### Source Storage Account (West US) ###
$srcStorageAccount = "enterprisecorp"
$srcStorageKey = "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX=="
 
### Target Storage Account (West US) ###
$destStorageAccount = "azurebrains"
$destStorageKey = "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX=="
 
### Create the source storage account context ### 
$srcContext = New-AzureStorageContext  –StorageAccountName $srcStorageAccount `
                                        -StorageAccountKey $srcStorageKey  
 
### Create the destination storage account context ### 
$destContext = New-AzureStorageContext  –StorageAccountName $destStorageAccount `
                                        -StorageAccountKey $destStorageKey  
 
### Destination Container Name ### 
$containerName = "vhds"
 
### Create the container on the destination ### 
New-AzureStorageContainer -Name $containerName -Context $destContext 
 
### Start the asynchronous copy - specify the source authentication with -SrcContext ### 
$blob1 = Start-AzureStorageBlobCopy -srcUri $srcUri `
                                    -SrcContext $srcContext `
                                    -DestContainer $containerName `
                                    -DestBlob "enterprisecorp-WEB-OSDisk.vhd" `
                                    -DestContext $destContext


### CHECK STATUS ###

### Retrieve the current status of the copy operation ###
$status = $blob1 | Get-AzureStorageBlobCopyState 
 
### Print out status ### 
$status 
 
### Loop until complete ###                                    
While($status.Status -eq "Pending"){
  $status = $blob1 | Get-AzureStorageBlobCopyState 
  Start-Sleep 10
  ### Print out status ###
  $status
}