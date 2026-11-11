import 'package:flutter/material.dart';
import '../services/storage.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});
  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final form = GlobalKey<FormState>();
  final username = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  bool signup = false;
  bool busy = false;
  String? error;
  @override
  void dispose() {
    username.dispose();
    email.dispose();
    password.dispose();
    super.dispose();
  }

  Future<void> submit() async {
    if (!form.currentState!.validate()) {
      return;
    }
    setState(() {
      busy = true;
      error = null;
    });
    try {
      if (signup) {
        await store.register(username.text, email.text, password.text);
      } else {
        await store.login(email.text, password.text);
      }
    } catch (failure) {
      if (mounted) {
        setState(
          () => error = failure.toString().replaceFirst('Exception: ', ''),
        );
      }
    } finally {
      if (mounted) {
        setState(() => busy = false);
      }
    }
  }

  void switchMode() => setState(() {
    signup = !signup;
    error = null;
    form.currentState?.reset();
  });
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Calm Steps')),
    body: Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 440),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: form,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Icon(Icons.spa, size: 64, color: Colors.teal),
                Text(
                  signup ? 'Create your account' : 'Welcome back',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const Text('Small moments. A calmer day.'),
                const SizedBox(height: 24),
                if (signup)
                  TextFormField(
                    controller: username,
                    decoration: const InputDecoration(labelText: 'Username'),
                    validator: (value) => (value ?? '').trim().length < 2
                        ? 'Enter at least 2 characters'
                        : null,
                  ),
                TextFormField(
                  controller: email,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(labelText: 'Email'),
                  validator: (value) =>
                      RegExp(
                        r'^[^\s@]+@[^\s@]+\.[^\s@]+$',
                      ).hasMatch((value ?? '').trim())
                      ? null
                      : 'Enter a valid email',
                ),
                TextFormField(
                  controller: password,
                  obscureText: true,
                  decoration: const InputDecoration(labelText: 'Password'),
                  validator: (value) => (value ?? '').length < 8
                      ? 'Use at least 8 characters'
                      : null,
                ),
                if (error != null)
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Text(
                      error!,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.error,
                      ),
                    ),
                  ),
                const SizedBox(height: 24),
                FilledButton(
                  onPressed: busy ? null : submit,
                  child: Text(
                    busy
                        ? 'Please wait…'
                        : signup
                        ? 'Sign up'
                        : 'Log in',
                  ),
                ),
                if (!signup)
                  OutlinedButton(
                    onPressed: busy ? null : switchMode,
                    child: const Text('Sign up'),
                  ),
                TextButton(
                  onPressed: busy ? null : switchMode,
                  child: Text(
                    signup ? 'Already registered? Log in' : 'New here? Sign up',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
