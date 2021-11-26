import 'package:flutter/material.dart';
import 'package:newshop_app/models/home_model.dart';
import 'package:newshop_app/modules/home/cubit/cubit.dart';
import 'package:newshop_app/shared/styles/colors.dart';

class ProductItem extends StatelessWidget {
  Products? product;
  ProductItem({
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    var cubit = HomeCubit.getHomeCubit(context);
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                image: NetworkImage(product!.image),
                width: double.infinity,
                height: 200,
              ),
              if (product!.discount != 0)
                Container(
                  color: Colors.red,
                  padding: EdgeInsets.symmetric(
                    horizontal: 5.0,
                  ),
                  child: Text(
                    'DISCOUNT',
                    style: TextStyle(
                      fontSize: 8.0,
                      color: Colors.white,
                    ),
                  ),
                ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product!.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 14.0,
                    height: 1.3,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      '${product!.price.round()}',
                      style: const TextStyle(
                        fontSize: 12.0,
                        color: defaultColor,
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    if (product!.discount != 0)
                      Text(
                        '${product!.oldPrice.round()}',
                        style: const TextStyle(
                          fontSize: 10.0,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    Spacer(),
                    IconButton(
                      onPressed: () {
                        cubit.changeFavorites(product!.id);
                      },
                      icon: CircleAvatar(
                        radius: 15,
                        backgroundColor: cubit.favorites[product!.id] ?? false ? defaultColor: Colors.grey,
                        child: Icon(
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
    );
  }
}
