$ErrorActionPreference = "Stop"

# Always run from repository directory
Set-Location $PSScriptRoot

# Check Java compiler
if (-not (Get-Command javac -ErrorAction SilentlyContinue)) {
    Write-Host "JDK not found. Please run setup.ps1 first."
    exit 1
}

# Create output directory
New-Item -ItemType Directory -Force -Path "out" | Out-Null

Write-Host "`nCompiling Java code..."

javac -d out YourCodeHere.java

if ($LASTEXITCODE -ne 0) {
    Write-Host "Compilation failed!"
    exit 1
}

Write-Host "`nRunning Java program..."

java -cp out YourCodeHere