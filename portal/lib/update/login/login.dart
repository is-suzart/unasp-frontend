import 'package:flutter/material.dart';
import 'package:portal/model/login.dart';
import 'package:portal/side-effecs/login/login.dart';
import 'package:portal/view/home.dart';
import 'package:signals_flutter/signals_flutter.dart';

class LoginController {
  final LoginRepository _repository;

  // State Signal
  final state = signal<LoginModel>(LoginModel.initial());

  LoginController({required LoginRepository repository})
    : _repository = repository;

  // Actions
  void setEmail(String value) {
    state.value = state.value.copyWith(email: value, errorMessage: '');
  }

  void setPassword(String value) {
    state.value = state.value.copyWith(password: value, errorMessage: '');
  }

  Future<void> submit(BuildContext context) async {
    if (state.value.status == LoginStatus.loading) return;

    final email = state.value.email;
    final password = state.value.password;

    if (email.isEmpty || password.isEmpty) {
      state.value = state.value.copyWith(
        status: LoginStatus.error,
        errorMessage: 'Preencha todos os campos',
      );
      return;
    }

    // Set Loading
    state.value = state.value.copyWith(status: LoginStatus.loading);

    try {
      // Call Repository
      final (user, token) = await _repository.login(email, password);

      // Success
      state.value = state.value.copyWith(status: LoginStatus.success);
      state.value = state.value.copyWith(user: user);
      debugPrint('Login Success: User ${user.name} with token $token');

      // Navigate
      if (context.mounted) {
        Navigator.of(
          context,
        ).pushReplacement(MaterialPageRoute(builder: (_) => const HomePage()));
      }
    } catch (e) {
      // Error
      state.value = state.value.copyWith(
        status: LoginStatus.error,
        errorMessage: e.toString().replaceAll('Exception: ', ''),
      );
    }
  }
}
