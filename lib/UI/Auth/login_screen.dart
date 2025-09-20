import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:planto_ecommerce_app/Routes/route_names.dart';
import 'package:planto_ecommerce_app/providers/auth_provider.dart';
import 'package:planto_ecommerce_app/Utils/Utils.dart';
import '../../Utils/round_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() { _isLoading = true; });
    try {
      await context.read<AuthProvider>().signIn(_emailController.text.trim(), _passwordController.text.trim());
      if (!mounted) return;
      
      final user = context.read<AuthProvider>().currentUser;
      if (user == null) {
        Utils.toastMessage('Login failed');
        return;
      }
      
      final route = user.role == 'admin' ? RouteNames.adminScreen : RouteNames.customerScreen;
      Navigator.pushNamedAndRemoveUntil(context, route, (route) => false);
    } catch (e) {
      Utils.toastMessage('Login failed: ${e.toString()}');
    } finally {
      if (mounted) setState(() { _isLoading = false; });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
                validator: (v) => (v == null || !v.contains('@')) ? 'Enter a valid email' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: (v) => (v == null || v.length < 6) ? 'Min 6 chars' : null,
              ),
              const SizedBox(height: 24),
              RoundButton(title: 'Login', onPressed: _isLoading ? null : _handleLogin, loading: _isLoading),
              TextButton(
                onPressed: () => Navigator.pushNamed(context, RouteNames.signUpScreen),
                child: const Text("Don't have an account? Sign up"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
