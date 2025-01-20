# <img src="Images/icon.png" width="32"> Enhanced SCCT Versus
A major patch for Splinter Cell: Chaos Theory's Versus mode, fixing bugs and exploits while improving gameplay and map balance.

Thanks to AllyPal for contributing to various fixes and improvements in Enhanced SCCT Versus with the [SCCT Versus Reloaded](https://allypal.github.io/SCCT_Versus_Reloaded) patch.

For a full list of patch notes, refer to the [Patch Notes](PatchNotes.md) page.

[![Discord](https://img.shields.io/discord/934536491420508281?color=%237289DA&label=Members&logo=discord&logoColor=white)](https://discord.gg/rmBp94uR58)

## Installation
The latest version of Enhanced SCCT Versus can be found in the [Releases](https://github.com/Joshhhuaaa/EnhancedSCCTVersus/releases) page. Please note that versions of Enhanced SCCT Versus are not compatible with the default version of the game or previous Enhanced versions.

### Game Setup
- After downloading Enhanced SCCT Versus, extract the contents. You will then have an Enhanced SCCT Versus folder, which you can place anywhere you like since it's portable.
- Run the game executable, `SCCT_Versus.exe` located in the System folder to begin playing.
- You can adjust additional settings in `SCCT_Versus.config` located in the System folder.

> [!IMPORTANT]
> If experiencing an error on startup, you likely need to install [Microsoft Visual C++ 2015-2022 Redistributable (x86)](https://aka.ms/vs/17/release/vc_redist.x86.exe)

## Playing Online
Ubisoft discontinued Chaos Theory's servers in April 2016. However, the multiplayer is still playable using a custom LAN master server or connecting directly to an IP address. 

Starting with Enhanced SCCT Versus v3.4, LAN Sessions now have the functionality to connect over the internet via IP address or master server. No third-party programs are needed to play online.
 - Includes a LAN master server that will automatically find sessions hosted online.
 - To connect directly to a specific IP address, configure the IP address and port (default: 7776) in the `serverList` entry of `SCCT_Versus.config`.

### Hosting a Game Session
When hosting a game session, if UPnP (Universal Plug and Play) is enabled on your router, a chat message will appear in the lobby indicating whether the ports have been successfully forwarded. However, if you prefer to keep UPnP disabled, you will need to manually port forward to allow other players to connect to your game:

| Protocol | Port  |
|----------|-------|
| UDP      | 7776  |
| UDP      | 8888  |

If there are conflicts within your network, you can adjust the port numbers by editing `host_port_game` and `host_port_query` in `SCCT_Versus.config`.
