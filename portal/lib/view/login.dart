import 'package:atomic/ui/atoms/app_button_atom.dart';
import 'package:atomic/ui/atoms/app_input_atom.dart';
import 'package:atomic/ui/atoms/app_text_atom.dart';
import 'package:flutter/material.dart';
import 'package:portal/model/login.dart';
import 'package:portal/side-effecs/login/login.dart';
import 'package:portal/update/login/login.dart';
import 'package:signals_flutter/signals_flutter.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final LoginController controller;

  @override
  void initState() {
    super.initState();
    controller = LoginController(repository: LoginRepository());
  }

  @override
  Widget build(BuildContext context) {
    // Watch controller state
    final loginState = controller.state.watch(context);

    if (loginState.status == LoginStatus.loading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      backgroundColor: Colors.grey[100], // Cinzinha claro
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              'assets/images/login_background.jpg',
              fit: BoxFit.cover,
            ),
          ),
          // Content
          Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Card com width limitado para desktop
                    Card(
                      elevation: 2, // Leve sombra
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(40.0),
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 400),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              // Título ou Logo
                              Center(
                                child: Column(
                                  children: [
                                    Image.asset(
                                      'assets/images/logo.png',
                                      height: 40, // Reduced by 50%
                                    ),
                                    const SizedBox(height: 32),
                                    AppTextAtom.h2(
                                      'Login',
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 32),

                              // Error Message Display
                              if (loginState.errorMessage.isNotEmpty) ...[
                                Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: Colors.red.withValues(alpha: 0.1),
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                      color: Colors.red.withValues(alpha: 0.3),
                                    ),
                                  ),
                                  child: Text(
                                    loginState.errorMessage,
                                    style: const TextStyle(color: Colors.red),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                const SizedBox(height: 24),
                              ],

                              // Login (Email)
                              AppInputAtom(
                                label: 'E-mail',
                                hint: 'ex: aluno@unasp.br',
                                prefixIcon: Icons.email_outlined,
                                keyboardType: TextInputType.emailAddress,
                                onChanged: controller.setEmail,
                              ),
                              const SizedBox(height: 24),

                              // Senha
                              AppInputAtom(
                                label: 'Senha',
                                hint: '••••••••',
                                obscureText: true,
                                prefixIcon: Icons.lock_outline,
                                onChanged: controller.setPassword,
                              ),
                              const SizedBox(height: 48),

                              // Botão de Login
                              AppButtonAtom(
                                label: 'ENTRAR',
                                style: AppButtonStyle.filled,
                                color: AppButtonColor.primary,
                                onPressed: () => controller.submit(context),
                              ),
                              const SizedBox(height: 24),

                              // Link para cadastrar
                              Center(
                                child: TextButton(
                                  onPressed: () {
                                    // Navegar para cadastro
                                  },
                                  style: TextButton.styleFrom(
                                    foregroundColor: Theme.of(
                                      context,
                                    ).primaryColor,
                                  ),
                                  child: AppTextAtom.body(
                                    'Não possui conta? Cadastre-se',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
