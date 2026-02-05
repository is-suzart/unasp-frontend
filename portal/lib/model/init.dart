// packages/unasp_entities/lib/auth_state.dart
class AuthState {
  // Esse é o seu MODEL
  final bool logged;
  final String? token;

  AuthState({required this.logged, this.token});

  // Método auxiliar para criar o estado inicial
  factory AuthState.initial() => AuthState(logged: false, token: null);
}
