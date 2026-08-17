# Olomu Asset Pipeline

Goal: Get the game looking and feeling alive as fast as possible using free / open assets that work well on Android.

## Recommended Free Asset Sources (Priority Order)

### 1. Nature & Environment (Highest priority for village)
- **Kenney Nature Kit (GLB version)**  
  https://eclair-assets.itch.io/nature-kit-glb-pack-329-free-cc0-3d-models  
  329 free CC0 models (trees, rocks, plants, outdoor props). Perfect for village surroundings.

- **Kenney Fantasy Town Kit**  
  https://opengameart.org/content/fantasy-town-kit  
  Modular buildings, fences, etc. (CC0). Can be adapted for village look.

### 2. Characters
- **Kenney Character Assets (free sample available)**  
  https://kenney.itch.io/kenney-character-assets  
  Low-poly, rigged, animated characters. Good starting point for the boy.

- Quaternius free character packs (search on quaternius.com or itch.io)

### 3. Props & General Low-Poly
- **Poly Pizza** → https://poly.pizza/  
  Thousands of free low-poly models (CC0 / public domain). Search for hut, pot, spear, basket, fire, etc.

- **FreePixel** → https://freepixel.art/3d-assets  
  100+ free GLB models (characters, buildings, props).

### 4. African / Village Specific
True free African village packs are rare. Best approach:
1. Use modular Kenney / Quaternius buildings + nature.
2. Customize with simple recoloring or small AI-generated props later.
3. Search Poly Pizza + Sketchfab (filter free + downloadable) for "hut", "mud house", "african pot", "spear".

## How to Import into Godot 4.7
1. Download the pack (prefer GLB / glTF).
2. Drag the `.glb` files into `assets/models/`.
3. Godot will auto-import them.
4. Place instances in your village scene.

## Current Action Plan
1. Download Kenney Nature Kit (GLB) → put trees, rocks, plants in village.
2. Download a few free character models as temporary boy / family placeholders.
3. Build a simple village test scene using these assets.
4. Later replace placeholders with better custom models.

## Folder Structure (already created)
```
assets/
  models/     ← put all .glb here
  textures/
  audio/
  ui/
```

Keep everything low-poly and optimized for mobile.
