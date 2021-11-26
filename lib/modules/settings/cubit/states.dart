import 'package:newshop_app/models/user_model.dart';

abstract class SettingStates {}

class UserDataInitialState extends SettingStates {}

class LoadingUserDataState extends SettingStates {}

class SuccessUserDataState extends SettingStates {
  final UserModel user;
  SuccessUserDataState(this.user);
}

class ErrorUserDataState extends SettingStates {
  final String error;
  ErrorUserDataState(this.error);
}

class LoadingUpdateDataState extends SettingStates {}

class SuccessUpdateDataState extends SettingStates {
  final UserModel user;
  SuccessUpdateDataState(this.user);
}

class ErrorUpdateDataState extends SettingStates {
  final String error;
  ErrorUpdateDataState(this.error);
}

class LoadingUserLogoutState extends SettingStates {}

class SuccessUserLogoutState extends SettingStates {
  final UserModel user;
  SuccessUserLogoutState(this.user);
}

class ErrorUserLogoutState extends SettingStates {
  final String error;
  ErrorUserLogoutState(this.error);
}
