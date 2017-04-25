<#
 .Title
  Phase 2 - Verificacion de nucleos de maquina

 .Author
  Alejandro Almeida | @alejandrolmeida | Intelequia Software Solutions

#>

# 1. VERIFICACION DE RECURSOS  ------------------------------------------>

	# 1.1. Verificacion de sucifientes nucleos de maquina virtual en ARM y en la region
		$location = "northeurope"
		Get-AzureRmVMUsage -Location $location