# Controls — Westland Survival Style

Target device: **Redmi Note 11 Pro**

## How it works on phone

| Screen Area       | Action                          |
|-------------------|---------------------------------|
| Left side         | Virtual Joystick → Move character |
| Right side        | Drag finger → Freely rotate camera (orbit) |
| Jump button       | (will be added in UI)           |
| Interact          | (will be added)                 |

This is the same playing method used in Westland Survival:
- Move with left thumb
- Look around freely with right thumb by dragging

## Technical details already implemented
- Smooth camera rotation (not instant/jittery)
- Separate touch indexes so movement and looking don’t fight each other
- Sensitivity tuned for Redmi Note 11 Pro size and touch response
- Camera pitch limited so it doesn’t flip upside down

## Still to add later
- On-screen Jump button
- On-screen Interact / Gather button
- Optional run button or auto-run when joystick is fully pushed
