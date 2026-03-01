import 'dart:async';
import 'dart:io';

import 'package:unicode_animations/unicode_animations.dart';

Future<void> main(List<String> args) async {
  final spinnerName = args.isNotEmpty ? args[0] : 'braille';

  final BrailleSpinnerName found;
  try {
    found = BrailleSpinnerName.values.byName(spinnerName);
  } on ArgumentError {
    stderr.writeln('Unknown spinner: $spinnerName');
    stderr.writeln(
      'Available: ${BrailleSpinnerName.values.map((e) => e.name).join(', ')}',
    );
    exit(1);
  }

  final spinner = Spinner.of(found);
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
