# Create top-level OUs
New-ADOrganizationalUnit -Name "_Admin" -Path "DC=joe,DC=lab" -ProtectedFromAccidentalDeletion $true
New-ADOrganizationalUnit -Name "_Servers" -Path "DC=joe,DC=lab" -ProtectedFromAccidentalDeletion $true
New-ADOrganizationalUnit -Name "_Workstations" -Path "DC=joe,DC=lab" -ProtectedFromAccidentalDeletion $true
New-ADOrganizationalUnit -Name "_Users" -Path "DC=joe,DC=lab" -ProtectedFromAccidentalDeletion $true
New-ADOrganizationalUnit -Name "_Groups" -Path "DC=joe,DC=lab" -ProtectedFromAccidentalDeletion $true

# Server sub-OUs
New-ADOrganizationalUnit -Name "File" -Path "OU=_Servers,DC=joe,DC=lab"
New-ADOrganizationalUnit -Name "Mail" -Path "OU=_Servers,DC=joe,DC=lab"
New-ADOrganizationalUnit -Name "Web" -Path "OU=_Servers,DC=joe,DC=lab"
New-ADOrganizationalUnit -Name "Security" -Path "OU=_Servers,DC=joe,DC=lab"

# User sub-OUs
New-ADOrganizationalUnit -Name "Employees" -Path "OU=_Users,DC=joe,DC=lab"
New-ADOrganizationalUnit -Name "Contractors" -Path "OU=_Users,DC=joe,DC=lab"
New-ADOrganizationalUnit -Name "ServiceAccounts" -Path "OU=_Users,DC=joe,DC=lab"

# Employee department OUs
New-ADOrganizationalUnit -Name "Finance" -Path "OU=Employees,OU=_Users,DC=joe,DC=lab"
New-ADOrganizationalUnit -Name "HR" -Path "OU=Employees,OU=_Users,DC=joe,DC=lab"
New-ADOrganizationalUnit -Name "Sales" -Path "OU=Employees,OU=_Users,DC=joe,DC=lab"
New-ADOrganizationalUnit -Name "Engineering" -Path "OU=Employees,OU=_Users,DC=joe,DC=lab"

# Group sub-OUs
New-ADOrganizationalUnit -Name "Role" -Path "OU=_Groups,DC=joe,DC=lab"
New-ADOrganizationalUnit -Name "Resource" -Path "OU=_Groups,DC=joe,DC=lab"
New-ADOrganizationalUnit -Name "App" -Path "OU=_Groups,DC=joe,DC=lab"

# Workstation site OUs
New-ADOrganizationalUnit -Name "HQ" -Path "OU=_Workstations,DC=joe,DC=lab"

Write-Host "OU structure created successfully" -ForegroundColor Green