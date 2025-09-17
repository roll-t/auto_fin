import 'package:auto_find/main/showroom/data/model/car_model.dart';

/// Root model
class ProfitMatrixResponseModel {
  final List<ProfitMatrixYear>? matrix;
  List<CarModel>? soldList;
  final Totals? totals;

  ProfitMatrixResponseModel({
    this.matrix,
    this.soldList,
    this.totals,
  });

  factory ProfitMatrixResponseModel.fromJson(Map<String, dynamic> json) {
    return ProfitMatrixResponseModel(
      matrix: (json['matrix'] as List<dynamic>?)
          ?.map((e) => ProfitMatrixYear.fromJson(e as Map<String, dynamic>))
          .toList(),
      soldList: (json['sold_list'] as List<dynamic>?)
          ?.map((e) => CarModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      totals: json['totals'] != null
          ? Totals.fromJson(json['totals'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'matrix': matrix?.map((e) => e.toJson()).toList(),
        'sold_list': soldList?.map((e) => e.toJson()).toList(),
        'totals': totals?.toJson(),
      };

  /// Convert toàn bộ dữ liệu matrix thành List<MonthProfit>
  List<MonthProfit> toListMonthProfit() {
    final List<MonthProfit> result = [];

    for (final yearItem in matrix ?? []) {
      final months = yearItem.toMonthList();
      for (int i = 0; i < months.length; i++) {
        final profit = months[i];
        if (profit != null) {
          result.add(
            MonthProfit(
              year: yearItem.year ?? 0,
              month: i + 1,
              profit: profit,
            ),
          );
        }
      }
    }

    return result;
  }
}

/// Ma trận lợi nhuận theo năm
class ProfitMatrixYear {
  final int? year;
  final double? m1;
  final double? m2;
  final double? m3;
  final double? m4;
  final double? m5;
  final double? m6;
  final double? m7;
  final double? m8;
  final double? m9;
  final double? m10;
  final double? m11;
  final double? m12;
  final double? totalProfitYearMillion;

  ProfitMatrixYear({
    this.year,
    this.m1,
    this.m2,
    this.m3,
    this.m4,
    this.m5,
    this.m6,
    this.m7,
    this.m8,
    this.m9,
    this.m10,
    this.m11,
    this.m12,
    this.totalProfitYearMillion,
  });

  List<double?> toMonthList() {
    return [
      m1,
      m2,
      m3,
      m4,
      m5,
      m6,
      m7,
      m8,
      m9,
      m10,
      m11,
      m12,
    ];
  }

  factory ProfitMatrixYear.fromJson(Map<String, dynamic> json) {
    double? toDouble(dynamic value) =>
        value == null ? null : (value as num).toDouble();

    return ProfitMatrixYear(
      year: json['year'],
      m1: toDouble(json['M1']),
      m2: toDouble(json['M2']),
      m3: toDouble(json['M3']),
      m4: toDouble(json['M4']),
      m5: toDouble(json['M5']),
      m6: toDouble(json['M6']),
      m7: toDouble(json['M7']),
      m8: toDouble(json['M8']),
      m9: toDouble(json['M9']),
      m10: toDouble(json['M10']),
      m11: toDouble(json['M11']),
      m12: toDouble(json['M12']),
      totalProfitYearMillion: toDouble(json['total_profit_year_million']),
    );
  }

  Map<String, dynamic> toJson() => {
        'year': year,
        'M1': m1,
        'M2': m2,
        'M3': m3,
        'M4': m4,
        'M5': m5,
        'M6': m6,
        'M7': m7,
        'M8': m8,
        'M9': m9,
        'M10': m10,
        'M11': m11,
        'M12': m12,
        'total_profit_year_million': totalProfitYearMillion,
      };
}

/// Tổng lợi nhuận + giá trị
class Totals {
  final Map<String, YearTotal>? byYear;
  final double? grandProfit;
  final double? grandProfitMillion;
  final double? grandSoldValue;
  final double? grandSoldValueMillion;

  Totals({
    this.byYear,
    this.grandProfit,
    this.grandProfitMillion,
    this.grandSoldValue,
    this.grandSoldValueMillion,
  });

  factory Totals.fromJson(Map<String, dynamic> json) {
    final byYearJson = json['by_year'] as Map<String, dynamic>?;
    final byYearParsed = byYearJson?.map(
      (key, value) => MapEntry(key, YearTotal.fromJson(value)),
    );
    return Totals(
      byYear: byYearParsed,
      grandProfit: (json['grand_profit'] as num?)?.toDouble(),
      grandProfitMillion: (json['grand_profit_million'] as num?)?.toDouble(),
      grandSoldValue: (json['grand_sold_value'] as num?)?.toDouble(),
      grandSoldValueMillion:
          (json['grand_sold_value_million'] as num?)?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() => {
        'by_year': byYear?.map((k, v) => MapEntry(k, v.toJson())),
        'grand_profit': grandProfit,
        'grand_profit_million': grandProfitMillion,
        'grand_sold_value': grandSoldValue,
        'grand_sold_value_million': grandSoldValueMillion,
      };
}

class YearTotal {
  final double? profit;
  final double? profitMillion;
  final double? soldValue;
  final double? soldValueMillion;

  YearTotal({
    this.profit,
    this.profitMillion,
    this.soldValue,
    this.soldValueMillion,
  });

  factory YearTotal.fromJson(Map<String, dynamic> json) {
    return YearTotal(
      profit: (json['profit'] as num?)?.toDouble(),
      profitMillion: (json['profit_million'] as num?)?.toDouble(),
      soldValue: (json['sold_value'] as num?)?.toDouble(),
      soldValueMillion: (json['sold_value_million'] as num?)?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() => {
        'profit': profit,
        'profit_million': profitMillion,
        'sold_value': soldValue,
        'sold_value_million': soldValueMillion,
      };
}

class MonthProfit {
  final int year;
  final int month;
  final double profit;

  MonthProfit({
    required this.year,
    required this.month,
    required this.profit,
  });

  Map<String, dynamic> toJson() {
    return {
      'year': year,
      'month': month,
      'profit': profit,
    };
  }
}
