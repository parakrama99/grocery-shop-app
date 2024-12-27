import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:grocery_shop/const.dart';
import 'package:grocery_shop/pages/payment_page.dart';
import 'package:grocery_shop/provider/cart_provider.dart';
import 'package:grocery_shop/widgets/cartItem.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    // Accessing the CartProvider instance to manage the cart state
    CartProvider cartProvider = Provider.of<CartProvider>(context);
    
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context); // Navigates back to the previous screen
          },
          child: Icon(
            Icons.arrow_back_ios_rounded,
            color: black.withOpacity(0.7),
            size: 18,
          ),
        ),
        title: Text(
          'Cart', 
          style: poppin.copyWith(
              fontSize: 18, color: black, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: cartProvider.carts.isNotEmpty
                ? Text.rich(TextSpan(children: [
                    TextSpan(
                        text:
                            '${cartProvider.carts.length} ', // Display the cart item count
                        style: poppin.copyWith(
                            fontSize: 14, fontWeight: FontWeight.w600)),
                    TextSpan(
                        text:
                            cartProvider.carts.length > 1 ? ' Items' : ' Item', // Singular or plural item label
                        style: poppin.copyWith(
                            fontSize: 14, fontWeight: FontWeight.w400)),
                  ]))
                : Container(),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: List.generate(
                    cartProvider.carts.length,
                    (index) => Padding(
                          padding: const EdgeInsets.only(bottom: 15),
                          child: Container(
                            height: 105,
                            decoration: BoxDecoration(
                                color: grey.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(20)),
                            child: Slidable(
                                endActionPane: ActionPane(
                                    extentRatio: 0.15,
                                    motion: const BehindMotion(),
                                    children: [
                                      SlidableAction(
                                        onPressed: (context) {
                                          // Removes an item from the cart
                                          cartProvider.remoceCart(
                                              cartProvider.carts[index].id!);
                                        },
                                        icon: Icons.delete_outline_rounded,
                                        foregroundColor: Colors.red,
                                        autoClose: true,
                                        backgroundColor: grey.withOpacity(0.1),
                                        borderRadius:
                                            const BorderRadius.horizontal(
                                                right: Radius.circular(20)),
                                      )
                                    ]),
                                child:
                                    CartItem(cart: cartProvider.carts[index])), // Displays cart items
                          ),
                        )),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: AnimatedContainer(
        duration: const Duration(seconds: 2),
        height: cartProvider.carts.isNotEmpty ? 265 : 0, // Shows the bottom container when the cart is not empty
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          color: white,
          boxShadow: [
            BoxShadow(
                color: black.withOpacity(0.2),
                offset: Offset.zero,
                spreadRadius: 5,
                blurRadius: 10)
          ],
        ),
        child: Padding(
          padding:
              const EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 30),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text.rich(TextSpan(children: [
                      TextSpan(
                          text: '${cartProvider.carts.length} ', // Display the number of items in the cart
                          style: poppin.copyWith(
                              fontSize: 16,
                              color: grey,
                              fontWeight: FontWeight.w600)),
                      TextSpan(
                          text: cartProvider.carts.length > 1
                              ? ' Items'
                              : ' Item', // Plural or singular label for items
                          style: poppin.copyWith(
                              fontSize: 16,
                              color: grey,
                              fontWeight: FontWeight.w200)),
                    ])),
                    Text(
                      'Rs.${(cartProvider.totalPrice()).toStringAsFixed(2)}', // Display total price of cart
                      style: poppin.copyWith(
                          fontSize: 16,
                          color: grey,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total', // Label for total cost
                      style: poppin.copyWith(
                          fontSize: 18,
                          color: black,
                          fontWeight: FontWeight.w600),
                    ),
                    Text(
                      'Rs.${cartProvider.totalPrice().toStringAsFixed(2)}', // Total cost value
                      style: poppin.copyWith(
                          fontSize: 18,
                          color: black,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.green, // Checkout button color
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Center(
                    child: GestureDetector(
                      onTap: () {
                        // Navigate to the payment page
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PaymentPage()),
                        );
                      },
                      child: Text(
                        'Check out', // Checkout button text
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
