import 'package:flutter/material.dart';

import '../login.dart';
import '../myHomeScreen.dart';
import '../service/api_clint.dart';

class User with ChangeNotifier {
  final ApiClient _apiClient = ApiClient();

  //Registrations
  Future<void> registerUsers(
      TextEditingController emailController,
      TextEditingController passwordController,
      GlobalKey<FormState> formKey,
      context,) async {
    if (formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('Processing Data'),
        backgroundColor: Colors.green.shade300,
      ));

      Map<String, dynamic> userData = {
        "Email": [
          {
            "Type": "Primary",
            "Value": emailController.text,
          }
        ],
        "Password": passwordController.text,
        "About": 'I am a new user :smile:',
        "FirstName": "Test",
        "LastName": "Account",
        "FullName": "Test Account",
        "BirthDate": "10-12-1985",
        "Gender": "M",
      };

      dynamic res = await _apiClient.registerUser(userData);

      ScaffoldMessenger.of(context).hideCurrentSnackBar();

      if (res['ErrorCode'] == null) {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const LoginScreen()));
        notifyListeners();
      } else {
        notifyListeners();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Error: ${res['Message']}'),
          backgroundColor: Colors.red.shade300,
        ));
      }
      notifyListeners();
    }
  }

  //login page controller

  Future<void> login(
    TextEditingController emailController,
    TextEditingController passwordController,
    GlobalKey<FormState> formKey,
      context
  ) async {
    if (formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('Processing Data'),
        backgroundColor: Colors.green.shade300,
      ));

      dynamic res = await _apiClient.login(
        emailController.text,
        passwordController.text,
      );

      ScaffoldMessenger.of(context).hideCurrentSnackBar();

      if (res['ErrorCode'] == null) {
        String accessToken = res['access_token'];
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => HomeScreen(accesstoken: accessToken)));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Error: ${res['Message']}'),
          backgroundColor: Colors.red.shade300,
        ));

      }
    }
    notifyListeners();
  }
}
