# ThresholdUI

ThresholdUI is a lightweight, scriptable graphical user interface package for Mudlet (a MUD client). It provides a set of Lua scripts, GUI components, and packaged builds to add customizable HUD and meter features to your Mudlet profile.

## Key features

- Modular Lua-based GUI components (see `src/GUI/`)
- Timers, styles, and event handlers for in-game thresholds and meters
- Packaged build in `build/ThresholdUI.mpackage` for easy import into Mudlet

## Repository layout

- `src/` - source Lua scripts and GUI modules used during development
  - `scripts/` - core scripts (connection, event handlers, timers, styles)
  - `GUI/` - GUI components and containers
  - `aliases/` - example aliases and helper scripts
- `build/` - output packages and XML used for distribution (`ThresholdUI.mpackage`, `ThresholdUI.xml`)
- `tmp/` - temporary files and generated preferences used while testing
- `filtered/` - filtered build artifacts (internal packaging scaffolding)
- `package.json` - project metadata; may include build/tooling configuration

## Installation

1. Import the provided package: open Mudlet and import `build/ThresholdUI.mpackage` or `build/ThresholdUI.xml` using Mudlet's package import UI.
2. Alternatively, copy the relevant `src/` Lua files into your Mudlet profile's scripts directory.

After installing, restart Mudlet or reload your profile to ensure scripts initialize correctly.

## Development

- Edit source files in `src/`. The primary entry points are in `src/scripts/` and `src/scripts/GUI/`.
- Use the files in `tmp/` during iterative testing inside Mudlet.
- The `build/` folder contains packaged outputs for distribution. If you maintain automated packaging, check `package.json` or project-specific build scripts for tooling details.

## Contributing

Contributions are welcome. Open issues or pull requests with a clear description of changes. When submitting code, prefer small focused commits and include brief tests or usage notes when relevant.

## License

This repository is released into the public domain under the Unlicense. See `UNLICENSE.txt` for the full text.

---

If anything in this README is unclear or you want help importing the package into Mudlet, open an issue with details about your Mudlet version and what you tried.
