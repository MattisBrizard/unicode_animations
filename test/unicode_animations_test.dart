import 'package:test/test.dart';
import 'package:unicode_animations/unicode_animations.dart';

void main() {
  group('Spinner class', () {
    test('has frames and intervalInMs', () {
      const spinner = Spinner(
        frames: ['a', 'b'],
        intervalInMs: 100,
      );
      expect(spinner.frames, ['a', 'b']);
      expect(spinner.intervalInMs, 100);
    });
  });

  group('Braille helpers', () {
    test('makeGrid creates correct dimensions', () {
      final grid = makeGrid(4, 8);
      expect(grid.length, 4);
      expect(grid[0].length, 8);
      expect(grid, isA<List<List<bool>>>());
    });

    test('makeGrid initializes to false', () {
      final grid = makeGrid(2, 2);
      for (final row in grid) {
        for (final cell in row) {
          expect(cell, false);
        }
      }
    });

    test('gridToBraille single dot at (0,0)', () {
      final grid = makeGrid(4, 2);
      grid[0][0] = true;
      // (0,0) has bit 0x01, base 0x2800 → 0x2801 (⠁)
      expect(gridToBraille(grid), '⠁');
    });

    test('gridToBraille single dot at (0,1)', () {
      final grid = makeGrid(4, 2);
      grid[0][1] = true;
      // (0,1) has bit 0x08, base 0x2800 → 0x2808 (⠈)
      expect(gridToBraille(grid), '⠈');
    });

    test('gridToBraille single dot at (3,1)', () {
      final grid = makeGrid(4, 2);
      grid[3][1] = true;
      // (3,1) has bit 0x80, base 0x2800 → 0x2880 (⢀)
      expect(gridToBraille(grid), '⢀');
    });

    test('gridToBraille all dots true', () {
      final grid = makeGrid(4, 2);
      for (int i = 0; i < 4; i++) {
        for (int j = 0; j < 2; j++) {
          grid[i][j] = true;
        }
      }
      // All 8 bits set: 0x2800 | 0xFF = 0x28FF (⣿)
      expect(gridToBraille(grid), '⣿');
    });

    test('gridToBraille multiple characters', () {
      final grid = makeGrid(4, 4);
      // First pair: top-left dot only
      grid[0][0] = true;
      // Second pair: all dots
      for (int i = 0; i < 4; i++) {
        grid[i][2] = true;
        grid[i][3] = true;
      }
      expect(gridToBraille(grid), '⠁⣿');
    });

    test('gridToBraille empty grid', () {
      final grid = makeGrid(4, 0);
      expect(gridToBraille(grid), '');
    });

    test('gridToBraille throws on wrong row count', () {
      final grid = makeGrid(3, 2);
      expect(
        () => gridToBraille(grid),
        throwsA(isA<ArgumentError>()),
      );
    });

    test('gridToBraille throws on odd column count', () {
      final grid = makeGrid(4, 3);
      expect(
        () => gridToBraille(grid),
        throwsA(isA<ArgumentError>()),
      );
    });

    test('gridToBraille throws on inconsistent row lengths', () {
      final grid = <List<bool>>[
        [true, false],
        [false, true, false, true],
        [false, false],
        [false, false],
      ];
      expect(
        () => gridToBraille(grid),
        throwsA(isA<ArgumentError>()),
      );
    });
  });

  group('Hardcoded spinners', () {
    test('braille spinner has correct frame count', () {
      expect(spinners[BrailleSpinnerName.braille]!.frames.length, 10);
    });

    test('braille spinner has correct intervalInMs', () {
      expect(spinners[BrailleSpinnerName.braille]!.intervalInMs, 80);
    });

    test('braille spinner has correct frames', () {
      final expected = [
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
      ];
      expect(
        spinners[BrailleSpinnerName.braille]!.frames,
        expected,
      );
    });

    test('brailleWave spinner has correct frame count', () {
      expect(spinners[BrailleSpinnerName.brailleWave]!.frames.length, 8);
    });

    test('brailleWave spinner has correct intervalInMs', () {
      expect(spinners[BrailleSpinnerName.brailleWave]!.intervalInMs, 100);
    });

    test('brailleWave spinner has correct frames', () {
      final expected = [
        '⠁⠂⠄⡀',
        '⠂⠄⡀⢀',
        '⠄⡀⢀⠠',
        '⡀⢀⠠⠐',
        '⢀⠠⠐⠈',
        '⠠⠐⠈⠁',
        '⠐⠈⠁⠂',
        '⠈⠁⠂⠄',
      ];
      expect(
        spinners[BrailleSpinnerName.brailleWave]!.frames,
        expected,
      );
    });

    test('dna spinner has correct frame count', () {
      expect(spinners[BrailleSpinnerName.dna]!.frames.length, 12);
    });

    test('dna spinner has correct intervalInMs', () {
      expect(spinners[BrailleSpinnerName.dna]!.intervalInMs, 80);
    });

    test('dna spinner has correct frames', () {
      final expected = [
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
      ];
      expect(
        spinners[BrailleSpinnerName.dna]!.frames,
        expected,
      );
    });
  });

  group('Scan spinner', () {
    test('scan spinner has correct frame count', () {
      expect(spinners[BrailleSpinnerName.scan]!.frames.length, 10);
    });

    test('scan spinner has correct intervalInMs', () {
      expect(spinners[BrailleSpinnerName.scan]!.intervalInMs, 70);
    });

    test('scan spinner has correct frames', () {
      final expected = [
        '⡇⠀⠀⠀',
        '⣿⠀⠀⠀',
        '⢸⡇⠀⠀',
        '⠀⣿⠀⠀',
        '⠀⢸⡇⠀',
        '⠀⠀⣿⠀',
        '⠀⠀⢸⡇',
        '⠀⠀⠀⣿',
        '⠀⠀⠀⢸',
        '⠀⠀⠀⠀',
      ];
      expect(spinners[BrailleSpinnerName.scan]!.frames, expected);
    });
  });

  group('Rain spinner', () {
    test('rain spinner has correct frame count', () {
      expect(spinners[BrailleSpinnerName.rain]!.frames.length, 12);
    });

    test('rain spinner has correct intervalInMs', () {
      expect(spinners[BrailleSpinnerName.rain]!.intervalInMs, 100);
    });

    test('rain spinner has correct frames', () {
      final expected = [
        '⢁⠂⠔⠈',
        '⠂⠌⡠⠐',
        '⠄⡐⢀⠡',
        '⡈⠠⠀⢂',
        '⠐⢀⠁⠄',
        '⠠⠁⠊⡀',
        '⢁⠂⠔⠈',
        '⠂⠌⡠⠐',
        '⠄⡐⢀⠡',
        '⡈⠠⠀⢂',
        '⠐⢀⠁⠄',
        '⠠⠁⠊⡀',
      ];
      expect(spinners[BrailleSpinnerName.rain]!.frames, expected);
    });
  });

  group('ScanLine spinner', () {
    test('scanLine spinner has correct frame count', () {
      expect(spinners[BrailleSpinnerName.scanLine]!.frames.length, 6);
    });

    test('scanLine spinner has correct intervalInMs', () {
      expect(spinners[BrailleSpinnerName.scanLine]!.intervalInMs, 120);
    });

    test('scanLine spinner has correct frames', () {
      final expected = [
        '⠉⠉⠉',
        '⠓⠓⠓',
        '⠦⠦⠦',
        '⣄⣄⣄',
        '⠦⠦⠦',
        '⠓⠓⠓',
      ];
      expect(spinners[BrailleSpinnerName.scanLine]!.frames, expected);
    });
  });

  group('Pulse spinner', () {
    test('pulse spinner has correct frame count', () {
      expect(spinners[BrailleSpinnerName.pulse]!.frames.length, 5);
    });

    test('pulse spinner has correct intervalInMs', () {
      expect(spinners[BrailleSpinnerName.pulse]!.intervalInMs, 180);
    });

    test('pulse spinner has correct frames', () {
      final expected = [
        '⠀⠶⠀',
        '⠰⣿⠆',
        '⢾⣉⡷',
        '⣏⠀⣹',
        '⡁⠀⢈',
      ];
      expect(spinners[BrailleSpinnerName.pulse]!.frames, expected);
    });
  });

  group('Snake spinner', () {
    test('snake spinner has correct frame count', () {
      expect(spinners[BrailleSpinnerName.snake]!.frames.length, 16);
    });

    test('snake spinner has correct intervalInMs', () {
      expect(spinners[BrailleSpinnerName.snake]!.intervalInMs, 80);
    });

    test('snake spinner has correct frames', () {
      final expected = [
        '⣁⡀',
        '⣉⠀',
        '⡉⠁',
        '⠉⠉',
        '⠈⠙',
        '⠀⠛',
        '⠐⠚',
        '⠒⠒',
        '⠖⠂',
        '⠶⠀',
        '⠦⠄',
        '⠤⠤',
        '⠠⢤',
        '⠀⣤',
        '⢀⣠',
        '⣀⣀',
      ];
      expect(spinners[BrailleSpinnerName.snake]!.frames, expected);
    });
  });

  group('Sparkle spinner', () {
    test('sparkle spinner has correct frame count', () {
      expect(spinners[BrailleSpinnerName.sparkle]!.frames.length, 6);
    });

    test('sparkle spinner has correct intervalInMs', () {
      expect(spinners[BrailleSpinnerName.sparkle]!.intervalInMs, 150);
    });

    test('sparkle spinner has correct frames', () {
      final expected = [
        '⡡⠊⢔⠡',
        '⠊⡰⡡⡘',
        '⢔⢅⠈⢢',
        '⡁⢂⠆⡍',
        '⢔⠨⢑⢐',
        '⠨⡑⡠⠊',
      ];
      expect(spinners[BrailleSpinnerName.sparkle]!.frames, expected);
    });
  });

  group('Cascade spinner', () {
    test('cascade spinner has correct frame count', () {
      expect(spinners[BrailleSpinnerName.cascade]!.frames.length, 14);
    });

    test('cascade spinner has correct intervalInMs', () {
      expect(spinners[BrailleSpinnerName.cascade]!.intervalInMs, 60);
    });

    test('cascade spinner has correct frames', () {
      final expected = [
        '⠀⠀⠀⠀',
        '⠀⠀⠀⠀',
        '⠁⠀⠀⠀',
        '⠋⠀⠀⠀',
        '⠞⠁⠀⠀',
        '⡴⠋⠀⠀',
        '⣠⠞⠁⠀',
        '⢀⡴⠋⠀',
        '⠀⣠⠞⠁',
        '⠀⢀⡴⠋',
        '⠀⠀⣠⠞',
        '⠀⠀⢀⡴',
        '⠀⠀⠀⣠',
        '⠀⠀⠀⢀',
      ];
      expect(spinners[BrailleSpinnerName.cascade]!.frames, expected);
    });
  });

  group('Columns spinner', () {
    test('columns spinner has correct frame count', () {
      expect(spinners[BrailleSpinnerName.columns]!.frames.length, 26);
    });

    test('columns spinner has correct intervalInMs', () {
      expect(spinners[BrailleSpinnerName.columns]!.intervalInMs, 60);
    });

    test('columns spinner has correct frames', () {
      final expected = [
        '⡀⠀⠀',
        '⡄⠀⠀',
        '⡆⠀⠀',
        '⡇⠀⠀',
        '⣇⠀⠀',
        '⣧⠀⠀',
        '⣷⠀⠀',
        '⣿⠀⠀',
        '⣿⡀⠀',
        '⣿⡄⠀',
        '⣿⡆⠀',
        '⣿⡇⠀',
        '⣿⣇⠀',
        '⣿⣧⠀',
        '⣿⣷⠀',
        '⣿⣿⠀',
        '⣿⣿⡀',
        '⣿⣿⡄',
        '⣿⣿⡆',
        '⣿⣿⡇',
        '⣿⣿⣇',
        '⣿⣿⣧',
        '⣿⣿⣷',
        '⣿⣿⣿',
        '⣿⣿⣿',
        '⠀⠀⠀',
      ];
      expect(spinners[BrailleSpinnerName.columns]!.frames, expected);
    });
  });

  group('Orbit spinner', () {
    test('orbit spinner has correct frame count', () {
      expect(spinners[BrailleSpinnerName.orbit]!.frames.length, 8);
    });

    test('orbit spinner has correct intervalInMs', () {
      expect(spinners[BrailleSpinnerName.orbit]!.intervalInMs, 100);
    });

    test('orbit spinner has correct frames', () {
      final expected = [
        '⠃',
        '⠉',
        '⠘',
        '⠰',
        '⢠',
        '⣀',
        '⡄',
        '⠆',
      ];
      expect(spinners[BrailleSpinnerName.orbit]!.frames, expected);
    });
  });

  group('Breathe spinner', () {
    test('breathe spinner has correct frame count', () {
      expect(spinners[BrailleSpinnerName.breathe]!.frames.length, 17);
    });

    test('breathe spinner has correct intervalInMs', () {
      expect(spinners[BrailleSpinnerName.breathe]!.intervalInMs, 100);
    });

    test('breathe spinner has correct frames', () {
      final expected = [
        '⠀',
        '⠂',
        '⠌',
        '⡑',
        '⢕',
        '⢝',
        '⣫',
        '⣟',
        '⣿',
        '⣟',
        '⣫',
        '⢝',
        '⢕',
        '⡑',
        '⠌',
        '⠂',
        '⠀',
      ];
      expect(spinners[BrailleSpinnerName.breathe]!.frames, expected);
    });
  });

  group('WaveRows spinner', () {
    test('waveRows spinner has correct frame count', () {
      expect(spinners[BrailleSpinnerName.waveRows]!.frames.length, 16);
    });

    test('waveRows spinner has correct intervalInMs', () {
      expect(spinners[BrailleSpinnerName.waveRows]!.intervalInMs, 90);
    });

    test('waveRows spinner has correct frames', () {
      final expected = [
        '⠖⠉⠉⠑',
        '⡠⠖⠉⠉',
        '⣠⡠⠖⠉',
        '⣄⣠⡠⠖',
        '⠢⣄⣠⡠',
        '⠙⠢⣄⣠',
        '⠉⠙⠢⣄',
        '⠊⠉⠙⠢',
        '⠜⠊⠉⠙',
        '⡤⠜⠊⠉',
        '⣀⡤⠜⠊',
        '⢤⣀⡤⠜',
        '⠣⢤⣀⡤',
        '⠑⠣⢤⣀',
        '⠉⠑⠣⢤',
        '⠋⠉⠑⠣',
      ];
      expect(spinners[BrailleSpinnerName.waveRows]!.frames, expected);
    });
  });

  group('Checkerboard spinner', () {
    test('checkerboard spinner has correct frame count', () {
      expect(spinners[BrailleSpinnerName.checkerboard]!.frames.length, 4);
    });

    test('checkerboard spinner has correct intervalInMs', () {
      expect(spinners[BrailleSpinnerName.checkerboard]!.intervalInMs, 250);
    });

    test('checkerboard spinner has correct frames', () {
      final expected = [
        '⢕⢕⢕',
        '⡪⡪⡪',
        '⢊⠔⡡',
        '⡡⢊⠔',
      ];
      expect(spinners[BrailleSpinnerName.checkerboard]!.frames, expected);
    });
  });

  group('Helix spinner', () {
    test('helix spinner has correct frame count', () {
      expect(spinners[BrailleSpinnerName.helix]!.frames.length, 16);
    });

    test('helix spinner has correct intervalInMs', () {
      expect(spinners[BrailleSpinnerName.helix]!.intervalInMs, 80);
    });

    test('helix spinner has correct frames', () {
      final expected = [
        '⢌⣉⢎⣉',
        '⣉⡱⣉⡱',
        '⣉⢎⣉⢎',
        '⡱⣉⡱⣉',
        '⢎⣉⢎⣉',
        '⣉⡱⣉⡱',
        '⣉⢎⣉⢎',
        '⡱⣉⡱⣉',
        '⢎⣉⢎⣉',
        '⣉⡱⣉⡱',
        '⣉⢎⣉⢎',
        '⡱⣉⡱⣉',
        '⢎⣉⢎⣉',
        '⣉⡱⣉⡱',
        '⣉⢎⣉⢎',
        '⡱⣉⡱⣉',
      ];
      expect(spinners[BrailleSpinnerName.helix]!.frames, expected);
    });
  });

  group('FillSweep spinner', () {
    test('fillSweep spinner has correct frame count', () {
      expect(spinners[BrailleSpinnerName.fillSweep]!.frames.length, 11);
    });

    test('fillSweep spinner has correct intervalInMs', () {
      expect(spinners[BrailleSpinnerName.fillSweep]!.intervalInMs, 100);
    });

    test('fillSweep spinner has correct frames', () {
      final expected = [
        '⣀⣀',
        '⣤⣤',
        '⣶⣶',
        '⣿⣿',
        '⣿⣿',
        '⣿⣿',
        '⣶⣶',
        '⣤⣤',
        '⣀⣀',
        '⠀⠀',
        '⠀⠀',
      ];
      expect(spinners[BrailleSpinnerName.fillSweep]!.frames, expected);
    });
  });

  group('DiagSwipe spinner', () {
    test('diagSwipe spinner has correct frame count', () {
      expect(spinners[BrailleSpinnerName.diagSwipe]!.frames.length, 16);
    });

    test('diagSwipe spinner has correct intervalInMs', () {
      expect(spinners[BrailleSpinnerName.diagSwipe]!.intervalInMs, 60);
    });

    test('diagSwipe spinner has correct frames', () {
      final expected = [
        '⠁⠀',
        '⠋⠀',
        '⠟⠁',
        '⡿⠋',
        '⣿⠟',
        '⣿⡿',
        '⣿⣿',
        '⣿⣿',
        '⣾⣿',
        '⣴⣿',
        '⣠⣾',
        '⢀⣴',
        '⠀⣠',
        '⠀⢀',
        '⠀⠀',
        '⠀⠀',
      ];
      expect(spinners[BrailleSpinnerName.diagSwipe]!.frames, expected);
    });
  });

  group('Pendulum spinner', () {
    test('pendulum spinner has correct frame count', () {
      expect(spinners[BrailleSpinnerName.pendulum]!.frames.length, 120);
    });

    test('pendulum spinner has correct intervalInMs', () {
      expect(spinners[BrailleSpinnerName.pendulum]!.intervalInMs, 12);
    });

    test('pendulum spinner has correct frames', () {
      final expected = [
        '⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶',
        '⠒⠒⠒⠒⠒⠒⠒⠛⠛⠛',
        '⠒⠚⠛⠛⠛⠉⠉⠉⠉⠉',
        '⠛⠛⠉⠉⠉⠉⠉⠉⠉⠉',
        '⠋⠉⠉⠉⠉⠉⠉⠛⠓⠒',
        '⠉⠉⠉⠉⠙⠛⠒⠒⠶⠤',
        '⠉⠉⠉⠙⠓⠒⠦⠤⣤⣀',
        '⠉⠉⠙⠓⠲⠤⢤⣄⣀⣀',
        '⠉⠙⠓⠲⠤⣤⣀⣀⣀⣤',
        '⠉⠓⠲⠤⣤⣀⣀⣠⡤⠴',
        '⠙⠒⠦⢤⣀⣀⣠⡤⠖⠚',
        '⠓⠲⢤⣄⣀⣠⡤⠖⠛⠉',
        '⠓⠦⣤⣀⣀⡤⠖⠚⠉⠉',
        '⠲⢤⣄⣀⡤⠴⠚⠉⠉⠓',
        '⠢⢤⣀⣠⠴⠚⠉⠉⠓⠦',
        '⠦⣄⣀⡤⠖⠋⠉⠓⠢⣄',
        '⢤⣀⣠⠴⠚⠉⠙⠲⢤⣀',
        '⢤⣀⣠⠔⠋⠉⠓⢤⣀⣠',
        '⣄⣀⡤⠚⠉⠙⠢⣄⣀⡤',
        '⣄⣠⠴⠊⠉⠓⢤⣀⡠⠖',
        '⣀⣠⠖⠋⠙⠢⣄⣠⠴⠋',
        '⣀⡤⠚⠉⠓⢤⣀⡤⠚⠉',
        '⣀⡴⠊⠉⠲⣄⣠⠔⠋⠙',
        '⣠⠔⠋⠙⠦⣀⡠⠚⠉⠳',
        '⣠⠖⠉⠓⢤⣀⠴⠋⠙⠦',
        '⡠⠚⠉⠲⣄⣠⠞⠉⠳⢄',
        '⡤⠊⠙⠢⣀⡤⠊⠙⠢⣀',
        '⡴⠋⠑⢦⣀⠔⠋⠑⢄⣠',
        '⠔⠋⠓⢄⣠⠞⠉⠢⣄⡠',
        '⠔⠉⠳⣄⡠⠊⠙⢦⣀⠔',
        '⠞⠉⠢⣀⡴⠋⠑⢄⡠⠚',
        '⠊⠙⢦⣀⠔⠉⠢⣀⡴⠋',
        '⠊⠑⢄⣠⠞⠙⢦⣀⠔⠉',
        '⠋⠑⢄⡠⠊⠑⢄⡠⠊⠙',
        '⠋⠳⣄⡴⠋⠳⣄⡴⠋⠳',
        '⠉⠢⣀⠔⠉⠢⣀⠔⠉⠢',
        '⠉⠢⣀⠜⠙⢦⣠⠞⠙⢦',
        '⠙⢦⣠⠎⠑⢄⡠⠊⠑⣄',
        '⠙⢄⡠⠊⠑⣄⡴⠋⠣⣀',
        '⠑⢄⡠⠋⠣⣀⠔⠉⢢⣠',
        '⠑⣄⡔⠉⠢⣀⠞⠙⢄⡠',
        '⠳⣄⠔⠉⢦⣠⠊⠑⣄⡔',
        '⠣⣀⠜⠙⢄⡠⠋⠣⣀⠜',
        '⠢⣠⠎⠑⢄⡴⠉⠢⣠⠎',
        '⢢⣠⠊⠱⣄⠔⠙⢆⡠⠊',
        '⢦⡠⠊⠣⣀⠜⠑⢄⡴⠋',
        '⢄⡰⠋⠢⣠⠎⠑⣄⠔⠙',
        '⢄⡴⠉⢢⡠⠊⠳⣀⠜⠑',
        '⣄⡔⠙⢆⡠⠋⠢⣠⠊⠑',
        '⣄⠜⠙⢄⡴⠉⢢⡠⠊⠣',
        '⣀⠜⠑⢄⡔⠙⢆⡠⠋⠢',
        '⣠⠎⠑⣄⠜⠙⢄⡔⠉⢦',
        '⣠⠊⠳⣀⠞⠑⣄⠔⠙⢄',
        '⡠⠊⠣⣠⠎⠱⣄⠜⠑⢄',
        '⡠⠋⠢⣠⠊⠣⣀⠎⠑⣄',
        '⡰⠉⢢⡠⠋⠢⣠⠊⠳⣀',
        '⡔⠉⢆⡠⠋⢢⡠⠊⠣⣠',
        '⡔⠙⢄⡰⠉⢦⡠⠋⢢⡠',
        '⠜⠙⢄⡔⠙⢄⡰⠉⢢⡠',
        '⠜⠑⣄⠔⠙⢄⡔⠙⢆⡰',
        '⠎⠑⣄⠜⠑⣄⡔⠙⢄⡔',
        '⠊⠱⣀⠞⠑⣄⠜⠑⢄⡔',
        '⠊⠣⣠⠎⠱⣀⠜⠑⣄⠔',
        '⠋⠢⣠⠊⠣⣀⠎⠱⣄⠜',
        '⠋⢢⡠⠊⠣⣠⠊⠱⣀⠞',
        '⠉⢦⡠⠋⠢⣠⠊⠣⣀⠎',
        '⠙⢆⡰⠋⢢⡠⠊⠣⣠⠊',
        '⠙⢄⡴⠉⢦⡠⠋⠢⣠⠊',
        '⠑⢄⡔⠙⢆⡰⠋⢢⡠⠊',
        '⠑⣄⠔⠙⢄⡰⠉⢢⡠⠊',
        '⠱⣄⠜⠙⢄⡔⠉⢦⡠⠋',
        '⠳⣀⠜⠑⢄⡔⠉⢆⡠⠋',
        '⠣⣠⠎⠑⣄⠔⠙⢆⡠⠋',
        '⠢⣠⠊⠱⣄⠔⠙⢄⡰⠋',
        '⢢⡠⠊⠳⣀⠜⠙⢄⡰⠋',
        '⢦⡠⠊⠣⣀⠜⠑⢄⡴⠋',
        '⢄⡠⠋⠣⣀⠞⠑⢄⡴⠉',
        '⢄⡴⠋⠢⣠⠞⠑⢄⡴⠉',
        '⣄⡔⠉⢢⣠⠎⠑⢄⡴⠉',
        '⣄⠔⠉⢢⣠⠊⠑⣄⡴⠉',
        '⣀⠔⠙⢦⣠⠊⠑⣄⡴⠉',
        '⣀⠜⠙⢆⡠⠊⠑⣄⡴⠋',
        '⣠⠞⠙⢄⡠⠊⠑⣄⡴⠋',
        '⣠⠊⠑⢄⡠⠊⠑⣄⡴⠋',
        '⡠⠊⠑⢄⡠⠊⠑⣄⡴⠋',
        '⡠⠊⠑⣄⡠⠋⠑⣄⡴⠋',
        '⡴⠋⠳⣄⡴⠋⠑⣄⡠⠋',
        '⡴⠋⠳⣄⡴⠋⠑⣄⡠⠊',
        '⠔⠉⠣⣄⡴⠋⠓⢄⡠⠊',
        '⠔⠉⠢⣀⡴⠋⠑⢄⡠⠊',
        '⠞⠉⠢⣀⡴⠋⠑⢄⡠⠚',
        '⠚⠙⠢⣀⡴⠋⠑⢄⣠⠞',
        '⠊⠙⢦⣀⠔⠋⠑⢄⣠⠞',
        '⠋⠙⢦⣀⠔⠋⠑⢄⣠⠔',
        '⠋⠑⢤⣀⠔⠋⠑⢤⣀⠔',
        '⠉⠓⢄⣀⠔⠋⠑⢤⣀⠴',
        '⠉⠳⢄⣠⠔⠋⠑⢦⣀⡤',
        '⠉⠲⣄⣠⠔⠋⠙⠦⣀⡤',
        '⠙⠢⣄⣠⠔⠋⠙⠦⣀⡠',
        '⠙⠢⣄⣠⠔⠋⠙⠢⣄⣠',
        '⠑⠦⣀⣠⠔⠋⠙⠢⣄⣀',
        '⠓⢦⣀⣠⠔⠋⠙⠲⢄⣀',
        '⠓⢤⣀⣠⠔⠋⠉⠲⢤⣀',
        '⠲⢤⣀⡠⠖⠋⠉⠓⢤⣀',
        '⠢⣄⣀⡤⠖⠋⠉⠓⠦⣄',
        '⠦⣄⣀⡤⠖⠋⠉⠓⠢⣄',
        '⢤⣄⣀⡤⠖⠋⠉⠙⠲⢤',
        '⢤⣀⣀⡤⠖⠋⠉⠙⠒⠤',
        '⣄⣀⣀⡤⠖⠛⠉⠉⠓⠦',
        '⣄⣀⣠⡤⠖⠚⠉⠉⠛⠲',
        '⣀⣀⣠⠤⠖⠚⠉⠉⠙⠓',
        '⣀⣀⣠⠤⠖⠚⠋⠉⠉⠛',
        '⣀⣀⣤⠤⠖⠚⠋⠉⠉⠙',
        '⣀⣠⡤⠤⠖⠒⠛⠉⠉⠉',
        '⣀⣠⡤⠤⠖⠒⠛⠉⠉⠉',
        '⣠⣤⠤⠴⠶⠒⠚⠛⠉⠉',
        '⣤⡤⠤⠴⠶⠒⠒⠛⠋⠉',
        '⡤⠤⠤⠴⠶⠒⠒⠒⠛⠛',
        '⠤⠤⠤⠶⠶⠖⠒⠒⠒⠚',
        '⠤⠴⠶⠶⠶⠶⠶⠒⠒⠒',
      ];
      expect(spinners[BrailleSpinnerName.pendulum]!.frames, expected);
    });
  });

  group('Compress spinner', () {
    test('compress spinner has correct frame count', () {
      expect(spinners[BrailleSpinnerName.compress]!.frames.length, 100);
    });

    test('compress spinner has correct intervalInMs', () {
      expect(spinners[BrailleSpinnerName.compress]!.intervalInMs, 40);
    });

    test('compress spinner has correct frames', () {
      final expected = [
        '⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿',
        '⣿⣽⣿⣿⣿⣾⣿⣿⣿⣿',
        '⣿⣽⣿⣿⣿⣾⣿⡿⣿⣿',
        '⣿⣽⣿⣿⣿⣾⣿⣿⣿⡇',
        '⣿⣽⣿⣿⣿⣾⣷⢿⣿⡇',
        '⣿⣽⣽⣾⣷⣿⣷⢿⣿⡇',
        '⣿⣽⣽⣾⣷⣿⣷⢿⣿⡇',
        '⣿⣽⣹⣿⣷⣿⣷⢯⣿⡇',
        '⣿⣽⣹⣿⣷⣿⣷⢿⣿⠀',
        '⣿⣽⣷⣿⣷⣿⣿⣽⣿⠀',
        '⣿⣽⣷⣿⣷⣿⡿⣽⣿⠀',
        '⣿⣼⣷⣿⣷⣿⡺⣽⣿⠀',
        '⣿⣬⣷⣿⣷⡿⡺⣽⡇⠀',
        '⣿⣨⣷⣯⣿⡿⡺⣽⡇⠀',
        '⣿⣨⣷⣯⣿⡿⣺⣿⡇⠀',
        '⣿⡍⡧⣿⣾⡿⣯⣿⡇⠀',
        '⣿⡍⡧⣿⣾⣿⢯⣿⡇⠀',
        '⣿⡍⡧⣿⣾⣾⢏⣿⠀⠀',
        '⣿⡍⡧⣿⣾⣗⢏⣿⠀⠀',
        '⣿⡍⡧⣿⣾⢗⢿⣿⠀⠀',
        '⣿⡍⣿⣼⣾⢗⣿⣿⠀⠀',
        '⣿⡍⣿⣼⣷⢿⣹⣿⠀⠀',
        '⣿⡍⣿⣼⣷⢿⣹⡇⠀⠀',
        '⣿⡍⣿⣼⣳⡿⣹⡇⠀⠀',
        '⣿⡍⣿⣼⣳⡿⣿⡇⠀⠀',
        '⣿⡍⣿⣷⣻⡺⣿⡇⠀⠀',
        '⣿⡍⣿⣵⣻⣺⡾⠀⠀⠀',
        '⣿⣽⢼⣱⡿⣏⡾⠀⠀⠀',
        '⣿⣽⢼⢱⡿⣏⡿⠀⠀⠀',
        '⣿⣽⢼⢹⣾⢿⠿⠀⠀⠀',
        '⣿⣼⢼⢹⣾⢿⠿⠀⠀⠀',
        '⣿⣼⢼⢹⣗⣷⠇⠀⠀⠀',
        '⣿⣼⣇⣟⣗⣷⠇⠀⠀⠀',
        '⣿⣼⣇⣟⣿⣹⠇⠀⠀⠀',
        '⣿⣹⣇⣿⢿⣹⠇⠀⠀⠀',
        '⣿⣹⣇⣾⠿⡟⠇⠀⠀⠀',
        '⣻⣹⣇⣾⠿⡿⠀⠀⠀⠀',
        '⣻⣹⣇⣷⢿⡾⠀⠀⠀⠀',
        '⣻⣱⣇⣿⢺⡿⠀⠀⠀⠀',
        '⣻⣱⢇⣿⢏⡿⠀⠀⠀⠀',
        '⣻⣱⡇⣿⢿⠻⠀⠀⠀⠀',
        '⣻⣱⣷⢻⢿⠇⠀⠀⠀⠀',
        '⣻⣱⣷⡿⡷⠇⠀⠀⠀⠀',
        '⣻⣱⣷⡿⡿⠆⠀⠀⠀⠀',
        '⣻⣱⣷⡿⡿⠆⠀⠀⠀⠀',
        '⣇⡳⣸⡿⡿⠀⠀⠀⠀⠀',
        '⣇⡳⣸⡿⡿⠀⠀⠀⠀⠀',
        '⣃⡳⣰⡿⡿⠀⠀⠀⠀⠀',
        '⣃⡳⣰⡿⠷⠀⠀⠀⠀⠀',
        '⣃⡳⣰⠿⠷⠀⠀⠀⠀⠀',
        '⣃⡳⣴⠿⠇⠀⠀⠀⠀⠀',
        '⣃⣳⣴⠿⠇⠀⠀⠀⠀⠀',
        '⣃⡳⣼⠿⠇⠀⠀⠀⠀⠀',
        '⣃⡷⣾⠿⠆⠀⠀⠀⠀⠀',
        '⣃⡷⣾⠿⠆⠀⠀⠀⠀⠀',
        '⣃⡷⣾⠿⠀⠀⠀⠀⠀⠀',
        '⣋⡶⡞⠿⠀⠀⠀⠀⠀⠀',
        '⣋⡶⡾⠿⠀⠀⠀⠀⠀⠀',
        '⣋⡆⡾⠷⠀⠀⠀⠀⠀⠀',
        '⣋⣦⡿⠇⠀⠀⠀⠀⠀⠀',
        '⣋⣦⡿⠇⠀⠀⠀⠀⠀⠀',
        '⣋⣦⠯⠇⠀⠀⠀⠀⠀⠀',
        '⣋⢶⠯⠇⠀⠀⠀⠀⠀⠀',
        '⣚⢶⠿⠆⠀⠀⠀⠀⠀⠀',
        '⣚⢶⠿⠀⠀⠀⠀⠀⠀⠀',
        '⣚⢶⠿⠀⠀⠀⠀⠀⠀⠀',
        '⣚⢾⠏⠀⠀⠀⠀⠀⠀⠀',
        '⣚⢾⠏⠀⠀⠀⠀⠀⠀⠀',
        '⣺⠞⠅⠀⠀⠀⠀⠀⠀⠀',
        '⣪⠾⠅⠀⠀⠀⠀⠀⠀⠀',
        '⣪⠮⠅⠀⠀⠀⠀⠀⠀⠀',
        '⣺⠮⠅⠀⠀⠀⠀⠀⠀⠀',
        '⣲⠮⠁⠀⠀⠀⠀⠀⠀⠀',
        '⣲⠭⠀⠀⠀⠀⠀⠀⠀⠀',
        '⢲⠍⠀⠀⠀⠀⠀⠀⠀⠀',
        '⡲⠅⠀⠀⠀⠀⠀⠀⠀⠀',
        '⡲⠅⠀⠀⠀⠀⠀⠀⠀⠀',
        '⡲⠁⠀⠀⠀⠀⠀⠀⠀⠀',
        '⡲⠁⠀⠀⠀⠀⠀⠀⠀⠀',
        '⡲⠁⠀⠀⠀⠀⠀⠀⠀⠀',
        '⡺⠀⠀⠀⠀⠀⠀⠀⠀⠀',
        '⡺⠀⠀⠀⠀⠀⠀⠀⠀⠀',
        '⡺⠀⠀⠀⠀⠀⠀⠀⠀⠀',
        '⡺⠀⠀⠀⠀⠀⠀⠀⠀⠀',
        '⡮⠀⠀⠀⠀⠀⠀⠀⠀⠀',
        '⡮⠀⠀⠀⠀⠀⠀⠀⠀⠀',
        '⡮⠀⠀⠀⠀⠀⠀⠀⠀⠀',
        '⡮⠀⠀⠀⠀⠀⠀⠀⠀⠀',
        '⡮⠀⠀⠀⠀⠀⠀⠀⠀⠀',
        '⡮⠀⠀⠀⠀⠀⠀⠀⠀⠀',
        '⡮⠀⠀⠀⠀⠀⠀⠀⠀⠀',
        '⡮⠀⠀⠀⠀⠀⠀⠀⠀⠀',
        '⡮⠀⠀⠀⠀⠀⠀⠀⠀⠀',
        '⡮⠀⠀⠀⠀⠀⠀⠀⠀⠀',
        '⡮⠀⠀⠀⠀⠀⠀⠀⠀⠀',
        '⡮⠀⠀⠀⠀⠀⠀⠀⠀⠀',
        '⡮⠀⠀⠀⠀⠀⠀⠀⠀⠀',
        '⡮⠀⠀⠀⠀⠀⠀⠀⠀⠀',
        '⡮⠀⠀⠀⠀⠀⠀⠀⠀⠀',
        '⡮⠀⠀⠀⠀⠀⠀⠀⠀⠀',
      ];
      expect(spinners[BrailleSpinnerName.compress]!.frames, expected);
    });
  });

  group('Sort spinner', () {
    test('sort spinner has correct frame count', () {
      expect(spinners[BrailleSpinnerName.sort]!.frames.length, 100);
    });

    test('sort spinner has correct intervalInMs', () {
      expect(spinners[BrailleSpinnerName.sort]!.intervalInMs, 40);
    });

    test('sort spinner has correct frames', () {
      final expected = [
        '⡏⠴⢁⠌⠓⠤⠢⠲⢤⠡',
        '⣿⡔⢁⠞⠱⠤⠢⠲⠤⠡',
        '⣿⡔⢁⠞⠡⠤⠢⠖⠴⠡',
        '⣿⡜⢁⠞⢡⢦⠣⠔⡴⠡',
        '⢹⠜⢃⠞⢡⢢⠡⠔⡔⠡',
        '⢹⠔⢃⠎⢁⢢⢡⠖⡔⠳',
        '⢹⡗⢢⠌⢁⢂⢁⠖⠔⠲',
        '⢹⡗⠢⠌⢣⢢⢁⠲⠔⠒',
        '⠉⡗⠢⠌⢢⢢⢁⠲⠶⠲',
        '⠉⡗⠡⠌⠢⠦⢁⠲⠢⠳',
        '⠉⣿⢡⠎⠦⠦⢁⠲⠢⠳',
        '⠉⣿⢡⠎⠦⠶⢃⠲⢢⠡',
        '⠉⢺⢡⠊⠢⠶⢂⠒⢢⠡',
        '⠉⢺⢡⠚⠢⠶⢂⠒⢦⠡',
        '⠉⢺⣧⠒⠣⠲⢦⠞⢦⠡',
        '⠉⢺⣧⠒⠣⠢⢦⠎⠤⠱',
        '⠉⠓⣧⠒⢡⠣⢢⠎⡤⠳',
        '⠉⠛⡧⠖⢡⢣⢂⠊⡴⠓',
        '⠉⠛⣿⠖⠡⢃⢃⠚⡴⠓',
        '⠉⠛⣿⠞⠣⢃⢃⠓⡴⠛',
        '⠉⠛⣿⠎⠣⢂⢁⠑⡴⠛',
        '⠉⠛⢻⠎⠳⢂⢁⠱⠤⠑',
        '⠉⠛⢻⡏⠒⢦⢁⠡⠤⠑',
        '⠉⠛⢻⡏⠒⢤⢃⠣⠦⠱',
        '⠉⠛⢻⡏⠓⠤⢣⠢⠦⠡',
        '⠉⠛⠳⡏⠳⠤⠢⠢⠦⠡',
        '⠉⠛⠓⣿⠣⠤⠢⠶⠤⢡',
        '⠉⠛⠓⣿⢣⠤⠣⠔⠴⢡',
        '⠉⠛⠓⣿⢣⠦⠣⠔⠔⠡',
        '⠉⠛⠓⢺⢃⠢⢡⠔⠔⠣',
        '⠉⠛⠓⢺⠣⢢⢁⠔⠔⠲',
        '⠉⠛⠓⢺⡧⢢⢁⠖⠔⠲',
        '⠉⠛⠓⢺⡧⢢⢁⠒⠖⠒',
        '⠉⠛⠓⠒⡧⠢⢁⠒⠶⠒',
        '⠉⠛⠓⠒⡧⠢⢁⠳⠢⠒',
        '⠉⠛⠓⠒⣿⠢⢃⠳⢢⠳',
        '⠉⠛⠓⠒⣿⠲⢂⠓⢢⠱',
        '⠉⠛⠓⠒⢺⠲⢂⠒⢂⠱',
        '⠉⠛⠓⠒⢺⠢⢆⠒⢦⠡',
        '⠉⠛⠓⠒⢺⡧⢦⠚⢤⠱',
        '⠉⠛⠓⠒⢺⡧⢦⠚⡤⠱',
        '⠉⠛⠓⠒⠲⡧⢢⠚⡤⠑',
        '⠉⠛⠓⠒⠲⡧⢣⠚⡰⠑',
        '⠉⠛⠓⠒⠲⣿⢃⠒⡰⠓',
        '⠉⠛⠓⠒⠲⣿⢃⠓⡔⠓',
        '⠉⠛⠓⠒⠲⣿⢃⠳⠴⠑',
        '⠉⠛⠓⠒⠲⢾⢃⠣⠴⠑',
        '⠉⠛⠓⠒⠲⢾⣇⠣⠦⠱',
        '⠉⠛⠓⠒⠲⢾⣇⠢⠦⠡',
        '⠉⠛⠓⠒⠲⢾⣇⠢⠢⠡',
        '⠉⠛⠓⠒⠲⠦⣇⠶⠢⢡',
        '⠉⠛⠓⠒⠲⠦⣿⠒⠦⢡',
        '⠉⠛⠓⠒⠲⠦⣿⠒⠶⢡',
        '⠉⠛⠓⠒⠲⠦⣿⠚⠴⠣',
        '⠉⠛⠓⠒⠲⠦⢾⠚⠔⠢',
        '⠉⠛⠓⠒⠲⠦⢾⠒⠔⠲',
        '⠉⠛⠓⠒⠲⠦⢾⡗⠴⠒',
        '⠉⠛⠓⠒⠲⠦⢾⡗⠴⠒',
        '⠉⠛⠓⠒⠲⠦⢤⡗⠦⠒',
        '⠉⠛⠓⠒⠲⠦⢤⡗⠤⠓',
        '⠉⠛⠓⠒⠲⠦⠤⣿⢤⠑',
        '⠉⠛⠓⠒⠲⠦⠤⣿⢄⠑',
        '⠉⠛⠓⠒⠲⠦⠤⢼⢄⠱',
        '⠉⠛⠓⠒⠲⠦⠤⢼⠤⠱',
        '⠉⠛⠓⠒⠲⠦⠤⢼⡧⠱',
        '⠉⠛⠓⠒⠲⠦⠤⢼⡧⠱',
        '⠉⠛⠓⠒⠲⠦⠤⠤⡧⠱',
        '⠉⠛⠓⠒⠲⠦⠤⠤⡧⠑',
        '⠉⠛⠓⠒⠲⠦⠤⠤⣿⠑',
        '⠉⠛⠓⠒⠲⠦⠤⠤⣿⠑',
        '⠉⠛⠓⠒⠲⠦⠤⠤⢼⠓',
        '⠉⠛⠓⠒⠲⠦⠤⠤⢼⠳',
        '⠉⠛⠓⠒⠲⠦⠤⠤⣼⡷',
        '⠉⠛⠓⠒⠲⠦⠤⢤⣼⡷',
        '⠉⠛⠓⠒⠲⠦⠤⢤⣼⡷',
        '⠉⠛⠓⠒⠲⠦⠤⢤⣤⡷',
        '⠉⠛⠓⠒⠲⠦⠤⢤⣤⣿',
        '⠉⠛⠓⠒⠲⠦⠤⢤⣤⣿',
        '⠉⠛⠓⠒⠲⠦⠤⢤⣤⣿',
        '⠉⠛⠓⠒⠲⠦⠤⢤⣤⢼',
        '⠉⠛⠓⠒⠲⠦⠤⢤⣤⢼',
        '⠉⠛⠓⠒⠲⠦⠤⢤⣤⢼',
        '⠉⠛⠓⠒⠲⠦⠤⢤⣤⣼',
        '⠉⠛⠓⠒⠲⠦⠤⢤⣤⣤',
        '⠉⠛⠓⠒⠲⠦⠤⢤⣤⣤',
        '⠉⠛⠓⠒⠲⠦⠤⢤⣤⣠',
        '⠉⠛⠓⠒⠲⠦⠤⢤⣤⣀',
        '⠉⠛⠓⠒⠲⠦⠤⢤⣤⣀',
        '⠉⠛⠓⠒⠲⠦⠤⢤⣤⣀',
        '⠉⠛⠓⠒⠲⠦⠤⢤⣤⣀',
        '⠉⠛⠓⠒⠲⠦⠤⢤⣤⣀',
        '⠉⠛⠓⠒⠲⠦⠤⢤⣤⣀',
        '⠉⠛⠓⠒⠲⠦⠤⢤⣤⣀',
        '⠉⠛⠓⠒⠲⠦⠤⢤⣤⣀',
        '⠉⠛⠓⠒⠲⠦⠤⢤⣤⣀',
        '⠉⠛⠓⠒⠲⠦⠤⢤⣤⣀',
        '⠉⠛⠓⠒⠲⠦⠤⢤⣤⣀',
        '⠉⠛⠓⠒⠲⠦⠤⢤⣤⣀',
        '⠉⠛⠓⠒⠲⠦⠤⢤⣤⣀',
        '⠉⠛⠓⠒⠲⠦⠤⢤⣤⣀',
      ];
      expect(spinners[BrailleSpinnerName.sort]!.frames, expected);
    });
  });

  group('Spinner.of', () {
    test('returns the correct spinner', () {
      expect(Spinner.of(BrailleSpinnerName.braille).frames.length, 10);
      expect(Spinner.of(BrailleSpinnerName.helix).frames.length, 16);
    });

    test('is identical to spinners map lookup', () {
      for (final name in BrailleSpinnerName.values) {
        expect(Spinner.of(name).frames, spinners[name]!.frames);
      }
    });
  });

  group('BrailleSpinnerName.values.byName', () {
    test('resolves known name', () {
      expect(
        BrailleSpinnerName.values.byName('helix'),
        BrailleSpinnerName.helix,
      );
    });

    test('throws ArgumentError for unknown name', () {
      expect(
        () => BrailleSpinnerName.values.byName('unknown'),
        throwsArgumentError,
      );
    });
  });

  group('Spinners map', () {
    test('contains all 21 spinners', () {
      expect(spinners.length, 21);
    });

    test('all spinners have non-empty frames', () {
      for (final entry in spinners.entries) {
        expect(
          entry.value.frames.isNotEmpty,
          true,
          reason: '${entry.key.name} should have frames',
        );
      }
    });

    test('all spinners have positive intervalInMs', () {
      for (final entry in spinners.entries) {
        expect(
          entry.value.intervalInMs > 0,
          true,
          reason: '${entry.key.name} should have positive intervalInMs',
        );
      }
    });
  });

  group('Generator parameterization', () {
    test('generateScan with custom intervalInMs', () {
      final spinner = generateScan(intervalInMs: 50);
      expect(spinner.intervalInMs, 50);
      expect(spinner.frames.length, 10);
    });

    test('generateRain with custom intervalInMs', () {
      final spinner = generateRain(intervalInMs: 200);
      expect(spinner.intervalInMs, 200);
      expect(spinner.frames.length, 12);
    });

    test('generateScanLine with custom intervalInMs', () {
      final spinner = generateScanLine(intervalInMs: 80);
      expect(spinner.intervalInMs, 80);
      expect(spinner.frames.length, 6);
    });

    test('generatePulse with custom intervalInMs', () {
      final spinner = generatePulse(intervalInMs: 100);
      expect(spinner.intervalInMs, 100);
      expect(spinner.frames.length, 5);
    });

    test('generateSnake with custom intervalInMs', () {
      final spinner = generateSnake(intervalInMs: 120);
      expect(spinner.intervalInMs, 120);
      expect(spinner.frames.length, 16);
    });

    test('generateSparkle with custom intervalInMs', () {
      final spinner = generateSparkle(intervalInMs: 100);
      expect(spinner.intervalInMs, 100);
      expect(spinner.frames.length, 6);
    });

    test('generateCascade with custom intervalInMs', () {
      final spinner = generateCascade(intervalInMs: 80);
      expect(spinner.intervalInMs, 80);
      expect(spinner.frames.length, 14);
    });

    test('generateColumns with custom intervalInMs', () {
      final spinner = generateColumns(intervalInMs: 40);
      expect(spinner.intervalInMs, 40);
      expect(spinner.frames.length, 26);
    });

    test('generateOrbit with custom intervalInMs', () {
      final spinner = generateOrbit(intervalInMs: 150);
      expect(spinner.intervalInMs, 150);
      expect(spinner.frames.length, 8);
    });

    test('generateBreathe with custom intervalInMs', () {
      final spinner = generateBreathe(intervalInMs: 200);
      expect(spinner.intervalInMs, 200);
      expect(spinner.frames.length, 17);
    });

    test('generateWaveRows with custom intervalInMs', () {
      final spinner = generateWaveRows(intervalInMs: 120);
      expect(spinner.intervalInMs, 120);
      expect(spinner.frames.length, 16);
    });

    test('generateCheckerboard with custom intervalInMs', () {
      final spinner = generateCheckerboard(intervalInMs: 300);
      expect(spinner.intervalInMs, 300);
      expect(spinner.frames.length, 4);
    });

    test('generateHelix with custom intervalInMs', () {
      final spinner = generateHelix(intervalInMs: 60);
      expect(spinner.intervalInMs, 60);
      expect(spinner.frames.length, 16);
    });

    test('generateFillSweep with custom intervalInMs', () {
      final spinner = generateFillSweep(intervalInMs: 150);
      expect(spinner.intervalInMs, 150);
      expect(spinner.frames.length, 11);
    });

    test('generateDiagSwipe with custom intervalInMs', () {
      final spinner = generateDiagSwipe(intervalInMs: 80);
      expect(spinner.intervalInMs, 80);
      expect(spinner.frames.length, 16);
    });

    test('generatePendulum with custom intervalInMs', () {
      final spinner = generatePendulum(intervalInMs: 50);
      expect(spinner.intervalInMs, 50);
      expect(spinner.frames.length, 120);
    });

    test('generateCompress with custom intervalInMs', () {
      final spinner = generateCompress(intervalInMs: 50);
      expect(spinner.intervalInMs, 50);
      expect(spinner.frames.length, 100);
    });

    test('generateSort with custom intervalInMs', () {
      final spinner = generateSort(intervalInMs: 50);
      expect(spinner.intervalInMs, 50);
      expect(spinner.frames.length, 100);
    });

    test('default intervalInMs matches pre-computed spinner', () {
      expect(generateScan().intervalInMs, scanSpinner.intervalInMs);
      expect(generateHelix().intervalInMs, helixSpinner.intervalInMs);
      expect(generateOrbit().intervalInMs, orbitSpinner.intervalInMs);
    });

    test('custom intervalInMs does not affect frames', () {
      final a = generateHelix(intervalInMs: 60);
      final b = generateHelix(intervalInMs: 200);
      expect(a.frames, b.frames);
    });
  });
}
