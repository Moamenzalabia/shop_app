import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:newshop_app/modules/home/cubit/cubit.dart';
import 'package:newshop_app/modules/home/cubit/states.dart';
import 'package:newshop_app/shared/components/constants.dart';

import 'components/favorite_item.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (BuildContext context, HomeStates state) {},
      builder: (BuildContext context, HomeStates state) {
        var cubit = HomeCubit.getHomeCubit(context);
        return Conditional.single(
          context: context,
          conditionBuilder: (context) => state is! LoadingGetFavoritesState,
          widgetBuilder: (context) => ListView.separated(
            itemBuilder: (context, index) => FavoriteItem(product: cubit.favoritesModel!.data.data[index].product),
            separatorBuilder: (context, index) => myDivider(),
            itemCount: cubit.favoritesModel!.data.data.length,
          ),
          fallbackBuilder: (context) =>
          const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
