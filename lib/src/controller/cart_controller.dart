import 'package:ecommerce_app/src/model/product_response_model.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  var cart = List<Product>.empty().obs;
  var totalQuantity = 0.obs;
  var totalPrice = 0.0.obs;

  void addToCart(Product product) {
    final existingProduct = cart.firstWhere(
      (p) => p.id == product.id,
      orElse: () => Product(
          id: product.id,
          title: product.title,
          price: product.price,
          description: product.description,
          category: product.category,
          image: product.image,
          quantity: 0,
          rating: product.rating),
    );

    if (existingProduct.quantity == 0) {
      cart.add(existingProduct);
    }

    existingProduct.quantity++;
    // Update total quantity and total price
    totalQuantity.value++;
    totalPrice.value += product.price;

    update();
  }

  void removeFromCart(Product product) {
    cart.removeWhere((p) => p.id == product.id);

    // Update total quantity and total price
    totalQuantity.value -= product.quantity;
    totalPrice.value -= (product.price * product.quantity);
    update();
  }

  void increment(Product product) {
    final existingProduct = cart.firstWhere((p) => p.id == product.id);
    existingProduct.quantity++;
    totalQuantity.value++;
    totalPrice.value += product.price;
    update(); // Update the UI
  }

  void decrement(Product product) {
    final existingProduct = cart.firstWhere((p) => p.id == product.id);
    if (existingProduct.quantity > 0) {
      existingProduct.quantity--;
      totalQuantity.value--;
      totalPrice.value -= product.price;
      update(); // Update the UI
    }
  }
}
