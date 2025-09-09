import 'package:intl/intl.dart';

extension NumCurrencyExtension on num? {
  String toCurrency({bool withSymbol = false}) {
    final formatter = NumberFormat.currency(
      locale: 'vi_VN',
      symbol: withSymbol ? '₫' : '',
      decimalDigits: 0,
    );
    return formatter.format(this ?? 0);
  }
}

extension StringCurrencyExtension on String? {
  String toCurrency({bool withSymbol = false}) {
    if (this == null || this!.isEmpty) return '';
    final value = num.tryParse(this!.replaceAll('.', '').replaceAll(',', ''));
    if (value == null) return this!;
    final formatter = NumberFormat.currency(
      locale: 'vi_VN',
      symbol: withSymbol ? '₫' : '',
      decimalDigits: 0,
    );
    return formatter.format(value);
  }
}
