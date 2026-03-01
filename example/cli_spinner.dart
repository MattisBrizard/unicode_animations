import 'dart:async';
import 'dart:io';

import 'package:unicode_animations/unicode_animations.dart';

Future<T> runWithSpinner<T>(
  String label,
  Future<T> Function() fn, {
  BrailleSpinnerName name = BrailleSpinnerName.braille,
}) async {
  final Spinner spinner = Spinner.of(name);
  int i = 0;
  final Timer timer = Timer.periodic(
    Duration(milliseconds: spinner.intervalInMs),
    (_) {
      stdout.write(
          '\r\x1B[2K  ${spinner.frames[i++ % spinner.frames.length]} $label');
    },
  );
  final T result = await fn();
  timer.cancel();
  stdout.write('\r\x1B[2K  ✔ $label\n');
  return result;
}

Future<void> main() async {
  await runWithSpinner(
    'Linting...',
    _asyncOperation,
    name: BrailleSpinnerName.scan,
  );
  await runWithSpinner(
    'Running tests...',
    _asyncOperation,
    name: BrailleSpinnerName.helix,
  );
  await runWithSpinner(
    'Building...',
    _asyncOperation,
    name: BrailleSpinnerName.cascade,
  );
  await runWithSpinner(
    'Publishing...',
    _asyncOperation,
    name: BrailleSpinnerName.braille,
  );
}

Future<void> _asyncOperation() {
  return Future<void>.delayed(const Duration(seconds: 1));
}
