# media-brightness-toggle

An [AutoHotkey](https://www.autohotkey.com/) (v2) script that turns your keyboard's Media Play/Pause key into a toggle switch for your Volume Up/Down keys which lets them control your display brightness instead of the volume when enabled.

## How it works

- Press **Media Play/Pause** to switch betweeen two modes:
    - **Volume Mode** (default): Normal Volume Up/Down behavior
    - **Brightness Mode**: Volume Up/Down raise or lower your display brightness in steps of 10% instead of thanging the volume
- A small popup will appear on thee bottom-right corner of your screen each time you switch between modes, showing which mode is now active.
- Brightness mode automatically turns itself off while Fortnite is detected as running, since global hotkeys and third-party hooks can trip anti-cheat software. A warning popup with a sound is also shown wheen this happens.

## Requirements

- Windows with a monitor/driver that supports WMI brightness control (typically laptop displays or monitors with DDC/CI Support through Windows' built-in brightness API).
- [AutoHotkey](https://www.autohotkey.com/download/) (v2) installed.

## Installation

1. Install [AutoHotkey](https://www.autohotkey.com/download/) if you do not already have it.
2. Download `MediaBrightnessToggle.ahk` from this repository.
3. Double-click script to run (or right-click -> **Run Script**)

### Run on startup (optional)

To have the toggla available automatically:

1. Press `Win + R`, type `shell:startup`, and press Enter.
2. Copy `MediaBrightnessToggle.ahk` (or a shortcut to it) into the folder that opens.

## Usage
 
| Key | Action |
|---|---|
| **Media Play/Pause** | Toggle between Volume Mode and Brightness Mode |
| **Volume Up** | Increase volume (Volume Mode) / Increase brightness by 10% (Brightness Mode) |
| **Volume Down** | Decrease volume (Volume Mode) / Decrease brightness by 10% (Brightness Mode) |
 
The current mode is always shown in a temporary popup notification whenever you switch, so you never have to guess which mode you're in.
 
## Fortnite safety check
 
The script polls running processes every 2 seconds. If it detects `FortniteClient-Win64-Shipping.exe` (or its EAC/EOS variant), it automatically disables Brightness Mode and shows a persistent warning popup recommending you close AutoHotkey entirely while playing. This is a precaution — use anti-cheat-sensitive software at your own risk, and consider quitting AutoHotkey before launching any game with kernel-level anti-cheat.
 
## Customization
 
Open `MediaBrightnessToggle.ahk` in a text editor to tweak:
 
- **Brightness step size** — change the `+ 10` / `- 10` values in the `Volume_Up` / `Volume_Down` hotkeys.
- **Popup colors, icons, and duration** — edit the arguments passed to `ShowTogglePopup()` or the `SetTimer(ClosePopup, -2000)` line (in milliseconds).
- **Process check interval** — change the `2000` (ms) value in `SetTimer(CheckFortniteRunning, 2000)`.

## License
 
Licensed under the [MIT License](LICENSE).
