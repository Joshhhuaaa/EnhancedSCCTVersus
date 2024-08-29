# Enhanced SCCT Versus - Profile Manager by Joshhhuaaa
# This script is used for creating profiles in Enhanced SCCT Versus v3.0+.
# To offer players more control over mouse settings, a manual script is required.
# Unfortunately, the in-game profile creation cannot generate the necessary config files correctly.

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
$form.Text = "Enhanced SCCT Versus - Profile Manager"
$form.Size = New-Object System.Drawing.Size(350, 210)
$form.StartPosition = "CenterScreen"
$form.FormBorderStyle = "FixedDialog"
$form.MaximizeBox = $false
$form.MinimizeBox = $false
$form.Icon = $icon

# Set as topmost window
$topmost = New-Object 'System.Windows.Forms.Form' -Property @{TopMost=$true}

# Profile name
$labelProfileName = New-Object System.Windows.Forms.Label
$labelProfileName.Text = "Profile Name:"
$labelProfileName.Location = New-Object System.Drawing.Point(10, 10)
$labelProfileName.Size = New-Object System.Drawing.Size(100, 20)
$form.Controls.Add($labelProfileName)

$comboProfileName = New-Object System.Windows.Forms.ComboBox
$comboProfileName.Location = New-Object System.Drawing.Point(120, 10)
$comboProfileName.Size = New-Object System.Drawing.Size(200, 20)
$comboProfileName.DropDownStyle = [System.Windows.Forms.ComboBoxStyle]::DropDown
$form.Controls.Add($comboProfileName)

# Mouse multiplier
$labelMouseMultiplier = New-Object System.Windows.Forms.Label
$labelMouseMultiplier.Text = "Mouse Multiplier:"
$labelMouseMultiplier.Location = New-Object System.Drawing.Point(10, 50)
$labelMouseMultiplier.Size = New-Object System.Drawing.Size(100, 20)
$form.Controls.Add($labelMouseMultiplier)

$textMouseMultiplier = New-Object System.Windows.Forms.TextBox
$textMouseMultiplier.Location = New-Object System.Drawing.Point(120, 50)
$textMouseMultiplier.Size = New-Object System.Drawing.Size(200, 20)
# Placeholder text
$textMouseMultiplier.ForeColor = [System.Drawing.Color]::Gray
$textMouseMultiplier.Text = "Default Versus multiplier: 6.0"
$form.Controls.Add($textMouseMultiplier)

# Mouse multiplier focus
$textMouseMultiplier.add_Enter({
    if ($textMouseMultiplier.Text -eq "Default Versus multiplier: 6.0") {
        $textMouseMultiplier.Text = ""
        $textMouseMultiplier.ForeColor = [System.Drawing.SystemColors]::ControlText
    }
})

# Mouse multiplier unfocus
$textMouseMultiplier.add_Leave({
    if ($textMouseMultiplier.Text -eq "") {
        $textMouseMultiplier.Text = "Default Versus multiplier: 6.0"
        $textMouseMultiplier.ForeColor = [System.Drawing.Color]::Gray
    }
})

# Screen resolution
$labelScreenResolution = New-Object System.Windows.Forms.Label
$labelScreenResolution.Text = "Screen Resolution:"
$labelScreenResolution.Location = New-Object System.Drawing.Point(10, 90)
$labelScreenResolution.Size = New-Object System.Drawing.Size(100, 20)
$form.Controls.Add($labelScreenResolution)

$comboScreenResolution = New-Object System.Windows.Forms.ComboBox
$comboScreenResolution.Location = New-Object System.Drawing.Point(120, 90)
$comboScreenResolution.Size = New-Object System.Drawing.Size(200, 20)
$comboScreenResolution.DropDownStyle = [System.Windows.Forms.ComboBoxStyle]::DropDownList
$comboScreenResolution.Items.AddRange(@(
    "0 - 640x480",
    "1 - 800x600",
    "2 - 1024x768",
    "3 - 1280x1024",
    "4 - 7680x4320 (Native)",
    "5 - 1440x1080",
    "6 - 1920x1080",
    "7 - 1920x1440",
    "8 - 2560x1440",
    "9 - 2880x2160",
    "10 - 3840x2160"
))
$comboScreenResolution.SelectedIndex = 4
$form.Controls.Add($comboScreenResolution)

# Create button
$buttonCreate = New-Object System.Windows.Forms.Button
$buttonCreate.Text = "Create Profile"
$buttonCreate.Location = New-Object System.Drawing.Point(120, 130)
$buttonCreate.Size = New-Object System.Drawing.Size(90, 30)
$form.Controls.Add($buttonCreate)

# Event handler for the create button
$buttonCreate.Add_Click({
    $profileName = $comboProfileName.Text
    if ($profileName -match "^[a-zA-Z0-9_-]{1,15}$") {
        $mouseSpeed = $textMouseMultiplier.Text
        if ($mouseSpeed -match "^(\d+(\.\d*)?|\.\d+)$") {
            # Prepend a 0 if the multiplier starts with a dot
            if ($mouseSpeed -match "^\.") {
                $mouseSpeed = "0$mouseSpeed"
            }
            $mouseSpeed = "{0:N6}" -f [math]::Round([double]$mouseSpeed, 6)

            # Prevent using 0.0 mouse multiplier / warn against values above 6.0
            if ($mouseSpeed -eq "0.000000") {
                [System.Windows.Forms.MessageBox]::Show("A mouse multiplier set to 0.0 will disable your mouse. Please enter a value greater than zero.", "Error", [System.Windows.Forms.MessageBoxButtons]::OK)
            } elseif ([double]$mouseSpeed -gt 6.0) {
                $result = [System.Windows.Forms.MessageBox]::Show("Are you sure you want to use this mouse multiplier? Values above 6.0 are not recommended.", "Warning", [System.Windows.Forms.MessageBoxButtons]::YesNo)
                if ($result -eq [System.Windows.Forms.DialogResult]::No) {
                    return
                }
            }

            $screenResolution = $comboScreenResolution.SelectedIndex
            if ($screenResolution -ge 0 -and $screenResolution -le 10) {
                $dirPath = "C:\ProgramData\Ubisoft\Tom Clancy's Splinter Cell Chaos Theory\Saved Games\Versus"
                if (-not (Test-Path -Path $dirPath)) {
                    New-Item -ItemType Directory -Path $dirPath | Out-Null
                }
                
                $fileNames = @("${profileName}_prf.ini", "${profileName}_kbd_0.ini", "${profileName}_kbd_1.ini")
                $profileExists = $false
                foreach ($fileName in $fileNames) {
                    $filePath = Join-Path -Path $dirPath -ChildPath $fileName
                    if (Test-Path -Path $filePath) {
                        $profileExists = $true
                        break
                    }
                }

                if ($profileExists) {
                    $result = [System.Windows.Forms.MessageBox]::Show("A profile with the name '$profileName' already exists. Do you want to update this profile's mouse multiplier and screen resolution?", "Profile Exists", [System.Windows.Forms.MessageBoxButtons]::YesNo)
                    if ($result -eq [System.Windows.Forms.DialogResult]::Yes) {
                        Modify-Profile -profileName $profileName -mouseSpeed $mouseSpeed -screenResolution $screenResolution
                    }
                } else {
                    foreach ($fileName in $fileNames) {
                        $filePath = Join-Path -Path $dirPath -ChildPath $fileName
                        if ($fileName -match '_kbd') {
                            Generate-ProfileKeybinds $filePath $mouseSpeed
                        } elseif ($fileName -match '_prf') {
                            Generate-ProfilePreferences $filePath $screenResolution
                        }
                    }
                    [System.Windows.Forms.MessageBox]::Show("Profile created successfully.", "Profile Created", [System.Windows.Forms.MessageBoxButtons]::OK)
                    # Reset profile options
                    $comboProfileName.Text = ""
                    $textMouseMultiplier.Text = ""
                    $textMouseMultiplier.Text = "Default Versus multiplier: 6.0"
                    $textMouseMultiplier.ForeColor = [System.Drawing.Color]::Gray
                    $comboScreenResolution.SelectedIndex = 4

                    # Refresh profile list
                    $comboProfileName.Items.Clear()
                    $profileFiles = Get-ChildItem -Path $dirPath -Filter "*_prf.ini"
                    foreach ($file in $profileFiles) {
                        $profileName = $file.BaseName -replace "_prf$", ""
                        if ($profileName -ne "dedicated_server") {
                            $comboProfileName.Items.Add($profileName) | Out-Null
                        }
                    }

                    # If the profile list is empty, adjust the dropdown height
                    if ($comboProfileName.Items.Count -eq 0) {
                        $comboProfileName.DropDownHeight = 1
                    } else {
                        $comboProfileName.DropDownHeight = 150
                    }
                }
            } else {
                [System.Windows.Forms.MessageBox]::Show("Invalid screen resolution selection.", "Error", [System.Windows.Forms.MessageBoxButtons]::OK)
            }
        } else {
            [System.Windows.Forms.MessageBox]::Show("Invalid mouse multiplier value.", "Error", [System.Windows.Forms.MessageBoxButtons]::OK)
        }
    } else {
        [System.Windows.Forms.MessageBox]::Show("Invalid profile name. Use only numbers, letters, _ and - with a 15 character maximum.", "Error", [System.Windows.Forms.MessageBoxButtons]::OK)
    }
})

# Delete button
$buttonDelete = New-Object System.Windows.Forms.Button
$buttonDelete.Text = "Delete Profile"
$buttonDelete.Location = New-Object System.Drawing.Point(230, 130)
$buttonDelete.Size = New-Object System.Drawing.Size(90, 30)
$form.Controls.Add($buttonDelete)

# Event handler for the delete button
$buttonDelete.Add_Click({
    $profileName = $comboProfileName.Text

    if ([string]::IsNullOrWhiteSpace($profileName)) {
        [System.Windows.Forms.MessageBox]::Show("Please enter a profile name.", "Error", [System.Windows.Forms.MessageBoxButtons]::OK)
    } else {
        $confirmation = [System.Windows.Forms.MessageBox]::Show("Are you sure you want to delete the profile '$profileName'?", "Profile Deletion", [System.Windows.Forms.MessageBoxButtons]::YesNo)
        if ($confirmation -eq [System.Windows.Forms.DialogResult]::Yes) {
            Delete-Profile -profileName $profileName
        }
    }
})

# Event handler for profile selection
$comboProfileName.add_SelectedIndexChanged({
    $selectedProfile = $comboProfileName.SelectedItem
    if (-not [string]::IsNullOrWhiteSpace($selectedProfile)) {
        $dirPath = "C:\ProgramData\Ubisoft\Tom Clancy's Splinter Cell Chaos Theory\Saved Games\Versus"
        $prfFileName = "${selectedProfile}_prf.ini"
        $kbdFileNames = @("${selectedProfile}_kbd_0.ini", "${selectedProfile}_kbd_1.ini")

        # Read profile preferences
        $prfFilePath = Join-Path -Path $dirPath -ChildPath $prfFileName
        if (Test-Path $prfFilePath) {
            $prfContent = Get-Content -Path $prfFilePath
            $screenResLine = $prfContent | Where-Object { $_ -match '^ScreenRes=' }
            # Default to ScreenRes=4 if not found
            $screenResolution = if ($screenResLine) { $screenResLine -replace 'ScreenRes=', '' } else { "4" }

            # Read screen resolution from profile
            if ([int]::TryParse($screenResolution, [ref]$null) -and [int]$screenResolution -ge 0 -and [int]$screenResolution -le 10) {
                $comboScreenResolution.SelectedIndex = [int]$screenResolution
            } else {
                # Default to ScreenRes=4 if invalid
                $comboScreenResolution.SelectedIndex = 4
            }
        } else {
            [System.Windows.Forms.MessageBox]::Show("Profile preferences not found.", "Error", [System.Windows.Forms.MessageBoxButtons]::OK)
        }

        # Read profile keybinds
        $validMouseMultiplierFound = $false
        $missingKbdFiles = @()
        foreach ($kbdFileName in $kbdFileNames) {
            $kbdFilePath = Join-Path -Path $dirPath -ChildPath $kbdFileName
            if (Test-Path $kbdFilePath) {
                $kbdContent = Get-Content -Path $kbdFilePath
                $mouseXMultiplierLine = $kbdContent | Where-Object { $_ -match '^IK_MouseX=Axis aMouseX Speed=' }
                $mouseYMultiplierLine = $kbdContent | Where-Object { $_ -match '^IK_MouseY=Axis aMouseY Speed=' }
                
                if (-not ($mouseXMultiplierLine -and $mouseYMultiplierLine)) {
                    $missingKbdFiles += $kbdFileName
                }

                $mouseXMultiplier = ($mouseXMultiplierLine -split '=')[2]
                $mouseYMultiplier = ($mouseYMultiplierLine -split '=')[2]
                if ([float]::TryParse($mouseXMultiplier, [ref]$null) -and [float]::TryParse($mouseYMultiplier, [ref]$null) -and [float]$mouseXMultiplier -gt 0.0 -and [float]$mouseYMultiplier -gt 0.0) {
                    if ($kbdFileName -eq $kbdFileNames[0]) {
                        # Set MouseMultiplier with MouseX from _kbd_0.ini
                        $textMouseMultiplier.Text = $mouseXMultiplier
                    }
                    $textMouseMultiplier.ForeColor = [System.Drawing.SystemColors]::ControlText
                    $validMouseMultiplierFound = $true
                } else {
                    # If multiplier is invalid
                    [System.Windows.Forms.MessageBox]::Show("Invalid mouse multiplier. Please update the profile '$selectedProfile' with a valid multiplier or your mouse will not work in-game.", "Error", [System.Windows.Forms.MessageBoxButtons]::OK)
                    $textMouseMultiplier.Text = ""
                    $textMouseMultiplier.Text = "Default Versus multiplier: 6.0"
                    $textMouseMultiplier.ForeColor = [System.Drawing.Color]::Gray
                    return
                }
            } else {
                $missingKbdFiles += $kbdFileName
            }
        }

        # If keybind files missing
        if ($missingKbdFiles.Count -gt 0) {
            [System.Windows.Forms.MessageBox]::Show("Missing mouse multiplier. Please update the profile '$selectedProfile' with a valid multiplier or your mouse will not work in-game.", "Error", [System.Windows.Forms.MessageBoxButtons]::OK)
            $textMouseMultiplier.Text = ""
            $textMouseMultiplier.Text = "Default Versus multiplier: 6.0"
            $textMouseMultiplier.ForeColor = [System.Drawing.Color]::Gray
        }
    }
})

# Prevents typing invalid profile name
$comboProfileName.add_KeyPress({
    param ($sender, $e)
    if ($e.KeyChar -notmatch "[a-zA-Z0-9_-]" -and $e.KeyChar -ne [char][System.Windows.Forms.Keys]::Back) {
        $e.Handled = $true
    } elseif ($comboProfileName.Text.Length -ge 15 -and $e.KeyChar -ne [char][System.Windows.Forms.Keys]::Back) {
        $e.Handled = $true
    }
})

# Prevents typing invalid mouse multiplier
$textMouseMultiplier.Add_KeyPress({
    param ($sender, $e)
    if (([char]::IsDigit($e.KeyChar) -or $e.KeyChar -eq '.' -or $e.KeyChar -eq [char]8) -and 
        (-not ($sender.Text.Contains('.') -and $e.KeyChar -eq '.'))) {
        $e.Handled = $false
    } else {
        $e.Handled = $true
    }
})

# Prevents Shift+Insert from pasting
$suppressPaste = {
    param ($sender, $e)
    if ($e.Modifiers -eq [System.Windows.Forms.Keys]::Shift -and $e.KeyCode -eq [System.Windows.Forms.Keys]::Insert) {
        $e.SuppressKeyPress = $true
    }
}
$comboProfileName.add_KeyDown($suppressPaste)
$textMouseMultiplier.add_KeyDown($suppressPaste)

function Modify-Profile {
    param ($profileName, $mouseSpeed, $screenResolution)

    $dirPath = "C:\ProgramData\Ubisoft\Tom Clancy's Splinter Cell Chaos Theory\Saved Games\Versus"
    $fileNames = @("${profileName}_prf.ini", "${profileName}_kbd_0.ini", "${profileName}_kbd_1.ini")

    foreach ($fileName in $fileNames) {
        $filePath = Join-Path -Path $dirPath -ChildPath $fileName

        if (Test-Path $filePath) {
            $content = Get-Content $filePath
            if ($content -isnot [array]) {
                $content = @($content)
            }

            if ($fileName -match '_kbd') {
                $isValid = $false
                foreach ($line in $content) {
                    if ($line -match '^\[Engine.Input\]$') {
                        $isValid = $true
                        break
                    }
                }

                if ([string]::IsNullOrWhiteSpace($content) -or (-not $isValid)) {
                    Generate-ProfileKeybinds $filePath $mouseSpeed
                    continue
                }

                if ($content -match 'IK_MouseX=Axis aMouseX Speed=\d+(\.\d+)?') {
                    $content = $content -replace 'IK_MouseX=Axis aMouseX Speed=\d+(\.\d+)?', "IK_MouseX=Axis aMouseX Speed=$mouseSpeed"
                } elseif ($content -match 'IK_MouseX=.*') {
                    $content = $content -replace 'IK_MouseX=.*', "IK_MouseX=Axis aMouseX Speed=$mouseSpeed"
                } else {
                    $content += "IK_MouseX=Axis aMouseX Speed=$mouseSpeed"
                }

                if ($content -match 'IK_MouseY=Axis aMouseY Speed=\d+(\.\d+)?') {
                    $content = $content -replace 'IK_MouseY=Axis aMouseY Speed=\d+(\.\d+)?', "IK_MouseY=Axis aMouseY Speed=$mouseSpeed"
                } elseif ($content -match 'IK_MouseY=.*') {
                    $content = $content -replace 'IK_MouseY=.*', "IK_MouseY=Axis aMouseY Speed=$mouseSpeed"
                } else {
                    $content += "IK_MouseY=Axis aMouseY Speed=$mouseSpeed"
                }
            }

            if ($fileName -match '_prf') {
                $isValid = $false
                foreach ($line in $content) {
                    if ($line -match '^\[SBase.SPlayerProfile\]$') {
                        $isValid = $true
                        break
                    }
                }

                if ([string]::IsNullOrWhiteSpace($content) -or (-not $isValid)) {
                    Generate-ProfilePreferences $filePath $screenResolution
                    continue
                }
                
                if ($content -match 'ScreenRes=\d+') {
                    $content = $content -replace 'ScreenRes=\d+', "ScreenRes=$screenResolution"
                } elseif ($content -match 'ScreenRes=.*') {
                    $content = $content -replace 'ScreenRes=.*', "ScreenRes=$screenResolution"
                } else {
                    $content += "ScreenRes=$screenResolution"
                }

            }

            $content | Set-Content $filePath
        } else {
            if ($fileName -match '_kbd') {
                Generate-ProfileKeybinds $filePath $mouseSpeed
            }

            if ($fileName -match '_prf') {
                Generate-ProfilePreferences $filePath $screenResolution
            }
        }
    }

    [System.Windows.Forms.MessageBox]::Show("Profile updated with new mouse multiplier and screen resolution.", "Profile Updated", [System.Windows.Forms.MessageBoxButtons]::OK)
    # Reset profile options
    $comboProfileName.Text = ""
    $textMouseMultiplier.Text = ""
    $textMouseMultiplier.Text = "Default Versus multiplier: 6.0"
    $textMouseMultiplier.ForeColor = [System.Drawing.Color]::Gray
    $comboScreenResolution.SelectedIndex = 4

    # Refresh profile list
    $comboProfileName.Items.Clear()
    $profileFiles = Get-ChildItem -Path $dirPath -Filter "*_prf.ini"
    foreach ($file in $profileFiles) {
        $profileName = $file.BaseName -replace "_prf$", ""
        if ($profileName -ne "dedicated_server") {
            $comboProfileName.Items.Add($profileName) | Out-Null
        }
    }

    # If the profile list is empty, adjust the dropdown height
    if ($comboProfileName.Items.Count -eq 0) {
        $comboProfileName.DropDownHeight = 1
    } else {
        $comboProfileName.DropDownHeight = 150
    }
}

# _prf.ini
function Generate-ProfilePreferences ($fileName, $screenResolution) {
    $prfContent = @"
[SBase.SPlayerProfile]
ATTEquipment[0]=Class§(677)'SBase§(180).SGadSmokeGrenade§(707695)'
ATTEquipment[1]=Class§(677)'SBase§(180).SGadChaffeGrenade§(707687)'
ATTEquipment[2]=Class§(677)'SBase§(180).SGadStickyCam§(212280)'
ATTEquipment[3]=Class§(677)'SBase§(180).SGadHeartBeatSensor§(945352)'
DEFEquipment[0]=Class§(677)'SBase§(180).SGadFragGrenade§(707690)'
DEFEquipment[1]=Class§(677)'SBase§(180).SGadMultiMinesLauncher§(179964)'
DEFEquipment[2]=Class§(677)'SBase§(180).SGadBackPack§(854069)'
DEFEquipment[3]=Class§(677)'SBase§(180).SGadGasMask§(854071)'
ATTWeapClass=Class§(677)'SBase§(180).SStickyShocker§(1294646)'
DEFWeapClass=Class§(677)'SBase§(180).SWeaponDefense§(190223)'
LobbyName=
NumTeam=0
InvertY=False
InvertX=False
bInFeet=False
bQuickTurn=True
allowVoiceChat=False
voiceChatQuality=2
iEffectVolume=1.000000
iMusicVolume=1.000000
iVoiceChatVolume=1.000000
MouseSensitivity=10.000000
iDecalX=0
iDecalY=0
iMapsPlayed[0]=0
iMapsPlayed[1]=0
iTotalPlayingTime=0
bExamDone=True
bVisibleFromDedicatedServer=True
bTutorialAdvancement_ATT_0_8=30
bTutorialAdvancement_DEF_0_8=30
ScreenRes=$screenResolution
GraphQual=2
GraphPostQual=1
SelectedKeyboard=0
SelectedMouse=1
bEAX=True
"@
    Set-Content -Path $fileName -Value $prfContent
}

# _kbd_0.ini / _kbd_1.ini
function Generate-ProfileKeybinds ($fileName, $mouseSpeed) {
    $kbdContent += @"
[Engine.Input]
IK_MouseX=Axis aMouseX Speed=$mouseSpeed
IK_MouseY=Axis aMouseY Speed=$mouseSpeed
IK_None=
IK_LeftMouse=Fire | GadgetQuickChoice 0
IK_RightMouse=AltFire | GadgetQuickChoice 1 | HoldBreath
IK_Cancel=
IK_MiddleMouse=ChangeSpeed
IK_MouseX1=
IK_MouseX2=
IK_Unknown07=
IK_Backspace=
IK_Tab=SwitchHeadset 3
IK_Unknown0A=
IK_Unknown0B=
IK_Unknown0C=
IK_Enter=
IK_Unknown0E=
IK_Unknown0F=
IK_Shift=Use
IK_Ctrl=
IK_Alt=
IK_Pause=
IK_CapsLock=
IK_Unknown15=
IK_Unknown16=
IK_Unknown17=
IK_Unknown18=
IK_Unknown19=
IK_Unknown1A=
IK_Unknown1C=
IK_Unknown1D=
IK_Unknown1E=
IK_Unknown1F=
IK_Space=Jump
IK_PageUp=ZoomIn
IK_PageDown=ZoomOut
IK_End=
IK_Home=
IK_Left=
IK_Up=
IK_Right=
IK_Down=
IK_Select=
IK_Print=
IK_Execute=
IK_PrintScrn=
IK_Insert=
IK_Delete=
IK_Help=
IK_0=
IK_1=SelectGadget 0
IK_2=SelectGadget 1
IK_3=SelectGadget 2
IK_4=SelectGadget 3
IK_5=AliasPrevItem
IK_6=AliasNextItem
IK_7=
IK_8=
IK_9=
IK_Unknown3A=
IK_Unknown3B=
IK_Unknown3C=
IK_Unknown3D=
IK_Unknown3E=
IK_Unknown3F=
IK_Unknown40=
IK_A=AliasGauche
IK_B=SwitchBinocularVision
IK_C=Crouch
IK_D=AliasDroite
IK_E=FireMode | GadTorcheSwitch
IK_F=ROF
IK_G=
IK_H=HackComm
IK_I=
IK_J=
IK_K=
IK_L=SwitchLaser
IK_M=
IK_N=
IK_O=
IK_P=
IK_Q=Roll | GadLaserSwitch
IK_R=Reload
IK_S=AliasBas
IK_T=PerformCoopMvt
IK_U=
IK_V=PrevStickyCam
IK_W=AliasHaut
IK_X=
IK_Y=
IK_Z=Btw
IK_Unknown5B=
IK_Unknown5C=
IK_Unknown5D=
IK_Unknown5E=
IK_Unknown5F=
IK_NumPad0=
IK_NumPad1=
IK_NumPad2=
IK_NumPad3=
IK_NumPad4=
IK_NumPad5=
IK_NumPad6=
IK_NumPad7=
IK_NumPad8=
IK_NumPad9=
IK_GreyStar=
IK_GreyPlus=
IK_Separator=
IK_GreyMinus=
IK_NumPadPeriod=
IK_GreySlash=
IK_F1=SwitchHeadset 1
IK_F2=SwitchHeadset 2
IK_F3=DisplayDefaultControls
IK_F4=DisplayHud
IK_F7=DisplayStrategicMap
IK_F8=DisplaySessionStatus
IK_F9=SwitchEnhancedReality
IK_F10=ShowConnectedPlayers
IK_F11=Quit
IK_F12=
IK_F13=
IK_F14=
IK_F15=
IK_F16=
IK_F17=
IK_F18=
IK_F19=
IK_F20=
IK_F21=
IK_F22=
IK_F23=
IK_F24=
IK_Unknown88=
IK_Unknown89=
IK_Unknown8A=
IK_Unknown8B=
IK_Unknown8C=
IK_Unknown8D=
IK_Unknown8E=
IK_Unknown8F=
IK_NumLock=
IK_ScrollLock=
IK_Unknown92=
IK_Unknown93=
IK_Unknown94=
IK_Unknown95=
IK_Unknown96=
IK_Unknown97=
IK_Unknown98=
IK_Unknown99=
IK_Unknown9A=
IK_Unknown9B=
IK_Unknown9C=
IK_Unknown9D=
IK_Unknown9E=
IK_Unknown9F=
IK_LShift=
IK_RShift=
IK_LControl=
IK_RControl=
IK_UnknownA4=
IK_UnknownA5=
IK_UnknownA6=
IK_UnknownA7=
IK_UnknownA8=
IK_UnknownA9=
IK_UnknownAA=
IK_UnknownAB=
IK_UnknownAC=
IK_UnknownAD=
IK_UnknownAE=
IK_UnknownAF=
IK_UnknownB0=
IK_UnknownB1=
IK_UnknownB2=
IK_UnknownB3=
IK_UnknownB4=
IK_UnknownB5=
IK_UnknownB6=
IK_UnknownB7=
IK_UnknownB8=
IK_Unicode=
IK_Semicolon=
IK_Equals=
IK_Comma=
IK_Minus=
IK_Period=
IK_Slash=
IK_Tilde=
IK_UnknownC1=
IK_UnknownC2=
IK_UnknownC3=
IK_UnknownC4=
IK_UnknownC5=
IK_UnknownC6=
IK_UnknownC7=
IK_Joy1=
IK_Joy2=
IK_Joy3=
IK_Joy4=
IK_Joy5=
IK_Joy6=
IK_Joy7=
IK_Joy8=
IK_Joy9=
IK_Joy10=
IK_Joy11=
IK_Joy12=
IK_Joy13=
IK_Joy14=
IK_Joy15=
IK_Joy16=
IK_UnknownD8=
IK_UnknownD9=
IK_UnknownDA=
IK_LeftBracket=
IK_Backslash=
IK_RightBracket=
IK_SingleQuote=
IK_UnknownDF=
IK_UnknownE0=
IK_UnknownE1=
IK_UnknownE2=
IK_UnknownE3=
IK_MouseZ=
IK_MouseW=
IK_JoyU=
IK_JoyV=
IK_JoySlider1=
IK_JoySlider2=
IK_Unknown10E=
IK_Unknown10F=
IK_JoyX=
IK_JoyY=
IK_JoyZ=
IK_JoyR=
IK_UnknownF4=
IK_UnknownF5=
IK_Attn=
IK_CrSel=
IK_ExSel=
IK_ErEof=
IK_Play=
IK_Zoom=
IK_NoName=
IK_PA1=
IK_OEMClear=
IK_MouseWheelDown=WheelDown
IK_MouseWheelUp=WheelUp
IK_Escape=ShowMenu
IK_F5=Talk
IK_F6=TeamTalk
"@
    Set-Content -Path $fileName -Value $kbdContent
 }

function Load-Profiles {
    $dirPath = "C:\ProgramData\Ubisoft\Tom Clancy's Splinter Cell Chaos Theory\Saved Games\Versus"
    if (Test-Path $dirPath) {
        $profiles = Get-ChildItem -Path $dirPath -Filter '*_prf.ini' | ForEach-Object {
            $profileName = $_.BaseName -replace '_prf', ''
            if ($profileName -ne 'dedicated_server') {
                $profileName
            }
        }

        # Clear profile list
        $comboProfileName.Items.Clear()
        $comboProfileName.DropDownHeight = 150

        # Check if profiles exist before attempting to load
        if ($profiles -ne $null -and $profiles.Count -gt 0) {
            $comboProfileName.Items.AddRange($profiles)
        }
    }
}

function Delete-Profile {
    param ($profileName)

    $dirPath = "C:\ProgramData\Ubisoft\Tom Clancy's Splinter Cell Chaos Theory\Saved Games\Versus"
    $fileNames = @("${profileName}_prf.ini", "${profileName}_kbd_0.ini", "${profileName}_kbd_1.ini")

    $filesDeleted = $false
    foreach ($fileName in $fileNames) {
        $filePath = Join-Path -Path $dirPath -ChildPath $fileName
        if (Test-Path $filePath) {
            Remove-Item $filePath -Force
            $filesDeleted = $true
        }
    }

    if ($filesDeleted) {
        [System.Windows.Forms.MessageBox]::Show("Profile deleted successfully.", "Profile Deleted", [System.Windows.Forms.MessageBoxButtons]::OK)

        # Reset profile options
        $comboProfileName.Text = ""
        $textMouseMultiplier.Text = ""
        $textMouseMultiplier.Text = "Default Versus multiplier: 6.0"
        $textMouseMultiplier.ForeColor = [System.Drawing.Color]::Gray
        $comboScreenResolution.SelectedIndex = 4

        # Refresh profile list
        $comboProfileName.Items.Clear()
        $profileFiles = Get-ChildItem -Path $dirPath -Filter "*_prf.ini"
        foreach ($file in $profileFiles) {
            $profileName = $file.BaseName -replace "_prf$", ""
            if ($profileName -ne "dedicated_server") {
                $comboProfileName.Items.Add($profileName) | Out-Null
            }
        }

        # If the profile list is empty, adjust the dropdown height
        if ($comboProfileName.Items.Count -eq 0) {
            $comboProfileName.DropDownHeight = 1
        } else {
            $comboProfileName.DropDownHeight = 150
        }
    } else {
        [System.Windows.Forms.MessageBox]::Show("Profile does not exist.", "Profile Not Found", [System.Windows.Forms.MessageBoxButtons]::OK)
        # Reset profile options
        $comboProfileName.Text = ""
        $textMouseMultiplier.Text = ""
        $textMouseMultiplier.Text = "Default Versus multiplier: 6.0"
        $textMouseMultiplier.ForeColor = [System.Drawing.Color]::Gray
        $comboScreenResolution.SelectedIndex = 4

        # Refresh profile list
        $comboProfileName.Items.Clear()
        $profileFiles = Get-ChildItem -Path $dirPath -Filter "*_prf.ini"
        foreach ($file in $profileFiles) {
            $profileName = $file.BaseName -replace "_prf$", ""
            if ($profileName -ne "dedicated_server") {
                $comboProfileName.Items.Add($profileName) | Out-Null
            }
        }

        # If the profile list is empty, adjust the dropdown height
        if ($comboProfileName.Items.Count -eq 0) {
            $comboProfileName.DropDownHeight = 1
        } else {
            $comboProfileName.DropDownHeight = 150
        }
    }
}

$form.Add_FormClosing({
    [Console.Window]::ShowWindow($console, 1) | Out-Null
})

$form.Add_Shown({ Load-Profiles })
[void]$form.ShowDialog($topmost)