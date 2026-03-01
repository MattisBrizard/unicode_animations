import 'dart:async';
import 'dart:io';

import 'package:unicode_animations/unicode_animations.dart';

Future<void> _animate(Spinner spinner, Duration duration) async {
  int i = 0;
  final timer = Timer.periodic(
    Duration(milliseconds: spinner.intervalInMs),
    (_) {
      stdout.write('\r${spinner.frames[i++ % spinner.frames.length]}');
    },
  );
  await Future<void>.delayed(duration);
  timer.cancel();
  stdout.write('\r\x1B[2K');
}

Future<void> main() async {
  const clock = Spinner(
    frames: [
      '🕛',
      '🕐',
      '🕑',
      '🕒',
      '🕓',
      '🕔',
      '🕕',
      '🕖',
      '🕗',
      '🕘',
      '🕙',
      '🕚'
    ],
    intervalInMs: 100,
  );

  final bouncingDot = Spinner(
    frames: List<String>.generate(4, (row) {
      final grid = makeGrid(4, 2);
      grid[row][0] = true;
      return gridToBraille(grid);
    }),
    intervalInMs: 150,
  );

  await _animate(clock, const Duration(seconds: 3));
  await _animate(bouncingDot, const Duration(seconds: 3));
}
