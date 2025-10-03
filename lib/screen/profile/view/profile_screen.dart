import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  final Map<String, dynamic> params;

  const ProfileScreen({super.key, required this.params});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late final String userId;

  @override
  void initState() {
    userId = widget.params["user_id"] ?? "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Profile")),
      body: Center(
        child: Text(
          userId.isEmpty ? "No User Found" : "Hello User",
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ),
    );
  }
}
