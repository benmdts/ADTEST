# Domaine AD
$domain = "DC=pmelocale,DC=local"

# OU où seront créés les groupes
$ouPath = "OU=Groupes,OU=PME,$domain"

# Liste des groupes et de leurs membres
$groups = @(
    # Groupes par département
    @{Name="G_Direction"; Members=@("jmartin", "ebernard")},
    @{Name="G_RH"; Members=@("mhugo", "tdupuis", "alemoine")},
    @{Name="G_IT"; Members=@("admin.jdupont", "pbernard", "sdelacroix", "ngiraud")},
    @{Name="G_Comptabilité"; Members=@("lmoreau", "cvasseur", "dfontaine", "gbarbier")},
    @{Name="G_Commercial"; Members=@("fmarin", "avallet", "bcharpentier", "mrolland", "jleclerc")},
    @{Name="G_Support"; Members=@("jduhamel", "mboyer", "cperrier", "rblondel")},
    @{Name="G_Marketing"; Members=@("elorin", "mfaure", "sdevaux")},
    @{Name="G_Logistique"; Members=@("vthomas", "pmasson", "cbazin")},
    @{Name="G_Stagiaires"; Members=@("slemaitre", "mduval")},

    # Groupes fonctionnels
    @{Name="G_Admins_IT"; Members=@("admin.jdupont", "sdelacroix")},
    @{Name="G_Utilisateurs"; Members=@("jmartin", "ebernard", "mhugo", "tdupuis", "alemoine", "admin.jdupont", "pbernard", "sdelacroix", "ngiraud", "lmoreau", "cvasseur", "dfontaine", "gbarbier", "fmarin", "avallet", "bcharpentier", "mrolland", "jleclerc", "jduhamel", "mboyer", "cperrier", "rblondel", "elorin", "mfaure", "sdevaux", "vthomas", "pmasson", "cbazin", "slemaitre", "mduval")},
    @{Name="G_Accès_Comptable"; Members=@("G_Comptabilité", "G_Direction")},
    @{Name="G_Accès_Support"; Members=@("G_Support", "G_IT")},
    @{Name="G_Gestionnaires"; Members=@("G_Direction", "G_RH", "G_Comptabilité", "G_IT")},
    @{Name="G_Utilisateurs_Ext"; Members=@("G_Stagiaires")}
)

# Création des groupes et ajout des membres
foreach ($group in $groups) {
    $groupPath = "CN=$($group.Name),$ouPath"

    # Vérifie si le groupe existe déjà
    if (-not (Get-ADGroup -Filter { Name -eq $group.Name })) {
        New-ADGroup -Name $group.Name -GroupScope Global -Path $ouPath -Description "Groupe $($group.Name)"
        Write-Host "Groupe $($group.Name) créé ✅"
    } else {
        Write-Host "Groupe $($group.Name) existe déjà ⏭"
    }

    # Ajout des membres au groupe
    foreach ($member in $group.Members) {
        # Vérifie si l'entrée est un groupe (pour les groupes imbriqués)
        if ($member -match "^G_") {
            $groupDN = (Get-ADGroup -Filter { Name -eq $member }).DistinguishedName
            if ($groupDN) {
                Add-ADGroupMember -Identity $group.Name -Members $groupDN
                Write-Host "Ajout du groupe $member dans $($group.Name) 🔗"
            } else {
                Write-Host "⚠️ Le groupe $member n'existe pas !"
            }
        }
        # Sinon, c'est un utilisateur
        else {
            $userDN = (Get-ADUser -Filter { SamAccountName -eq $member }).DistinguishedName
            if ($userDN) {
                Add-ADGroupMember -Identity $group.Name -Members $userDN
                Write-Host "Ajout de $member dans $($group.Name) 👤"
            } else {
                Write-Host "⚠️ L'utilisateur $member n'existe pas !"
            }
        }
    }
}

Write-Host "Création des groupes et affectation des membres terminée ! 🚀"

