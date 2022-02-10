import 'package:dinner_assistant_flutter/locator.dart';
import 'package:dinner_assistant_flutter/view/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/interface/auth_interface.dart';
import 'core/service/auth_service.dart';
import 'core/theme/my_theme.dart';

Future<void> main() async {
  setupLocator();
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
       providers: [
        ChangeNotifierProvider<AuthInterface>(
          create: (_) => AuthService(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        home: const SplashScreen(),
      ),
    );
  }
}
