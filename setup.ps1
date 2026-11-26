
$ErrorActionPreference = "Stop"

Write-Host ""
Write-Host "===================================="
Write-Host "       JAVA PRACTICE ENVIRONMENT"
Write-Host "===================================="
Write-Host ""

# 1. Check Windows Package Manager
if (-not (Get-Command winget -ErrorAction SilentlyContinue)) {
    Write-Host "ERROR: Winget is not installed."
    Write-Host "Install Windows App Installer first."
    exit 1
}

# 2. Install JDK 25
Write-Host "[1/3] Installing Java JDK 25..."

winget install --id EclipseAdoptium.Temurin.25.JDK `
    --exact `
    --source winget `
    --accept-package-agreements `
    --accept-source-agreements

if ($LASTEXITCODE -ne 0) {
    Write-Host "JDK installation failed!"
    exit 1
}

# 3. Install VS Code Java Extension Pack
Write-Host ""
Write-Host "[2/3] Installing Java Extension Pack..."

if (Get-Command code -ErrorAction SilentlyContinue) {
    code --install-extension vscjava.vscode-java-pack
} else {
    Write-Host "VS Code CLI not found. Install Java Extension Pack manually."
}

# 4. Configure PowerShell run command
Write-Host ""
Write-Host "[3/3] Configuring run command..."

$profilePath = $PROFILE
$profileDirectory = Split-Path -Parent $profilePath

if (-not (Test-Path $profileDirectory)) {
    New-Item -ItemType Directory -Path $profileDirectory -Force | Out-Null
}

if (-not (Test-Path $profilePath)) {
    New-Item -ItemType File -Path $profilePath -Force | Out-Null
}

$profileContent = Get-Content $profilePath -Raw -ErrorAction SilentlyContinue

$marker = "# JAVA_ENV_RUN_COMMAND"

if (-not ($profileContent -match [regex]::Escape($marker))) {

    $functionCode = @'

# JAVA_ENV_RUN_COMMAND
function run {
    $runner = Join-Path (Get-Location).Path "run.ps1"

    if (-not (Test-Path -LiteralPath $runner -PathType Leaf)) {
        Write-Host "Error: run.ps1 not found!"
        Write-Host "Please open the java_env project folder first."
        return
    }

    & $runner
}
'@

    Add-Content -Path $profilePath -Value $functionCode
}

Write-Host ""
Write-Host "===================================="
Write-Host "       SETUP COMPLETED!"
Write-Host "===================================="
Write-Host ""
Write-Host "Restart your VS Code terminal."
Write-Host "Open java_env folder and type: run"
Write-Host ""
