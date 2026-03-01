// Hardcoded spinner definitions for braille, braillewave, and dna.

import 'package:unicode_animations/unicode_animations.dart';

/// Classic Braille spinner: 10 frames rotating through Braille dots.
const Spinner brailleSpinner = Spinner(
  frames: [
    '⠋',
    '⠙',
    '⠹',
    '⠸',
    '⠼',
    '⠴',
    '⠦',
    '⠧',
    '⠇',
    '⠏',
  ],
  intervalInMs: 80,
);

/// Braille wave: 8 frames showing a wave pattern across 4 characters.
const Spinner brailleWaveSpinner = Spinner(
  frames: [
    '⠁⠂⠄⡀',
    '⠂⠄⡀⢀',
    '⠄⡀⢀⠠',
    '⡀⢀⠠⠐',
    '⢀⠠⠐⠈',
    '⠠⠐⠈⠁',
    '⠐⠈⠁⠂',
    '⠈⠁⠂⠄',
  ],
  intervalInMs: 100,
);

/// DNA spinner: 12 frames showing a DNA double-helix pattern across 4 characters.
const Spinner dnaSpinner = Spinner(
  frames: [
    '⠋⠉⠙⠚',
    '⠉⠙⠚⠒',
    '⠙⠚⠒⠂',
    '⠚⠒⠂⠂',
    '⠒⠂⠂⠒',
    '⠂⠂⠒⠲',
    '⠂⠒⠲⠴',
    '⠒⠲⠴⠤',
    '⠲⠴⠤⠄',
    '⠴⠤⠄⠋',
    '⠤⠄⠋⠉',
    '⠄⠋⠉⠙',
  ],
  intervalInMs: 80,
);
