# Définition du domaine AD (remplace avec ton domaine si nécessaire)
$domain = "DC=pmelocale,DC=local"

# Liste des OU avec leurs emplacements corrects
$ouList = @(
    @{ Name="PME"; Path=$domain },
    @{ Name="Utilisateurs"; Path="OU=PME,$domain" },
    @{ Name="Groupes"; Path="OU=PME,$domain" },
    @{ Name="Ressources"; Path="OU=PME,$domain" },
    @{ Name="Imprimantes"; Path="OU=Ressources,OU=PME,$domain" },
    @{ Name="Ordinateurs"; Path="OU=PME,$domain" },
    @{ Name="Postes_Fixes"; Path="OU=Ordinateurs,OU=PME,$domain" },
    @{ Name="Postes_Portables"; Path="OU=Ordinateurs,OU=PME,$domain" },
    @{ Name="Serveurs"; Path="OU=Ordinateurs,OU=PME,$domain" }
)

# Création des OU si elles n'existent pas encore
foreach ($ou in $ouList) {
    $ouName = $ou.Name
    $ouPath = $ou.Path

    # Vérifie si l'OU existe déjà
    if (-not (Get-ADOrganizationalUnit -Filter { Name -eq $ouName -and DistinguishedName -like "*$ouPath*" } -ErrorAction SilentlyContinue)) {
        New-ADOrganizationalUnit -Name $ouName -Path $ouPath -ProtectedFromAccidentalDeletion $false
        Write-Host "✅ OU créée : $ouName sous $ouPath"
    } else {
        Write-Host "⏭️ OU déjà existante : $ouName sous $ouPath"
    }
}

Write-Host "🚀 Création des OU terminée avec succès !"

