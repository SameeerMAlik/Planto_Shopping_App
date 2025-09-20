import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';

class CustomerScreen extends StatefulWidget {
  const CustomerScreen({super.key});

  @override
  State<CustomerScreen> createState() => _CustomerScreenState();
}

class _CustomerScreenState extends State<CustomerScreen> {
  Future<void> _signOut() async {
    await context.read<AuthProvider>().signOut();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Customer'),
        centerTitle: true,
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: _signOut,
          child: const Text('Sign out'),
        ),
      ),
    );
  }
}
