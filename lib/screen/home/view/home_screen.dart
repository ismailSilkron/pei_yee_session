import 'package:flutter/material.dart';
import 'package:pei_yee_session/config/router/path_route.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home")),
      body: Center(
        child: Column(
          spacing: 20,
          children: [
            Text("Homescreen", style: Theme.of(context).textTheme.titleLarge),
            TextButton(
              onPressed: () async {
                await Navigator.of(context).pushNamed(PathRoute.registerScreen);
              },
              child: Text("register"),
            ),
            TextButton(
              onPressed: () async {
                await Navigator.of(context).pushNamed(PathRoute.loginScreen);
              },
              child: Text("login"),
            ),
            TextButton(
              onPressed: () async {
                await Navigator.of(context).pushNamed(
                  PathRoute.profileScreen,
                  arguments: {"user_id": "123"},
                );
              },
              child: Text("Profile"),
            ),
          ],
        ),
      ),
    );
  }
}
