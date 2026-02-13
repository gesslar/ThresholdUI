# ThresholdUI

A dark-themed, gold-accented HUD for Threshold RPG in Mudlet that displays your vitals, combat info, progression, and game clock in a persistent bottom-of-screen bar.

## Installation

In Threshold, type `gmcp gui` to install fresh or update to the latest version.

## Features Overview

### Vitals Gauges

Three horizontal bars on the left side showing your current and maximum values for:

- **HP** (Hit Points) - red
- **SP** (Spell Points) - blue
- **EP** (Endurance Points) - teal

When you are stunned or immobilized, all three bars dim to give you an immediate visual cue.

### Combat, XP, and Shielding

Three horizontal bars in the center showing:

- **Foe** - your current enemy's health percentage with their name displayed on the bar; also shows who the enemy is targeting if it isn't you
- **XP** - your experience progress to the next level as a percentage
- **Shield** - your magical shielding percentage; this bar only appears when shielding is active and hides when it is not

### Vertical Meters

Four thin vertical meters on the right side:

- **C** (Capacity) - how full your inventory is
- **T** (Tummy) - your hunger/fullness level
- **H** (HealBank) - your stored healing reserves
- **R** (Regen) - progress toward your next healing tick (can be toggled on/off)

### In-Game Date and Time

A small panel showing the in-game calendar clock, updated every second:

- Date (month/day/year)
- Day of the week (e.g. Coronea, Solus, Lunas)
- Time as an ordinal toll (e.g. "14th toll")
- Current devotion period

This panel can be toggled on/off.

### Inactive Timer

When you are resting, trancing, or meditating, a bar appears above the HUD showing how long you have been inactive (e.g. "You have been Trancing for 5m 32s") with a subtle breathing background animation.

### Psion Feedback

For psion players, a row of four indicators appears above the HUD showing the state of your feedback abilities: **shock**, **net**, **mastery**, and **gaze**. Each indicator lights up in gold when that ability has feedback and stays dim when it does not. This bar only appears when the game sends feedback data and is hidden while the inactive timer is shown.

## Useful Commands (Aliases)

ThresholdUI provides several aliases (commands) you can type in Mudlet to control the UI:

- **Toggle Heal Tick Gauge**
  - Type: `regen on` or `regen off`
  - Shows or hides the healing tick gauge.

- **Toggle Date Time Box**
  - Type: `datetime on` or `datetime off`
  - Displays or hides the in-game date and time box.

Enjoy your adventures with ThresholdUI!
