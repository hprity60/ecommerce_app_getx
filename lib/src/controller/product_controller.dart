// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:get/get.dart';

import 'package:ecommerce_app/src/model/product_response_model.dart';
import 'package:ecommerce_app/src/repositories/get_product_repository.dart';

class ProductController extends GetxController {
  var isLoading = true.obs;
  var products = List<Product>.empty().obs;

  @override
  Future<void> onInit() async {
    getAllProduct();
    update();
    super.onInit();
  }

  Future<List<Product>> getAllProduct() async {
    try {
      isLoading(true);
      products.value = await GetProductRepository.getAllProducts();
      return products;
    } catch (e) {
      throw Exception();
    } finally {
      isLoading(false);
    }
  }
}
