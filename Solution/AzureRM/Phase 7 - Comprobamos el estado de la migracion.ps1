<#
 .Title
  Phase 7 - Check VM Status

 .Author
  Alejandro Almeida | @alejandrolmeida | Intelequia Software Solutions

#>

# 7. ESTADO DE LAS MAQUINAS

	# 7.1. Mostramos una lista con el nombre y el estado de todas las VM de la suscripcion 
		Get-AzureRmVM | Get-AzureRmVM -Status | Select ResourceGroupName,name,{$_.statuses.displaystatus}

	# 7.2. Mostramos una lista con el nombre de todas las VM de la subscipcion en ejecucion
		Get-AzureRmVM | Get-AzureRmVM -Status | ?{$_.statuses.displaystatus -eq "VM running"} | Select Name, ResourceGroupName

    # 7.3. Detenemos todas las VM en ejecucion de la subscipcion 
		Get-AzureRmVM | Get-AzureRmVM -Status | ?{$_.statuses.displaystatus -eq "VM running"} | Select Name, ResourceGroupName | Stop-AzureRmVM -Force
