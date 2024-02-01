# Mouse Multiplier

Starting from version 3.0, Enhanced SCCT Versus allows players to customize their Mouse Multiplier directly within the profile configuration files.

## How to Adjust Your Mouse Multiplier

You can modify your Mouse Multiplier using the `CreateProfile.cmd` script in the System folder or by manually editing your profile config file with a text editor.

## Automated Script
- Whether you already have a profile or need to create a new one, use `CreateProfile.cmd` and enter your profile name when prompted. For existing profiles, simply type the name of the existing profile.
- You will be prompted to adjust your Mouse Multiplier. Existing profiles from earlier Enhanced versions or default Versus use the default Mouse Multiplier of 6.0.

 <img src="Images/CreateProfile.png" width="768">

## Manual Edit
- Access the Saved Games directory using the included shortcut `_Profiles_` in the System folder or navigate to: `C:\ProgramData\Ubisoft\Tom Clancy's Splinter Cell Chaos Theory\Saved Games\Versus`.
- Open your profile's keyboard configuration files: `<profilename>_kbd_0.ini` and `<profilename>_kbd_1.ini`.
  - If you switch control layouts per team: _kbd_0 corresponds to Key 1 in-game, and _kbd_1 corresponds to Key 2.
- Adjust your `IK_MouseX` and `IK_MouseY` speed values to your desired Mouse Multiplier.

For example, changing your Mouse Multiplier to 0.5:
```
[Engine.Input]
IK_MouseX=Axis aMouseX Speed=0.500000
IK_MouseY=Axis aMouseY Speed=0.500000
```

## Recommendations
- It is strongly advised not to exceed 6.0, the benefits of adjusting the multiplier come from lowering it. Enter any number up to 6 decimal places, and the script will round it if needed.
- For a significant reduction in pixel skipping, try using a Mouse Multiplier within 0.1 to 1.0. It is recommended pairing this with an in-game Mouse Sensitivity of 40.
- Mouse Sensitivity of 40 in-game appears to have significantly less negative acceleration. Therefore, aim to find a Mouse Multiplier between 0.1 to 1.0 that feels comfortable while using an in-game Mouse Sensitivity of 40. You can always adjust your mouse DPI to compensate with no negative effects if necessary.


**Note: Mouse Sensitivity of 40 in-game will not feel good on the default Mouse Multiplier of 6.0 and may result in significant pixel skipping. It is only recommended to use an in-game Mouse Sensitivity of 40 if you can keep your multiplier under 1.0.**
