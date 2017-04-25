<#
 .Title
  Phase 3 - Migración de recursos

 .Author
  Alejandro Almeida | @alejandrolmeida | Intelequia Software Solutions

#>

# 6. MIGRACION DE CUENTA DE ALMACENAMIENTO --------------------------------------------------------->

    # 6.1. PREPARACION 
        $storageAccountName = "enterprisecorp"
        Move-AzureStorageAccount -Prepare -StorageAccountName $storageAccountName

    # 6.2. CANCELAR
        Move-AzureStorageAccount -Abort -StorageAccountName $storageAccountName

    # 6.3. EJECUTAR
        Move-AzureStorageAccount -Commit -StorageAccountName $storageAccountName