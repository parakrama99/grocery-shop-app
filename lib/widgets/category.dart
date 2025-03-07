import 'package:flutter/material.dart';
import 'package:grocery_shop/const.dart';
import 'package:grocery_shop/models/category_model.dart';

class CategoryItem extends StatelessWidget {
  final CategoryModel category;
  final String selectedCategory;
  const CategoryItem({
    super.key,
    required this.category,
    required this.selectedCategory,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10, top: 10, right: 20, bottom: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: selectedCategory == category.text ? deepPurple : white,
      ),
      child: Row(
        children: [
          Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: white),
              child: Image.asset(
                'assets/category/${category.image!}',
                height: 20,
              )),
          const SizedBox(width: 10),
          Text(
            category.text!,
            style: poppin.copyWith(
                color: selectedCategory == category.text ? white : deepPurple),
          )
        ],
      ),
    );
  }
}
