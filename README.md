# Omarchy System Stats Widget

A clean, Waybar-style system statistics widget for the Omarchy Linux desktop shell. 

## Features
- **Temperature**: Shows CPU package temperature (`sensors`).
- **Power Profile**: Shows current power profile (`powerprofilesctl`).
- **CPU**: Shows CPU usage percentage.
- **Memory**: Shows RAM usage percentage.
- **Disk**: Shows root filesystem (`/`) usage.
- **Uptime**: Shows system uptime.

## Installation

Omarchy plugins can be installed simply by copying the folder into your `~/.config/omarchy/plugins/` directory.

```bash
# Copy to plugins directory
cp -r . ~/.config/omarchy/plugins/system-stats

# Ensure the script is executable
chmod +x ~/.config/omarchy/plugins/system-stats/stats.sh
```

## Configuration

To add the widget to your bar, edit your `~/.config/omarchy/shell.json` and add `{"id": "system-stats"}` to the `right` section (or wherever you prefer).

```json
      "right": [
        {
          "id": "system-stats"
        },
        ...
```

The shell will automatically reload and display the widget.

## Requirements

- `lm_sensors` (for temperature)
- `power-profiles-daemon` (for power profile)
- `btop` (opens when clicking stats)
- `alacritty` (terminal for btop)

## Safety & Privacy

This plugin only reads standard Linux system statistics (`/proc/stat`, `/proc/uptime`, `free`, `df`, `sensors`) and does not collect, store, or transmit any personal information.
