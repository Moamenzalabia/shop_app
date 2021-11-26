import 'package:flutter/material.dart';
import 'package:newshop_app/models/categories_model.dart';

class ListCategoryItemCard extends StatelessWidget {
  final DataModel categoryData;
  final Function()? press;
  ListCategoryItemCard({
    required this.categoryData,
    required this.press,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        color: Colors.grey[300],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                child: Hero(
                  tag: '${categoryData.id}',
                  child: Image(
                    image: NetworkImage(categoryData.image),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20 / 4),
              child: Text(
                categoryData.name,
                style: TextStyle(color: Colors.blue),
              ),
            )
          ],
        ),
      ),
    );
  }
}
