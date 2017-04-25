<#
 .Title
  Phase 8 - Movemos los recursos a otro grupo de recursos en la misma u otra suscripcion 

 .Author
  Alejandro Almeida | @alejandrolmeida | Intelequia Software Solutions

#>

# 8. MOVIENDO RECURSOS

	# 8.1. 
	$NewResourceGroup = ""
	$OldResourceGroup = ""
	$NewSubscriptionId = ""
	$vm01 = Get-AzureRmResource -ResourceGroupName OldRG -ResourceName "VM01"
	$vm02 = Get-AzureRmResource -ResourceGroupName OldRG -ResourceName "VM02"
	Move-AzureRmResource -DestinationResourceGroupName $NewResourceGroup -DestinationSubscriptionId $NewSubscriptionId -ResourceId $vm01.ResourceId, $vm02.ResourceId