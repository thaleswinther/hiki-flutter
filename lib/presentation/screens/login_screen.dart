import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../utils/color.dart';
import '../viewmodel/login_viewmodel.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      body: Container(
        color: white,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: SingleChildScrollView(
              child: Consumer<LoginViewModel>(
                builder: (context, viewModel, child) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 96.0),
                        child: Text(
                          loc.welcome,
                          style: const TextStyle(fontSize: 16),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: 48),
                      Text(
                        loc.login,
                        style: const TextStyle(fontSize: 14),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        controller: _emailController,
                        onChanged: (value) => viewModel.updateEmail(value),
                        cursorColor: Colors.black,
                        decoration: InputDecoration(
                          labelText: loc.email,
                          labelStyle: const TextStyle(color: Colors.black),
                          fillColor: Colors.black,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(40),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.circular(40),
                          ),
                          contentPadding:
                          const EdgeInsets.symmetric(horizontal: 16),
                        ),
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: _passwordController,
                        onChanged: (value) => viewModel.updatePassword(value),
                        cursorColor: Colors.black,
                        decoration: InputDecoration(
                          labelText: loc.password,
                          labelStyle: const TextStyle(color: Colors.black),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.circular(40),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(40),
                          ),
                          contentPadding:
                          const EdgeInsets.symmetric(horizontal: 16),
                        ),
                        obscureText: true,
                      ),
                      if (viewModel.error != null)
                        Column(
                          children: [
                            const SizedBox(height: 8),
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
                          },
                          child: Text(
                            loc.password_forgot,
                            style:
                            const TextStyle(color: primary, fontSize: 14),
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
                              _emailController.clear();
                              _passwordController.clear();
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
                        child: Text(
                          loc.login,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          const Expanded(
                              child: Divider(color: Colors.black)),
                          Padding(
                            padding:
                            const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Text(loc.or),
                          ),
                          const Expanded(
                              child: Divider(color: Colors.black)),
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
                                Text(loc.facebook_description),
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
                                Text(loc.google_description),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(loc.register_account),
                          const SizedBox(width: 4),
                          GestureDetector(
                            onTap: () {
                              _emailController.clear();
                              _passwordController.clear();
                              widget.onRegisterClick();
                            },
                            child: Text(
                              loc.create_account,
                              style: const TextStyle(
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
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
