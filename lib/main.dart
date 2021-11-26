import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newshop_app/modules/login/login_screen.dart';
import 'package:newshop_app/shared/app_cubit/app_cubit.dart';
import 'package:newshop_app/shared/app_cubit/app_states.dart';
import 'package:newshop_app/shared/bloc_observer.dart';
import 'package:newshop_app/shared/network/local/cache_helper.dart';
import 'package:newshop_app/shared/network/remote/dio_helper.dart';
import 'package:newshop_app/shared/styles/app_themes.dart';
import 'modules/home/cubit/cubit.dart';
import 'modules/home/home_screen.dart';
import 'modules/on_boarding/on_boarding_screen.dart';
import 'modules/settings/cubit/cubit.dart';

void main() async {
  // بيتأكد ان كل حاجه هنا في الميثود خلصت و بعدين يتفح الابلكيشن
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await CacheHelper().init();
  DioHelper.init();
  bool isDarkMode = false; //CacheHelper().getSavedData(key: 'isDarkMode');

  Widget widget = OnBoardingScreen();
  var token = CacheHelper().getSavedData(key: 'token') ?? '';

  if (CacheHelper().getSavedData(key: 'onBoarding') ?? false) {
    if (token.isNotEmpty == true) {
      widget = HomeScreen();
    } else {
      widget = LoginScreen();
    }
  } else {
    widget = const OnBoardingScreen();
  }

  runApp(MyApp(isDarkMode, widget));
}

class MyApp extends StatelessWidget {
  final bool isDarkMode;
  final Widget startWidget;
  MyApp(
    this.isDarkMode,
    this.startWidget,
  );

  @override
  // constructor
  // build
  // this is manager of my app that will build the design and show on screen
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => AppCubit()
            ..changeAppMode(
              fromShared: isDarkMode,
            ),
        ),
        BlocProvider(
          create: (BuildContext context) => HomeCubit()..getHomeData()..getCategories()..getFavorites(),
        ),
        BlocProvider(
          create: (BuildContext context) => SettingCubit()..getUserData(),
        ),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (BuildContext context, AppStates state) {
          // if (state is AppInsertDatabaseState) Navigator.pop(context);
        },
        builder: (BuildContext context, AppStates state) {
          AppCubit cubit = AppCubit.getAppCubit(context);
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              themeMode: cubit.isDarkMode ? ThemeMode.dark : ThemeMode.light,
              darkTheme: AppThemesMode.darkTheme,
              theme: AppThemesMode.lightTheme,
              home: startWidget);
        },
      ),
    );
  }
}
