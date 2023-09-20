import 'package:ecommerce_app/src/model/product_response_model.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  var cart = List<Product>.empty().obs;

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
  }

  void removeFromCart(Product product) {
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
        rating: product.rating,
      ),
    );

    if (existingProduct.quantity > 0) {
      existingProduct.quantity--;

      if (existingProduct.quantity == 0) {
        cart.remove(existingProduct);
      }
    }
  }

  // void addToCart(Product item) {
  //   // Check if the product is already in the cart
  //   final existingItem = cartItems.firstWhere(
  //     (element) => element.id == item.id,
  //     orElse: () => Product(
  //         id: -1,
  //         title: '',
  //         price: 0,
  //         description: '',
  //         category: '',
  //         image: '',
  //         rating: Rating(rate: 0, count: 0)),
  //   );

  //   // ignore: unnecessary_null_comparison
  //   if (existingItem.id != -1) {
  //     // If the product is in the cart, increment its quantity
  //     existingItem.incrementQuantity();
  //   } else {
  //     // Otherwise, add the product to the cart
  //     cartItems.add(item);
  //   }

  //   update(); // Manually trigger a UI update
  // }

  // void removeFromCart(Product item) {
  //   // Remove the product from the cart
  //   cartItems.remove(item);

  //   update(); // Manually trigger a UI update
  // }

  // void removeItemById(int id) {
  //   final itemToRemove = cartItems.firstWhere(
  //     (item) => item.id == id,
  //     orElse: () => Product(
  //         id: -1,
  //         title: '',
  //         price: 0,
  //         description: '',
  //         category: '',
  //         image: '',
  //         rating: Rating(rate: 0, count: 0)),
  //   );

  //   cartItems.remove(itemToRemove);
  //   update();
  // }

  void incrementQuantity(Product item) {
    try {
      // Increment the quantity of the specified product
      item.incrementQuantity();

      update(); // Manually trigger a UI update
    } catch (e) {
      throw Exception(e);
    }
  }

  void decrementQuantity(Product item) {
    // Decrement the quantity of the specified product
    item.decrementQuantity();

    // If the quantity reaches zero, remove the product from the cart
    if (item.quantity <= 0) {
      removeFromCart(item);
    }

    update(); // Manually trigger a UI update
  }
}
