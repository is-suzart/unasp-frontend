import 'package:entities/user.dart';

enum LoginStatus {
  idle,
  loading,
  success,
  error;

  bool get isLoading => this == loading;
}

class LoginModel {
  final String email;
  final String password;
  final LoginStatus status;
  final String errorMessage;
  final UserEntity? user;

  // Getter para facilitar acesso ao status de loading, mantendo consistência
  bool get loading => status == LoginStatus.loading;

  const LoginModel({
    required this.email,
    required this.password,
    this.status = LoginStatus.idle,
    this.errorMessage = '',
    this.user,
  });

  factory LoginModel.initial() => const LoginModel(
    email: '',
    password: '',
    status: LoginStatus.idle,
    errorMessage: '',
    user: null,
  );

  LoginModel copyWith({
    String? email,
    String? password,
    LoginStatus? status,
    String? errorMessage,
    UserEntity? user,
  }) {
    return LoginModel(
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      user: user ?? this.user,
    );
  }
}
