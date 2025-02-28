# Définition du domaine AD (remplace avec ton domaine si nécessaire)
$domain = "DC=pmelocale,DC=local"

# Liste des OU à créer
$ouList = @(
    "OU=PME,$domain",
    "OU=Utilisateurs,OU=PME,$domain",
    "OU=Groupes,OU=PME,$domain",
    "OU=Ressources,OU=PME,$domain",
    "OU=Imprimantes,OU=Ressources,OU=PME,$domain",
    "OU=Ordinateurs,OU=PME,$domain",
    "OU=Postes_Fixes,OU=Ordinateurs,OU=PME,$domain",
    "OU=Postes_Portables,OU=Ordinateurs,OU=PME,$domain",
    "OU=Serveurs,OU=Ordinateurs,OU=PME,$domain"
)

# Création des OU si elles n'existent pas encore
foreach ($ou in $ouList) {
    if (-not (Get-ADOrganizationalUnit -Filter { DistinguishedName -eq $ou } -ErrorAction SilentlyContinue)) {
        New-ADOrganizationalUnit -Name ($ou -split ",")[0] -Path ($ou -replace "OU=[^,]+,", "") -ProtectedFromAccidentalDeletion $false
        Write-Host "✅ OU créée : $ou"
    } else {
        Write-Host "⏭️ OU déjà existante : $ou"
    }
}

Write-Host "🚀 Création des OU terminée avec succès !"

