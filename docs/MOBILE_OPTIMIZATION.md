# Mobile Optimization Notes — Olomu Survival

Target: Mid-range Android phones (typical devices used for testing)

## Key Settings for Godot 4.7

### Project Settings → Rendering
- Renderer: **Mobile** (not Forward+)
- Textures → VRAM Compression → Import ETC2/ASTC = enabled

### Performance Targets
- Aim for stable 30–60 FPS
- Keep draw calls under ~100
- Prefer low-poly models + shared materials
- Use simple lighting

### Controls Design (already implemented)
- Left half of screen → Virtual Joystick (movement)
- Right half of screen → Touch drag (camera look)

### Recommended Project Settings
- Physics Ticks Per Second: 30 or 60
- Max FPS: 60 (or 30 for better battery)

## What the scripts already do
- Virtual joystick only appears when you touch the left side
- Camera look only works on the right side
- Movement is smoothed for better feel on touchscreens
- Deadzone prevents accidental tiny movements

## Still needs your final tuning on the real phone
- Joystick size / position comfort
- Camera sensitivity feel
