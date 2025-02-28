# Domaine AD
$domain = "DC=pmelocale,DC=local"

# OUs où seront créés les ordinateurs
$ouPathPostesFixes = "OU=Postes_Fixes,OU=Ordinateurs,OU=PME,$domain"
$ouPathPostesPortables = "OU=Postes_Portables,OU=Ordinateurs,OU=PME,$domain"
$ouPathServers = "OU=Serveurs,OU=PME,$domain"

# Liste des ordinateurs à créer
$computers = @(
    # Serveurs
    @{Name="SRV-DC01"; OU=$ouPathServers},
    @{Name="SRV-File01"; OU=$ouPathServers},
    @{Name="SRV-Web01"; OU=$ouPathServers},

    # Postes fixes
    @{Name="PC-Fixe01"; OU=$ouPathPostesFixes},
    @{Name="PC-Fixe02"; OU=$ouPathPostesFixes},
    @{Name="PC-Fixe03"; OU=$ouPathPostesFixes},
    @{Name="PC-Fixe04"; OU=$ouPathPostesFixes},
    @{Name="PC-Fixe05"; OU=$ouPathPostesFixes},
    @{Name="PC-Fixe06"; OU=$ouPathPostesFixes},
    @{Name="PC-Fixe07"; OU=$ouPathPostesFixes},
    @{Name="PC-Fixe08"; OU=$ouPathPostesFixes},
    @{Name="PC-Fixe09"; OU=$ouPathPostesFixes},
    @{Name="PC-Fixe10"; OU=$ouPathPostesFixes},
    @{Name="PC-Fixe11"; OU=$ouPathPostesFixes},
    @{Name="PC-Fixe12"; OU=$ouPathPostesFixes},
    @{Name="PC-Fixe13"; OU=$ouPathPostesFixes},
    @{Name="PC-Fixe14"; OU=$ouPathPostesFixes},
    @{Name="PC-Fixe15"; OU=$ouPathPostesFixes},

    # Postes portables
    @{Name="PC-Portable01"; OU=$ouPathPostesPortables},
    @{Name="PC-Portable02"; OU=$ouPathPostesPortables},
    @{Name="PC-Portable03"; OU=$ouPathPostesPortables},
    @{Name="PC-Portable04"; OU=$ouPathPostesPortables},
    @{Name="PC-Portable05"; OU=$ouPathPostesPortables},
    @{Name="PC-Portable06"; OU=$ouPathPostesPortables},
    @{Name="PC-Portable07"; OU=$ouPathPostesPortables},
    @{Name="PC-Portable08"; OU=$ouPathPostesPortables},
    @{Name="PC-Portable09"; OU=$ouPathPostesPortables},
    @{Name="PC-Portable10"; OU=$ouPathPostesPortables},
    @{Name="PC-Portable11"; OU=$ouPathPostesPortables},
    @{Name="PC-Portable12"; OU=$ouPathPostesPortables},
    @{Name="PC-Portable13"; OU=$ouPathPostesPortables},
    @{Name="PC-Portable14"; OU=$ouPathPostesPortables},
    @{Name="PC-Portable15"; OU=$ouPathPostesPortables}
)

# Création des ordinateurs
foreach ($computer in $computers) {
    $computerName = $computer.Name
    $ouPath = $computer.OU

    # Vérifie si l'ordinateur existe déjà
    if (-not (Get-ADComputer -Filter { Name -eq $computerName })) {
        New-ADComputer -Name $computerName -Path $ouPath -Description "Ordinateur $computerName"
        Write-Host "Ordinateur $computerName créé ✅"
    } else {
        Write-Host "Ordinateur $computerName existe déjà ⏭"
    }
}

Write-Host "Création des ordinateurs terminée ! 🚀"

