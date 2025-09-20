import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:planto_ecommerce_app/Routes/route_names.dart';
import 'package:planto_ecommerce_app/UI/Auth/login_screen.dart';
import '../UI/Admin_Screen.dart';
import '../UI/Auth/signup_screen.dart';
import '../UI/Customer_Screen.dart';
import '../UI/Splash_Screen.dart';

class RedirectRoutes {
  // static Route<dynamic> is return type for routes

  static Route<dynamic> generateRoute(RouteSettings settings) {
    //use switch case to check which route is called
    switch (settings.name) {

      case RouteNames.loginScreen:
        return MaterialPageRoute(builder: (context) => LoginScreen());
      case RouteNames.signUpScreen:
        return MaterialPageRoute(builder: (context) => SignupScreen());
      case RouteNames.splashScreen:
        return MaterialPageRoute(builder: (context) => SplashScreen());
      case RouteNames.adminScreen:
        return MaterialPageRoute(builder: (context) => AdminScreen());
      case RouteNames.customerScreen:
        return MaterialPageRoute(builder: (context) => CustomerScreen());


      default:
        return MaterialPageRoute(
          builder: (context) {
            return Scaffold(
              appBar: AppBar(title: Text('No route Exists')),
              body: Text('Invalid Rute', style: TextStyle(fontSize: 50)),
            );
          },
        );
    }
  }
}
