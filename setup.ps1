
$ErrorActionPreference = "Stop"

Write-Host ""
Write-Host "========================================"
Write-Host "       JAVA PRACTICE ENVIRONMENT"
Write-Host "========================================"
Write-Host ""

# 1. Check Windows Package Manager
Write-Host "[1/5] Checking Winget..."

if (-not (Get-Command winget -ErrorAction SilentlyContinue)) {
    Write-Host "ERROR: Winget is not installed."
    Write-Host "Please install Windows App Installer first."
    exit 1
}

Write-Host "Winget found!"

# 2. Install JDK 25
Write-Host ""
Write-Host "[2/5] Installing Java JDK 25..."

winget install --id EclipseAdoptium.Temurin.25.JDK `
    --exact `
    --source winget `
    --accept-package-agreements `
    --accept-source-agreements

if ($LASTEXITCODE -ne 0) {
    Write-Host "JDK installation failed!"
    exit 1
}

Write-Host "JDK installation completed!"

# 3. Install VS Code Java Extension Pack
Write-Host ""
Write-Host "[3/5] Installing Java Extension Pack..."

if (Get-Command code -ErrorAction SilentlyContinue) {

    code --install-extension vscjava.vscode-java-pack

    if ($LASTEXITCODE -ne 0) {
        Write-Host "Extension installation failed."
        Write-Host "You can install it manually from VS Code."
    }

} else {

    Write-Host "VS Code CLI not found."
    Write-Host "Install Java Extension Pack manually."

}

# 4. Refresh Java PATH
Write-Host ""
Write-Host "[4/5] Refreshing Java PATH..."

$machinePath = [Environment]::GetEnvironmentVariable("Path", "Machine")
$userPath = [Environment]::GetEnvironmentVariable("Path", "User")

$env:Path = "$machinePath;$userPath"

$javaCommand = Get-Command javac -ErrorAction SilentlyContinue

if (-not $javaCommand) {

    $jdkFolder = "C:\Program Files\Eclipse Adoptium"

    if (Test-Path $jdkFolder) {

        $jdk = Get-ChildItem $jdkFolder -Directory |
            Where-Object { $_.Name -like "jdk-25*" } |
            Sort-Object Name -Descending |
            Select-Object -First 1

        if ($jdk) {
            $env:JAVA_HOME = $jdk.FullName
            $env:Path = "$($jdk.FullName)\bin;$env:Path"
        }
    }
}

if (-not (Get-Command javac -ErrorAction SilentlyContinue)) {
    Write-Host "JDK installed, but compiler not detected."
    Write-Host "Restart terminal and run setup again if necessary."
}

# 5. Configure PowerShell run command
Write-Host ""
Write-Host "[5/5] Configuring run command..."

$profilePath = $PROFILE
$profileDirectory = Split-Path -Parent $profilePath

if (-not (Test-Path $profileDirectory)) {

    New-Item -ItemType Directory `
        -Path $profileDirectory `
        -Force | Out-Null

}

if (-not (Test-Path $profilePath)) {

    New-Item -ItemType File `
        -Path $profilePath `
        -Force | Out-Null

}

$marker = "# JAVA_ENV_RUN_COMMAND"

$profileContent = Get-Content $profilePath -Raw -ErrorAction SilentlyContinue

if (-not ($profileContent -match [regex]::Escape($marker))) {

    $functionCode = @'

# JAVA_ENV_RUN_COMMAND

function run {

    $runner = Join-Path (Get-Location).Path "run.ps1"

    if (Test-Path -LiteralPath $runner -PathType Leaf) {

        & $runner

    } else {

        Write-Host "Error: run.ps1 not found!"
        Write-Host "Please open your java_env project folder first."

    }

}

'@

    Add-Content -Path $profilePath -Value $functionCode

}

# Load run function immediately
. $profilePath

Write-Host ""
Write-Host "========================================"
Write-Host "       SETUP COMPLETED SUCCESSFULLY"
Write-Host "========================================"
Write-Host ""

Write-Host "Java Version:"
java -version

Write-Host ""
Write-Host "Java Compiler:"
javac -version

Write-Host ""
Write-Host "You can now write Java code in:"
Write-Host "YourCodeHere.java"

Write-Host ""
Write-Host "To run your program, simply type:"
Write-Host "run"

Write-Host ""
