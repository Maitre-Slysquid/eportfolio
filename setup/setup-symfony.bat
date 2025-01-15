@echo off
SETLOCAL EnableDelayedExpansion

:: Configuration
SET PHP_VERSION=8.2
SET COMPOSER_SETUP_URL=https://getcomposer.org/Composer-Setup.exe

echo ===================================
echo Installation de l'environnement Symfony
echo ===================================

:: Fonction pour afficher en couleur
for /F "tokens=1,2 delims=#" %%a in ('"prompt #$H#$E# & echo on & for %%b in (1) do rem"') do (
  set "ESC=%%b"
)

:: Couleurs personnalisées pour les messages
SET "GREEN=%ESC%[92m"
SET "RED=%ESC%[91m"
SET "YELLOW=%ESC%[93m"
SET "RESET=%ESC%[0m"

:: Vérifier les privilèges administrateur
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo %RED%Ce script necessite des privileges administrateur%RESET%
    echo Veuillez relancer en tant qu'administrateur
    pause
    exit /b 1
)
echo %GREEN%OK: Privileges administrateur%RESET%

:: Vérifier si Scoop est installé
where scoop >nul 2>&1
if %errorLevel% neq 0 (
    echo.
    echo %YELLOW%Installation de Scoop...%RESET%
    powershell -Command "Set-ExecutionPolicy RemoteSigned -Scope CurrentUser"
    powershell -Command "irm get.scoop.sh -outfile 'install.ps1'"
    powershell -ExecutionPolicy RemoteSigned -File install.ps1
    del install.ps1
    if !errorLevel! neq 0 (
        echo %RED%Erreur lors de l'installation de Scoop%RESET%
        pause
        exit /b 1
    )
    echo %GREEN%Scoop installe avec succes%RESET%
    :: Rafraîchir le PATH
    set "PATH=%PATH%;%USERPROFILE%\scoop\shims"
)

:: Installer PHP 8.2
echo.
echo %YELLOW%Installation de PHP 8.2...%RESET%
scoop bucket add main
scoop install php8.2
if %errorLevel% neq 0 (
    echo %RED%Erreur lors de l'installation de PHP%RESET%
    pause
    exit /b 1
)

:: Activer les extensions requises
echo.
echo Configuration des extensions PHP...
SET PHP_INI_PATH=%USERPROFILE%\scoop\apps\php8.2\current\php.ini
powershell -Command "(Get-Content '%PHP_INI_PATH%') -replace ';extension=zip', 'extension=zip' | Set-Content '%PHP_INI_PATH%'"
powershell -Command "(Get-Content '%PHP_INI_PATH%') -replace ';extension=fileinfo', 'extension=fileinfo' | Set-Content '%PHP_INI_PATH%'"
powershell -Command "(Get-Content '%PHP_INI_PATH%') -replace ';extension=pdo_mysql', 'extension=pdo_mysql' | Set-Content '%PHP_INI_PATH%'"
powershell -Command "(Get-Content '%PHP_INI_PATH%') -replace ';extension=intl', 'extension=intl' | Set-Content '%PHP_INI_PATH%'"

:: Installer Composer
echo.
echo %YELLOW%Installation de Composer...%RESET%
powershell -Command "Invoke-WebRequest -Uri '%COMPOSER_SETUP_URL%' -OutFile composer-setup.exe"
composer-setup.exe /SILENT
del composer-setup.exe

:: Installer Git
echo.
echo %YELLOW%Installation de Git...%RESET%
scoop install git

:: Configurer Git
echo.
echo Configuration de Git...
git config --global user.email "yessineslysquid@gmail.com"
git config --global user.name "Maitre-Slysquid"

:: Installer Symfony CLI
echo.
echo %YELLOW%Installation de Symfony CLI...%RESET%
scoop install symfony-cli

:: Vérification finale
echo.
echo ===================================
echo Verification de l'installation
echo ===================================
echo.
php -v
echo.
composer -V
echo.
symfony -v
echo.
symfony check:requirements

echo.
echo %GREEN%Installation terminee !%RESET%
echo Pour lancer un projet Symfony:
echo 1. cd chemin/vers/votre/projet
echo 2. composer install
echo 3. symfony server:start

pause