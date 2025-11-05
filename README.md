# ThresholdUI

ThresholdUI is a lightweight, scriptable graphical user interface package for Mudlet (a MUD client). It provides a set of Lua scripts, GUI components, and packaged builds to add customizable HUD and meter features to your Mudlet profile.

## Key features

- Modular Lua-based GUI components (see `src/scripts/GUI/`)
- Timers, styles, and event handlers for in-game thresholds and meters
- Packaged build in `build/ThresholdUI.mpackage` for easy import into Mudlet

## Repository layout

- `src/` - source Lua scripts and supporting assets used during development
  - `scripts/` - core scripts (connection, event handlers, timers, styles)
  - `scripts/GUI/` - GUI components and containers loaded by the scripts
  - `aliases/` - example aliases and helper scripts
  - `resources/` - bundled assets such as images and preference defaults
- `package.json` - project metadata; may include build/tooling configuration
- `mfile` - Mudlet package manifest used when exporting

> **Note:** Historical references to `build/`, `tmp/`, or `filtered/` directories refer to paths that are generated during packaging and are not checked into the repository. Packaging tools will create them when you run the export workflow.

## Installation

1. Import a packaged release: open Mudlet and import the generated `ThresholdUI.mpackage` or `ThresholdUI.xml` (produced by the export workflow in the `build/` directory).
2. Alternatively, copy the relevant `src/` Lua files into your Mudlet profile's scripts directory.

After installing, restart Mudlet or reload your profile to ensure scripts initialize correctly.

## Development

- Edit source files in `src/`. The primary entry points are in `src/scripts/` and `src/scripts/GUI/`.
- When exporting a package, Mudlet (or related tooling) will create a `build/` directory containing distributable `.mpackage` and `.xml` files.
- If your workflow uses temporary testing outputs, keep them outside the repository or ensure they are ignored via tooling configuration.

## Contributing

Contributions are welcome. Open issues or pull requests with a clear description of changes. When submitting code, prefer small focused commits and include brief tests or usage notes when relevant.

## License

This repository is released into the public domain under the Unlicense. See `UNLICENSE.txt` for the full text.

---

If anything in this README is unclear or you want help importing the package into Mudlet, open an issue with details about your Mudlet version and what you tried.
