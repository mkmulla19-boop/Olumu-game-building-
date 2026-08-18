# Mobile HUD Setup Guide (Westland Style)

Target phone: **Redmi Note 11 Pro**

## Recommended Scene Structure for Mobile HUD

Create a scene called `MobileHUD.tscn` (CanvasLayer):

```
MobileHUD (CanvasLayer)
├── VirtualJoystick (Control) → attach virtual_joystick.gd
├── Buttons (Control)
│   ├── JumpButton (TouchScreenButton)
│   └── InteractButton (TouchScreenButton)
└── SurvivalBars (Control)
    ├── HungerBar (ProgressBar)
    └── ThirstBar (ProgressBar)
```

## Suggested Layout (for Redmi Note 11 Pro screen)

- VirtualJoystick: appears dynamically on left side when touched
- JumpButton: bottom-right area
- InteractButton: just above or beside Jump button
- HungerBar + ThirstBar: top of the screen (small, semi-transparent)

## How to connect

1. Instance MobileHUD in your main village scene
2. Attach `mobile_hud.gd` to the root CanvasLayer
3. Make sure the player is in group "player" and has SurvivalNeeds child
4. The script will automatically find the player and update the bars

## Controls Summary

| Control            | Location          | Action                |
|--------------------|-------------------|-----------------------|
| Virtual Joystick   | Left side         | Move character        |
| Drag               | Right side        | Rotate camera         |
| Jump Button        | Bottom right      | Jump                  |
| Interact Button    | Bottom right      | Gather / Interact     |
| Hunger / Thirst    | Top               | Visual feedback       |
