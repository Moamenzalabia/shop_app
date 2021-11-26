import 'package:flutter/material.dart';
import 'package:newshop_app/models/favorites_model.dart';
import 'package:newshop_app/modules/home/cubit/cubit.dart';
import 'package:newshop_app/shared/styles/colors.dart';

class FavoriteItem extends StatelessWidget {
  Product product;
  bool isOldPrice;
  FavoriteItem({
    this.isOldPrice = true,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    var cubit = HomeCubit.getHomeCubit(context);
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Container(
        height: 120,
        child: Row(
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: NetworkImage(product.image),
                  width: 120,
                  height: 120,
                ),
                if (product.discount != 0 && isOldPrice)
                  Container(
                    color: Colors.red,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 5,
                    ),
                    child: const Text(
                      'DISCOUNT',
                      style: TextStyle(
                        fontSize: 8,
                        color: Colors.white,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14.0,
                      height: 1.3,
                    ),
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Text(
                        '${product.price.round()}',
                        style: const TextStyle(
                          fontSize: 12,
                          color: defaultColor,
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      if (product.discount != 0 && isOldPrice)
                        Text(
                          '${product.oldPrice.round()}',
                          style: const TextStyle(
                            fontSize: 10.0,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      const Spacer(),
                      IconButton(
                        onPressed: () {
                          cubit.changeFavorites(product.id);
                        },
                        icon: CircleAvatar(
                          radius: 15,
                          backgroundColor: cubit.favorites[product.id] ?? false
                              ? defaultColor
                              : Colors.grey,
                          child: const Icon(
                            Icons.favorite_border,
                            size: 20,
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
