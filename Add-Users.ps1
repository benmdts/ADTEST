# Définition des utilisateurs et de leurs informations
$users = @(
    # Direction
    @{SamAccountName="jmartin"; Name="Jean Martin"; OU="Direction"; Title="Directeur Général"; Password="P@ssword2024!"},
    @{SamAccountName="ebernard"; Name="Emma Bernard"; OU="Direction"; Title="Assistante de Direction"; Password="P@ssword2024!"},

    # Ressources Humaines
    @{SamAccountName="mhugo"; Name="Marie Hugo"; OU="RH"; Title="Responsable RH"; Password="P@ssword2024!"},
    @{SamAccountName="tdupuis"; Name="Thomas Dupuis"; OU="RH"; Title="Gestionnaire RH"; Password="P@ssword2024!"},
    @{SamAccountName="alemoine"; Name="Alice Lemoine"; OU="RH"; Title="Chargée de recrutement"; Password="P@ssword2024!"},

    # Informatique
    @{SamAccountName="admin.jdupont"; Name="Julien Dupont"; OU="IT"; Title="Administrateur Système"; Password="P@ssword2024!"},
    @{SamAccountName="pbernard"; Name="Paul Bernard"; OU="IT"; Title="Technicien IT"; Password="P@ssword2024!"},
    @{SamAccountName="sdelacroix"; Name="Sophie Delacroix"; OU="IT"; Title="Ingénieure Sécurité"; Password="P@ssword2024!"},
    @{SamAccountName="ngiraud"; Name="Nicolas Giraud"; OU="IT"; Title="Support Helpdesk"; Password="P@ssword2024!"},

    # Comptabilité
    @{SamAccountName="lmoreau"; Name="Lucas Moreau"; OU="Comptabilité"; Title="Chef comptable"; Password="P@ssword2024!"},
    @{SamAccountName="cvasseur"; Name="Claire Vasseur"; OU="Comptabilité"; Title="Comptable junior"; Password="P@ssword2024!"},
    @{SamAccountName="dfontaine"; Name="David Fontaine"; OU="Comptabilité"; Title="Analyste financier"; Password="P@ssword2024!"},
    @{SamAccountName="gbarbier"; Name="Gabrielle Barbier"; OU="Comptabilité"; Title="Assistante comptable"; Password="P@ssword2024!"},

    # Commercial/Ventes
    @{SamAccountName="fmarin"; Name="François Marin"; OU="Commercial"; Title="Responsable Commercial"; Password="P@ssword2024!"},
    @{SamAccountName="avallet"; Name="Alice Vallet"; OU="Commercial"; Title="Commerciale B2B"; Password="P@ssword2024!"},
    @{SamAccountName="bcharpentier"; Name="Benjamin Charpentier"; OU="Commercial"; Title="Commercial B2C"; Password="P@ssword2024!"},
    @{SamAccountName="mrolland"; Name="Mathilde Rolland"; OU="Commercial"; Title="Chargée de Prospection"; Password="P@ssword2024!"},
    @{SamAccountName="jleclerc"; Name="Julien Leclerc"; OU="Commercial"; Title="Responsable Grands Comptes"; Password="P@ssword2024!"},

    # Support Client
    @{SamAccountName="jduhamel"; Name="Julie Duhamel"; OU="Support"; Title="Responsable Support"; Password="P@ssword2024!"},
    @{SamAccountName="mboyer"; Name="Maxime Boyer"; OU="Support"; Title="Technicien Support"; Password="P@ssword2024!"},
    @{SamAccountName="cperrier"; Name="Camille Perrier"; OU="Support"; Title="Service Client"; Password="P@ssword2024!"},
    @{SamAccountName="rblondel"; Name="Romain Blondel"; OU="Support"; Title="Support Technique"; Password="P@ssword2024!"},

    # Marketing
    @{SamAccountName="elorin"; Name="Elodie Lorin"; OU="Marketing"; Title="Responsable Marketing"; Password="P@ssword2024!"},
    @{SamAccountName="mfaure"; Name="Marc Faure"; OU="Marketing"; Title="Chargé de Communication"; Password="P@ssword2024!"},
    @{SamAccountName="sdevaux"; Name="Sarah Devaux"; OU="Marketing"; Title="Community Manager"; Password="P@ssword2024!"},

    # Logistique
    @{SamAccountName="vthomas"; Name="Vincent Thomas"; OU="Logistique"; Title="Responsable Logistique"; Password="P@ssword2024!"},
    @{SamAccountName="pmasson"; Name="Paul Masson"; OU="Logistique"; Title="Gestionnaire de Stock"; Password="P@ssword2024!"},
    @{SamAccountName="cbazin"; Name="Caroline Bazin"; OU="Logistique"; Title="Agent d’Entrepôt"; Password="P@ssword2024!"},

    # Stagiaires
    @{SamAccountName="slemaitre"; Name="Sébastien Lemaitre"; OU="Stagiaires"; Title="Stagiaire IT"; Password="P@ssword2024!"},
    @{SamAccountName="mduval"; Name="Manon Duval"; OU="Stagiaires"; Title="Stagiaire Marketing"; Password="P@ssword2024!"}
)

# Domaine de l'AD
$domain = "DC=pmelocale,DC=local"

# Création des utilisateurs
foreach ($user in $users) {
    $ouPath = "OU=$($user.OU),OU=Utilisateurs,OU=PME,$domain"
    $userPrincipalName = "$($user.SamAccountName)@pmelocale.local"
    $password = ConvertTo-SecureString $user.Password -AsPlainText -Force

    New-ADUser -SamAccountName $user.SamAccountName `
               -UserPrincipalName $userPrincipalName `
               -Name $user.Name `
               -GivenName ($user.Name -split " ")[0] `
               -Surname ($user.Name -split " ")[1] `
               -Title $user.Title `
               -Path $ouPath `
               -AccountPassword $password `
               -Enabled $true `
               -PasswordNeverExpires $true `
               -PassThru

    Write-Host "Utilisateur $($user.SamAccountName) créé dans $ouPath"
}

Write-Host "Création des utilisateurs terminée ! 🚀"

