import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:newshop_app/models/categories_model.dart';
import 'package:newshop_app/models/home_model.dart';
import 'package:newshop_app/modules/cateogries/components/category_item.dart';
import 'package:newshop_app/modules/home/cubit/cubit.dart';
import 'package:newshop_app/modules/home/cubit/states.dart';
import 'package:newshop_app/modules/products/components/product_item.dart';
import 'package:newshop_app/shared/components/app_toast.dart';

import 'components/slider_widget.dart';

class ProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (BuildContext context, HomeStates state) {
        if (state is SuccessChangeFavoritesState) {
          if(state.model.status){
            AppToast.showToast(messageText: state.model.message, toastState: ToastStates.SUCCESS);
          }else{
            AppToast.showToast(messageText: state.model.message, toastState: ToastStates.ERROR);
          }
        }
      },
      builder: (BuildContext context, HomeStates state) {
        var cubit = HomeCubit.getHomeCubit(context);
        return Conditional.single(
          context: context,
          conditionBuilder: (context) =>
              cubit.homeModel != null && cubit.categoriesModel != null,
          widgetBuilder: (context) =>
              productBuilder(cubit.homeModel, cubit.categoriesModel),
          fallbackBuilder: (context) =>
              const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget productBuilder(HomeModel? model, CategoriesModel? categoriesModel) =>
      SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
              items: model!.data.banners
                  .map(
                    (e) => Image(
                      image: NetworkImage(e.image),
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  )
                  .toList(),
              options: CarouselOptions(
                height: 200,
                viewportFraction: 1.0,
                enlargeCenterPage: false,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 3),
                autoPlayAnimationDuration: Duration(seconds: 1),
                autoPlayCurve: Curves.fastOutSlowIn,
                scrollDirection: Axis.horizontal,
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 10.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Categories',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    height: 100,
                    child: ListView.separated(
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => CategoryItem(
                            model: categoriesModel!.data.data[index]),
                        separatorBuilder: (context, index) => SizedBox(
                              width: 10.0,
                            ),
                        itemCount: categoriesModel!.data.data.length),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    'New Products',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.grey[300],
              child: GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                mainAxisSpacing: 2,
                crossAxisSpacing: 2,
                childAspectRatio: 1 / 1.66,
                children: List.generate(
                  model.data.products.length,
                  (index) => ProductItem(product: model.data.products[index]),
                ),
              ),
            ),
          ],
        ),
      );
}
