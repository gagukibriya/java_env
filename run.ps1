
$ErrorActionPreference = "Stop"

Set-Location $PSScriptRoot

# Check Java compiler
if (-not (Get-Command javac -ErrorAction SilentlyContinue)) {
    Write-Host "Java JDK not found!"
    Write-Host "Please run setup.ps1 first."
    exit 1
}

# Create output folder
New-Item -ItemType Directory -Force -Path "out" | Out-Null

Write-Host ""
Write-Host "Compiling Java code..."
Write-Host ""

javac -d out YourCodeHere.java

if ($LASTEXITCODE -ne 0) {
    Write-Host "Compilation failed!"
    exit 1
}

Write-Host "Running Java program..."
Write-Host ""

java -cp out YourCodeHere
