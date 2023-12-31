import 'package:ecommerce_app/src/controller/cart_controller.dart';

import '../controller/product_controller.dart';
import 'add_to_cart_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:badges/badges.dart' as badge;

class ProductPage extends StatelessWidget {
  ProductPage({super.key});

  final productController = Get.put(ProductController());
  final cartController = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text(
            'Ecommerce STore',
            style: TextStyle(color: Colors.black),
          ),
          actions: [
            Obx(() {
              return productController.isLoading.value
                  ? const Center(child: CircularProgressIndicator())
                  : badge.Badge(
                      position: badge.BadgePosition.topEnd(top: -10, end: -12),
                      showBadge: true,
                      ignorePointer: false,
                      badgeContent: Text(
                        cartController.cart.length.toString(),
                        style: const TextStyle(color: Colors.white),
                      ),
                      onTap: () {
                        Get.to(AddToCartPage(
                          productList: productController.products,
                        ));
                      },
                      child: const Icon(
                        Icons.shopping_cart,
                        color: Colors.black,
                        size: 30,
                      ),
                    );
            }),
            const SizedBox(width: 20),
          ],
        ),
        body: Obx(() => productController.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200,
                      childAspectRatio: 2 / 3,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 10),
                  itemCount: productController.products.length,
                  itemBuilder: (BuildContext context, int index) {
                    final items = productController.products[index];
                    return Container(
                        width: MediaQuery.of(context).size.width / 2,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        height: 222,
                        // alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 236, 236, 235),
                            borderRadius: BorderRadius.circular(15)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                height: 100,
                                width: MediaQuery.of(context).size.width,
                                color: Colors.white,
                                child: Image.network(
                                  productController.products[index].image,
                                  fit: BoxFit.fitHeight,
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              items.title,
                              maxLines: 2,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Row(
                                  children: List.generate(5, (index) {
                                    // Calculate whether to display a full star, half star, or empty star based on the rating
                                    double value = items.rating.rate - index;
                                    IconData starIcon;
                                    Color starColor;

                                    if (value >= 1.0) {
                                      starIcon = Icons.star;
                                      starColor = Colors.orange;
                                    } else if (value >= 0.5) {
                                      starIcon = Icons.star_half;
                                      starColor = Colors.orange;
                                    } else {
                                      starIcon = Icons.star_border;
                                      starColor = Colors.grey;
                                    }

                                    return Icon(
                                      starIcon,
                                      size: 15,
                                      color: starColor,
                                    );
                                  }),
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  items.rating.rate.toString(),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Text(
                                  "\$ ${items.price}",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const Spacer(),
                                GestureDetector(
                                  onTap: () {
                                    cartController.addToCart(items);
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: const Icon(Icons.add),
                                  ),
                                )
                              ],
                            )
                          ],
                        ));
                  },
                ),
              )));
  }
}
