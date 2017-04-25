<#
 .Title
  Phase 1 - Suscripción y registro para la migración

 .Author
  Alejandro Almeida | @alejandrolmeida | Intelequia Software Solutions

#>

# 1. SUSCRIPCION Y REGISTRO  ------------------------------------------>

	# 1.1. Hacemos login en el modelo ARM
		Login-AzureRMAccount

	# 1.2. Seleccionamos una subscripcion por el nombre para la sesion actual
		$subscr="MSDN - Alejandro Almeida"
		Get-AzureRmSubscription –SubscriptionName $subscr | Select-AzureRmSubscription

	# 1.3. Mostramos los grupos de recursos ordenados por nombre
		Get-AzureRMResourceGroup | Sort ResourceGroupName | Select ResourceGroupName,location

	# 1.4. Mostramos todos los Proveedores de Recursos
		Get-AzureRmResourceProvider | Select ProviderNamespace, locations

	# 1.5. Nos registramos en el Proveedor de Recursos de Migracion 
		Register-AzureRmResourceProvider -ProviderNamespace Microsoft.ClassicInfrastructureMigrate

	# 1.6. Comprobamos si estamos registrados (puede tardar unos minutos en finalizar el registro)
		Get-AzureRmResourceProvider -ProviderNamespace Microsoft.ClassicInfrastructureMigrate | Select RegistrationState

	# 1.7. Hacemos login en el modelo ASM
		Add-AzureAccount 

	# 1.8. Seleccionamos una subscripcion por el nombre para la sesion actual
		$SubscriptionName="MSDN - Alejandro Almeida"
		Select-AzureSubscription -SubscriptionName $SubscriptionName

	# 1.9. Obtenemos la lista de VM que estan en un servicio en la nube (no en una red virtual)
		Get-AzureService | Select Servicename,location