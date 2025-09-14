/// Root model
class ProfitMatrixResponseModel {
  final List<ProfitMatrixYear>? matrix;
  final List<SoldCar>? soldList;
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
          ?.map((e) => SoldCar.fromJson(e as Map<String, dynamic>))
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

/// Thông tin xe đã bán
class SoldCar {
  final int? id;
  final String? brand;
  final String? color;
  final String? name;
  final String? product;
  final String? type;
  final String? plate;
  final String? des;
  final String? status;
  final String? releaseYear;
  final double? importPrice;
  final double? price;
  final double? profit;
  final double? soldPrice;
  final double? soldCost;
  final double? importCost;
  final DateTime? importDate;
  final DateTime? soldDate;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  SoldCar({
    this.id,
    this.brand,
    this.color,
    this.name,
    this.product,
    this.type,
    this.plate,
    this.des,
    this.status,
    this.releaseYear,
    this.importPrice,
    this.price,
    this.profit,
    this.soldPrice,
    this.soldCost,
    this.importCost,
    this.importDate,
    this.soldDate,
    this.createdAt,
    this.updatedAt,
  });

  factory SoldCar.fromJson(Map<String, dynamic> json) {
    double? toDouble(dynamic value) =>
        value == null ? null : (value as num).toDouble();

    DateTime? toDate(String? value) =>
        value == null ? null : DateTime.tryParse(value);

    return SoldCar(
      id: json['id'] is String
          ? int.tryParse(json['id'])
          : (json['id'] as int?),
      brand: json['brand'],
      color: json['color'],
      name: json['name'],
      product: json['product'],
      type: json['type'],
      plate: json['plate'],
      des: json['des'],
      status: json['status'],
      releaseYear: json['release_year']?.toString(),
      importPrice: toDouble(json['import_price']),
      price: toDouble(json['price']),
      profit: toDouble(json['profit']),
      soldPrice: toDouble(json['sold_price']),
      soldCost: toDouble(json['sold_cost']),
      importCost: toDouble(json['import_cost']),
      importDate: toDate(json['import_date']),
      soldDate: toDate(json['sold_date']),
      createdAt: toDate(json['createdAt']),
      updatedAt: toDate(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'brand': brand,
        'color': color,
        'name': name,
        'product': product,
        'type': type,
        'plate': plate,
        'des': des,
        'status': status,
        'release_year': releaseYear,
        'import_price': importPrice,
        'price': price,
        'profit': profit,
        'sold_price': soldPrice,
        'sold_cost': soldCost,
        'import_cost': importCost,
        'import_date': importDate?.toIso8601String(),
        'sold_date': soldDate?.toIso8601String(),
        'createdAt': createdAt?.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
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
