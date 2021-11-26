import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:newshop_app/modules/home/cubit/cubit.dart';
import 'package:newshop_app/modules/home/cubit/states.dart';

import 'components/list_category_item_card.dart';

class CateogriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (BuildContext context, HomeStates state) {},
      builder: (BuildContext context, HomeStates state) {
        var cubit = HomeCubit.getHomeCubit(context);
        return Conditional.single(
          context: context,
          conditionBuilder: (context) => cubit.categoriesModel != null,
          widgetBuilder: (context) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: GridView.builder(
              itemCount: cubit.categoriesModel!.data.data.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
                childAspectRatio: 0.75,
              ),
              itemBuilder: (context, index) => ListCategoryItemCard(
                categoryData: cubit.categoriesModel!.data.data[index],
                press: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => DetailsScreen(
                  //       product: cubit.categoriesModel!.data.data[index],
                  //     ),
                  //   ),
                  // );
                },
              ),
            ),
          ),
          fallbackBuilder: (context) =>
              const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}

//CategoryDetailsScreen
