import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newshop_app/models/user_model.dart';
import 'package:newshop_app/modules/login/cubit/states.dart';
import 'package:newshop_app/shared/network/remote/dio_helper.dart';
import 'package:newshop_app/shared/network/remote/end_points.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());

  static LoginCubit getLoginCubit(context) => BlocProvider.of(context);
  bool isObscurePasswordText = true;
  IconData suffix = Icons.visibility_off_outlined;

  void userLogin({
    required String email,
    required String password,
  }) {
    emit(LoginLoadingState());
    DioHelper.postData(
      url: LOGIN,
      dataParameter: {
        'email': email,
        'password': password,
      },
    ).then((value) {
      emit(LoginSuccessState(UserModel.fromJson(value.data)));
    }).catchError((error) {
      emit(LoginErrorState(error.toString()));
    });
  }

  void changePasswordVisibilty() {
    isObscurePasswordText = !isObscurePasswordText;
    suffix = isObscurePasswordText
        ? Icons.visibility_outlined
        : Icons.visibility_off_outlined;
    emit(ChangePasswordVisibilityState());
  }
}
