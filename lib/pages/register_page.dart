import 'package:flutter/material.dart';

import '../config/colors.dart';
import '../database/database_helper.dart';
import '../models/user_model.dart';
import 'login_page.dart';

class RegisterPage extends StatefulWidget {
  static const routeName = '/register';

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nimController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  style: TextStyle(color: text),
                  controller: _usernameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    ),
                    fillColor: primary,
                    filled: true,
                    labelText: 'Username',
                    labelStyle: TextStyle(color: text)),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a username';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10.0),
                TextFormField(
                  style: TextStyle(color: text),
                  controller: _emailController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    ),
                    fillColor: primary,
                    filled: true,
                    labelText: 'Email',
                    labelStyle: TextStyle(color: text)),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter an email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10.0),
                TextFormField(
                  style: TextStyle(color: text),
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    ),
                    fillColor: primary,
                    filled: true,
                    labelText: 'Password',
                    labelStyle: TextStyle(color: text)),
                  obscureText: true,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a password';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10.0),
                TextFormField(
                  style: TextStyle(color: text),
                  controller: _nimController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    ),
                    fillColor: primary,
                    filled: true,
                    labelText: 'NIM',
                    labelStyle: TextStyle(color: text)),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a NIM';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primary,
                  ),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      final username = _usernameController.text;
                      final email = _emailController.text;
                      final password = _passwordController.text;
                      final nim = _nimController.text;
                      final user = UserModel(
                        username: username,
                        email: email,
                        password: password,
                        nim: nim,
                      );
                      await DatabaseHelper.instance.saveUser(user);
                      showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                          title: const Text('Success'),
                          content: const Text('Account registered successfully'),
                          actions: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: primary,
                              ),
                              onPressed: () {
                                Navigator.pushReplacementNamed(
                                    context, LoginPage.routeName);
                              },
                              child: const Text('OK'),
                            ),
                          ],
                        ),
                      );
                    }
                  },
                  child: const Text('Register', style: TextStyle(color: text)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}