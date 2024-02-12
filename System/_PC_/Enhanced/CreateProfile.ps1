# Enhanced SCCT Versus - Create Profile by Joshhhuaaa
# This script is used for creating profiles in Enhanced SCCT Versus v3.0+.
# To offer players more control over mouse settings, a manual script is required.
# Unfortunately, the in-game profile creation cannot generate the necessary config files correctly.

# Sets console to display white text on a black background
function Set-ConsoleColor ($bc, $fc) {
    $Host.UI.RawUI.BackgroundColor = $bc
    $Host.UI.RawUI.ForegroundColor = $fc
    Clear-Host
}
Set-ConsoleColor 'Black' 'White'

# Mouse Multiplier
function DisplayMouseMultiplierPrompt {
    Write-Host "`nEnter your desired mouse multiplier (e.g., 1.250000). For default Versus multiplier, use 6.0."
}

# Screen Resolution
function DisplayScreenResolutionPresets {
    Write-Host "`nEnter your desired screen resolution preset (0-10):" -ForegroundColor White
    Write-Host "    0  - 640x480" -ForegroundColor Yellow
    Write-Host "    1  - 800x600" -ForegroundColor White
    Write-Host "    2  - 1024x768" -ForegroundColor Yellow
    Write-Host "    3  - 1280x1024" -ForegroundColor White
    Write-Host "    4  - 7680x4320 (Safe option, native resolution, supports up to 8K)" -ForegroundColor Yellow
    Write-Host "    5  - 1440x1080" -ForegroundColor White
    Write-Host "    6  - 1920x1080" -ForegroundColor Yellow
    Write-Host "    7  - 1920x1440" -ForegroundColor White
    Write-Host "    8  - 2560x1440" -ForegroundColor Yellow
    Write-Host "    9  - 2880x2160" -ForegroundColor White
    Write-Host "    10 - 3840x2160" -ForegroundColor Yellow
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

Write-Host "Enhanced SCCT Versus - Create Profile"

do {
    # Profile name
    Write-Host "`nEnter your profile name. Use only numbers, letters, _ and - with a 15 character maximum."
    $profileName = Read-Host "Profile Name"

    # Checking if profile name meets conditions
    if ($profileName -match "^[a-zA-Z0-9_-]{1,15}$") {
        # Profile directory path
        $dirPath = "C:\ProgramData\Ubisoft\Tom Clancy's Splinter Cell Chaos Theory\Saved Games\Versus"

        # Creating the profile directory if it doesn't exist yet
        if (!(Test-Path -Path $dirPath)) {
            New-Item -ItemType Directory -Path $dirPath | Out-Null
        }

        # File names
        $fileNames = @("${profileName}_prf.ini", "${profileName}_kbd_0.ini", "${profileName}_kbd_1.ini")

        # Checking if the profile already exists
        $profileExists = $false
        foreach ($fileName in $fileNames) {
            $filePath = Join-Path -Path $dirPath -ChildPath $fileName
            if (Test-Path -Path $filePath) {
                $profileExists = $true
                break
            }
        }

        # If the profile exists, ask if they would like to changes to their current profile
        if ($profileExists) {
            $validResponse = $false
            while (-not $validResponse) {
            Write-Host "`nA profile with that name already exists. Do you want to make changes to this profile? (Yes/No)"
            $profileEdit = Read-Host

            if ($profileEdit.ToLower() -eq "yes") {
                # Mouse Multiplier
                DisplayMouseMultiplierPrompt

                do {
                    $mouseSpeed = Read-Host "Mouse Multiplier"
                    if ($mouseSpeed -match "^\d+(\.\d+)?$") {
                        $mouseSpeed = "{0:N6}" -f [math]::Round([double]$mouseSpeed, 6)
                        $validInput = $true
                    } else {
                        Write-Host "`nInvalid mouse multiplier."  -ForegroundColor Red
                        DisplayMouseMultiplierPrompt
                        $validInput = $false
                    }
                } while (-not $validInput)

                # Screen Resolution
                DisplayScreenResolutionPresets

                do {
                    $screenResolution = Read-Host "Screen Resolution"
                    if ($screenResolution -match "^\d+$" -and [int]$screenResolution -ge 0 -and [int]$screenResolution -le 10) {
                        $validInput = $true
                    } else {
                        Write-Host "`nInvalid screen resolution."  -ForegroundColor Red
                        DisplayScreenResolutionPresets
                        $validInput = $false
                    }
                } while (-not $validInput)

                # Keeps settings from current profile, only adjust mouse multiplier and screen resolution
                foreach ($fileName in $fileNames) {
                $filePath = Join-Path -Path $dirPath -ChildPath $fileName

                    # Check if keybind files exist
                    if (Test-Path $filePath) {
                        $content = Get-Content $filePath

                        # Check if the file is _kbd_0 or _kbd_1 and update mouse multiplier
                        if ($fileName -match '_kbd') {
                            if ($content -match 'IK_MouseX=Axis aMouseX Speed=(\d+(\.\d+)?)?.*') {
                                $content = $content -replace 'IK_MouseX=Axis aMouseX Speed=(\d+(\.\d+)?)?.*', "IK_MouseX=Axis aMouseX Speed=$mouseSpeed"
                            } elseif ($content -match 'IK_MouseX=.*') {
                                $content = $content -replace 'IK_MouseX=.*', "IK_MouseX=Axis aMouseX Speed=$mouseSpeed"
                            } else {
                                $content += "IK_MouseX=Axis aMouseX Speed=$mouseSpeed"
                            }

                            if ($content -match 'IK_MouseY=Axis aMouseY Speed=(\d+(\.\d+)?)?.*') {
                                $content = $content -replace 'IK_MouseY=Axis aMouseY Speed=(\d+(\.\d+)?)?.*', "IK_MouseY=Axis aMouseY Speed=$mouseSpeed"
                            } elseif ($content -match 'IK_MouseY=.*') {
                                $content = $content -replace 'IK_MouseY=.*', "IK_MouseY=Axis aMouseY Speed=$mouseSpeed"
                            } else {
                                $content += "IK_MouseY=Axis aMouseY Speed=$mouseSpeed"
                            }
                        }

                        # Check if the file is _prf and update screen resolution
                        if ($fileName -match '_prf') {
                            if ($content -match 'ScreenRes=\d+') {
                                $content = $content -replace 'ScreenRes=\d+', "ScreenRes=$screenResolution"
                            } else {
                                $content += "`nScreenRes=$screenResolution"
                            }
                        }
                        $content | Set-Content $filePath
                    } else {
                        # If a keybind file doesn't exist, generate a new one with the updated mouse multiplier
                        if ($fileName -match '_kbd') {
                            Generate-ProfileKeybinds $filePath $mouseSpeed
                        }
                    }
                }

                Write-Host "`nProfile updated with new mouse multiplier and screen resolution..."
                Start-Sleep -Seconds 1
                return
            } elseif ($profileEdit.ToLower() -eq "no") {
                Write-Host "`nProfile update cancelled."
                Start-Sleep -Seconds 1
                return
            } else {
                Write-Host "`nInvalid input." -ForegroundColor Red
            }
        }
    }

        # New profiles
        # Mouse Multiplier
        DisplayMouseMultiplierPrompt

        do {
            $mouseSpeed = Read-Host "Mouse Multiplier"
            if ($mouseSpeed -match "^\d+(\.\d+)?$") {
            $mouseSpeed = "{0:N6}" -f [math]::Round([double]$mouseSpeed, 6)
            $validInput = $true
            }
            else {
                Write-Host "`nInvalid mouse multiplier."  -ForegroundColor Red
                DisplayMouseMultiplierPrompt
                $validInput = $false
            }
        } while (-not $validInput)

        # Screen Resolution
        DisplayScreenResolutionPresets

        do {
            $screenResolution = Read-Host "Screen Resolution"
            if ($screenResolution -match "^\d+$" -and [int]$screenResolution -ge 0 -and [int]$screenResolution -le 10) {
                $validInput = $true
            } else {
                Write-Host "`nInvalid screen resolution."  -ForegroundColor Red
                DisplayScreenResolutionPresets
                $validInput = $false
            }
        } while (-not $validInput)

    # Creating profile configuration files
    $fileNames = @("${profileName}_prf.ini", "${profileName}_kbd_0.ini", "${profileName}_kbd_1.ini")

    foreach ($fileName in $fileNames) {
        $filePath = Join-Path -Path $dirPath -ChildPath $fileName
        if ($fileName -match '_prf') {
            Generate-ProfilePreferences $filePath $screenResolution
        } elseif ($fileName -match '_kbd') {
            Generate-ProfileKeybinds $filePath $mouseSpeed
        }
    }

    Write-Host "`nSaving profile..."
    Start-Sleep -Seconds 1
    break
} else {
    Write-Host "`nInvalid profile name.`n"
    }
} while ($true)