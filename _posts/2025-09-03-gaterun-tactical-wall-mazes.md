---
layout: post
title: "GateRun"
subtitle: "tactical wall mazes on a 7×7 board"
date: 2025-09-03 10:15:00 -0700
categories: [game-ideas]
tags: [turn-based, strategy, spa, ai, puzzle]
excerpt: "A small, fast, turn-based duel: move your pawn or place a wall to reroute your rival. First to reach the opposite side wins."
---

## TL;DR
**GateRun** is a minimalist, turn-based duel for 2 players (or 1P vs AI). On your turn, either **move** your pawn one cell (N/E/S/W) **or** **place a short wall** between two cells to reroute your opponent. **First to reach the opposite side wins.**

---

## Rules (Core)
- **Board:** 7×7 grid of cells.
- **Start:** P1 pawn starts at row 0, center column; P2 at row 6, center column.
- **Turn:** On your turn choose **one**:
  1) **Move** your pawn one step orthogonally into a non-blocked cell, or  
  2) **Place a wall** (two-cell edge) between adjacent cells to block movement along that edge.
- **Path rule:** A wall is **illegal** if it leaves either player with **no path** to their goal edge.
- **Goal:** Reach any cell on your **opposite edge** (P1 → bottom edge, P2 → top edge).
- **Wall supply:** 8 walls per player (shared visual pool is fine; track counts per player).

### Optional Skills (nice-to-have toggles)
- **Jump (×1):** If adjacent cell is occupied by opponent and the cell beyond is open, you may jump over as your move.
- **Rotate Wall (×1):** Rotate any one existing wall segment by 90° (still must honor the path rule).

---

## Why this is SPA‑friendly
- Single SVG grid; walls are just thickened edges between cells.
- State is tiny and serializable: `{pawns, walls, turn, counts}`.
- Legal moves are easy to compute; path‑check is a BFS.
- Scales well for mobile with simple touch targets.

---

## Data model (suggested)
```ts
type Player = 'P1' | 'P2';
type Cell = { r: number; c: number }; // 0..6
type Edge = string;                   // e.g., "2,3|2,4" for an east-west block
interface State {
  turn: Player;
  p1: Cell; p2: Cell;
  walls: Set<Edge>;
  wallsLeft: { P1: number; P2: number };
  over: boolean; winner?: Player;
}
```

### Helpers
- **Neighbors(cell):** filter to board bounds and edges not blocked by `walls`.
- **HasPath(cell, goalRow):** BFS; true if any cell on `goalRow` is reachable.
- **IsLegalWall(edge):** Temporarily add edge → both `HasPath(p1,6)` and `HasPath(p2,0)` must be true.

---

## AI bot (baseline)
Use **minimax with alpha‑beta pruning** and a small depth (2–3).

**Evaluation heuristic** (maximize):
```text
score = (distOppToGoal - distMeToGoal) * 10
        + (mobilityMe - mobilityOpp)
        - wallPenaltyIfLow
```
- `distXToGoal`: shortest path length via BFS (treat walls as blocked).
- `mobilityX`: number of legal moves for X this turn.
- Prefer wall placements that **increase opponent path length** or **preserve** your shortest path.

**Move ordering:** try (1) winning pawn moves, (2) disruptive walls (that raise opponent distance), then others.

---

## Turn structure (pseudo)
```ts
function generateMoves(s: State): Move[] {
  const moves: Move[] = [];
  // Pawn steps
  for (const n of neighbors(currentPawn(s))) moves.push({ type: 'move', to: n });
  // Walls
  if (s.wallsLeft[s.turn] > 0) {
    for (const e of allPotentialEdges())
      if (!s.walls.has(e) && isLegalWall(s, e)) moves.push({ type: 'wall', edge: e });
  }
  return moves;
}
```

---

## MVP Scope
- 7×7 board, 8 walls per player
- Path rule enforcement
- Single‑depth (2–3) AI with minimax
- Undo/redo stack, restart, “AI plays P1/P2” toggles
- Simple SVG visuals + keyboard/touch controls

### Nice‑to‑have
- Optional skills (Jump / Rotate Wall)
- Difficulty slider (AI depth + ε‑greedy mistakes)
- Seeded AI for reproducible puzzles (“daily duel”)

---

## Implementation tips
- Represent walls as **blocked edges** (between-cell pairs) rather than “grid posts”—it simplifies checks.
- Cache BFS distances per side when exploring many candidate walls in AI.
- Clamp AI to a move time budget (e.g., 50–100 ms) to keep UI snappy.
