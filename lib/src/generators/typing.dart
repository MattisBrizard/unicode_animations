// Typing spinner generator: cursor typing effect.

import 'package:unicode_animations/unicode_animations.dart';

/// Generates the typing spinner animation.
///
/// A vertical cursor bar moves left to right, filling columns behind it.
/// Then clears and blinks. On a 4×6 grid (3 Braille chars).
/// Results in 14 frames.
Spinner generateTyping({int? intervalInMs}) {
  const width = 6;
  const height = 4;

  final frameList = <String>[];

  // Phase 1: typing (6 frames) — cursor moves right, filling behind
  for (int cursor = 0; cursor < width; cursor++) {
    final grid = makeGrid(height, width);

    // Fill committed columns (partial: rows 0-2 only, to differ from cursor)
    for (int c = 0; c < cursor; c++) {
      for (int r = 0; r < height - 1; r++) {
        grid[r][c] = true;
      }
    }

    // Draw cursor bar (full height)
    for (int r = 0; r < height; r++) {
      grid[r][cursor] = true;
    }

    frameList.add(gridToBraille(grid));
  }

  // Phase 2: hold full (1 frame)
  final full = makeGrid(height, width);
  for (int r = 0; r < height - 1; r++) {
    for (int c = 0; c < width; c++) {
      full[r][c] = true;
    }
  }
  frameList.add(gridToBraille(full));

  // Phase 3: clearing right to left (6 frames)
  for (int clear = width - 1; clear >= 0; clear--) {
    final grid = makeGrid(height, width);
    for (int c = 0; c < clear; c++) {
      for (int r = 0; r < height - 1; r++) {
        grid[r][c] = true;
      }
    }
    frameList.add(gridToBraille(grid));
  }

  // Phase 4: blink cursor (1 frame)
  final blink = makeGrid(height, width);
  for (int r = 0; r < height; r++) {
    blink[r][0] = true;
  }
  frameList.add(gridToBraille(blink));

  return Spinner(frames: frameList, intervalInMs: intervalInMs ?? 100);
}

/// Pre-computed typing spinner.
final Spinner typingSpinner = generateTyping();
