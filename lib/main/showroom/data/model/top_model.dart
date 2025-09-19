class TopModel {
  final String? brand;
  final double? totalProfit;
  final double? totalProfitMillion;

  TopModel({
    this.brand,
    this.totalProfit,
    this.totalProfitMillion,
  });

  factory TopModel.fromJson(Map<String, dynamic> json) {
    return TopModel(
      brand: json['brand'] as String?,
      totalProfit: (json['total_profit'] as num?)?.toDouble(),
      totalProfitMillion: (json['total_profit_million'] as num?)?.toDouble(),
    );
  }
}
