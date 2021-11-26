import 'package:newshop_app/models/change_favorites_model.dart';
import 'package:newshop_app/models/user_model.dart';

abstract class HomeStates {}

class HomeInitialState extends HomeStates {}

class ChangeBottomNavState extends HomeStates {}

class LoadingHomeDataState extends HomeStates {}

class SuccessHomeDataState extends HomeStates {}

class ErrorHomeDataState extends HomeStates {}

class CategoryInitialState extends HomeStates {}

class LoadingCategoryDataState extends HomeStates {}

class SuccessCategoryDataState extends HomeStates {}

class ErrorCategoryDataState extends HomeStates {}

class LoadingChangeFavoritesState extends HomeStates {}

class SuccessChangeFavoritesState extends HomeStates {
  final ChangeFavoritesModel model;
  SuccessChangeFavoritesState(this.model);
}

class ErrorChangeFavoritesState extends HomeStates {}

class LoadingGetFavoritesState extends HomeStates {}

class SuccessGetFavoritesState extends HomeStates {}

class ErrorGetFavoritesState extends HomeStates {}
