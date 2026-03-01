// Diagonal swipe spinner generator: diagonal sweep wipe.

import 'package:unicode_animations/unicode_animations.dart';

/// Generates the diagswipe spinner animation.
///
/// Fills a 4×4 grid diagonally, holds, then clears diagonally.
/// Results in 16 frames.
Spinner generateDiagSwipe({int? intervalInMs}) {
  const width = 4;
  const height = 4;
  final maxDiag = width + height - 2;

  final frameList = <String>[];

  // Phase 1: diagonal fill
  for (int d = 0; d <= maxDiag; d++) {
    final grid = makeGrid(height, width);
    for (int r = 0; r < height; r++) {
      for (int c = 0; c < width; c++) {
        if (r + c <= d) {
          grid[r][c] = true;
        }
      }
    }
    frameList.add(gridToBraille(grid));
  }

  // Full frame
  final full = makeGrid(height, width);
  for (int r = 0; r < height; r++) {
    for (int c = 0; c < width; c++) {
      full[r][c] = true;
    }
  }
  frameList.add(gridToBraille(full));

  // Phase 2: diagonal clear
  for (int d = 0; d <= maxDiag; d++) {
    final grid = makeGrid(height, width);
    for (int r = 0; r < height; r++) {
      for (int c = 0; c < width; c++) {
        if (r + c > d) {
          grid[r][c] = true;
        }
      }
    }
    frameList.add(gridToBraille(grid));
  }

  // Empty frame
  frameList.add(gridToBraille(makeGrid(height, width)));

  return Spinner(frames: frameList, intervalInMs: intervalInMs ?? 60);
}

/// Pre-computed diagSwipe spinner.
final Spinner diagSwipeSpinner = generateDiagSwipe();
