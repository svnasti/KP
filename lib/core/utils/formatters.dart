String formatAmount(int value, {bool withSign = false}) {
  final digits = value.abs().toString();
  final buffer = StringBuffer();
  for (var i = 0; i < digits.length; i++) {
    if (i > 0 && (digits.length - i) % 3 == 0) buffer.write(' ');
    buffer.write(digits[i]);
  }
  final sign = value < 0 ? '-' : (withSign && value > 0 ? '+' : '');
  return '$sign$buffer грн';
}

String membersLabel(int count) {
  final lastTwo = count % 100;
  final last = count % 10;
  if (lastTwo >= 11 && lastTwo <= 14) return '$count учасників';
  if (last == 1) return '$count учасник';
  if (last >= 2 && last <= 4) return '$count учасники';
  return '$count учасників';
}
