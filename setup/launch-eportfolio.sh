#!/bin/bash

# Nom du script: launch-eportfolio.sh
# Description: Script pour lancer le serveur Symfony dans le dossier de l'eportfolio

# Définition du chemin du projet
PROJECT_PATH="/Users/xslysquidx/Library/Mobile Documents/com~apple~CloudDocs/cours iut/RT1/Saé/SAÉ 1.04/Eportfolio/eportfolio"

# Fonction pour afficher les messages d'erreur en rouge
print_error() {
    echo -e "\033[0;31m$1\033[0m"
}

# Fonction pour afficher les messages de succès en vert
print_success() {
    echo -e "\033[0;32m$1\033[0m"
}

# Vérifier si le dossier existe
if [ ! -d "$PROJECT_PATH" ]; then
    print_error "Erreur: Le dossier du projet n'existe pas: $PROJECT_PATH"
    exit 1
fi

# Se déplacer dans le dossier du projet
echo "Changement de répertoire vers le projet..."
cd "$PROJECT_PATH"

if [ $? -ne 0 ]; then
    print_error "Erreur: Impossible d'accéder au dossier du projet"
    exit 1
fi

print_success "Répertoire changé avec succès"

# Vérifier si Symfony est installé
if ! command -v symfony &> /dev/null; then
    print_error "Erreur: Symfony CLI n'est pas installé"
    echo "Veuillez installer Symfony CLI: https://symfony.com/download"
    exit 1
fi

# Lancer le serveur Symfony
echo "Démarrage du serveur Symfony..."
symfony server:start

# Si le serveur s'arrête, afficher un message
print_success "Serveur arrêté avec succès"
