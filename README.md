# Omarchy System Stats Widget

A clean, responsive, Waybar-style system statistics widget for the [Omarchy](https://github.com/omarchy/omarchy) Linux desktop shell. 

This widget provides at-a-glance system metrics directly in your Omarchy bar, complete with beautiful icons, color-coded health indicators, and interactive actions (such as opening `btop` for deeper inspection).

## Preview

<div align="center">
  <img alt="System Stats Widget Image Preview" src="https://github.com/user-attachments/assets/0acfbc27-50f1-4704-b072-dd10d0748971" width="800" />
</div>
<br>
<div align="center">
  <video src="https://github.com/user-attachments/assets/da213999-1a47-48d5-80b3-a005aacffdf9" width="800" title="System Stats Preview" autoplay loop muted playsinline></video>
</div>

## Installation

The recommended way to install this plugin is via the Omarchy CLI:

```bash
omarchy plugin add https://github.com/gurvindersingh-web/quickshellomarchy.git
```

*For manual installation: Download or clone this repository and place the folder in `~/.config/omarchy/plugins/gurvindersingh-web.system-stats`, then ensure `stats.sh` is executable (`chmod +x stats.sh`).*

## Removal

To remove the plugin, use the Omarchy CLI:

```bash
omarchy plugin remove gurvindersingh-web.system-stats
```

## Features

-  **Temperature**: Shows CPU package temperature (`sensors`). Click to view processes.
-  **Power Profile**: Shows current power profile (`powerprofilesctl`). Click to toggle profiles.
- 󰍛 **CPU**: Shows CPU usage percentage. Left click for `btop`, right click for a new terminal.
- 󰘚 **Memory**: Shows RAM usage percentage.
- 󰋊 **Disk**: Shows root filesystem (`/`) usage.
- 󰔚 **Uptime**: Shows system uptime cleanly formatted.

Each module automatically color-codes based on state (e.g., performance mode vs balanced mode), adding a cohesive and intuitive aesthetic to your desktop.

## Configuration

To add the widget to your bar, edit your `~/.config/omarchy/shell.json` and add `{"id": "gurvindersingh-web.system-stats"}` to the `right` section (or wherever you prefer to place it).

```json
{
  "bar": {
    "layout": {
      "right": [
        {
          "id": "gurvindersingh-web.system-stats"
        }
      ]
    }
  }
}
```

The shell will automatically reload and display the widget instantly.

## Requirements & Dependencies

To ensure all metrics display correctly, please ensure the following dependencies are installed on your system:

- `lm_sensors` (required for temperature reading)
- `power-profiles-daemon` (required for power profile management)
- `btop` (default task manager opened when clicking stats)
- `alacritty` (default terminal for opening `btop`)

*Note: If a tool is missing (e.g. `sensors`), the widget will gracefully fallback to displaying `N/A` without breaking your bar.*

## Safety & Privacy

This plugin only executes standard, local Linux system diagnostic commands (`/proc/stat`, `/proc/uptime`, `free`, `df`, `sensors`) and does not collect, store, or transmit any personal information or telemetry over the internet.

## License

This project is licensed under the [MIT License](LICENSE).
