import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';
import 'package:hooka/screens/sign_up.dart';
import 'package:hooka/screens/user.dart';
import 'main_screen.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  late Box<User> usersBox;

  // Define constants for box names
  static const String usersBoxName = 'users';
  static const String userAuthBoxName = 'userAuth';

  @override
  void initState() {
    super.initState();
    _openBoxes();
  }

  Future<void> _openBoxes() async {
    try {
      usersBox = await Hive.openBox<User>(usersBoxName);
    } catch (e) {
      // Handle error when opening the box
      print("Error opening users box: $e");
    }
  }

  @override
  void dispose() {
    // Close the Hive box when the widget is disposed
    usersBox.close();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  String _hashPassword(String password) {
    // Hash the password using SHA-256
    final bytes = utf8.encode(password);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  Future<String?> checkIfUserExists(String email, String password) async {
    try {
      final user = usersBox.get(email); // Get user by email

      if (user != null) {
        if (user.password == _hashPassword(password)) {
          return user.userId; // Return userId if login is successful
        } else {
          return "Incorrect password"; // Return specific feedback
        }
      } else {
        return "Account not found"; // Return specific feedback
      }
    } catch (e) {
      print("Error checking user existence: $e");
      return "Error occurred"; // Return error message
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24.0),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final email = _emailController.text;
                    final password = _passwordController.text;

                    final feedback = await checkIfUserExists(email, password);

                    if (feedback != null) {
                      if (feedback == "Incorrect password" || feedback == "Account not found") {
                        // Show specific feedback
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(feedback)),
                        );
                      } else {
                        // Successful login
                        final userId = feedback; // Get userId from feedback
                        final authBox = await Hive.openBox(userAuthBoxName);
                        authBox.put('loggedInUserId', userId);

                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MainScreen(isLoggedIn: true),
                          ),
                        );

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('You are logged in!')),
                        );
                      }
                    }
                  }
                },
                child : const Text('Login'),
              ),
              const SizedBox(height: 16.0),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SignupPage()),
                  );
                },
                child: const Text('Create New Account'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
