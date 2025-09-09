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
