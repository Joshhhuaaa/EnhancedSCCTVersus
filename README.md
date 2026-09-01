# <img src="Images/icon.png" width="32"> Enhanced SCCT Versus
A major patch for Splinter Cell: Chaos Theory's Versus mode, fixing bugs and exploits while improving gameplay and map balance.

Thanks to AllyPal (NoFrameLimit) for contributing to various fixes and improvements in Enhanced SCCT Versus with the [SCCT Versus Reloaded](https://allypal.github.io/SCCT_Versus_Reloaded) patch.

For a full list of patch notes, refer to the [Patch Notes](PatchNotes.md) page.

When playing on dedicated servers, your performance is automatically tracked. You can view your performance, analyze game statistics, and browse available game sessions through the [SC Panel](https://sc-panel.com/).

[![Discord](https://img.shields.io/discord/934536491420508281?color=%237289DA&label=Members&logo=discord&logoColor=white)](https://discord.gg/rmBp94uR58)

## Installation
The latest version of Enhanced SCCT Versus can be found in the [Releases](https://github.com/Joshhhuaaa/EnhancedSCCTVersus/releases) page. Please note that versions of Enhanced SCCT Versus are not compatible with the default version of the game or previous Enhanced versions.

### Game Setup
- After downloading Enhanced SCCT Versus, extract the contents. You will then have an Enhanced SCCT Versus folder, which you can place anywhere you like since it's portable.
- Run the game executable, `SCCT_Versus.exe` located in the System folder to begin playing.
- Open the Reloaded settings in-game with <kbd>F12</kbd> or <kbd>Ctrl</kbd> + <kbd>O</kbd> hotkeys.
- You can adjust additional settings in `SCCT_Versus.config` located in the System folder.

> [!IMPORTANT]
> If experiencing an error on startup, you likely need to install [Microsoft Visual C++ 2015-2022 Redistributable (x86)](https://aka.ms/vs/17/release/vc_redist.x86.exe)

> [!WARNING] 
> Players located in Russia may experience issues connecting to the master server and dedicated servers due to ISP-level blocking. As a result, available dedicated servers may not appear unless a VPN is used.
> 
> As an alternative to using a VPN, you can manually add the following IP addresses to the `server_list` entry and replace the existing `master_server_dns` value in `SCCT_Versus.config`. These servers act as relays for both the master server and dedicated servers, allowing sessions to appear and connect in-game.
>
> ```
> "server_list": [
>     "138.124.26.105:10776",
>     "138.124.26.105:19776",
>     "138.124.26.105:9776",
>     "138.124.26.105:11776",
>     "138.124.26.105:7776",
>     "138.124.26.105:17776",
>     "138.124.26.105:27776",
>     "138.124.26.105:37776",
>     "138.124.26.105:9001",
>     "138.124.26.105:27015"
>   ],
> ```
> 
> ```
>  "master_server_dns": "138.124.26.105",
> ```

## Playing Online
Ubisoft discontinued Chaos Theory's servers in April 2016. However, the multiplayer is still playable using a custom LAN master server or connecting directly to an IP address. 

LAN Sessions now have the functionality to connect over the internet via IP address or master server. No third-party programs are needed to play online.
 - Includes a LAN master server that will automatically find sessions hosted online.
 - To connect directly to a specific IP address, configure the IP address and port (default: 7776) in the `server_list` entry of `SCCT_Versus.config`.

### Server Commands
When hosting or playing on a server, you can use chat commands to adjust session parameters. Simply type them into the in-game text chat.

| Command          | Description                                                                |
| ---------------- | -------------------------------------------------------------------------- |
| `!map <mapname>` | Changes the current map to the specified one.                              |
| `!next`          | Skips to the next map in the server's rotation list.                       |
| `!prev`          | Returns to the previous map in the server's rotation list.                 |
| `!resign`        | Forfeits the current round by eliminating your remaining lives.            |

>[!NOTE]
> In dedicated servers, all players have permission to change the map. In listen servers, only the host can change the map.

#### Map Naming Convention
When using the `!map` command, maps are referenced by their file names: the first four letters of the map name, followed by a suffix for the variant.
- Aquarius: `AquaD`
- Enhanced Aquarius: `AquaE`
- UMP Mount Hospital: `MounU`

### Hosting a Game Session
When hosting a game session, if UPnP (Universal Plug and Play) is enabled on your router, a chat message will appear in the lobby indicating whether the ports have been successfully forwarded. However, if you prefer to keep UPnP disabled, you will need to manually port forward to allow other players to connect to your game:

| Protocol | Port  |
|----------|-------|
| UDP      | 7776  |
| UDP      | 8888  |

>[!TIP]
> You can use the console command `listed true` or `listed false` to control whether your server appears on the master server.

If there are conflicts within your network, you can adjust the port numbers by editing `host_port_game` and `host_port_query` in `SCCT_Versus.config`.

For additional help, refer to the [Hosting Guide](https://gist.github.com/Joshhhuaaa/6e4f8ff745f5fe5148d4d8b265fa6518) page.
