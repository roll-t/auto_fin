import 'package:auto_find/main/showroom/data/model/profit_matrix_response_model.dart';
import 'package:intl/intl.dart';

extension FormatDateVN on String {
  String toVNDate() {
    try {
      final dateTime = DateTime.parse(this);
      return DateFormat('dd/MM/yyyy').format(dateTime);
    } catch (e) {
      return this;
    }
  }
}

extension MonthProfitExt on MonthProfit {
  DateTime get date => DateTime(year, month);
}
