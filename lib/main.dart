import 'package:flutter/material.dart';
import 'package:flutter_app/data/expense_data.dart';
import 'package:flutter_app/pages/auth/auth_page.dart';
import 'package:flutter_app/pages/home/home_page.dart';
import 'package:flutter_app/pages/theme/theme_provider.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import 'Initializer/firebase_Initializer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  print('Initializing Firebase...');
  await FirebaseInitializer.initializeFirebase();
  print('Firebase Initialized!');

  // Initialize Hive
  await Hive.initFlutter();

  // open hive box
  await Hive.openBox("expense_database");

    runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => ExpenseData()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ExpenseData(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: AuthPage(),
        theme: Provider.of<ThemeProvider>(context).themeData,
      ),
    );

  }
}
