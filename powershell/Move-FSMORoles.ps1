# Move all FSMO roles to a target DC
# Usage: Edit $targetDC, run as Domain Admin

$targetDC = "DC02"

Move-ADDirectoryServerOperationMasterRole `
    -Identity $targetDC `
    -OperationMasterRole PDCEmulator,RIDMaster,InfrastructureMaster,SchemaMaster,DomainNamingMaster `
    -Confirm:$false

Get-ADDomain | Select-Object PDCEmulator,RIDMaster,InfrastructureMaster
Get-ADForest | Select-Object SchemaMaster,DomainNamingMaster