// Progress bar spinner generator: horizontal loading bar.

import 'package:unicode_animations/unicode_animations.dart';

/// Generates the progressBar spinner animation.
///
/// A horizontal bar fills left to right with a gradient leading edge,
/// holds when full, then clears. 4×20 grid (10 Braille chars).
/// Results in 44 frames.
Spinner generateProgressBar({int? intervalInMs}) {
  const width = 20;
  const height = 4;

  final frameList = <String>[];

  // Phase 1: fill left to right (20 frames)
  for (int fill = 0; fill < width; fill++) {
    final grid = makeGrid(height, width);

    // Fill completed columns fully
    for (int c = 0; c < fill; c++) {
      for (int r = 0; r < height; r++) {
        grid[r][c] = true;
      }
    }

    // Leading edge: partial fill (bottom-up gradient)
    final filledRows = (fill % height) + 1;
    for (int r = height - 1; r >= height - filledRows; r--) {
      grid[r][fill] = true;
    }

    frameList.add(gridToBraille(grid));
  }

  // Phase 2: full (2 frames)
  final full = makeGrid(height, width);
  for (int r = 0; r < height; r++) {
    for (int c = 0; c < width; c++) {
      full[r][c] = true;
    }
  }
  final fullFrame = gridToBraille(full);
  frameList.add(fullFrame);
  frameList.add(fullFrame);

  // Phase 3: clear left to right (20 frames)
  for (int clear = 0; clear < width; clear++) {
    final grid = makeGrid(height, width);
    for (int c = clear + 1; c < width; c++) {
      for (int r = 0; r < height; r++) {
        grid[r][c] = true;
      }
    }
    frameList.add(gridToBraille(grid));
  }

  // Phase 4: empty (2 frames)
  final emptyFrame = gridToBraille(makeGrid(height, width));
  frameList.add(emptyFrame);
  frameList.add(emptyFrame);

  return Spinner(frames: frameList, intervalInMs: intervalInMs ?? 50);
}

/// Pre-computed progressBar spinner.
final Spinner progressBarSpinner = generateProgressBar();
