import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newshop_app/models/user_model.dart';
import 'package:newshop_app/modules/settings/cubit/states.dart';
import 'package:newshop_app/shared/network/remote/dio_helper.dart';
import 'package:newshop_app/shared/network/remote/end_points.dart';

class SettingCubit extends Cubit<SettingStates> {
  SettingCubit() : super(UserDataInitialState());

  static SettingCubit getSettingCubit(context) => BlocProvider.of(context);

  UserModel? userModel;
  void getUserData() {
    emit(LoadingUserDataState());

    DioHelper.getData(
      url: PROFILE,
    ).then((value) {
      userModel = UserModel.fromJson(value.data);
      emit(SuccessUserDataState(userModel!));
    }).catchError((error) {
      emit(ErrorUserDataState(error.toString()));
    });
  }

  void updateUserData({
    required String name,
    required String email,
    required String phone,
  }) {
    emit(LoadingUpdateDataState());
    DioHelper.putData(
      url: UPDATE_PROFILE,
      dataParameter: {
        'name': name,
        'email': email,
        'phone': phone,
      },
    ).then((value) {
      userModel = UserModel.fromJson(value.data);
      emit(SuccessUpdateDataState(userModel!));
    }).catchError((error) {
      emit(ErrorUpdateDataState(error.toString()));
    });
  }
}
