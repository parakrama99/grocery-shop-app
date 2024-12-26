// Importing necessary packages
import 'package:flutter/material.dart';
import 'package:pet_shop_app/const.dart';  // Custom constants like colors and text styles
import 'package:pet_shop_app/models/product_model.dart';  // Product model
import 'package:pet_shop_app/provider/cart_provider.dart';  // Cart provider to manage cart state
import 'package:provider/provider.dart';  // To provide and consume CartProvider

class DetailPage extends StatefulWidget {
  // Accepting a product as a parameter to show details
  final ProductModel product;
  const DetailPage({super.key, required this.product});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  // Variable to track the quantity of the product
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    // Accessing CartProvider to manage the cart
    CartProvider cartProvider = Provider.of<CartProvider>(context);

    // The main page layout
    return Scaffold(
      appBar: AppBar(
        elevation: 0,  // No shadow for the AppBar
        backgroundColor: Colors.transparent,  // Transparent background
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);  // Go back when tapped
          },
          child: Icon(
            Icons.arrow_back_ios_rounded,  // Back arrow icon
            color: black.withOpacity(0.7),  // Icon color
            size: 18,  // Icon size
          ),
        ),
      ),
      backgroundColor: white,  // Background color of the page
      body: Column(
        children: [
          // Display product image with a circular shadow
          SizedBox(
              height: MediaQuery.of(context).size.height * 0.5 - 10,  // Adjust height of the image
              child: Stack(
                children: [
                  Positioned(
                    top: MediaQuery.of(context).size.height * 0.12,
                    right: MediaQuery.of(context).size.width * 0.2,
                    child: Container(
                      height: 250,  // Height of the circle
                      width: 250,  // Width of the circle
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,  // Circle shape
                        boxShadow: [
                          BoxShadow(
                              color: widget.product.color!,
                              offset: Offset.zero,
                              blurRadius: 100,  // Shadow blur radius
                              spreadRadius: 0)  // Shadow spread
                        ],
                      ),
                    ),
                  ),
                  // Display the product image
                  Image.asset('assets/foods/${widget.product.image}'),
                ],
              )),
          Padding(
            padding: const EdgeInsets.all(20),  // Padding around the details
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,  // Align text to the left
              children: [
                // Product name
                Text(
                  widget.product.name!,
                  style: poppin.copyWith(
                      fontSize: 18, color: black, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                // Product description
                Text(
                  widget.product.description!,
                  maxLines: 4,  // Show up to 4 lines of description
                  style: poppin.copyWith(
                      height: 1.5, fontSize: 14, color: black.withOpacity(0.5)),
                ),
                const SizedBox(height: 20),
                // Quantity selection (Add and Remove buttons)
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      decoration: BoxDecoration(
                          color: grey.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(20)),
                      child: Row(
                        children: [
                          // Add button
                          GestureDetector(
                              onTap: () {
                                setState(() {
                                  quantity++;  // Increase quantity
                                });
                              },
                              child: const Icon(Icons.add, color: grey)),
                          const SizedBox(width: 20),
                          // Display quantity
                          Text(
                            '$quantity',
                            style: poppin,
                          ),
                          const SizedBox(width: 20),
                          // Remove button
                          GestureDetector(
                              onTap: () {
                                setState(() {
                                  if (quantity > 1) {
                                    quantity--;  // Decrease quantity
                                  }
                                });
                              },
                              child: const Icon(Icons.remove, color: grey)),
                        ],
                      ),
                    ),
                    const Spacer(),
                    // Display total price based on quantity
                    Text(
                      'Rs.${(quantity * widget.product.price!).toStringAsFixed(2)}',
                      style: poppin.copyWith(
                          fontSize: 32,
                          color: black,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
      // Bottom navigation bar for actions
      bottomNavigationBar: Container(
        height: 90,
        color: white,
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            // Favorite icon (currently not functional)
            const Icon(
              Icons.favorite_outline,
              size: 32,
              color: grey,
            ),
            const SizedBox(width: 25),
            // Add to cart button
            GestureDetector(
              onTap: () {
                cartProvider.addCart(widget.product, quantity);  // Add product to cart
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 80),
                decoration: BoxDecoration(
                    color: green, borderRadius: BorderRadius.circular(20)),
                child: Center(
                  child: Row(
                    children: [
                      // Shopping cart icon
                      const Icon(Icons.shopping_cart_outlined, color: white),
                      const SizedBox(width: 10),
                      // Add to cart text
                      Text(
                        'Add to cart',
                        style: poppin.copyWith(
                            color: white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
