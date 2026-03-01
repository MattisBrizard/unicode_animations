// Scan spinner generator: vertical bar sweeping left to right.

import 'package:unicode_animations/unicode_animations.dart';

/// Generates the scan spinner animation.
///
/// Creates a vertical bar that sweeps left to right across a 4×8 grid.
/// Results in 10 frames.
Spinner generateScan({int? intervalInMs}) {
  const rows = 4;
  const cols = 8;
  const frames = 10;

  final frameList = <String>[];

  // pos ranges from -1 to 8, creating the scanning effect
  for (int pos = -1; pos < frames - 1; pos++) {
    final grid = makeGrid(rows, cols);

    // Light up columns pos and pos+1 (if they exist)
    for (int row = 0; row < rows; row++) {
      if (pos >= 0 && pos < cols) {
        grid[row][pos] = true;
      }
      if (pos + 1 >= 0 && pos + 1 < cols) {
        grid[row][pos + 1] = true;
      }
    }

    frameList.add(gridToBraille(grid));
  }

  return Spinner(frames: frameList, intervalInMs: intervalInMs ?? 70);
}

/// Pre-computed scan spinner.
final Spinner scanSpinner = generateScan();
