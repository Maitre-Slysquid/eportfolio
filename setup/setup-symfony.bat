@echo off
SETLOCAL EnableDelayedExpansion

:: Configuration
SET PHP_VERSION=8.2
SET PHP_REQUIRED_VERSION=8.2.12
SET COMPOSER_SETUP_URL=https://getcomposer.org/Composer-Setup.exe

echo ===================================
echo Verification de l'environnement
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

:: Variables pour le statut des composants
SET SCOOP_NEEDED=0
SET PHP_NEEDED=0
SET COMPOSER_NEEDED=0
SET SYMFONY_NEEDED=0
SET ZIP_EXTENSION_NEEDED=0
SET GIT_NEEDED=0
SET VSCODE_NEEDED=0

echo Verification des privileges administrateur...
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo %RED%Ce script necessite des privileges administrateur%RESET%
    echo Veuillez relancer en tant qu'administrateur
    pause
    exit /b 1
)
echo %GREEN%OK: Privileges administrateur%RESET%

:: Vérifier Scoop
echo.
echo Verification de Scoop...
where scoop >nul 2>&1
if %errorLevel% neq 0 (
    echo %YELLOW%Scoop n'est pas installe%RESET%
    SET SCOOP_NEEDED=1
) else (
    echo %GREEN%OK: Scoop est installe%RESET%
)

:: Vérifier PHP
echo.
echo Verification de PHP...
where php >nul 2>&1
if %errorLevel% neq 0 (
    echo %YELLOW%PHP n'est pas installe%RESET%
    SET PHP_NEEDED=1
) else (
    for /f "tokens=2 delims==" %%I in ('php -r "echo PHP_VERSION;"') do set PHP_CURRENT_VERSION=%%I
    echo Version actuelle : !PHP_CURRENT_VERSION!
    if "!PHP_CURRENT_VERSION!" neq "%PHP_REQUIRED_VERSION%" (
        echo %YELLOW%La version de PHP ne correspond pas a la version requise%RESET%
        SET PHP_NEEDED=1
    ) else (
        echo %GREEN%OK: PHP est installe avec la bonne version%RESET%
    )
)

:: Vérifier l'extension ZIP si PHP est installé
if %PHP_NEEDED%==0 (
    echo.
    echo Verification de l'extension ZIP...
    php -r "exit(extension_loaded('zip') ? 0 : 1);" >nul 2>&1
    if %errorLevel% neq 0 (
        echo %YELLOW%L'extension ZIP n'est pas activee%RESET%
        SET ZIP_EXTENSION_NEEDED=1
    ) else (
        echo %GREEN%OK: Extension ZIP est activee%RESET%
    )
)

:: Vérifier Composer
echo.
echo Verification de Composer...
where composer >nul 2>&1
if %errorLevel% neq 0 (
    echo %YELLOW%Composer n'est pas installe%RESET%
    SET COMPOSER_NEEDED=1
) else (
    echo %GREEN%OK: Composer est installe%RESET%
)

:: Vérifier Git
echo.
echo Verification de Git...
where git >nul 2>&1
if %errorLevel% neq 0 (
    echo %YELLOW%Git n'est pas installe%RESET%
    SET GIT_NEEDED=1
) else (
    echo %GREEN%OK: Git est installe%RESET%
)

:: Vérifier VS Code
echo.
echo Verification de Visual Studio Code...
where code >nul 2>&1
if %errorLevel% neq 0 (
    echo %YELLOW%Visual Studio Code n'est pas installe%RESET%
    SET VSCODE_NEEDED=1
) else (
    echo %GREEN%OK: Visual Studio Code est installe%RESET%
)

:: Vérifier Symfony CLI
echo.
echo Verification de Symfony CLI...
where symfony >nul 2>&1
if %errorLevel% neq 0 (
    echo %YELLOW%Symfony CLI n'est pas installe%RESET%
    SET SYMFONY_NEEDED=1
) else (
    echo %GREEN%OK: Symfony CLI est installe%RESET%
)

:: Résumé et confirmation
echo.
echo ===================================
echo Resume des actions necessaires:
echo ===================================
SET ACTIONS_NEEDED=0

if %SCOOP_NEEDED%==1 (
    echo %YELLOW%- Installation de Scoop%RESET%
    SET /A ACTIONS_NEEDED+=1
)
if %PHP_NEEDED%==1 (
    echo %YELLOW%- Installation/Mise a jour de PHP%RESET%
    SET /A ACTIONS_NEEDED+=1
)
if %ZIP_EXTENSION_NEEDED%==1 (
    echo %YELLOW%- Activation de l'extension ZIP%RESET%
    SET /A ACTIONS_NEEDED+=1
)
if %COMPOSER_NEEDED%==1 (
    echo %YELLOW%- Installation de Composer%RESET%
    SET /A ACTIONS_NEEDED+=1
)
if %SYMFONY_NEEDED%==1 (
    echo %YELLOW%- Installation de Symfony CLI%RESET%
    SET /A ACTIONS_NEEDED+=1
)
if %GIT_NEEDED%==1 (
    echo %YELLOW%- Installation de Git%RESET%
    SET /A ACTIONS_NEEDED+=1
)
if %VSCODE_NEEDED%==1 (
    echo %YELLOW%- Installation de VS Code%RESET%
    SET /A ACTIONS_NEEDED+=1
)

if %ACTIONS_NEEDED%==0 (
    echo %GREEN%Tout est deja installe et configure correctement !%RESET%
) else (
    echo.
    set /p CONFIRM="Voulez-vous proceder aux installations necessaires? (O/N): "
    if /i "%CONFIRM%" neq "O" (
        echo Installation annulee
        goto SERVER_START
    )

    :: Installations
    echo.
    echo ===================================
    echo Installation des composants manquants
    echo ===================================

    :: Installer Scoop si nécessaire
    if %SCOOP_NEEDED%==1 (
        echo.
        echo Installation de Scoop...
        powershell -Command "Set-ExecutionPolicy RemoteSigned -Scope CurrentUser"
        powershell -Command "Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression"
        if !errorLevel! neq 0 (
            echo %RED%Erreur lors de l'installation de Scoop%RESET%
            pause
            exit /b 1
        )
        echo %GREEN%Scoop installe avec succes%RESET%
    )

    :: Installer PHP si nécessaire
    if %PHP_NEEDED%==1 (
        echo.
        echo Installation de PHP %PHP_VERSION%...
        scoop install php%PHP_VERSION%
        if !errorLevel! neq 0 (
            echo %RED%Erreur lors de l'installation de PHP%RESET%
            pause
            exit /b 1
        )
        echo %GREEN%PHP installe avec succes%RESET%
    )

    :: Configurer ZIP si nécessaire
    if %ZIP_EXTENSION_NEEDED%==1 (
        echo.
        echo Configuration de l'extension ZIP...
        SET PHP_INI_PATH=%USERPROFILE%\scoop\apps\php%PHP_VERSION%\current\php.ini
        powershell -Command "(Get-Content '%PHP_INI_PATH%') -replace ';extension=zip', 'extension=zip' | Set-Content '%PHP_INI_PATH%'"
        powershell -Command "(Get-Content '%PHP_INI_PATH%') -replace ';extension=fileinfo', 'extension=fileinfo' | Set-Content '%PHP_INI_PATH%'"
        echo %GREEN%Extension ZIP configuree%RESET%
    )

    :: Installer Composer si nécessaire
    if %COMPOSER_NEEDED%==1 (
        echo.
        echo Installation de Composer...
        powershell -Command "Invoke-WebRequest -Uri '%COMPOSER_SETUP_URL%' -OutFile composer-setup.exe"
        composer-setup.exe /SILENT
        del composer-setup.exe
        echo %GREEN%Composer installe avec succes%RESET%
    )

    :: Installer Git si nécessaire
    if %GIT_NEEDED%==1 (
        echo.
        echo Installation de Git...
        scoop install git
        if !errorLevel! neq 0 (
            echo %RED%Erreur lors de l'installation de Git%RESET%
            pause
            exit /b 1
        )
        echo %GREEN%Git installe avec succes%RESET%
    )

    :: Configurer Git
    echo.
    echo Configuration de Git...
    git config --global user.email "yessineslysquid@gmail.com"
    git config --global user.name "Maitre-Slysquid"
    echo %GREEN%Git configure avec succes%RESET%

    :: Installer VS Code si nécessaire
    if %VSCODE_NEEDED%==1 (
        echo.
        echo Installation de Visual Studio Code...
        scoop bucket add extras
        scoop install vscode
        if !errorLevel! neq 0 (
            echo %RED%Erreur lors de l'installation de VS Code%RESET%
            pause
            exit /b 1
        )
        echo %GREEN%Visual Studio Code installe avec succes%RESET%
    )

    :: Installation des extensions VS Code nécessaires
    echo.
    echo Installation des extensions VS Code...
    code --install-extension github.vscode-pull-request-github
    code --install-extension github.copilot
    code --install-extension github.github-vscode-theme
    echo %GREEN%Extensions VS Code installees avec succes%RESET%

    :: Ouvrir l'interface GitHub dans VS Code
    echo.
    echo Ouverture de l'authentification GitHub dans VS Code...
    start "" "vscode://github.copilot.authLauncher"
    timeout /t 2 >nul
    start "" "vscode://vscode.github-authentication/did-authenticate"

    :: Installer Symfony CLI si nécessaire
    if %SYMFONY_NEEDED%==1 (
        echo.
        echo Installation de Symfony CLI...
        scoop bucket add main
        scoop install symfony-cli
        if !errorLevel! neq 0 (
            echo %RED%Erreur lors de l'installation de Symfony CLI%RESET%
            pause
            exit /b 1
        )
        echo %GREEN%Symfony CLI installe avec succes%RESET%
    )
)

:SERVER_START
:: Demander si l'utilisateur veut lancer le serveur
echo.
echo %YELLOW%Voulez-vous lancer le serveur Symfony? (O/N):%RESET%
set "START_SERVER="
set /p START_SERVER=
echo Le choix est: [%START_SERVER%]

if /i "%START_SERVER%" == "O" (
    :PATH_INPUT
    echo.
    echo %YELLOW%Entrez le chemin de votre projet Symfony (chemin obligatoire):%RESET%
    set "SYMFONY_PATH="
    set /p SYMFONY_PATH=
    echo Le chemin est: [%SYMFONY_PATH%]
    
    :: Vérifie si le chemin est vide
    if "!SYMFONY_PATH!"=="" (
        echo %RED%Le chemin est obligatoire. Veuillez entrer un chemin valide.%RESET%
        goto PATH_INPUT
    )

    if not "%SYMFONY_PATH%"=="" (
        if exist "%SYMFONY_PATH%" (
            echo.
            echo %YELLOW%Installation des dependances Composer...%RESET%
            cd /d "%SYMFONY_PATH%"
            :: Vérifier si composer.json existe
            if not exist "composer.json" (
                echo %RED%Erreur: composer.json non trouve dans le dossier%RESET%
                goto END
            )

            echo %YELLOW%Installation des dependances via Composer...%RESET%
            call composer install
            if !errorLevel! neq 0 (
                echo %RED%Erreur lors de l'installation des dependances%RESET%
                goto END
            )
            
            :: Vérifier si les dossiers var et vendor existent
            if not exist "vendor" (
                echo %RED%Erreur: Le dossier vendor n'a pas ete cree correctement%RESET%
                goto END
            )
            
            if not exist "var" (
                echo %RED%Erreur: Le dossier var n'a pas ete cree correctement%RESET%
                goto END
            )

            echo %GREEN%Dependances installees avec succes%RESET%
            echo.
            echo %YELLOW%Demarrage du serveur Symfony...%RESET%
                symfony server:stop 2>nul
                symfony server:start
            )
        ) else (
            echo %RED%Le chemin specifie n'existe pas%RESET%
        )
    ) else (
        echo %RED%Aucun chemin specifie%RESET%
    )
) else (
    echo.
    echo %YELLOW%Pour demarrer le serveur plus tard, utilisez:%RESET%
    echo cd chemin/vers/votre/projet
    echo symfony server:start
)

:: Vérification finale
echo.
echo ===================================
echo Verification finale de l'installation
echo ===================================

echo.
symfony check:requirements

echo.
echo Installation terminee ! Verifiez les messages ci-dessus pour vous assurer que tout est correct.
pause