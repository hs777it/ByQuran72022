import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:welivewithquran/Views/main_screen.dart';

import 'Controller/auth_controller.dart';
import 'Views/login_screen.dart';
import 'Views/splash_screen.dart';
import 'constants/get_pages_constant.dart';
import 'zTools/tools.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();

  // Firebase Initialize
  await Firebase.initializeApp().then((value) => Get.put(AuthController()));

  // SSL certification problem on all http requests
  HttpOverrides.global = MyHttpOverrides();


  // SharedPreferences pref = await SharedPreferences.getInstance();
  // var email = pref.getString('email');
  await GetStorage.init();

  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      builder: (context, child) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
       // getPages: getPages,
        //initialRoute: RouteConstant.splashScreen,
        title:BookTools.appName,
        theme: ThemeData(colorScheme:ColorScheme.light(),fontFamily: 'Janna' ),
        darkTheme: ThemeData.dark(),
        locale: const Locale('ar'),
        home: child,
      ),
      child:  SplashScreen(),
      // child:  LibraryScreen(),
    );
  }
}



class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (cert, String host, int port)=> true;
  }
}
