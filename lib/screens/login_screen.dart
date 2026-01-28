import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';
import 'admin/admin_home_screen.dart';
import 'user/categories_screen.dart';
import 'register_screen.dart'; // 👈 AJOUT

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Connexion')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Email'),
                onSaved: (v) => email = v!,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Mot de passe'),
                obscureText: true,
                onSaved: (v) => password = v!,
              ),
              const SizedBox(height: 20),

              // 🔐 BOUTON CONNEXION
              ElevatedButton(
                child: const Text('Se connecter'),
                onPressed: () {
                  _formKey.currentState!.save();
                  final success =
                      Provider.of<AuthProvider>(context, listen: false)
                          .login(email, password);

                  if (!success) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Identifiants incorrects'),
                      ),
                    );
                    return;
                  }

                  final auth =
                      Provider.of<AuthProvider>(context, listen: false);

                  if (auth.isAdmin) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const AdminHomeScreen(),
                      ),
                    );
                  } else {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const CategoriesScreen(),
                      ),
                    );
                  }
                },
              ),

              const SizedBox(height: 10),

              // 🆕 BOUTON INSCRIPTION
              TextButton(
                child: const Text("Pas encore de compte ? S'inscrire"),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const RegisterScreen(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
