# Olomu — Before the Invasion

**Working Title:** Olomu Survival  
**Engine:** Godot 4.7.1  
**Platform Target:** Android-first (mobile)  
**Genre:** Narrative 3D Survival / Emotional Journey  
**Studio:** Mkmulla Game Studio

---

## Story Core (Locked)

The boy starts in his village at dawn.

Suddenly another community attacks.  
His father and mother fight the enemies.  
His father tells him to run for safety.  
Before he can fully escape, he witnesses the killing of his family.  
Only then does he flee toward another community.

This is the emotional foundation of the game.

### Planned Story Beats
1. Peaceful village start (family present)
2. Attack begins
3. Parents fighting
4. Father’s order to run
5. Family falls
6. Escape sequence
7. Arrival at new community (warmer, safer feeling)

---

## Current Project Status

- [x] Core story locked
- [x] Basic Godot 4.7 project structure started
- [x] Player controller (CharacterBody3D + SpringArm camera) in progress
- [ ] Clean folder structure & proper Git setup
- [ ] Mobile-friendly controls
- [ ] First playable village scene
- [ ] Dialogue system
- [ ] 3D assets (character, village, props)
- [ ] Escape sequence prototype

---

## Project Structure (Target)

```
Olomu/
├── assets/
│   ├── models/          # .glb / .gltf characters, props, buildings
│   ├── textures/
│   ├── audio/
│   └── ui/
├── scenes/
│   ├── player/
│   ├── village/
│   ├── escape/
│   └── ui/
├── scripts/
│   ├── player/
│   ├── systems/         # dialogue, save, etc.
│   └── utils/
├── resources/
└── project.godot
```

---

## Development Guidelines

- Keep everything mobile-friendly (touch controls, performance)
- Prefer low-poly / stylized art for Android performance
- Build one solid layer at a time
- Document important decisions in this README or Issues

---

## Useful Resources

- Third-person controllers: selgesel/godot4-third-person-controller, GDQuest demos
- Dialogue: nathanhoad/godot_dialogue_manager
- Mobile starters: lukky-nl/Pocket-Godot

---

**Made with care by Mkmulla Game Studio**  
"Just a curious young fellow trying to build a game from scratch."
