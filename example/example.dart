import 'dart:async';
import 'dart:io';

import 'package:unicode_animations/unicode_animations.dart';

Future<void> main() async {
  final spinner = Spinner.of(BrailleSpinnerName.braille);
  int frameIndex = 0;

  final timer = Timer.periodic(
    Duration(milliseconds: spinner.intervalInMs),
    (_) {
      stdout.write('\r${spinner.frames[frameIndex++ % spinner.frames.length]}');
    },
  );

  await Future<void>.delayed(const Duration(seconds: 5));

  timer.cancel();
  stdout.write('\r\x1B[2K');
}
