class CarModel {
  final int? id;
  final String? brand;
  final String? color;
  final String? des;
  final String? name;
  final String? plate;
  final String? product;
  final String? status;
  final String? type;
  final String? releaseYear;
  final bool? isDeleted;
  final String? deletedAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? importDate;
  final DateTime? soldDate;
  final double? importCost;
  final double? importPrice;
  final double? soldCost;
  final double? soldPrice;
  final double? price;
  final double? profit;
  final String? soldDes;

  const CarModel({
    this.id,
    this.brand,
    this.color,
    this.des,
    this.name,
    this.plate,
    this.product,
    this.status,
    this.type,
    this.releaseYear,
    this.isDeleted,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.importDate,
    this.soldDate,
    this.importCost,
    this.importPrice,
    this.soldCost,
    this.soldPrice,
    this.price,
    this.profit,
    this.soldDes,
  });

  CarModel copyWith({
    int? id,
    String? brand,
    String? color,
    String? des,
    String? name,
    String? plate,
    String? product,
    String? status,
    String? type,
    String? releaseYear,
    bool? isDeleted,
    String? deletedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? importDate,
    DateTime? soldDate,
    double? importCost,
    double? importPrice,
    double? soldCost,
    double? soldPrice,
    double? price,
    double? profit,
    String? soldDes,
  }) {
    return CarModel(
      id: id ?? this.id,
      brand: brand ?? this.brand,
      color: color ?? this.color,
      des: des ?? this.des,
      name: name ?? this.name,
      plate: plate ?? this.plate,
      product: product ?? this.product,
      status: status ?? this.status,
      type: type ?? this.type,
      releaseYear: releaseYear ?? this.releaseYear,
      isDeleted: isDeleted ?? this.isDeleted,
      deletedAt: deletedAt ?? this.deletedAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      importDate: importDate ?? this.importDate,
      soldDate: soldDate ?? this.soldDate,
      importCost: importCost ?? this.importCost,
      importPrice: importPrice ?? this.importPrice,
      soldCost: soldCost ?? this.soldCost,
      soldPrice: soldPrice ?? this.soldPrice,
      price: price ?? this.price,
      profit: profit ?? this.profit,
      soldDes: soldDes ?? this.soldDes,
    );
  }

  factory CarModel.fromJson(Map<String, dynamic> json) {
    return CarModel(
      id: json['id'] is int ? json['id'] : int.tryParse(json['id'].toString()),
      brand: json['brand']?.toString(),
      color: json['color']?.toString(),
      des: json['des']?.toString(),
      name: json['name']?.toString(),
      plate: json['plate']?.toString(),
      product: json['product']?.toString(),
      status: json['status']?.toString(),
      type: json['type']?.toString(),
      releaseYear: json['release_year'].toString(),
      isDeleted: json['isDeleted'] is bool
          ? json['isDeleted']
          : json['isDeleted']?.toString().toLowerCase() == 'true',
      deletedAt: json['deletedAt']?.toString(),
      createdAt: _parseDate(json['createdAt']),
      updatedAt: _parseDate(json['updatedAt']),
      importDate: _parseDate(json['import_date']),
      soldDate: _parseDate(json['sold_date']),
      importCost: _parseDouble(json['import_cost']),
      importPrice: _parseDouble(json['import_price']),
      soldCost: _parseDouble(json['sold_cost']),
      soldPrice: _parseDouble(json['sold_price']),
      price: _parseDouble(json['price']),
      profit: _parseDouble(json['profit']),
      soldDes: json['sold_des']?.toString(),
    );
  }

  static DateTime? _parseDate(dynamic value) {
    if (value == null || value.toString().isEmpty) return null;
    return DateTime.tryParse(value.toString());
  }

  static double? _parseDouble(dynamic value) {
    if (value == null) return 0.0;
    if (value is num) return value.toDouble();
    return double.tryParse(value.toString()) ?? 0.0;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'brand': brand,
      'color': color,
      'des': des,
      'name': name,
      'plate': plate,
      'product': product,
      'status': status,
      'type': type,
      'release_year': releaseYear,
      'isDeleted': isDeleted,
      'deletedAt': deletedAt,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'import_date': importDate?.toIso8601String(),
      'sold_date': soldDate?.toIso8601String(),
      'import_cost': importCost,
      'import_price': importPrice,
      'sold_cost': soldCost,
      'sold_price': soldPrice,
      'price': price,
      'profit': profit,
      'sold_des': soldDes,
    };
  }

  @override
  String toString() {
    return 'CarModel(id: $id, brand: $brand, name: $name, price: $price)';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CarModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          brand == other.brand &&
          name == other.name &&
          price == other.price;

  @override
  int get hashCode =>
      id.hashCode ^ brand.hashCode ^ name.hashCode ^ price.hashCode;
}
