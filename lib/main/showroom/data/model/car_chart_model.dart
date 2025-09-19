class CarChartsModel {
  final ChartSeries? barImportValueMillion;
  final ChartSeries? barProfitMillion;
  final ChartSeriesInt? lineSoldCount;

  CarChartsModel({
    this.barImportValueMillion,
    this.barProfitMillion,
    this.lineSoldCount,
  });

  factory CarChartsModel.fromJson(Map<String, dynamic> json) {
    return CarChartsModel(
      barImportValueMillion: json['bar_import_value_million'] != null
          ? ChartSeries.fromJson(json['bar_import_value_million'])
          : null,
      barProfitMillion: json['bar_profit_million'] != null
          ? ChartSeries.fromJson(json['bar_profit_million'])
          : null,
      lineSoldCount: json['line_sold_count'] != null
          ? ChartSeriesInt.fromJson(json['line_sold_count'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'bar_import_value_million': barImportValueMillion?.toJson(),
      'bar_profit_million': barProfitMillion?.toJson(),
      'line_sold_count': lineSoldCount?.toJson(),
    };
  }
}

/// Dành cho dữ liệu dạng double
class ChartSeries {
  final int? prev;
  final List<double>? seriesPrev;
  final List<double>? seriesYear;
  final int? year;

  ChartSeries({
    this.prev,
    this.seriesPrev,
    this.seriesYear,
    this.year,
  });

  factory ChartSeries.fromJson(Map<String, dynamic> json) {
    return ChartSeries(
      prev: json['prev'] as int?,
      seriesPrev: json['series_prev'] != null
          ? List<double>.from(
              (json['series_prev'] as List).map((x) => (x as num).toDouble()))
          : null,
      seriesYear: json['series_year'] != null
          ? List<double>.from(
              (json['series_year'] as List).map((x) => (x as num).toDouble()))
          : null,
      year: json['year'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'prev': prev,
      'series_prev': seriesPrev,
      'series_year': seriesYear,
      'year': year,
    };
  }
}

/// Dành cho dữ liệu dạng int (line_sold_count)
class ChartSeriesInt {
  final int? prev;
  final List<int>? seriesPrev;
  final List<int>? seriesYear;
  final int? year;

  ChartSeriesInt({
    this.prev,
    this.seriesPrev,
    this.seriesYear,
    this.year,
  });

  factory ChartSeriesInt.fromJson(Map<String, dynamic> json) {
    return ChartSeriesInt(
      prev: json['prev'] as int?,
      seriesPrev: json['series_prev'] != null
          ? List<int>.from(json['series_prev'])
          : null,
      seriesYear: json['series_year'] != null
          ? List<int>.from(json['series_year'])
          : null,
      year: json['year'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'prev': prev,
      'series_prev': seriesPrev,
      'series_year': seriesYear,
      'year': year,
    };
  }
}
