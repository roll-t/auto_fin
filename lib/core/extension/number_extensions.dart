import 'package:auto_find/core/ui/widgets/bottom_sheet/bottom_sheet_controller.dart';
import 'package:intl/intl.dart';

// extension NumCurrencyExtension on num? {
//   String toCurrency({bool withSymbol = false}) {
//     final formatter = NumberFormat.currency(
//       locale: 'vi_VN',
//       symbol: withSymbol ? '₫' : '',
//       decimalDigits: 0,
//     );
//     return formatter.format(this ?? 0);
//   }
// }

/// 👉 Extension cho String: format lại và convert về double
extension StringCurrencyExtension on String? {
  /// Format thành tiền tệ (dùng khi hiển thị)
  String toCurrency({bool withSymbol = false}) {
    if (this == null || this!.isEmpty) return '';
    final value = num.tryParse(this!.replaceAll('.', '').replaceAll(',', ''));
    if (value == null) return this!;
    final formatter = NumberFormat.currency(
      locale: 'vi_VN',
      symbol: withSymbol ? 'VND' : '',
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
extension CurrencyFormatter on String {
  String toCurrencyWithUnit(BottomSheetController currencyUnitController) {
    if (trim().isEmpty) return "0";

    final value = double.tryParse(this) ?? 0;

    final String unitId = currencyUnitController.itemSelected.value.id ?? "";
    final String unitTitle =
        currencyUnitController.itemSelected.value.title ?? "";

    double convertedValue = value;
    switch (unitId) {
      case "million":
        convertedValue = value / 1000000;
        break;
      case "billion":
        convertedValue = value / 1000000000;
        break;
      case "vnd":
      default:
        convertedValue = value;
    }

    // Nếu là triệu hoặc tỷ -> có 2 số thập phân
    final formatter = (unitId == "million" || unitId == "billion")
        ? NumberFormat('#,##0.00', 'vi_VN')
        : NumberFormat('#,###', 'vi_VN');

    String formatted = formatter.format(convertedValue);

    // Đổi dấu phân cách nghìn thành khoảng trắng
    if (formatted.contains(',')) {
      final parts = formatted.split(',');
      formatted = '${parts[0].replaceAll('.', '.')}${unitId == "million" || unitId == "billion" ? ',${parts[1]}' : ''}';
    } else {
      formatted = formatted.replaceAll('.', '.');
    }

    return "$formatted $unitTitle";
  }
}
