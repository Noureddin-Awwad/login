import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hooka/screens/splash_screens.dart';
import 'package:hooka/screens/user.dart';
import 'package:hooka/screens/address.dart';
import 'package:hooka/screens/education.dart';
import 'package:hooka/screens/experience.dart';
import 'package:hooka/user_provider.dart'; // Import UserProvider
import 'package:provider/provider.dart'; // Import Provider

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  // Register adapters
  Hive.registerAdapter(UserAdapter());
  Hive.registerAdapter(AddressAdapter());
  Hive.registerAdapter(EducationAdapter());
  Hive.registerAdapter(ExperienceAdapter());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UserProvider(), // Provide UserProvider
      child: MaterialApp(
        theme: ThemeData(
          appBarTheme: const AppBarTheme(),
        ),
        debugShowCheckedModeBanner: false,
        home: const SplashScreen(),
      ),
    );
  }
}
