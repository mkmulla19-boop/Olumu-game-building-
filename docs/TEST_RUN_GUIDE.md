# Olomu Survival — Test Run Guide

This guide tells you exactly how to assemble what has been prepared so you can do a first test run.

## What has been prepared for you

In the GitHub repo you now have:

### Scripts
- `scripts/player/player_controller.gd` → Basic third-person controller (desktop + basic touch support)
- `scripts/systems/survival_needs.gd` → Hunger & Thirst
- `scripts/systems/inventory.gd` → Simple inventory
- `scripts/systems/save_load.gd` → Save / Load
- `scripts/story/opening_sequence.gd` → Opening story sequence

### Documentation
- Full Game Vision
- Asset Pipeline
- Next Steps
- This Test Run Guide

## How to set up the first test

1. Open your Godot 4.7.1 project.
2. Copy the entire `scripts` folder from the GitHub repo into your project.
3. Create a new scene: `scenes/village/test_village.tscn`
4. Add a basic environment (CSGBox or imported free low-poly ground + trees).
5. Add a CharacterBody3D as the player and attach `player_controller.gd`.
6. Add a SpringArm3D + Camera3D as children of the player (structure expected by the script).
7. Add the survival, inventory and opening sequence scripts as needed (can be children of the player or autoloads).
8. Set up basic Input Map actions:
   - move_forward, move_back, move_left, move_right
   - jump, run
9. For mobile: you will still need to refine the touch controls (this is the only part that currently needs your attention on device).

## Goal of the first test run

- Player can walk around a simple village area
- Hunger and Thirst slowly decrease
- Opening sequence can be triggered
- Game can be saved and loaded

Once this works, we expand from a solid foundation.
