// Seeded pseudo-random number generator for deterministic animations.

/// Creates a seeded pseudo-random number generator using a linear
/// congruential generator (LCG).
///
/// Returns a closure that produces deterministic values in `[0, 1]`.
double Function() seededRandom(int seed) {
  int s = seed;
  return () {
    s = (s * 1664525 + 1013904223) & 0xffffffff;
    return s / 0xffffffff;
  };
}
