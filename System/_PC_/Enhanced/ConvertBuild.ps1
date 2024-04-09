# Enhanced SCCT Versus - Convert Build by Joshhhuaaa
# This script is used to easily convert the game build between dgVoodoo2 or 3D Analyze.
# 3D Analyze is usually only recommended if having mouse issues with dgVoodoo2 or if you would like to use windowed mode.

# Sets console to display white text on a black background
function Set-ConsoleColor ($bc, $fc) {
    $Host.UI.RawUI.BackgroundColor = $bc
    $Host.UI.RawUI.ForegroundColor = $fc
    Clear-Host
}
Set-ConsoleColor 'Black' 'White'

# Paths
$scriptPath = Split-Path -Parent $MyInvocation.MyCommand.Definition
$parentPath = Split-Path (Split-Path (Split-Path $scriptPath -Parent) -Parent) -Parent

function Convert {
    param (
        [string]$zipFileName,
        [string]$message,
        [string[]]$filesToRemove
    )

    Write-Host $message

    # Archive path
    $zipFilePath = Join-Path -Path $scriptPath -ChildPath $zipFileName

    # Extract archive
    Expand-Archive -Path $zipFilePath -DestinationPath $parentPath -Force

    # Delete the files if they exist
    foreach ($file in $filesToRemove) {
        $filePath = Join-Path -Path $parentPath -ChildPath $file
        if (Test-Path -Path $filePath) { 
            Remove-Item -Path $filePath
        }
    }
}

function Convert-3DA {
    Convert -zipFileName "3DAnalyze.zip" -message "Converting to 3D Analyze build..." -filesToRemove @("System\D3D8.dll", "System\dgVoodoo.conf")
}

function Convert-DG {
    Convert -zipFileName "dgVoodoo2.zip" -message "Converting to dgVoodoo2 build..." -filesToRemove @("Play SCCT Versus.cmd", "System\config_DX.ini", "System\config_GL.ini", "System\3da_extra8.dll", "System\d3df.dll", "System\d3dg.dll")

    $folderPath = Join-Path -Path $parentPath -ChildPath "Menus\Enhanced"
    if (Test-Path -Path $folderPath) { 
        Remove-Item -Path $folderPath -Recurse
    }
}

Write-Host "Enhanced SCCT Versus - Convert Build`n"

$validBuild = $false
while (-not $validBuild) {
    Write-Host "Enter your desired build (1-2):"
    Write-Host "    1  -  dgVoodoo2 (recommended)"  -ForegroundColor Yellow
    Write-Host "    2  -  3D Analyze"  -ForegroundColor White
    $build = Read-Host "Build"

    switch ($build) {
        "1" { 
            Convert-DG
            $validBuild = $true
        }
        "2" { 
            Convert-3DA
            $validBuild = $true
        }
        default { 
            Write-Host "`nInvalid build.`n" -ForegroundColor Red 
        }
    }
}