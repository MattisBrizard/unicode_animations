// Game of Life spinner generator: cellular automaton.

import 'package:unicode_animations/unicode_animations.dart';

/// Generates the gameOfLife spinner animation.
///
/// Runs Conway's Game of Life on a 4×8 toroidal grid using a seed
/// that produces a cyclic sequence. Results in 14 frames.
Spinner generateGameOfLife({int? intervalInMs}) {
  const width = 8;
  const height = 4;
  const maxGenerations = 24;
  final seed = makeGrid(height, width);

  // Place a blinker (period 2) — horizontal at row 0
  seed[0][1] = true;
  seed[0][2] = true;
  seed[0][3] = true;

  // Place a toad (period 2) — rows 2-3
  seed[2][2] = true;
  seed[2][3] = true;
  seed[2][4] = true;
  seed[3][1] = true;
  seed[3][2] = true;
  seed[3][3] = true;

  // Place a beacon (period 2) — rows 0-3, cols 5-7
  seed[0][5] = true;
  seed[0][6] = true;
  seed[1][5] = true;
  seed[2][7] = true;
  seed[3][6] = true;
  seed[3][7] = true;

  final frameList = <String>[];
  var current = seed;

  // Generate frames until we find a repeated state
  final seen = <String>{};
  for (int i = 0; i < maxGenerations; i++) {
    final frame = gridToBraille(current);
    if (!seen.add(frame)) break;
    frameList.add(frame);
    current = _nextGeneration(current, height, width);
  }

  return Spinner(frames: frameList, intervalInMs: intervalInMs ?? 120);
}

List<List<bool>> _nextGeneration(
  List<List<bool>> grid,
  int height,
  int width,
) {
  final next = makeGrid(height, width);
  for (int r = 0; r < height; r++) {
    for (int c = 0; c < width; c++) {
      int neighbors = 0;
      for (int dr = -1; dr <= 1; dr++) {
        for (int dc = -1; dc <= 1; dc++) {
          if (dr == 0 && dc == 0) continue;
          final nr = (r + dr + height) % height;
          final nc = (c + dc + width) % width;
          if (grid[nr][nc]) neighbors++;
        }
      }
      if (grid[r][c]) {
        next[r][c] = neighbors == 2 || neighbors == 3;
      } else {
        next[r][c] = neighbors == 3;
      }
    }
  }
  return next;
}

/// Pre-computed gameOfLife spinner.
final Spinner gameOfLifeSpinner = generateGameOfLife();
