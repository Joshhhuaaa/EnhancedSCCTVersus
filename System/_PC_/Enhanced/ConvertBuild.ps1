# Enhanced SCCT Versus - Convert Build by Joshhhuaaa
# This script is used to easily convert the game build between dgVoodoo2 or 3D-Analyze.
# 3D-Analyze is usually only recommended if having mouse issues with dgVoodoo2 or if you would like to use windowed mode.

# Hide PowerShell window
Add-Type -Name Window -Namespace Console -MemberDefinition '
[DllImport("Kernel32.dll")]
public static extern IntPtr GetConsoleWindow();

[DllImport("user32.dll")]
public static extern bool ShowWindow(IntPtr hWnd, Int32 nCmdShow);
'
$console = [Console.Window]::GetConsoleWindow()
[Console.Window]::ShowWindow($console, 0) | Out-Null

# Paths
$scriptPath = Split-Path -Parent $MyInvocation.MyCommand.Definition
$parentPath = Split-Path (Split-Path (Split-Path $scriptPath -Parent) -Parent) -Parent
$exePath = Join-Path (Split-Path (Split-Path (Split-Path $scriptPath -Parent) -Parent) -Parent) "System\SCCT_Versus.exe"

# WinForms GUI
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing
[System.Windows.Forms.Application]::EnableVisualStyles()

# Extract icon
try {
    $icon = [System.Drawing.Icon]::ExtractAssociatedIcon($exePath)
    $form.Icon = $icon
} catch {
    Write-Host "Failed to extract icon from $exePath"
}

# Form
$form = New-Object System.Windows.Forms.Form
$form.Text = "Enhanced SCCT Versus - Convert Build"
$form.Size = New-Object System.Drawing.Size(300, 150)
$form.StartPosition = "CenterScreen"
$form.FormBorderStyle = "FixedDialog"
$form.MaximizeBox = $false
$form.MinimizeBox = $false
$form.Icon = $icon

# Set as topmost window
$topmost = New-Object 'System.Windows.Forms.Form' -Property @{TopMost=$true}

# Build
$label = New-Object System.Windows.Forms.Label
$label.Text = "Convert Build:"
$label.Location = New-Object System.Drawing.Point(10, 20)
$label.Size = New-Object System.Drawing.Size(100, 20)
$form.Controls.Add($label)

$dropdown = New-Object System.Windows.Forms.ComboBox
$dropdown.Location = New-Object System.Drawing.Point(120, 20)
$dropdown.Size = New-Object System.Drawing.Size(150, 20)
$dropdown.DropDownStyle = [System.Windows.Forms.ComboBoxStyle]::DropDownList
$dropdown.Items.Add("dgVoodoo2") | Out-Null
$dropdown.Items.Add("3D-Analyze") | Out-Null
$dropdown.SelectedIndex = 0
$form.Controls.Add($dropdown)

# Convert button
$button = New-Object System.Windows.Forms.Button
$button.Text = "Convert"
$button.Location = New-Object System.Drawing.Point(100, 60)
$button.Size = New-Object System.Drawing.Size(100, 30)
$form.Controls.Add($button)

# Event handler for the convert button
$button.Add_Click({
    $selectedBuild = $dropdown.SelectedItem.ToString()
    switch ($selectedBuild) {
        "dgVoodoo2" {
            Convert-DG
        }
        "3D-Analyze" {
            Convert-3DA
        }
    }
    $form.Close()
})

# Check for SCCT_Versus.exe to verify script is in the correct directory
function CheckGameDirectory {
    $gameExecutable = Join-Path -Path $parentPath -ChildPath "System\SCCT_Versus.exe"
    if (-not (Test-Path -Path $gameExecutable -PathType Leaf)) {
        [System.Windows.Forms.MessageBox]::Show("SCCT_Versus.exe was not found, so converting builds may not extract files to the correct location.", "Warning", [System.Windows.Forms.MessageBoxButtons]::OK)
    }
}

function Convert {
    param (
        [string]$zipFileName,
        [string]$message,
        [string[]]$filesToRemove,
        [string]$buildType
    )

    # Archive path
    $zipFilePath = Join-Path -Path $scriptPath -ChildPath $zipFileName

    if (-not (Test-Path -Path $zipFilePath)) {
        [System.Windows.Forms.MessageBox]::Show("$buildType package not found.", "Error", [System.Windows.Forms.MessageBoxButtons]::OK)
        return
    }

    # Extract archive
    Expand-Archive -Path $zipFilePath -DestinationPath $parentPath -Force

    # Delete the files if they exist
    foreach ($file in $filesToRemove) {
        $filePath = Join-Path -Path $parentPath -ChildPath $file
        if (Test-Path -Path $filePath) { 
            Remove-Item -Path $filePath
        }
    }

    # Display success message based on build type
    [System.Windows.Forms.MessageBox]::Show("Successfully converted to $buildType build.", "Build Converted", [System.Windows.Forms.MessageBoxButtons]::OK)
}

function Convert-3DA {
    Convert -zipFileName "3DAnalyze.zip" -filesToRemove @("System\D3D8.dll", "System\dgVoodoo.conf") -buildType "3D-Analyze"
}

function Convert-DG {
    Convert -zipFileName "dgVoodoo2.zip" -filesToRemove @("Play SCCT Versus.cmd", "System\config_DX.ini", "System\config_GL.ini", "System\3da_extra8.dll", "System\d3df.dll", "System\d3dg.dll") -buildType "dgVoodoo2"

    $folderPath = Join-Path -Path $parentPath -ChildPath "Menus\Enhanced"
    if (Test-Path -Path $folderPath) { 
        Remove-Item -Path $folderPath -Recurse
    }
}

$form.Add_FormClosing({
    [Console.Window]::ShowWindow($console, 1) | Out-Null
})

CheckGameDirectory
[void]$form.ShowDialog($topmost)