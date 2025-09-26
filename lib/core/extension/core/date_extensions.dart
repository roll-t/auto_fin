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

extension VNDateParsing on String {
  /// Chuyển chuỗi "dd/MM/yyyy" sang "yyyy-MM-ddTHH:mm:ss.sssZ"
  String? toIsoUtcString() {
    try {
      final date = DateFormat("dd/MM/yyyy").parse(this);
      // Chuyển sang UTC rồi format ra ISO 8601 với hậu tố Z
      return date.toUtc().toIso8601String();
    } catch (e) {
      return null; // Trả về null nếu parse lỗi
    }
  }

  /// Chuyển "dd/MM/yyyy" → DateTime UTC (ISO 8601)
  DateTime? toIsoUtcDateTime() {
    try {
      final date = DateFormat("dd/MM/yyyy").parseUtc(this);
      return date;
    } catch (e) {
      return null;
    }
  }
}

extension DurationExtensions on int {
  Duration get ms => Duration(milliseconds: this);
  Duration get s => Duration(seconds: this);
}
