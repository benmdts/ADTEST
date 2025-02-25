# Domaine AD
$domain = "DC=pmelocale,DC=local"

# OU des imprimantes
$ouPathImprimantes = "OU=Imprimantes,OU=Ressources,OU=PME,$domain"

# Liste des imprimantes à créer
$printers = @(
    @{Name="Imprimante_Admin"; OU=$ouPathImprimantes; Description="Imprimante pour le service administratif"},
    @{Name="Imprimante_Marketing"; OU=$ouPathImprimantes; Description="Imprimante pour le service marketing"},
    @{Name="Imprimante_Technique"; OU=$ouPathImprimantes; Description="Imprimante pour le service technique"},
    @{Name="Imprimante_General"; OU=$ouPathImprimantes; Description="Imprimante partagée entre les différents départements"},
    @{Name="Imprimante_Reunion"; OU=$ouPathImprimantes; Description="Imprimante pour la salle de réunion"}
)

# Création des imprimantes
foreach ($printer in $printers) {
    $printerName = $printer.Name
    $ouPath = $printer.OU
    $description = $printer.Description

    # Vérifie si l'imprimante existe déjà
    if (-not (Get-ADObject -Filter { Name -eq $printerName })) {
        New-ADObject -Name $printerName -Type "printQueue" -Path $ouPath -Description $description
        Write-Host "Imprimante $printerName créée ✅"
    } else {
        Write-Host "Imprimante $printerName existe déjà ⏭"
    }
}

Write-Host "Création des imprimantes terminée ! 🚀"

