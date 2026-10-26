# ThresholdUI

A graphical interface for [Threshold RPG](https://www.thresholdrpg.com/) in Mudlet. It adds a status bar along the bottom of your screen that keeps your vitals, combat, and the game clock in view, all driven live by GMCP.

## What you get

- **Vitals** — HP, SP, and EP gauges. They dim while you're stunned or immobile.
- **Combat** — your foe's name and health, and who your foe is fighting.
- **Experience and shielding** — progress to your next level, plus a shielding gauge that appears only when you have shields up.
- **Meters** — capacity (C), tummy (T), heal bank (H), and regen tick (R).
- **Game clock** — the date, weekday, toll of the day, and current devotion on Threshold's calendar.
- **Rest timer** — a gently pulsing bar showing how long you've been resting, meditating, or trancing.
- **Psion feedback** — shock, net, mastery, and gaze indicators, shown only for characters that have them.

## Installation

## Primary

If you're logged in to Threshold:

1. Ensure that you hav GMCP enabled: `gmcp on`
2. Install the GUI: `gmcp gui`

## Alternative

1. Download `ThresholdUI.mpackage` from the [latest release](https://github.com/gesslar/ThresholdUI/releases/latest).
2. In Mudlet, open **Package Manager** and install the downloaded file.

ThresholdUI sets up GMCP with Threshold for you as soon as it's installed.

## Commands

| Command | What it does |
| --- | --- |
| `/regen on` / `regen off` | Show or hide the regen tick meter. |
| `/datetime on` / `datetime off` | Show or hide the game clock. |

Your choices are remembered between sessions and reinstalls.

## License

ThresholdUI is released under the [0BSD](https://opensource.org/license/0bsd).
