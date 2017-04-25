<#
 .Title
  Phase 3 - Migración de VMs asociadas a una Red Virtual nueva

 .Author
  Alejandro Almeida | @alejandrolmeida | Intelequia Software Solutions

#>

# 4. MIGRACION DE VM EN VNET | TEST 2 --------------------------------------------------------->

	# 4.1. VALIDACION
        $vnetName = "EnterpriseVnet"
		$validate = Move-AzureVirtualNetwork -Validate -VirtualNetworkName $vnetName
        $validate.ValidationMessages

        # Si tenemos mensajes de error por las extesiones las quitamos y volvemos a validar
        $serviceName = "enterprisecorp"        
        Get-AzureVM –ServiceName $serviceName | Set-AzureVMBGInfoExtension –ReferenceName "BGInfo" –Version "1.*" -Uninstall | Update-AzureVM
    
    # 4.2. PREPARACION 
        Move-AzureVirtualNetwork -Prepare -VirtualNetworkName $vnetName

    # 4.3. CANCELAR - SI NO ESTAMOS PREPARADOS
        Move-AzureVirtualNetwork -Abort -VirtualNetworkName $vnetName

    # 4.4. EJECUTAR - SI ESTAMOS PREPARADOS
        Move-AzureVirtualNetwork -Commit -VirtualNetworkName $vnetName