import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodel/register_viewmodel.dart';

class RegisterScreen extends StatelessWidget {
  final VoidCallback onRegisterSuccess;
  final VoidCallback onLoginClick;

  const RegisterScreen({required this.onRegisterSuccess, required this.onLoginClick, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<RegisterViewModel>(
      builder: (context, viewModel, child) {
        if (viewModel.isRegistered) {
          onRegisterSuccess();
        }
        return Scaffold(
          appBar: AppBar(title: Text('Register')),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  decoration: InputDecoration(labelText: 'Email'),
                  onChanged: viewModel.updateEmail,
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'Username'),
                  onChanged: viewModel.updateUsername,
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'Password'),
                  obscureText: true,
                  onChanged: viewModel.updatePassword,
                ),
                if (viewModel.error != null)
                  Text(
                    viewModel.error!,
                    style: TextStyle(color: Colors.red),
                  ),
                SizedBox(height: 20),
                viewModel.isLoading
                    ? CircularProgressIndicator()
                    : ElevatedButton(
                  onPressed: viewModel.register,
                  child: Text('Register'),
                ),
                TextButton(
                  onPressed: onLoginClick,
                  child: Text('Already have an account? Login'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
