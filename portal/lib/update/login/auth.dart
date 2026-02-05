// apps/unasp_portal/lib/state/auth_controller.dart

import 'package:portal/model/init.dart';
import 'package:portal/side-effecs/login/auth.dart';
import 'package:signals_flutter/signals_flutter.dart';

class AuthController {
  final AuthRepository _repo; // Sua Infra (Side-effects)

  // A "Caixa" (Signal) que segura o Modelo
  // O valor inicial vem do factory AuthState.initial()
  final state = signal<AuthState>(AuthState.initial());

  AuthController(this._repo);

  // AQUI MORA O INIT!
  void init() {
    // 1. Comando: "Vá buscar o token no disco!"
    _repo.getToken().then((token) {
      // 2. Update: "Recebi o token, agora mude o Modelo!"
      state.value = AuthState(logged: token != null, token: token);
    });
  }
}
