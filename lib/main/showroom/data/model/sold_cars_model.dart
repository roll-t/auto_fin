import 'dart:convert';
import 'package:auto_find/main/showroom/data/model/car_model.dart';

class SoldCarsModel {
  final List<CarModel>? items;
  final String? nextPageToken;
  final SoldCarsTotals? totals;

  SoldCarsModel({
    required this.items,
    this.nextPageToken,
    this.totals,
  });

  factory SoldCarsModel.fromJson(Map<String, dynamic> json) {
    return SoldCarsModel(
      items: json['items'] != null
          ? (json['items'] as List<dynamic>)
              .map((e) => CarModel.fromJson(e))
              .toList()
          : null,
      nextPageToken: json['nextPageToken'],
      totals: json['totals'] != null
          ? SoldCarsTotals.fromJson(json['totals'])
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        "items": items?.map((e) => e.toJson()).toList(),
        "nextPageToken": nextPageToken,
        "totals": totals?.toJson(),
      };

  /// Parse từ raw JSON string
  static SoldCarsModel fromRawJson(String str) =>
      SoldCarsModel.fromJson(json.decode(str));
}

/// Model tổng hợp số liệu
class SoldCarsTotals {
  final double profit;
  final double soldValue;

  SoldCarsTotals({
    required this.profit,
    required this.soldValue,
  });

  factory SoldCarsTotals.fromJson(Map<String, dynamic> json) {
    return SoldCarsTotals(
      profit: (json['profit'] ?? 0).toDouble(),
      soldValue: (json['sold_value'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() => {
        "profit": profit,
        "sold_value": soldValue,
      };
}
