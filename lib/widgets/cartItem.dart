import 'package:flutter/material.dart';
import 'package:grocery_shop/const.dart';

import 'package:grocery_shop/models/cart_model.dart';

class CartItem extends StatelessWidget {
  final CartModel cart;
  const CartItem({
    super.key,
    required this.cart,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 105,
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.only(left: 10, top: 10, right: 20, bottom: 10),
      decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
                offset: const Offset(3, 3),
                color: black.withOpacity(0.2),
                spreadRadius: 3,
                blurRadius: 5)
          ]),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: grey.withOpacity(0.4),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Image.asset('assets/foods/${cart.product!.image!}'),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  cart.product!.name!,
                  style: poppin.copyWith(
                      fontSize: 18, fontWeight: FontWeight.w600, color: black),
                ),
                Text(
                  cart.product!.category!,
                  style: poppin.copyWith(fontSize: 14, color: black),
                ),
                const SizedBox(height: 10),
                Text(
                  'Rs.${(cart.product!.price!).toStringAsFixed(2)}',
                  style: poppin.copyWith(
                      fontSize: 18, fontWeight: FontWeight.w600, color: black),
                ),
              ],
            ),
          ),
          Text(
            '${cart.quantity}x',
            style: poppin.copyWith(
                fontSize: 14, color: black, fontWeight: FontWeight.w600),
          )
        ],
      ),
    );
  }
}
