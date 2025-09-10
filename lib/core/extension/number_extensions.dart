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

/// 👉 Extension cho String: format lại và convert về double
extension StringCurrencyExtension on String? {
  /// Format thành tiền tệ (dùng khi hiển thị)
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

  /// Convert về double để gửi lên API
  double toCurrencyDouble() {
    if (this == null || this!.isEmpty) return 0;
    return double.tryParse(this!.replaceAll('.', '').replaceAll(',', '')) ?? 0;
  }
}
