# Recommended Project Settings — Olomu Survival

For **Redmi Note 11 Pro** and similar mid-range Android devices.

## Rendering
- Renderer: **Mobile**
- VRAM Compression: ETC2/ASTC enabled
- Anti-aliasing: Disabled or MSAA 2x maximum

## Physics
- Physics Ticks Per Second: 30 or 60

## Display
- Orientation: Sensor Landscape or Landscape
- V-Sync: On

## Input
Make sure these actions exist:
- move_forward, move_back, move_left, move_right
- jump, run, interact, pause

## Performance Tips
- Keep draw calls under 100 if possible
- Prefer low-poly free assets
- Avoid too many realtime lights
- Use simple materials
