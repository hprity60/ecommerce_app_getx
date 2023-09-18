// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dio/dio.dart';

import '../model/product_response_model.dart';
import '../providers/dio_providers.dart';
import '../strings/app_strings.dart';

class GetProductRepository {
  static final DioProvider dioProvider = DioProvider();

  static Future<List<Product>> getAllProducts() async {
    try {
      Response response =
          await dioProvider.client.get(AppStrings.getAllProductsUri);

      final List<dynamic> jsonBody = response.data;

      List<Product> products =
          jsonBody.map((json) => Product.fromJson(json)).toList();

      print(response.data);

      return products;
    } catch (e) {
      throw Exception();
    }
  }
}
