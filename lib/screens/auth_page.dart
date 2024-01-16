import 'package:ayiolo_safari_advisor/services/auth_service.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  AuthService? authService;

  @override
  void initState() {
    super.initState();
    authService = AuthService();
  }

  bool isNewUser = false;

  @override
  Widget build(BuildContext context) {
    final navigator = Navigator.of(context);
    final scaffoldMessage = ScaffoldMessenger.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(isNewUser ? 'Signup to Ayiolo' : 'Login to Ayiolo'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Enter an email';
                  }
                  
                  final emailRegex =
                      RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
                  if (!emailRegex.hasMatch(value)) {
                    return 'Enter a valid email address';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  labelText: 'Email',
                ),
                controller: _emailController,
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                validator: (value) => value!.length < 6
                    ? 'Password must be at least 6 characters long.'
                    : null,
                decoration: const InputDecoration(
                  labelText: 'Password',
                ),
                controller: _passwordController,
                obscureText: true,
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () async {
                  authService ??= AuthService();
                  if (_formKey.currentState?.validate() == true) {
                    try {
                      if (isNewUser) {
                        await authService!.signUpWithEmailAndPassword(
                          _emailController.text,
                          _passwordController.text,
                        );
                        navigator.pushReplacementNamed('/welcome');
                      } else {
                        await authService!.signInWithEmailAndPassword(
                          _emailController.text,
                          _passwordController.text,
                        );
                        navigator.pushReplacementNamed('/welcome');
                      }
                    } catch (e) {
                      scaffoldMessage.showSnackBar(
                        SnackBar(
                          content: Text(authService?.error ??
                              'An unexpected error occurred.'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  }
                },
                child: Text(isNewUser ? 'Signup' : 'Login'),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    isNewUser = !isNewUser;
                  });
                },
                child: Text(isNewUser
                    ? 'Already have an account? Login'
                    : 'Don\'t have an account? Signup'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
