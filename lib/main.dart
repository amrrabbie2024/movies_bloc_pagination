import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movies_bloc/core/get_it.dart';
import 'package:flutter_movies_bloc/core/kiwi.dart';
import 'package:flutter_movies_bloc/core/logic/cash_helper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/logic/helper_methods.dart';
import 'views/movies/view.dart';
import 'views/splash/view.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();

  CashHelper.init();
  initKiwi();
  initGetIt();

  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
        supportedLocales: [Locale('en'), Locale('ar'),Locale('fr')],
        path: 'assets/translations', // <-- change the path of the translation files
        fallbackLocale: Locale('en'),
        //startLocale: Locale('ar'),
        child: MyApp()
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
    minTextAdapt: true,
    splitScreenMode: true,
    // Use builder only if you need to use library outside ScreenUtilInit context
    builder: (_ , child) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      //locale: context.deviceLocale,
      navigatorKey: navigtorKey,
      title: 'Movies app',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
       fontFamily: "Roboto",
        colorScheme: ColorScheme.fromSeed(primary: Colors.green,seedColor: Colors.green),
        useMaterial3: true,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.transparent,
          centerTitle: true,
          titleTextStyle: TextStyle(color: Colors.green,fontWeight: FontWeight.bold,fontSize: 24,fontFamily: "PlaywriteNZ"),
          titleSpacing: 10
        ),
        iconButtonTheme: IconButtonThemeData(
          style: IconButton.styleFrom(
          )
        ),
        iconTheme: IconThemeData(
          color: Colors.green
        ),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              textStyle: TextStyle(color: Colors.orange,fontSize: 20,fontWeight: FontWeight.w500)
            )
          )
      ),
      home: const SplashView(),
    );
  }
    );
  }
}

