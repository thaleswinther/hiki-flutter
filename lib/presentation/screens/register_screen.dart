import 'package:flutter/material.dart';
import 'package:hiki_flutter/utils/color.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart'; // Import necessário para a localização
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
    var localizations = AppLocalizations.of(context)!; // Obtem as traduções do contexto

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
                  Text(
                    localizations.welcome, // "Bem-vindo"
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 48),
                  Text(
                    localizations.register_message, // "Crie sua conta"
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    label: localizations.email, // "Email"
                    onChanged: viewModel.updateEmail,
                    obscureText: false,
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    label: localizations.username, // "Username"
                    onChanged: viewModel.updateUsername,
                    obscureText: false,
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    label: localizations.password, // "Senha"
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
                    child: Text(
                      localizations.create, // "Criar"
                      style: const TextStyle(color: white),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      const Expanded(
                        child: Divider(
                          thickness: 1,
                          color: Colors.black,
                          indent: 32,
                          endIndent: 16,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          localizations.or, // "ou"
                          style: const TextStyle(color: Colors.black),
                        ),
                      ),
                      const Expanded(
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
                            Text(localizations.facebook_description), // "Facebook"
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
                            Text(localizations.google_description), // "Google"
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        localizations.login_account, // "Já tem uma conta?"
                        style: const TextStyle(color: Colors.black),
                      ),
                      TextButton(
                        onPressed: onLoginClick,
                        child: Text(
                          localizations.click_here, // "Entre aqui"
                          style: const TextStyle(
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
          labelStyle: const TextStyle(color: Colors.black),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: black),
            borderRadius: BorderRadius.circular(40),
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
