import 'package:auto_find/core/config/const/app_enum.dart';
import 'package:auto_find/core/config/result.dart';
import 'package:auto_find/core/services/api_client.dart';
import 'package:auto_find/core/services/api_endpoint.dart';
import 'package:auto_find/main/showroom/data/model/brand_car_model.dart';
import 'package:get/get.dart';

class BrandCarApi {
  final ApiClient _client = Get.find<ApiClient>();

  /// Lấy danh sách brand (ẩn soft-delete) + phân trang
  Future<Result> getBrands({
    int pageSize = 20,
    String? startAfter,
    bool activeOnly = false,
  }) {
    final query = {
      'pageSize': pageSize,
      if (startAfter != null) 'startAfter': startAfter,
      'activeOnly': activeOnly,
    };
    return _client.get(ApiEndpoint.brandProducts, query: query);
  }

  /// Lấy toàn bộ brand_products (ẩn soft-delete)
  Future<Result> getAllBrands() {
    return _client.get(ApiEndpoint.allBrandProducts);
  }

  /// Lấy chi tiết brand theo ID
  Future<Result> getBrandDetail(int brandId) {
    return _client.get(ApiEndpoint.brandDetail(brandId));
  }

  /// Tạo brand mới (có thể gửi kèm products)
  Future<Result> createBrand(BrandCarModel brand) {
    return _client.post(
      ApiEndpoint.brandProducts,
      data: brand.toJson(),
    );
  }

  /// Cập nhật brand (name/status hoặc ghi đè toàn bộ products)
  Future<Result> updateBrand(int brandId, BrandCarModel brand) async {
    final response = await _client.put(
      ApiEndpoint.brandDetail(brandId),
      data: brand.toJson(),
    );

    if (response.data is Map<String, dynamic>) {
      return Result(
        status: Results.success,
        data: response.data["data"],
        message: response.data["message"]?.toString(),
      );
    }

    return Result(
      status: Results.error,
      data: null,
      message: "Phản hồi không hợp lệ",
    );
  }

  /// Soft delete brand
  Future<Result> deleteBrand(int brandId) {
    return _client.delete(ApiEndpoint.brandDetail(brandId));
  }

  /// Lấy danh sách products của 1 brand
  Future<Result> getProductsOfBrand(int brandId, {bool activeOnly = false}) {
    final query = {
      'activeOnly': activeOnly,
    };
    return _client.get(ApiEndpoint.brandProductsById(brandId), query: query);
  }

  /// Thêm 1 product vào brand
  Future<Result> addProductToBrand(int brandId, ProductModel product) {
    return _client.post(
      ApiEndpoint.brandProductsById(brandId),
      data: product.toJson(),
    );
  }

  /// Lấy chi tiết 1 product trong brand
  Future<Result> getProductDetail(int brandId, int productId) {
    return _client.get(ApiEndpoint.productDetail(brandId, productId));
  }

  /// Sửa product (chỉ name/status)
  Future<Result> updateProduct(int brandId, int productId, ProductModel product) {
    return _client.patch(
      ApiEndpoint.productDetail(brandId, productId),
      data: product.toJson(),
    );
  }

  /// Xoá product khỏi brand
  Future<Result> deleteProduct(int brandId, int productId) {
    return _client.delete(ApiEndpoint.productDetail(brandId, productId));
  }
}
