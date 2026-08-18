# FINAL ASSEMBLY CHECKLIST — Olomu Survival Vertical Slice

Only testing should remain after you finish this list.

## 1. Project Settings (Do this first)

**Project → Project Settings**

### Rendering
- Renderer → **Mobile**
- Textures → VRAM Compression → Import ETC2 ASTC = **On**

### Input Map (add if missing)
- move_forward, move_back, move_left, move_right
- jump
- run
- interact
- pause (recommended: Esc or Android back)

### Display
- Window → Handheld → Orientation = Sensor or Landscape (your choice)

### Application
- Config → Name = Olomu Survival

---

## 2. Folder Structure (should already exist)
```
assets/
scenes/
  player/
  village/
  ui/
scripts/
  player/
  systems/
  ui/
  npc/
  story/
docs/
```

---

## 3. Player Scene
1. Create `scenes/player/Player.tscn`
2. Root: CharacterBody3D (add to group "player")
3. Add CollisionShape3D (CapsuleShape3D)
4. Add SpringArm3D (Spring Length ≈ 4.0)
5. Add Camera3D as child of SpringArm3D
6. Attach `scripts/player/player_controller.gd`
7. Add child Node named `SurvivalNeeds` → attach survival_needs.gd
8. Add child Node named `Inventory` → attach inventory.gd

---

## 4. Mobile HUD Scene
1. Create `scenes/ui/MobileHUD.tscn` (CanvasLayer)
2. Add Control node → attach virtual_joystick.gd
3. Add Buttons container with two TouchScreenButtons (Jump + Interact)
4. Add SurvivalBars with two ProgressBars (Hunger + Thirst)
5. Attach `scripts/ui/mobile_hud.gd` to the CanvasLayer

---

## 5. Test Village Scene
1. Create `scenes/village/test_village.tscn`
2. Add ground (CSGBox3D or MeshInstance3D + StaticBody3D)
3. Instance Player.tscn
4. Instance MobileHUD.tscn
5. Add a few trees / rocks / simple buildings (free low-poly assets)
6. Add 3–5 gatherable items (Area3D + gatherable.gd)
7. Add 1–2 simple NPCs (CharacterBody3D + simple_npc.gd)
8. Add OpeningSequence node → attach opening_sequence.gd (set auto_start = true for testing)

---

## 6. Optional but Recommended
- Add PauseMenu (Control) and connect it
- Add InventoryUI and a button to open it
- Add a simple DirectionalLight3D + WorldEnvironment

---

## 7. Export / Test on Redmi Note 11 Pro
1. Install Android Build Template if not done
2. Export → Android
3. Install on your Redmi Note 11 Pro
4. Test the following:
   - Virtual joystick movement (left side)
   - Camera rotation by dragging (right side)
   - Jump button
   - Interact / Gather
   - Hunger & Thirst bars decreasing
   - Opening sequence playing
   - NPCs walking
   - Save / Load (if connected)

---

## Done Criteria
When all the above works on your Redmi Note 11 Pro, the vertical slice foundation is complete and only testing + polishing remains.
