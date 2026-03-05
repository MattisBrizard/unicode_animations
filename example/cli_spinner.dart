import 'dart:async';
import 'dart:io';

import 'package:unicode_animations/unicode_animations.dart';

Future<T> _runWithSpinner<T>(
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
  await _runWithSpinner(
    'Linting...',
    _asyncOperation,
    name: BrailleSpinnerName.scan,
  );
  await _runWithSpinner(
    'Running tests...',
    _asyncOperation,
    name: BrailleSpinnerName.helix,
  );
  await _runWithSpinner(
    'Building...',
    _asyncOperation,
    name: BrailleSpinnerName.cascade,
  );
  await _runWithSpinner(
    'Publishing...',
    _asyncOperation,
    name: BrailleSpinnerName.braille,
  );
}

Future<void> _asyncOperation() {
  return Future<void>.delayed(const Duration(seconds: 1));
}
