import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:planto_ecommerce_app/Routes/redirect_routes.dart';
import 'package:planto_ecommerce_app/Routes/route_names.dart';
import 'package:planto_ecommerce_app/Utils/colors.dart';
import 'package:provider/provider.dart';
import 'providers/auth_provider.dart';
import 'features/auth/domain/auth_repository.dart';
import 'features/auth/data/firebase_auth_repository.dart';

import 'firebase_options.dart';


void main() async{
  //Add firebase to project
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthRepository>(create: (_) => FirebaseAuthRepository()),
        ChangeNotifierProvider(create: (ctx) => AuthProvider(ctx.read<AuthRepository>())),
      ],
      child: MaterialApp(
        theme: ThemeData(
          appBarTheme: AppBarTheme(
            centerTitle: true,
            color: AppColors.purpleColor
          ),
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),

        ),
        title: 'Planto E-commerce',
        initialRoute: RouteNames.splashScreen,
        onGenerateRoute: RedirectRoutes.generateRoute,
      ),
    );
  }
}

