// Verification script: prints all spinner frames for manual inspection.
//
// Usage: dart run example/verify_all.dart
// ignore_for_file: avoid_print

import 'package:unicode_animations/unicode_animations.dart';

void main() {
  for (final entry in spinners.entries) {
    final name = entry.key.name;
    final spinner = entry.value;

    print(
        '=== $name (${spinner.frames.length} frames, ${spinner.intervalInMs}ms) ===');
    for (int i = 0; i < spinner.frames.length; i++) {
      print('${i.toString().padLeft(2)}: ${spinner.frames[i]}');
    }
    print('');
  }
}
