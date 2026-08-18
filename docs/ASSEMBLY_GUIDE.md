# Olomu Survival — Assembly Guide for First Test Run

Follow these steps exactly to get a working vertical slice test.

## 1. Project Setup
- Open your Godot 4.7.1 project
- Make sure the `scripts` folder from GitHub is inside your project

## 2. Input Map (Project → Project Settings → Input Map)
Add these actions if they don’t exist:
- `move_forward` (W)
- `move_back` (S)
- `move_left` (A)
- `move_right` (D)
- `jump` (Space)
- `run` (Shift)
- `interact` (E)

## 3. Player Setup
1. Create a new scene or use existing player
2. Root node: `CharacterBody3D` (add to group "player")
3. Add CollisionShape3D (CapsuleShape3D recommended)
4. Add child `SpringArm3D`
   - Spring Length: 4.0
   - Add child `Camera3D` under the SpringArm
5. Attach `scripts/player/player_controller.gd` to the CharacterBody3D
6. Add child nodes:
   - `SurvivalNeeds` (Node) → attach survival_needs.gd
   - `Inventory` (Node) → attach inventory.gd

## 4. Simple Village Test Scene
1. Create `scenes/village/test_village.tscn`
2. Add a StaticBody3D or CSGBox3D as ground
3. Instance your Player scene
4. Add a few MeshInstance3D or imported free low-poly trees/buildings
5. Add 2–3 gatherable items (Area3D + gatherable.gd)
6. Add 1–2 simple NPCs (CharacterBody3D + simple_npc.gd)
7. Optionally add the OpeningSequence node and call `start_opening_sequence()` from a button or timer

## 5. Mobile Notes
The player controller has basic touch look support.
For a proper mobile feel you still need:
- Virtual joystick for movement (left side)
- Touch drag for camera (right side)
This is the only part that currently requires your device testing and fine-tuning.

## 6. First Test Goals
- Walk around the village
- See NPCs wandering
- Gather a few items
- Watch Hunger/Thirst decrease
- Trigger the opening sequence
- Save and load the game

Once these work, the foundation is solid and we can expand.
