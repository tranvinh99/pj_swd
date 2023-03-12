import "package:f_home_mo/api/api_service.dart";
import "package:flutter/material.dart";

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ApiService apiService = ApiService();
    return Scaffold(
      body: Center(
        child: TextButton(
          child: const Text('Lay data'),
          onPressed: () async {
            await apiService.getAllUsers();
          },
        ),
      ),
    );
  }
}
