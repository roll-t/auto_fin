import 'package:auto_find/main/showroom/data/model/brand_car_model.dart';
import 'package:auto_find/main/showroom/data/model/list_brand_model.dart';
import 'package:auto_find/main/showroom/data/source/brand_product_api.dart';

class BrandCarRepository {
  final BrandCarApi _api = BrandCarApi();

  /// Lấy danh sách brand + phân trang
  Future<ListBrandModel> getBrands({
    int pageSize = 20,
    String? startAfter,
    bool activeOnly = false,
  }) async {
    final result = await _api.getBrands(
      pageSize: pageSize,
      startAfter: startAfter,
      activeOnly: activeOnly,
    );

    if (result.isSuccess) {
      if (result.data is Map<String, dynamic>) {
        return ListBrandModel.fromJson(result.data as Map<String, dynamic>);
      }
      return ListBrandModel(items: [], nextPageToken: null);
    }
    throw Exception(result.message ?? "Lỗi khi gọi API getBrands");
  }

  /// Lấy toàn bộ brands (ẩn soft-delete)
  Future<List<BrandCarModel>> getAllBrands() async {
    final result = await _api.getAllBrands();
    if (result.isSuccess) {
      if (result.data is List) {
        return (result.data as List)
            .map((e) => BrandCarModel.fromJson(e))
            .toList();
      }
      return [];
    }
    throw Exception(result.message ?? "Lỗi khi gọi API getAllBrands");
  }

  /// Lấy chi tiết brand
  Future<BrandCarModel> getBrandDetail(int brandId) async {
    final result = await _api.getBrandDetail(brandId);
    if (result.isSuccess && result.data is Map<String, dynamic>) {
      return BrandCarModel.fromJson(result.data as Map<String, dynamic>);
    }
    throw Exception(result.message ?? "Không lấy được chi tiết brand");
  }

  /// Tạo brand mới
  Future<void> createBrand(BrandCarModel brand) async {
    final result = await _api.createBrand(brand);
    if (!result.isSuccess) {
      throw Exception(result.message ?? "Không thể tạo brand");
    }
  }

  /// Cập nhật brand
  Future<void> updateBrand(int brandId, BrandCarModel brand) async {
    final result = await _api.updateBrand(brandId, brand);
    if (!result.isSuccess) {
      throw Exception(result.message ?? "Không thể cập nhật brand");
    }
  }

  /// Soft delete brand
  Future<void> deleteBrand(int brandId) async {
    final result = await _api.deleteBrand(brandId);
    if (!result.isSuccess) {
      throw Exception(result.message ?? "Không thể xóa brand");
    }
  }

  /// Lấy danh sách products của 1 brand
  Future<List<ProductModel>> getProductsOfBrand(int brandId,
      {bool activeOnly = false}) async {
    final result =
        await _api.getProductsOfBrand(brandId, activeOnly: activeOnly);
    if (result.isSuccess && result.data is List) {
      return (result.data as List)
          .map((e) => ProductModel.fromJson(e))
          .toList();
    }
    throw Exception(result.message ?? "Không lấy được danh sách products");
  }

  /// Thêm product vào brand
  Future<void> addProductToBrand(int brandId, ProductModel product) async {
    final result = await _api.addProductToBrand(brandId, product);
    if (!result.isSuccess) {
      throw Exception(result.message ?? "Không thể thêm product");
    }
  }

  /// Lấy chi tiết 1 product
  Future<ProductModel> getProductDetail(int brandId, int productId) async {
    final result = await _api.getProductDetail(brandId, productId);
    if (result.isSuccess && result.data is Map<String, dynamic>) {
      return ProductModel.fromJson(result.data as Map<String, dynamic>);
    }
    throw Exception(result.message ?? "Không lấy được chi tiết product");
  }

  /// Sửa product
  Future<void> updateProduct(
      int brandId, int productId, ProductModel product) async {
    final result = await _api.updateProduct(brandId, productId, product);
    if (!result.isSuccess) {
      throw Exception(result.message ?? "Không thể sửa product");
    }
  }

  /// Xóa product
  Future<void> deleteProduct(int brandId, int productId) async {
    final result = await _api.deleteProduct(brandId, productId);
    if (!result.isSuccess) {
      throw Exception(result.message ?? "Không thể xóa product");
    }
  }
}
