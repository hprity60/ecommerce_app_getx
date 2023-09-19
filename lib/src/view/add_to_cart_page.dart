// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ecommerce_app/src/controller/cart_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:ecommerce_app/src/model/product_response_model.dart';

import '../controller/product_controller.dart';

class AddToCartPage extends StatelessWidget {
  AddToCartPage({
    Key? key,
    required this.productList,
  }) : super(key: key);
  final List<Product> productList;
  final productController = Get.put(ProductController());
  final cartController = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            )),
        centerTitle: true,
        title: const Text(
          'Your Cart',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: cartController.cartItems.isEmpty
          ? const Center(
              child: Text("Your Cart is Empty"),
            )
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                children: [
                  Expanded(
                    child: Obx(() {
                      return ListView.separated(
                          separatorBuilder: (context, index) {
                            return const SizedBox(height: 10);
                          },
                          itemCount: productController.productList.length,
                          itemBuilder: (context, index) {
                            if (index < cartController.cartItems.length) {
                              final item = cartController.cartItems[index];
                              final singleProductPrice =
                                  item.price * item.quantity;
                              return Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(color: Colors.black12),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: Container(
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.black12)),
                                            child: Image.network(
                                              item.image,
                                              height: 80,
                                              width: 90,
                                              fit: BoxFit.fitHeight,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                SizedBox(
                                                  width: 150,
                                                  child: Text(
                                                    item.title,
                                                    maxLines: 2,
                                                    style: const TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                ),
                                                const SizedBox(width: 45),
                                                IconButton(
                                                    onPressed: () {
                                                      if (cartController
                                                          .cartItems
                                                          .isNotEmpty) {
                                                        cartController
                                                            .removeItemById(
                                                                cartController
                                                                    .cartItems[
                                                                        index]
                                                                    .id);
                                                      } else {
                                                        Get.showSnackbar(
                                                          const GetSnackBar(
                                                            title:
                                                                "No Item found to delete",
                                                          ),
                                                        );
                                                      }

                                                      print(
                                                          "Cart Items >> ${cartController.cartItems.length}");
                                                    },
                                                    icon: const Icon(
                                                        Icons.delete))
                                              ],
                                            ),
                                            const SizedBox(height: 5),
                                            Row(
                                              children: [
                                                Text(
                                                  // ignore: unnecessary_null_comparison
                                                  item.quantity == 0
                                                      ? "\$ ${item.price}"
                                                      : "\$ $singleProductPrice",
                                                  style: const TextStyle(
                                                      color: Colors.brown,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                                const SizedBox(width: 48),
                                                IconButton(
                                                    onPressed: () {
                                                      if (cartController
                                                          .cartItems
                                                          .isNotEmpty) {
                                                        cartController
                                                            .incrementQuantity(
                                                                cartController
                                                                        .cartItems[
                                                                    index]);
                                                        print(
                                                            "Cart Items >> ${cartController.cartItems.length}");
                                                      } else {
                                                        Get.showSnackbar(
                                                          const GetSnackBar(
                                                            title: "No Item",
                                                          ),
                                                        );
                                                      }
                                                    },
                                                    icon:
                                                        const Icon(Icons.add)),
                                                Container(
                                                  padding:
                                                      const EdgeInsets.all(5),
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              2),
                                                      color:
                                                          const Color.fromARGB(
                                                              255,
                                                              219,
                                                              227,
                                                              228)),
                                                  child: Text(
                                                    cartController
                                                        .cartItems[index]
                                                        .quantity
                                                        .toString(),
                                                    style: const TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                ),
                                                IconButton(
                                                    onPressed: () {
                                                      if (cartController
                                                          .cartItems
                                                          .isNotEmpty) {
                                                        cartController
                                                            .decrementQuantity(
                                                                cartController
                                                                        .cartItems[
                                                                    index]);
                                                        print(
                                                            "Decrement item >> ${cartController.cartItems.length}");
                                                      }
                                                    },
                                                    icon: const Icon(
                                                        Icons.remove))
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            }
                            return null;
                          });
                    }),
                  ),
                  cartController.cartItems.isEmpty
                      ? const SizedBox()
                      : Container(
                          padding: const EdgeInsets.all(20),
                          margin: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Colors.black12.withOpacity(.1),
                              borderRadius: BorderRadius.circular(16)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Total items (${Product.calculateTotalQuantity(cartController.cartItems)})",
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w700),
                              ),
                              Text(
                                "Total Prices: ${Product.calculateTotalPrice(cartController.cartItems).toStringAsFixed(2)}",
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w700),
                              ),
                            ],
                          ),
                        ),
                ],
              ),
            ),
    );
  }
}
