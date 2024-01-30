# Enhanced SCCT Versus
A major patch for Splinter Cell: Chaos Theory's Versus mode, addressing bugs, exploits, and enhancing gameplay and map balance.

## Installation

The latest version of Enhanced SCCT Versus can be found in the [Releases](https://github.com/Joshhhuaaa/EnhancedSCCTVersus/releases) page. Please note that versions of Enhanced SCCT Versus are not compatible with the default version of the game or previous Enhanced versions.

---

### dgVoodoo2 build [recommended]
This is the recommended build that we have people download. It comes included with [dgVoodoo2](https://github.com/dege-diosg/dgVoodoo2), a wrapper that can restore the broken dynamic lights on modern PCs for SCCT Versus.

- After downloading Enhanced SCCT Versus, extract the contents, and you should have a Enhanced SCCT Versus folder. You can place it anywhere you like, it's portable.
- Run the game executable, "SCCT_Versus.exe" in the System folder to begin playing. 

dgVoodoo2 offers smoother, less pixelated shadows than 3D-Analyze. However, some users experience an issue where their game starts tabbing out while clicking the mouse on dgVoodoo2. If that occurs, you can try using 3D-Analyze to fix the issue.

---

### 3D-Analyze build
This is an alternate build that uses 3D-Analyze to fix the broken dynamic lights on modern PCs. It is usually only recommended if having mouse issues with dgVoodoo2 or if you would like to use windowed mode.

- After downloading Enhanced SCCT Versus, extract the contents, and you should have a Enhanced SCCT Versus folder. You can place it anywhere you like, it's portable.
- Run the command script, "Play SCCT_Versus.cmd" to begin playing.

The command script is in the root directory, it configures and runs the game executable under 3D-Analyze to fix the lighting.

---

### dgVoodoo2, Widescreen build [experimental]
This is an experimental build designed to run the game in 16:9 resolution without stretching the image. The HUD has been fully scaled and repositioned to support 16:9.

- After downloading Enhanced SCCT Versus, extract the contents, and you should have a Enhanced SCCT Versus folder. You can place it anywhere you like, it's portable.
- Run the game executable, "SCCT_Versus.exe" in the System folder to begin playing.
- If needed, adjust your resolution using dgWidescreen.ini in the System folder.

#### Known Issues
The Widescreen build has several issues that will likely never be fixed, it is currently unsupported.
- To prevent stretching, this build zooms into the game while on a higher resolution than your native, adjusting the HUD to be in your view. As a result, the menu will be cropped.
- Due to zooming into the game, some of the user interface in-game will appear larger, including text chat messages, "Sleeping" text as Mercenary, and Enhanced Reality objective icons.
-  As a Mercenary, Sniper Mode's field of view is not scaled correctly to the original 4:3 image, it is too zoomed in.

---

### EAX Resotration (optional)
EAX enhances the game's audio using hardware acceleration to process advanced 3D environments. Since Windows Vista, Microsoft has stripped out the DirectSound3D API, preventing EAX from functioning.

- To restore EAX functionality, run the registry file, "eax_restore.reg" in the System folder and press "Yes" to the dialog to add the registry entries.

 This registry file registers `dsound.dll` in Windows, enabling EAX to function. Please note that this registry applies only to your specific Windows user. If you create a new Windows user, you'll need to run the registry file again to restore EAX.
