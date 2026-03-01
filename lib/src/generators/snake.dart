// Snake spinner generator: a snake moving along a serpentine path.

import 'package:unicode_animations/unicode_animations.dart';

/// Generates the snake spinner animation.
///
/// Creates a 4-dot snake following a serpentine path through a 4×4 grid.
/// Results in 16 frames.
Spinner generateSnake({int? intervalInMs}) {
  const width = 4;
  const height = 4;

  // Build serpentine path
  final path = <(int, int)>[];
  for (int r = 0; r < height; r++) {
    if (r % 2 == 0) {
      for (int c = 0; c < width; c++) {
        path.add((r, c));
      }
    } else {
      for (int c = width - 1; c >= 0; c--) {
        path.add((r, c));
      }
    }
  }

  final frameList = <String>[];

  for (int i = 0; i < path.length; i++) {
    final grid = makeGrid(height, width);

    for (int t = 0; t < 4; t++) {
      final idx = (i - t + path.length) % path.length;
      final (row, col) = path[idx];
      grid[row][col] = true;
    }

    frameList.add(gridToBraille(grid));
  }

  return Spinner(frames: frameList, intervalInMs: intervalInMs ?? 80);
}

/// Pre-computed snake spinner.
final Spinner snakeSpinner = generateSnake();
