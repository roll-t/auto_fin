class TopModel {
  final String? brand;
  final String? product;
  final double? totalProfit;
  final double? totalProfitMillion;

  const TopModel({
    this.brand,
    this.product,
    this.totalProfit,
    this.totalProfitMillion,
  });

  factory TopModel.fromJson(Map<String, dynamic> json) {
    return TopModel(
      brand: json['brand'] as String?,
      product: json['product'] as String?,
      totalProfit: (json['total_profit'] as num?)?.toDouble(),
      totalProfitMillion: (json['total_profit_million'] as num?)?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() => {
        'brand': brand,
        'product': product,
        'total_profit': totalProfit,
        'total_profit_million': totalProfitMillion,
      };
}
