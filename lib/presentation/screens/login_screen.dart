import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodel/login_viewmodel.dart';

class LoginScreen extends StatelessWidget {
  final VoidCallback onLoginSuccess;
  final VoidCallback onRegisterClick;

  const LoginScreen({required this.onLoginSuccess, required this.onRegisterClick, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginViewModel>(
      builder: (context, viewModel, child) {
        if (viewModel.isLoggedIn) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            onLoginSuccess();
          });
        }
        return Scaffold(
          appBar: AppBar(title: Text('Login')),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  decoration: InputDecoration(labelText: 'Email'),
                  onChanged: viewModel.updateEmail,
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
                  onPressed: viewModel.login,
                  child: Text('Login'),
                ),
                TextButton(
                  onPressed: onRegisterClick,
                  child: Text('Don\'t have an account? Register'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

