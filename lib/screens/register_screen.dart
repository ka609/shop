import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';
import 'user/categories_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  String confirmPassword = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Inscription')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (v) =>
                    v!.isEmpty ? 'Veuillez entrer un email' : null,
                onSaved: (v) => email = v!,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Mot de passe'),
                obscureText: true,
                validator: (v) =>
                    v!.length < 4 ? 'Mot de passe trop court' : null,
                onSaved: (v) => password = v!,
              ),
              TextFormField(
                decoration: const InputDecoration(
                    labelText: 'Confirmer le mot de passe'),
                obscureText: true,
                validator: (v) => v != password
                    ? 'Les mots de passe ne correspondent pas'
                    : null,
                onSaved: (v) => confirmPassword = v!,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                child: const Text('Créer un compte'),
                onPressed: () {
                  if (!_formKey.currentState!.validate()) return;

                  _formKey.currentState!.save();

                  Provider.of<AuthProvider>(context, listen: false)
                      .registerUser(email);

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const CategoriesScreen(),
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
