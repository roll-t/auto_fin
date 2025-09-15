import 'package:auto_find/main/showroom/data/model/car_model.dart';

class ShowroomCarsModel {
  final List<CarModel>? items;
  final double? inventoryValue;

  ShowroomCarsModel({
    this.items,
    this.inventoryValue,
  });

  factory ShowroomCarsModel.fromJson(Map<String, dynamic> json) {
    final itemsJson = json['items'] as List?;
    final totals = json['totals'] as Map<String, dynamic>?;

    return ShowroomCarsModel(
      items: itemsJson?.map((e) => CarModel.fromJson(e)).toList(),
      inventoryValue: totals?['inventory_value'] != null
          ? (totals!['inventory_value'] as num).toDouble()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'items': items?.map((e) => e.toJson()).toList(),
      'totals': inventoryValue != null
          ? {'inventory_value': inventoryValue}
          : null,
    };
  }
}
