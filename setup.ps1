
$ErrorActionPreference = "Stop"

Write-Host "=============================="
Write-Host " JAVA PRACTICE ENVIRONMENT"
Write-Host "=============================="

# Check Windows Package Manager
if (-not (Get-Command winget -ErrorAction SilentlyContinue)) {
    Write-Host "ERROR: winget is not installed."
    Write-Host "Install Windows App Installer first."
    exit 1
}

# Install JDK 25
Write-Host "`nInstalling Eclipse Temurin JDK 25..."

winget install --id EclipseAdoptium.Temurin.25.JDK `
    --exact `
    --source winget `
    --accept-package-agreements `
    --accept-source-agreements

if ($LASTEXITCODE -ne 0) {
    Write-Host "JDK installation failed."
    exit 1
}

# Install Java Extension Pack if VS Code CLI is available
if (Get-Command code -ErrorAction SilentlyContinue) {
    Write-Host "`nInstalling Java Extension Pack..."
    code --install-extension vscjava.vscode-java-pack
}
else {
    Write-Host "`nVS Code CLI not found."
    YouCanInstall = "Install Java Extension Pack manually from VS Code."
    Write-Host $YouCanInstall
}

Write-Host "`nSetup completed!"
Write-Host "Restart your terminal before running Java."
