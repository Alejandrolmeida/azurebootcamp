<#
 .Title
  Phase 3 - Migración de recursos

 .Author
  Alejandro Almeida | @alejandrolmeida | Intelequia Software Solutions

#>

# 3. MIGRACION DE VM EN SERVICIO (SIN VNET) | TEST 1 --------------------------------------------------------->

    # 3.1. CREAMOS UNA IMPLEMENTACION NUEVA
		$serviceName = "AloneCorp"
        $vmName = "Alone-VM01"    
		$deployment = Get-AzureDeployment -ServiceName $serviceName
		$deploymentName = $deployment.DeploymentName

	# 3.2. VALIDACION
		$validate = Move-AzureService -Validate -ServiceName $serviceName -DeploymentName $deploymentName -CreateNewVirtualNetwork
		$validate.ValidationMessages

		# Si tenemos mensajes de error por las extesiones las quitamos y volvemos a validar
		Get-AzureVM –ServiceName $serviceName –name $vmName | Set-AzureVMBGInfoExtension –ReferenceName "BGInfo" –Version "1.*" -Uninstall | Update-AzureVM
    
	# 3.3. PREPARACION
		Move-AzureService -Prepare -ServiceName $serviceName -DeploymentName $deploymentName -CreateNewVirtualNetwork

    # 3.4. COMPROBACION
		$vm = Get-AzureVM -ServiceName $serviceName -Name $vmName
		$vm.VM.MigrationState
    
    # 3.5. CANCELAR - SI NO ESTAMOS PREPARADOS 
	    Move-AzureService -Abort -ServiceName $serviceName -DeploymentName $deploymentName

    # 3.6. EJECUTAR - SI ESTAMOS PREPARADOS 
	    Move-AzureService -Commit -ServiceName $serviceName -DeploymentName $deploymentName