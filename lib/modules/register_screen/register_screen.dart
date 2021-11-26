import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:newshop_app/modules/home/home_screen.dart';
import 'package:newshop_app/modules/login/login_screen.dart';
import 'package:newshop_app/shared/components/app_materialbutton.dart';
import 'package:newshop_app/shared/components/app_navigator.dart';
import 'package:newshop_app/shared/components/app_toast.dart';
import 'package:newshop_app/shared/components/outline_textfield_border.dart';
import 'package:newshop_app/shared/network/local/cache_helper.dart';

import 'cubit/cubit.dart';
import 'cubit/states.dart';

class RegisterScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (context, state) {
          if (state is RegisterSuccessState) {
            if (state.user.status) {
              AppToast.showToast(
                messageText: state.user.message,
                toastState: ToastStates.SUCCESS,
              );
              CacheHelper()
                  .saveData(key: 'token', value: state.user.data!.token)
                  .then((value) {
                if (value) {
                  AppNavigator.navigateAndFinish(
                    nextScreen: HomeScreen(),
                    context: context,
                  );
                }
              });
            } else {
              AppToast.showToast(
                messageText: state.user.message,
                toastState: ToastStates.ERROR,
              );
            }
          } else if (state is RegisterErrorState) {
            AppToast.showToast(
              messageText: state.error,
              toastState: ToastStates.ERROR,
            );
          }
        },
        builder: (context, state) {
          var cubit = RegisterCubit.getRegisterCubit(context);
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'REGISTER NOW',
                          style:
                              Theme.of(context).textTheme.headline4!.copyWith(
                                    color: Colors.black,
                                  ),
                        ),
                        Text(
                          'Register now to browse our hot offers',
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    color: Colors.grey,
                                  ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        OutlineTextfieldBorder(
                          controller: nameController,
                          textInputType: TextInputType.text,
                          labelText: 'Username',
                          prefixIcon: Icons.person,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter username';
                            }
                          },
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        OutlineTextfieldBorder(
                          controller: emailController,
                          textInputType: TextInputType.emailAddress,
                          labelText: 'Email Address',
                          prefixIcon: Icons.email,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter email address';
                            }
                          },
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        OutlineTextfieldBorder(
                          controller: phoneController,
                          textInputType: TextInputType.phone,
                          labelText: 'Phone number',
                          prefixIcon: Icons.phone,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter phone number';
                            }
                          },
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        OutlineTextfieldBorder(
                          controller: passwordController,
                          textInputType: TextInputType.visiblePassword,
                          labelText: "Password",
                          prefixIcon: Icons.lock,
                          suffix: cubit.suffix,
                          isObscureText: cubit.isObscurePasswordText,
                          onFieldSubmit: (value) {
                            if (formKey.currentState!.validate()) {
                              cubit.registerUser(
                                name: nameController.text,
                                email: emailController.text,
                                password: passwordController.text,
                                phone: phoneController.text,
                              );
                            }
                          },
                          suffixPressed: () {
                            cubit.changePasswordVisibilty();
                          },
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter password';
                            }
                          },
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Conditional.single(
                            context: context,
                            conditionBuilder: (context) =>
                                state is! RegisterLoadingState,
                            widgetBuilder: (context) => AppMaterialButton(
                                  title: 'REGISTER',
                                  onPressed: () {
                                    if (formKey.currentState!.validate()) {
                                      cubit.registerUser(
                                        name: nameController.text,
                                        email: emailController.text,
                                        password: passwordController.text,
                                        phone: phoneController.text,
                                      );
                                    }
                                  },
                                ),
                            fallbackBuilder: (context) =>
                                Center(child: CircularProgressIndicator())),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('I have an acount?'),
                            TextButton(
                              onPressed: () {
                                AppNavigator.navigateAndFinish(
                                  nextScreen: LoginScreen(),
                                  context: context,
                                );
                              },
                              child: Text('Login Now'),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
