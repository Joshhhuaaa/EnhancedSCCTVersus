# Enhanced SCCT Versus Patch Notes

### Gameplay
- Spies no longer faintly appear in EMF Vision, often called EMF ghosting, when not using any equipment.
- Spies no longer have adrenaline when being damaged allowing them to move faster for a short period. This eliminates major lag when Spies get shot at off-host.
- Improved Mercenary movement to prevent accidentally performing a Berserk if moving forward.
- Spies and Mercenaries no longer have inconsistent damage values depending on which side of the body was hit.
- Adjusted the Mercenary crosshair to align more closely with the center of the screen.
- Submachine Gun’s rate of fire has been reduced from 0.09 to 0.12.
- Submachine Gun's visual recoil has been reduced.
- Proxy Mines' minimum detected velocity (140) have been raised to the Xbox version's value (200). This eliminates a rare bug that causes Proxy Mines to explode even when sneaking.
- Presence Detectors scan every 1 second instead of 3 second intervals. A sound is no longer played when the scan occurs.
- Sticky Cam and Cam Net views now require less force to rotate, this improves lower Mouse Multipliers and allows for more precision in those camera modes.
  
### Audio
- The following sounds are no longer audible for more stealthy gameplay:
  - Using medical kits
  - Equipping the Shocker Gun without laser
  - Spies' goggles when switching vision modes
  - Crouched or sneaking footsteps
  - Soft landings on standard surfaces
  - Ledge climbing / shimmy
  - Pole / Ladder climbing
  - Back to wall animation
  - Activating Camo Suit

### Miscellaneous
- Players can now adjust their [Mouse Multiplier](MouseMultiplier.md) in their profile configuration files, providing greater sensitivity control, sometimes resulting in less pixel skipping and negative acceleration.
  - Creating profiles in-game is no longer supported. To create a profile, run the `CreateProfile.cmd` script in the System folder. You can also modify an existing profile's Mouse Multiplier and Screen Resolution in the script.
  - Existing profiles from Enhanced versions prior to 3.0 or default Versus remain functional and use the default Mouse Multiplier of 6.0.
- ESRB Notice on startup has been disabled to speed up boot time.
- The longer lobby music from the Xbox version has been restored.
- In Video Options, 1600x1200 is replaced with "Native Resolution" as the highest preset resolution choice, supporting up to 8K.
  - For users facing issues with Native Resolution detection or preferring a 4:3 aspect ratio, the profile configuration file now supports new Screen Resolution presets.

| ScreenRes | Resolution            |
|-----------|-----------------------|
| 0         | 640x480               |
| 1         | 800x600               |
| 2         | 1024x768              |
| 3         | 1280x1024             |
| 4         | 7680x4320 / Native    |
| 5         | 1440x1080             |
| 6         | 1920x1080             |
| 7         | 1920x1440             |
| 8         | 2560x1440             |
| 9         | 2880x2160             |
| 10        | 3840x2160             |

- dgVoodoo2 and 3D-Analyze comes included to fix dynamic lighting such as the Mercenary’s flashlight.
  - By default, the game will be installed as a dgVoodoo2 build. If you would like to switch between dgVoodoo2 or 3D-Analyze, run the command script, `ConvertBuild.cmd` in the System folder.
- Framer included in the game directory to easily remove the 30 FPS restriction.
- EAX can easily be restored into the game using the `eax_restore.reg` script in the System folder.
- Profiles can easily be accessed using the shortcut added in the System folder.
- Improvements to the automated `ChaosTheory.log` format.

### Maps
- Enhanced versions of all exclusive Pandora Tomorrow maps (Cinema, Krauser Lab, Mount Hospital, Schermerhorn, Vertigo Plaza) and Enhanced Sanctuary have been added to the map pool.
- All the Pandora Tomorrow UMP maps, Sanctuary, Skyscraper, and Terminus have been added to the map pool.
---
- Enhanced Aquarius:
  - Added a pole in the Spies’ insertion point to solely access Tech Room.
  - Spies can now climb back up to their insertion point from the Tech Room ceiling vents.
  - The fish tank containing a disk objective can no longer be refilled.
  - The balcony overlooking Pirates’ Room can now be climbed by Spies.
  - *Bug fixed:* Added a skybox to the exterior to prevent grenades from being bounced from the "roof" of outside.
  - *Bug fixed:* One of Pirates' Room beams was shifted to fix a small gap.
---
- Enhanced Cinema:
  - Based on the map foundation from Pandora Tomorrow.
  - All computer objectives have been raised to 12 seconds to neutralize.
  - Added a new disk objective in the Entry that must be captured in the Lobby.
  - A new medical kit is located in the Entry.
  - The ammo stock located in the Lobby’s 1st floor has been relocated to the other corner to make the climbable pole easier to access.
  - Cam. Net. support added with new cameras located in the Lobby and Video Games area.
  - *Bug fixed:* All motion sensors have been adjusted correctly to allow for sneak walk movement.
---
- Enhanced Club House:
  - The computer objectives located in the back of each floor have been adjusted to 12 seconds to neutralize.
  - Added a pole near the glass structure area.
  - *Bug fixed:* A visual bug near the glass structure area when the floors were destroyed on the first floor.
  - *Bug fixed:* Map sound package now includes objective interruption, win, and lose sounds.
---
- Enhanced Factory:
  - The Cam. Net.'s located in objective rooms have been removed, only the corridors are available.
  - Spies can no longer climb back up to Main Hall's coop objective once dropping into the room located behind the PC.
  - The explosive barrels located in the Machine Room no longer cause a major explosion.
  - The corner vent has been removed near the bottom Machine Room objective.
  - Spies can now open Corridor B’s door on both sides.
  - The mechanical digger has been raised to 5 seconds to activate.
  - Transformer Room's electric currents damage players 25 hit points per second instead of instantly killing players.
  - A new ladder is located on the side of the Mechanical Digger Room objective's structure.
  - A new ladder bridge at the top Mechanical Digger Room ledge has been added.
  - Mechanical Digger Room’s lights duration has been increased to 90 seconds when the generators are activated.
  - *Bug fixed:* Interactable objects in the Machine Room and Mechanical Digger Room incorrectly display "Security failure" on the HUD when chaffed, despite having no chaff effect.
---
- Enhanced Krauser Lab:
  - Based on the map foundation from Pandora Tomorrow.
  - Removed various security from Pandora Tomorrow that were unnecessary.
  - Time limit has been reduced to 10 minutes
  - Warehouse’s security has been reworked with each computer objective having two lasers from the top platform.
  - Removed the lasers surrounding Laboratory’s entrance and only have ceiling lasers guarding the computer objective.
  - Irradiation’s computer objectives have been shifted out of their chambers so Spies can have an easier time escaping.
  - An one-way escape exit can be used from Irradiation into the Parking Lot has been added. Mercenaries can use the new path both ways.
  - Cam. Net. support added with new cameras located in the Entrance, Parking Lot, and Irradiation.
  - *Bug fixed:* The explosive barrels now have a shorter range but lethal blast radius. Originally, they would only knock out people, however charging into a barrel that is not lethal would cause a bug where Mercenaries were permanently sleeping.
---
- Enhanced Missile Strike:
  - Map has been adjusted to 4 Spy lives and 3 Mercenary lives.
  - Hacking panels located in the Spies insertion point have been reduced from 10 seconds to 5 seconds.
  - In Sector 1, the second floor catwalks can no longer be shot through to secure the bombs.
  - Boxes around the East Control Panel objective have been shifted to prevent securing it from the center bunker.
  - Central Shaft, Light Corridor, and Generator's hacking panels now display a "Hacking in Progress..." message instead of directly exposing what the Spy is hacking.
  - In Sector 2, Spies must only capture one of the four disks to gain access to the Silo.
  - *Bug fixed:* Central Shaft interaction for Mercenaries could be spammed resulting in the door and its alarm message to become desynchronized.
---
- Enhanced Mount Hospital:
  - Based on the map foundation from Pandora Tomorrow.
  - All computer objectives have been raised to 12 seconds to neutralize.
  - Room 116’s room layout has been reworked to make it easier to defend.
  - Room 208 has been opened to make it easier to rotate around the second floor.
  - All motion sensors have been removed in the rooms.
  - A laser has been added for the Nursery vent.
  - A new medical kit is located in the Spy insertion point.
  - Cam. Net. support added with new cameras located in the 1st and 2nd floor hallways.
---
- Enhanced Museum:
  - The Cafe computer objectives have been reduced to 12 seconds to neutralize.
  - All door entrances leading into Storage are only accessible to the Mercenaries.
  - If Café Outside is neutralized, the door entrances leading to Storage will unlock in Exhibition.
  - If Café Inside is neutralized, the door entrances leading to Storage will unlock in Monolith.
  - *Bug fixed:* Removed the glass panels in Cafe Inside to prevent an exploit where Mercenaries can see Spies in Motion Vision through the ceiling.
  - *Bug fixed:* Spies in the Monolith vents could be seen from Cafe's outside fake backdrop material.
---
- Enhanced Orphanage:
  - Cam. Net. has been completely redesigned with five new ones: two located in first and second floor’s hallways and one in the courtyard.
  - Sector 2 spawn points do not activate until 10 seconds after Sector 1 has been bombed.
  - The elevators are now a one-click interaction.
  - The connector vent between Laundry and Storage has been removed.
  - The Storage vent leading to the Dormitory has been removed.
  - The Washroom vent located near the computer objective has been removed.
  - The Washroom vent located on the ceiling has been removed. 
  - A motion sensor located in the ceiling of Canteen has been removed.
  - A motion sensor located in the ceiling of Canteen has been relocated to detect both routes in the vent.
  - The drop zone has been repositioned with cover to protect spies.
  - *Bug fixed:* In Sector 1, when the bomb objectives exploded, they would kill players in their blast radius longer than the explosion visual effect.
  - *Bug fixed:* Added elevated ramps to the vents at the entrances to prevent an exploit where Mercenaries could neutralize Spies through the floor.
  - *Bug fixed:* In the Classroom hallway, one of the furniture dust covers was missing its EMF/Thermal texture.
  - *Bug fixed:* In Visit a Map, the first tip would remain on screen after leaving its radius.
---
- Enhanced Polar Base:
  - Generators have been reduced to 25 seconds to neutralize.
  - The doors to access Drilling Tower’s drop zone have been reduced to 2 seconds.
  - Removed 4 of the 8 medical kits as this map has too many for no good reason. The 4 medical kits that remain: Spy spawn, Mercenary spawn, Drilling Tower, and the one near Life Zone.
  - Drilling Tower’s right balcony has been raised to prevent Spies from auto jumping off.
  - *Bug fixed:* Security lasers have been corrected to disable the correct objectives.
  - *Bug fixed:* Spies should be able to properly snap a Mercenary's neck around the Generators area.
  - *Bug fixed:* Door behavior for Life Zone and Drilling Tower's drop zone have been changed so if bumped, the door will retry to close itself instead of staying open.
  - *Bug fixed:* Several container boxes were intersecting into pillars and other geometry around Hangar and Drilling Tower.
  - *Bug fixed:* Small collision fix between two meshes in the Drilling Tower drop zone room.
---
- Enhanced River Mall:
  - Spy Insertion Point has been reworked to allow for faster entry into the map.
  - The Offices area has been reworked to allow for faster rotation and preventing Spies from jumping out the window.
  - The computer objective located in the Offices has been relocated to the adjoining room.
  - A new vent has been added on the Video Games side of the Spy Insertion Point.
  - The vent located near the Hi-Fi 2nd Floor objective has been shortened.
  - *Bug fixed:* Hi-Fi Curtains interaction would no longer work if reactivated before the curtains were finished transitioning.
  - *Bug fixed:* Small collision fix on the glass doors that would allow players to shoot through the edges of them.
---
- Enhanced Schermerhorn:
  - Based on the map foundation from Pandora Tomorrow.
  - Removed various security from Pandora Tomorrow that were unnecessary.
  - All computer objectives have been raised to 12 seconds to neutralize.
  - Added a new disk objective in the Tech Room that must be captured in the Station or Water Tank.
  - The hacking panels that open the doors to Water Tank have been reduced to 4 seconds.
  - The computer located in the Water Tank Corridor has been relocated to the opposite wall to allow the Spies to have an easier escape.
  - The intractable buttons that opened and closed the Water Tank Corridor gates have been removed.
  - The security camera hack in the Tech Room has been removed.
  - Cam. Net. support added with new cameras located in the Station and Water Tank.
  - *Bug fixed:* The explosive barrels now have a shorter range but lethal blast radius. Originally, they would only knock out people, however charging into a barrel that is not lethal would cause a bug where Mercenaries were permanently sleeping.
---
- Enhanced Station:
   - Time limit has been reduced to 10 minutes, lives adjusted to 4 Spy lives and 3 Mercenary lives.
   - Parking lot jacks have been reduced to 20 seconds to neutralize.
   - Parking lot jacks door has been decreased from 3 seconds to 0 seconds.
   - Train Maintenance’s entrance doors now open once Spies neutralize the first mission objective.
   - Train Maintenance doors leading to each computer objective has been decreased from 3 seconds to 0 seconds.
   - A new medical kit is located in Train Maintenance.
   - *Bug fixed:* One of the coops in the Streets could not be sniped through the grills.
   - *Bug fixed:* The metal vents above Checkpoint will no longer create dust when moving fast in them.
---
- Enhanced Steel Squat:
  - A new mercenary spawn point located on the third floor for the start of the game has been added. It will only be enabled initially, it is disabled for future respawns.
  - One of the mercenaries is guaranteed an outside spawn point.
  - All computer objectives have been raised to 10 seconds to neutralize.
  - The Secret Files disk resets in 15 seconds after being dropped.
  - The shutters hacking panels have been raised to 4 seconds.
  - The Restaurant shutters have been relocated to the second floor.
  - The Laboratory area has been reworked to allow for faster rotation.
  - Secret Files hatch wraps around the boss's office instead of being a route to the connector building.
  - *Bug fixed:* Chaffing the Shop ceiling lights would cause the mesh to disappear.
---
- Enhanced Vertigo Plaza
  - Based on the map foundation from Pandora Tomorrow.
  - Removed various security from Pandora Tomorrow that were unnecessary.
  - Time limit has been reduced to 10 minutes.
  - All computer objectives have been lowered to 15 seconds to neutralize.
  - The hacking panels that open doors around the map have been reduced to 3 seconds.
  - Doors no longer have to be hacked if trying to leave the building from the inside.
  - Each bridge coming from the central building contains a new horizontal lift to make rotations faster for Mercenaries.
  - The arches on the top of each bridge have been removed to make rotations faster for Spies.
  - Cam. Net. support added with new cameras located on the Helipad.
  - *Bug fixed:* Collision missing on door frames which allowed gameplay objects be placed inside them.
