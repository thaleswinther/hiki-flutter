import 'package:flutter/material.dart';
import 'package:hiki_flutter/utils/color.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../viewmodel/register_viewmodel.dart';

class RegisterScreen extends StatelessWidget {
  final VoidCallback onRegisterSuccess;
  final VoidCallback onLoginClick;

  const RegisterScreen({
    required this.onRegisterSuccess,
    required this.onLoginClick,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<RegisterViewModel>(
      builder: (context, viewModel, child) {
        if (viewModel.isRegistered) {
          onRegisterSuccess();
        }
        return Scaffold(
          backgroundColor: white,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 104),
                  const Text(
                    'Bem-vindo',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 48),
                  const Text(
                    'Crie sua conta',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    label: 'Email',
                    onChanged: viewModel.updateEmail,
                    obscureText: false,
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    label: 'Username',
                    onChanged: viewModel.updateUsername,
                    obscureText: false,
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    label: 'Senha',
                    onChanged: viewModel.updatePassword,
                    obscureText: true,
                  ),
                  if (viewModel.error != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(
                        viewModel.error!,
                        style: const TextStyle(
                          color: Colors.red,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  const SizedBox(height: 16),
                  viewModel.isLoading
                      ? const CircularProgressIndicator()
                      : ElevatedButton(
                    onPressed: viewModel.register,
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(120, 44),
                      backgroundColor: redLess,
                    ),
                    child: const Text('Criar', style: TextStyle(color: white)),
                  ),
                  const SizedBox(height: 16),
                  const Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 1,
                          color: Colors.black,
                          indent: 32,
                          endIndent: 16,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          'ou',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 1,
                          color: Colors.black,
                          indent: 16,
                          endIndent: 32,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                // Lógica do Facebook
                              },
                              child: SvgPicture.asset(
                                'assets/images/facebook_logo_register.svg',
                                width: 64,
                                height: 64,
                              ),
                            ),
                            const Text('Facebook'),
                          ],
                        ),
                      ),
                      const SizedBox(width: 32),
                      Flexible(
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                // Lógica do Google
                              },
                              child: SvgPicture.asset(
                                'assets/images/google_logo_register.svg',
                                width: 64,
                                height: 64,
                              ),
                            ),
                            const Text('Google'),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Já tem uma conta?',
                        style: TextStyle(color: Colors.black),
                      ),
                      TextButton(
                        onPressed: onLoginClick,
                        child: const Text(
                          'Entre aqui',
                          style: TextStyle(
                            color: redLess,
                            decorationColor: redLess,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  SvgPicture.asset(
                    'assets/images/hiki_logo_without_text.svg',
                    width: 32,
                    height: 32,
                  ),
                  const SizedBox(height: 64),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildTextField({
    required String label,
    required Function(String) onChanged,
    required bool obscureText,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: TextField(
        onChanged: onChanged,
        obscureText: obscureText,
        cursorColor: Colors.black,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Colors.black),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: black),
            borderRadius: BorderRadius.circular(40)
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40),
            borderSide: const BorderSide(color: Colors.black),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
        ),
      ),
    );
  }
}
