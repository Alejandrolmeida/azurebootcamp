<#
 .Title
  Phase 3 - Migración de VMs asociadas a una Red Virtual existente

 .Author
  Alejandro Almeida | @alejandrolmeida | Intelequia Software Solutions

#>

# 5. MIGRACION DE VM EN VNET  --------------------------------------------------------->

    # 5.1. CREAMOS UNA IMPLEMENTACION NUEVA     
		$serviceName = "enterprisecorp"
		$deployment = Get-AzureDeployment -ServiceName $serviceName
		$deploymentName = $deployment.DeploymentName

    # 5.2. VALIDACION
        $existingVnetRGName = "AM-VNet-Migrated"
        $vnetName = "AM-Vnet"
        $subnetName = "Subnet-1"
        $validate = Move-AzureService -Validate -ServiceName $serviceName -DeploymentName $deploymentName -UseExistingVirtualNetwork -VirtualNetworkResourceGroupName $existingVnetRGName -VirtualNetworkName $vnetName -SubnetName $subnetName
        $validate.ValidationMessages

        # Si tenemos mensajes de error por las extesiones las quitamos y volvemos a validar
        Get-AzureVM –ServiceName $serviceName | Set-AzureVMBGInfoExtension –ReferenceName "BGInfo" –Version "1.*" - | Update-AzureVM

	# 5.3. PREPARACION
        Move-AzureService -Prepare -ServiceName $serviceName -DeploymentName $deploymentName -UseExistingVirtualNetwork -VirtualNetworkResourceGroupName $existingVnetRGName -VirtualNetworkName $vnetName -SubnetName $subnetName

    # 5.4. COMPROBAMOS ESTADO DE LA PREPARACION 
		$vmName = "AM-VM02"
		$vm = Get-AzureVM -ServiceName $serviceName -Name $vmName
		$vm.VM.MigrationState
		$vmName = "AM-VM03"
		$vm = Get-AzureVM -ServiceName $serviceName -Name $vmName
		$vm.VM.MigrationState
    
    # 5.5. CANCELAR - SI NO ESTAMOS PREPARADOS 
		Move-AzureService -Abort -ServiceName $serviceName -DeploymentName $deploymentName

    # 5.6. EJECUTAR - SI ESTAMOS PREPARADOS 
		Move-AzureService -Commit -ServiceName $serviceName -DeploymentName $deploymentName