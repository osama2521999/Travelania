import 'package:bookingapp/router/RoutePaths.dart';
import 'package:bookingapp/screen/bookingScreen.dart';
import 'package:bookingapp/screen/login.dart';
import 'package:bookingapp/screen/mainScreen.dart';
import 'package:bookingapp/screen/setting.dart';
import 'package:bookingapp/screen/singup.dart';
import 'package:flutter/material.dart';

class AppRouter{

  static Route<dynamic> generateRoute(RouteSettings settings) {

    switch (settings.name) {

      case RoutePaths.start:
        return MaterialPageRoute(builder: (_) =>  const Login());

      case RoutePaths.signUp:
        return MaterialPageRoute(builder: (_) =>  const SignUp());

      case RoutePaths.mainScreen:
        return MaterialPageRoute(builder: (_) =>   const MainScreen());

      case RoutePaths.settings:
        return MaterialPageRoute(builder: (_) =>  const Settings());

      case RoutePaths.bookingScreen:
        return MaterialPageRoute(builder: (_) =>   BookingScreen(argument: settings.arguments));

      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
              body: Center(
                child: Text('${settings.name} still under developed '),
              ),
            )
        );
    }
  }

}