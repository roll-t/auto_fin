import 'package:auto_find/main/showroom/data/model/brand_car_model.dart';
import 'package:auto_find/main/showroom/data/model/list_brand_model.dart';
import 'package:auto_find/main/showroom/data/repositories/brand_car_repository.dart';

class BrandProductUsecase {
  final BrandCarRepository _repository;

  BrandProductUsecase(this._repository);

  Future<ListBrandModel> getBrands({
    int pageSize = 20,
    String? startAfter,
    bool activeOnly = false,
  }) async {
    try {
      return await _repository.getBrands(
        pageSize: pageSize,
        startAfter: startAfter,
        activeOnly: activeOnly,
      );
    } catch (e, stack) {
      print('❌ Lỗi khi getBrands: $e');
      print(stack);
      return ListBrandModel(items: [], nextPageToken: null);
    }
  }

  Future<List<BrandCarModel>> getAllBrands() {
    return _repository.getAllBrands();
  }

  Future<BrandCarModel> getBrandDetail(int id) {
    return _repository.getBrandDetail(id);
  }

  Future<void> createBrand(BrandCarModel brand) {
    return _repository.createBrand(brand);
  }

  Future<void> updateBrand(int brandId, BrandCarModel brand) {
    return _repository.updateBrand(brandId, brand);
  }

  Future<void> deleteBrand(int brandId) {
    return _repository.deleteBrand(brandId);
  }

  Future<List<ProductModel>> getProductsOfBrand(int brandId,
      {bool activeOnly = false}) {
    return _repository.getProductsOfBrand(brandId, activeOnly: activeOnly);
  }

  Future<void> addProductToBrand(int brandId, ProductModel product) {
    return _repository.addProductToBrand(brandId, product);
  }

  Future<ProductModel> getProductDetail(int brandId, int productId) {
    return _repository.getProductDetail(brandId, productId);
  }

  Future<void> updateProduct(
      int brandId, int productId, ProductModel product) {
    return _repository.updateProduct(brandId, productId, product);
  }

  Future<void> deleteProduct(int brandId, int productId) {
    return _repository.deleteProduct(brandId, productId);
  }
}
