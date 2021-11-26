import 'package:flutter/material.dart';
import 'package:newshop_app/models/categories_model.dart';

class CategoryItem extends StatelessWidget {
  DataModel? model;
  CategoryItem({
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        Image(
          image: NetworkImage(model!.image),
          height: 100.0,
          width: 100.0,
          fit: BoxFit.cover,
        ),
        Container(
          color: Colors.black.withOpacity(
            .8,
          ),
          width: 100.0,
          child: Text(
            model!.name,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
