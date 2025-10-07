import 'package:flutter/material.dart';
import 'package:pei_yee_session/config/app_theme.dart';
import 'package:pei_yee_session/config/router/app_router.dart';
import 'package:pei_yee_session/screen/home/view/home_screen.dart';
import 'package:pei_yee_session/service/database/database_config.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await DatabaseConfig().initDB();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
      theme: AppTheme.lightMode(context),
      navigatorKey: AppRouter.navigatorKey,
      onGenerateRoute: AppRouter.generateRouteList,
      debugShowCheckedModeBanner: false,
    );
  }
}
