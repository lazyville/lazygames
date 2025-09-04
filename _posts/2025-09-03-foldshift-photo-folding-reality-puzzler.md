---
layout: post
title: "Foldshift — a photo-folding reality puzzler"
date: 2025-09-03 23:00:00 -0700
categories: [game-ideas]
tags: [puzzle, adventure, photography, prototype, indie]
excerpt: "Capture the world, fold the photo, and place it back to bend reality."
---

## Elevator pitch
Take a photo of the world, **fold** the print like origami, then **place** it back into the scene to bend reality—bridging gaps, hiding hazards, or duplicating paths. A compact, tactile puzzler where paper craft meets spatial logic.

## Core loop
1. **Scout** a diorama-like level to find a path to the goal.  
2. **Capture** a snapshot (framed area of the scene).  
3. **Fold & edit** the snapshot on a 3×3 or 4×4 crease grid (limited moves).  
4. **Place** the folded photo into the world; edges **snap** to geometry and become real.  
5. **Iterate** with new angles/prints until you reach the exit or collect all objectives.

## Key mechanics
- **Crease Grid:** Each fold consumes a move; valley vs. mountain folds affect which surfaces remain visible/collidable.  
- **Edge Snap:** When a folded photo’s edge aligns within a tolerance to existing geometry, it “welds,” creating walkable surfaces or blockers.  
- **Tear & Mask:** Drag to tear a photo; masked (erased) regions become holes—useful for making windows or tunnels.  
- **Ink Tools:**  
  - **Stencil** (solid): drawn shapes become collidable when placed.  
  - **Ghost** (dotted): drawn shapes are non-collidable (visual only) for misdirection puzzles.  
- **Develop Meter:** Each level grants N “develop points” (prints). Efficient solutions earn bonus stars.  
- **Parallax Rules:** Photos preserve lighting and parallax from their capture angle, creating perspective-based tricks.

## Level design & progression
- **World 1 — Paper Bridges:** Basics of folding to span gaps and create ramps.  
- **World 2 — Shutters & Light:** Use photos to block/redirect light beams and activate sensors.  
- **World 3 — Timed Prints:** Moving platforms are captured mid-motion; placed photos freeze that state.  
- **World 4 — Non-Euclidean:** Overlapping placements enable impossible loops and shortcuts.

## Aesthetic & feel
Minimal dioramas with **matte paper** materials, gentle ambient audio, subtle camera grain when “looking through” the viewfinder, and satisfying paper foley (crease, tear, slide).

## Controls
- **Mouse/Touch:** Click-drag to fold along highlighted creases; pinch/scroll to zoom; long-press to tear; toolbar toggles Ink tools.  
- **Controller:** Bumpers cycle crease lines; face buttons confirm fold/tear; triggers rotate/flip.

## MVP scope (6–8 weeks)
- 24 handcrafted puzzles across 3 biomes  
- 1 capture tool, fold/flip/tear, edge snap, basic stencil ink  
- Star scoring (prints used, folds used, time) + daily seed puzzle  
- Save/undo stack; accessibility presets (high-contrast outlines, input assistance)

## Stretch ideas
- **Photo Chemistry:** Warm/cool filters alter material behavior (ice/sand).  
- **Blueprint Mode:** Place multiple micro-prints that auto-assemble on confirm.  
- **Community Packs:** In-game level editor with shareable seeds.

## Inspirations (and how we differ)
- *Viewfinder* (photo becomes world), *Superliminal* (perspective), *Paper Mario* (folding).  
**Foldshift** centers on **crease-limited origami + teardown/masking** with strict move budgets and weldable edges, emphasizing **route construction** over pure perspective tricks.

## Tech notes (prototype path)
Unity/Godot with **render-to-texture** capture; folded photo represented as a mesh with crease transforms and a **signed distance field** for snap checks. Colliders baked per placement; shader pass applies paper normals & curl at folds.

## Why it could stand out
- Fresh **tactile verb set** (fold/tear/place) with systemic interactions.  
- Short, satisfying puzzle sessions suited to PC/console/mobile.  
- Strong visual identity (paper craft) that’s performant and accessible.

## Next steps
- Build graybox of 6 puzzles validating fold budgets, snap tolerances, and readability.  
- Playtest for **teachability** of folds vs. flips; tune UI affordances.  
- If retention >60% into World 2 during tests, expand ink tools and release a public demo.
