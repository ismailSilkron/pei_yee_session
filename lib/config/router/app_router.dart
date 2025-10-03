import 'package:flutter/material.dart';
import 'package:pei_yee_session/config/router/path_route.dart';
import 'package:pei_yee_session/screen/profile/view/profile_screen.dart';
import 'package:pei_yee_session/screen/register/view/register_screen.dart';

class AppRouter {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static Route<dynamic> generateRouteList(RouteSettings settings) {
    switch (settings.name) {
      case PathRoute.registerScreen:
        return _generateRoute(
          settings: settings,
          builder: (context) => RegisterScreen(),
        );
      case PathRoute.profileScreen:
        final params = settings.arguments as Map<String, dynamic>?;

        return _generateRoute(
          settings: settings,
          builder:
              (context) =>
                  ProfileScreen(params: params ?? {"user_id": "123123"}),
        );
      default:
        return _generateRoute(
          settings: settings,
          builder:
              (context) => Scaffold(
                body: Center(
                  child: Text("No Route Defined for ${settings.name}"),
                ),
              ),
        );
    }
  }

  static MaterialPageRoute _generateRoute({
    required RouteSettings settings,
    required Widget Function(BuildContext context) builder,
  }) {
    return MaterialPageRoute(builder: builder, settings: settings);
  }
}
