import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'presentation/views/splash_screen.dart';
import 'presentation/viewmodels/auth_provider.dart';

// Main function - Entry point of the app
// Update your main.dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

// Root widget of the application
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      // Wrap the app with Provider for state management
      providers: [
        // AuthProvider will manage authentication state throughout the app
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: MaterialApp(
        title: 'Planto - Fruit & Vegetable App',
        debugShowCheckedModeBanner: false, // Remove debug banner
        theme: ThemeData(
          primarySwatch: Colors.green, // Green theme for plant app
          fontFamily: 'Roboto',
        ),
        // Start with splash screen
        home: const SplashScreen(),
      ),
    );
  }
}