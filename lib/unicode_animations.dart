/// Pure Dart port of unicode-animations.
///
/// Provides 24 Unicode Braille spinner animations.
library;

import 'package:unicode_animations/src/generators/breathe.dart';
import 'package:unicode_animations/src/generators/cascade.dart';
import 'package:unicode_animations/src/generators/checkerboard.dart';
import 'package:unicode_animations/src/generators/columns.dart';
import 'package:unicode_animations/src/generators/compress.dart';
import 'package:unicode_animations/src/generators/diag_swipe.dart';
import 'package:unicode_animations/src/generators/fill_sweep.dart';
import 'package:unicode_animations/src/generators/game_of_life.dart';
import 'package:unicode_animations/src/generators/hardcoded.dart';
import 'package:unicode_animations/src/generators/helix.dart';
import 'package:unicode_animations/src/generators/orbit.dart';
import 'package:unicode_animations/src/generators/pendulum.dart';
import 'package:unicode_animations/src/generators/progress_bar.dart';
import 'package:unicode_animations/src/generators/pulse.dart';
import 'package:unicode_animations/src/generators/rain.dart';
import 'package:unicode_animations/src/generators/scan.dart';
import 'package:unicode_animations/src/generators/scan_line.dart';
import 'package:unicode_animations/src/generators/snake.dart';
import 'package:unicode_animations/src/generators/sort.dart';
import 'package:unicode_animations/src/generators/sparkle.dart';
import 'package:unicode_animations/src/generators/typing.dart';
import 'package:unicode_animations/src/generators/wave_rows.dart';

export 'package:unicode_animations/src/braille_helpers.dart';
export 'package:unicode_animations/src/generators/breathe.dart';
export 'package:unicode_animations/src/generators/cascade.dart';
export 'package:unicode_animations/src/generators/checkerboard.dart';
export 'package:unicode_animations/src/generators/columns.dart';
export 'package:unicode_animations/src/generators/compress.dart';
export 'package:unicode_animations/src/generators/diag_swipe.dart';
export 'package:unicode_animations/src/generators/fill_sweep.dart';
export 'package:unicode_animations/src/generators/game_of_life.dart';
export 'package:unicode_animations/src/generators/hardcoded.dart';
export 'package:unicode_animations/src/generators/helix.dart';
export 'package:unicode_animations/src/generators/orbit.dart';
export 'package:unicode_animations/src/generators/pendulum.dart';
export 'package:unicode_animations/src/generators/progress_bar.dart';
export 'package:unicode_animations/src/generators/pulse.dart';
export 'package:unicode_animations/src/generators/rain.dart';
export 'package:unicode_animations/src/generators/scan.dart';
export 'package:unicode_animations/src/generators/scan_line.dart';
export 'package:unicode_animations/src/generators/snake.dart';
export 'package:unicode_animations/src/generators/sort.dart';
export 'package:unicode_animations/src/generators/sparkle.dart';
export 'package:unicode_animations/src/generators/typing.dart';
export 'package:unicode_animations/src/generators/wave_rows.dart';

/// A Unicode spinner animation frame sequence.
class Spinner {
  /// Creates a new spinner with the given [frames] and [intervalInMs].
  const Spinner({
    required this.frames,
    required this.intervalInMs,
  });

  /// The animation frames as Unicode strings.
  final List<String> frames;

  /// The interval between frames in milliseconds.
  final int intervalInMs;

  /// Returns the pre-computed [Spinner] for [name].
  ///
  /// This is a convenient non-nullable alternative to `spinners[name]!`.
  ///
  /// ```dart
  /// final s = Spinner.of(BrailleSpinnerName.helix);
  /// ```
  static Spinner of(BrailleSpinnerName name) => spinners[name]!;
}

/// Names of all available spinners.
enum BrailleSpinnerName {
  /// Classic Braille spinner (1 char).
  braille,

  /// Braille wave pattern (4 chars).
  brailleWave,

  /// DNA double-helix pattern (4 chars).
  dna,

  /// Vertical scanning bar (4 chars).
  scan,

  /// Falling rain drops (4 chars).
  rain,

  /// Horizontal scan line (3 chars).
  scanLine,

  /// Expanding circular pulse (3 chars).
  pulse,

  /// Moving snake (2 chars).
  snake,

  /// Sorting visualization (10 chars).
  sort,

  /// Random sparkle pattern (4 chars).
  sparkle,

  /// Diagonal cascade sweep (4 chars).
  cascade,

  /// Columns filling bottom-up (3 chars).
  columns,

  /// Data compression visualization (10 chars).
  compress,

  /// Circling orbit pattern (1 char).
  orbit,

  /// Swinging pendulum wave (10 chars).
  pendulum,

  /// Breathing expansion/contraction (1 char).
  breathe,

  /// Wave moving through rows (4 chars).
  waveRows,

  /// Alternating checkerboard (3 chars).
  checkerboard,

  /// Double sine wave helix (4 chars).
  helix,

  /// Filling and sweeping rows (2 chars).
  fillSweep,

  /// Diagonal sweep wipe (2 chars).
  diagSwipe,

  /// Cursor typing effect (3 chars).
  typing,

  /// Conway's Game of Life (4 chars).
  gameOfLife,

  /// Horizontal progress bar (10 chars).
  progressBar,
}

/// Pre-computed map of all available spinners by name.
final Map<BrailleSpinnerName, Spinner> spinners = Map.unmodifiable({
  BrailleSpinnerName.braille: brailleSpinner,
  BrailleSpinnerName.brailleWave: brailleWaveSpinner,
  BrailleSpinnerName.dna: dnaSpinner,
  BrailleSpinnerName.scan: scanSpinner,
  BrailleSpinnerName.rain: rainSpinner,
  BrailleSpinnerName.scanLine: scanLineSpinner,
  BrailleSpinnerName.pulse: pulseSpinner,
  BrailleSpinnerName.snake: snakeSpinner,
  BrailleSpinnerName.sort: sortSpinner,
  BrailleSpinnerName.sparkle: sparkleSpinner,
  BrailleSpinnerName.cascade: cascadeSpinner,
  BrailleSpinnerName.columns: columnsSpinner,
  BrailleSpinnerName.compress: compressSpinner,
  BrailleSpinnerName.orbit: orbitSpinner,
  BrailleSpinnerName.pendulum: pendulumSpinner,
  BrailleSpinnerName.breathe: breatheSpinner,
  BrailleSpinnerName.waveRows: waveRowsSpinner,
  BrailleSpinnerName.checkerboard: checkerboardSpinner,
  BrailleSpinnerName.helix: helixSpinner,
  BrailleSpinnerName.fillSweep: fillSweepSpinner,
  BrailleSpinnerName.diagSwipe: diagSwipeSpinner,
  BrailleSpinnerName.typing: typingSpinner,
  BrailleSpinnerName.gameOfLife: gameOfLifeSpinner,
  BrailleSpinnerName.progressBar: progressBarSpinner,
});
