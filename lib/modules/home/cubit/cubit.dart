import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newshop_app/models/categories_model.dart';
import 'package:newshop_app/models/change_favorites_model.dart';
import 'package:newshop_app/models/favorites_model.dart';
import 'package:newshop_app/models/home_model.dart';
import 'package:newshop_app/models/user_model.dart';
import 'package:newshop_app/modules/cateogries/cateogries_screen.dart';
import 'package:newshop_app/modules/favorites/favorites_screen.dart';
import 'package:newshop_app/modules/home/cubit/states.dart';
import 'package:newshop_app/modules/products/products_screen.dart';
import 'package:newshop_app/modules/settings/settings_screen.dart';
import 'package:newshop_app/shared/network/remote/dio_helper.dart';
import 'package:newshop_app/shared/network/remote/end_points.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitialState());

  static HomeCubit getHomeCubit(context) => BlocProvider.of(context);
  HomeModel? homeModel;
  CategoriesModel? categoriesModel;
  ChangeFavoritesModel? changeFavoritesModel;
  FavoritesModel? favoritesModel;
  int currentIndex = 0;
  Map<int, bool> favorites = {};

  List<Widget> bottomScreens = [
    ProductsScreen(),
    CateogriesScreen(),
    FavoritesScreen(),
    SettingsScreen()
  ];

  void changeBottom(int index) {
    currentIndex = index;
    emit(ChangeBottomNavState());
  }

  void getHomeData() {
    // emit(LoadingHomeDataState());
    DioHelper.getData(
      url: HOME,
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      homeModel!.data.products.forEach((element) {
        favorites.addAll({
          element.id: element.inFavorites,
        });
      });
      emit(SuccessHomeDataState());
    }).catchError((error) {
      emit(ErrorHomeDataState());
    });
  }

  void getCategories() {
    DioHelper.getData(
      url: GET_CATEGORIES,
    ).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      emit(SuccessCategoryDataState());
    }).catchError((error) {
      emit(ErrorCategoryDataState());
    });
  }

  void changeFavorites(int productId) {
    emit(LoadingChangeFavoritesState());
    DioHelper.postData(
      url: FAVORITES,
      dataParameter: {'product_id': productId},
    ).then((value) {
      changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);
      if (changeFavoritesModel!.status) {
        favorites[productId] = !(favorites[productId] ?? false);
        getFavorites();
      }
      emit(SuccessChangeFavoritesState(changeFavoritesModel!));
    }).catchError((error) {
      emit(ErrorChangeFavoritesState());
    });
  }

  void getFavorites() {
    emit(LoadingGetFavoritesState());
    DioHelper.getData(
      url: FAVORITES,
    ).then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);
      emit(SuccessGetFavoritesState());
    }).catchError((error) {
      emit(ErrorGetFavoritesState());
    });
  }
}
