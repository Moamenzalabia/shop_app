import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:newshop_app/modules/login/login_screen.dart';
import 'package:newshop_app/shared/components/app_materialbutton.dart';
import 'package:newshop_app/shared/components/app_navigator.dart';
import 'package:newshop_app/shared/components/outline_textfield_border.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class SettingsScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SettingCubit, SettingStates>(
      listener: (context, state) {
        if (state is SuccessUserDataState) {
          nameController.text = state.user.data!.name;
          emailController.text = state.user.data!.email;
          phoneController.text = state.user.data!.phone;
        }
      },
      builder: (context, state) {
        var cubit = SettingCubit.getSettingCubit(context);
        return Conditional.single(
          context: context,
          conditionBuilder: (context) => state is! LoadingUserDataState,
          widgetBuilder: (context) => Scaffold(
            appBar: AppBar(),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      if (state is LoadingUpdateDataState)
                        LinearProgressIndicator(),
                      const SizedBox(height: 20),
                      OutlineTextfieldBorder(
                        controller: nameController,
                        textInputType: TextInputType.text,
                        labelText: 'Username',
                        prefixIcon: Icons.person,
                        validate: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter username address';
                          }
                        },
                      ),
                      const SizedBox(
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
                      const SizedBox(
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
                      const SizedBox(
                        height: 15,
                      ),
                      Conditional.single(
                          context: context,
                          conditionBuilder: (context) =>
                              state is! LoadingUpdateDataState,
                          widgetBuilder: (context) => AppMaterialButton(
                                title: 'UP-DATE',
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    cubit.updateUserData(
                                      name: nameController.text,
                                      email: emailController.text,
                                      phone: phoneController.text,
                                    );
                                  }
                                },
                              ),
                          fallbackBuilder: (context) =>
                              Center(child: CircularProgressIndicator())),
                      const SizedBox(
                        height: 15,
                      ),
                     AppMaterialButton(
                       title: 'LOG-OUT',
                       onPressed: () {
                         AppNavigator.navigateAndFinish(nextScreen: LoginScreen(), context: context);
                       }
                     ),
                    ],
                  ),
                ),
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
