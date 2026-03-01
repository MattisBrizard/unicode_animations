// Columns spinner generator: columns filling bottom-up.

import 'package:unicode_animations/unicode_animations.dart';

/// Generates the columns spinner animation.
///
/// Fills columns one by one from bottom to top on a 4×6 grid,
/// then shows full and empty frames. Results in 26 frames.
Spinner generateColumns({int? intervalInMs}) {
  const width = 6;
  const height = 4;

  final frameList = <String>[];

  for (int col = 0; col < width; col++) {
    for (int fillTo = height - 1; fillTo >= 0; fillTo--) {
      final grid = makeGrid(height, width);

      // Fill all previous columns completely
      for (int pc = 0; pc < col; pc++) {
        for (int r = 0; r < height; r++) {
          grid[r][pc] = true;
        }
      }

      // Fill current column from fillTo to bottom
      for (int r = fillTo; r < height; r++) {
        grid[r][col] = true;
      }

      frameList.add(gridToBraille(grid));
    }
  }

  // Full frame
  final full = makeGrid(height, width);
  for (int r = 0; r < height; r++) {
    for (int c = 0; c < width; c++) {
      full[r][c] = true;
    }
  }
  frameList.add(gridToBraille(full));

  // Empty frame
  frameList.add(gridToBraille(makeGrid(height, width)));

  return Spinner(frames: frameList, intervalInMs: intervalInMs ?? 60);
}

/// Pre-computed columns spinner.
final Spinner columnsSpinner = generateColumns();
