import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../utils/color.dart';
import '../viewmodel/login_viewmodel.dart'; // Importe seu ViewModel

class LoginScreen extends StatefulWidget {
  final VoidCallback onLoginSuccess;
  final VoidCallback onRegisterClick;

  const LoginScreen({
    Key? key,
    required this.onLoginSuccess,
    required this.onRegisterClick,
  }) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isLoading = false;
  String? _errorMessage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: white,
        child: Center(
          child: _buildVerticalLayout(),
        ),
      ),
    );
  }

  Widget _buildVerticalLayout() {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: SingleChildScrollView(
        child: Consumer<LoginViewModel>(
          builder: (context, viewModel, child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 96.0),
                  child: const Text(
                    'Bem-vindo',
                    style: TextStyle(fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 48),
                const Text(
                  'Entrar',
                  style: TextStyle(fontSize: 14),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                TextField(
                  onChanged: (value) => viewModel.updateEmail(value),
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    labelStyle: TextStyle(color: Colors.black),
                    fillColor: Colors.black,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(40),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 16),
                TextField(
                  onChanged: (value) => viewModel.updatePassword(value),
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                    labelText: 'Senha',
                    labelStyle: TextStyle(color: Colors.black),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(40),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                  ),
                  obscureText: true,
                ),
                if (viewModel.error != null)
                  Column(
                    children: [
                      const SizedBox(height: 8), // Ajuste o valor conforme necessário
                      Text(
                        viewModel.error!,
                        style: const TextStyle(color: Colors.red),
                      ),
                    ],
                  ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      // Lógica de esquecimento de senha
                    },
                    child: const Text(
                      'Esqueci minha senha',
                      style: TextStyle(color: primary, fontSize: 14),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                viewModel.isLoading
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                  onPressed: () {
                    viewModel.login().then((_) {
                      if (viewModel.isLoggedIn) {
                        widget.onLoginSuccess();
                      }
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primary,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40),
                    ),
                  ),
                  child: const Text('Entrar',
                      style: TextStyle(color: Colors.white)),
                ),
                const SizedBox(height: 16),
                const Row(
                  children: [
                    Expanded(child: Divider(color: Colors.black)),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text('ou'),
                    ),
                    Expanded(child: Divider(color: Colors.black)),
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
                            onTap: () {},
                            child: SvgPicture.asset(
                              'assets/images/facebook_logo.svg',
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
                            onTap: () {},
                            child: SvgPicture.asset(
                              'assets/images/google_logo.svg',
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
                    const Text('Ainda não tem uma conta? '),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: widget.onRegisterClick,
                      child: const Text(
                        'Crie aqui',
                        style: TextStyle(
                          color: primary,
                          decorationColor: primary,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                SvgPicture.asset(
                  'assets/images/hiki_logo_without_text.svg',
                  height: 32,
                  width: 32,
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
