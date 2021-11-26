import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newshop_app/shared/network/local/cache_helper.dart';

import 'app_states.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());
  static AppCubit getAppCubit(context) => BlocProvider.of(context);

  bool isDarkMode = false;

  void changeAppMode({bool? fromShared}) {
    if (fromShared != null) {
      isDarkMode = fromShared;
      emit(AppChangeModeState());
    } else {
      isDarkMode = !isDarkMode;
      CacheHelper().saveData(
        key: 'isDarkMode',
        value: isDarkMode,
      ).then((value) {
        print('isDarkMode $value');
        emit(AppChangeModeState());
      });
    }
  }
}
