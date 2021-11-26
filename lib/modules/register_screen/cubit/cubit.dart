import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newshop_app/models/user_model.dart';
import 'package:newshop_app/modules/register_screen/cubit/states.dart';
import 'package:newshop_app/shared/network/remote/dio_helper.dart';
import 'package:newshop_app/shared/network/remote/end_points.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit getRegisterCubit(context) => BlocProvider.of(context);
  bool isObscurePasswordText = true;
  IconData suffix = Icons.visibility_off_outlined;

  void registerUser({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) {
    emit(RegisterLoadingState());
    DioHelper.postData(
      url: REGISTER,
      dataParameter: {
        'name': name,
        'email': email,
        'password': password,
        'phone': phone,
      },
    ).then((value) {
      print(UserModel.fromJson(value.data).message);
      emit(RegisterSuccessState(UserModel.fromJson(value.data)));
    }).catchError((error) {
      emit(RegisterErrorState(error.toString()));
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
