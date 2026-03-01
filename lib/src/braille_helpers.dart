/// Braille character base codepoint.
const int _brailleBase = 0x2800;

/// Dot bit map: each position (row, col) maps to a bit in the 8-dot Braille character.
/// Layout:
///   col 0    col 1
/// row 0: 0x01  0x08
/// row 1: 0x02  0x10
/// row 2: 0x04  0x20
/// row 3: 0x40  0x80
const List<List<int>> _dotMap = [
  [0x01, 0x08],
  [0x02, 0x10],
  [0x04, 0x20],
  [0x40, 0x80],
];

/// Creates an empty grid of [rows] × [cols] boolean values (all false).
List<List<bool>> makeGrid(int rows, int cols) {
  return List<List<bool>>.generate(
    rows,
    (i) => List<bool>.filled(cols, false),
    growable: false,
  );
}

/// Converts a 4-row grid of booleans into a Braille Unicode string.
///
/// Processes the grid left-to-right in 2-column chunks. Each chunk becomes
/// one Braille character. For example, a 4×8 grid produces 4 characters.
///
/// Throws an [ArgumentError] if:
/// - [grid] does not have exactly 4 rows (matches the 4 vertical dots of a Braille cell).
/// - The column count (`grid[0].length`) is odd.
/// - Any row has a different length than `grid[0]`.
String gridToBraille(List<List<bool>> grid) {
  if (grid.length != 4) {
    throw ArgumentError.value(
      grid.length,
      'grid',
      'must have exactly 4 rows',
    );
  }
  if (!grid[0].length.isEven) {
    throw ArgumentError.value(
      grid[0].length,
      'grid',
      'column count must be even',
    );
  }

  final cols = grid[0].length;

  for (int i = 1; i < grid.length; i++) {
    if (grid[i].length != cols) {
      throw ArgumentError.value(
        grid[i].length,
        'grid',
        'row $i has ${grid[i].length} columns but row 0 has $cols',
      );
    }
  }
  final buffer = StringBuffer();

  // Process columns in pairs [0,1], [2,3], [4,5], ...
  for (int col = 0; col < cols; col += 2) {
    int code = 0;

    // For each row, accumulate bits from columns [col] and [col+1]
    for (int row = 0; row < grid.length; row++) {
      if (grid[row][col]) {
        code |= _dotMap[row][0];
      }
      if (grid[row][col + 1]) {
        code |= _dotMap[row][1];
      }
    }

    buffer.writeCharCode(_brailleBase | code);
  }

  return buffer.toString();
}
