import 'package:entities/user.dart';

class LoginRepository {
  Future<(UserEntity, String)> login(String email, String password) async {
    // Simula uma chamada de rede
    await Future.delayed(const Duration(seconds: 2));

    // Simula sucesso ou erro.
    // Em produção, isso bateria numa API real.
    if ((email == 'admin' || email == 'aluno@unasp.br') &&
        password.isNotEmpty) {
      final user = UserEntity(
        id: '1',
        name: 'Usuário Teste',
        email: email,
        communityId: '1',
        position: 'admin',
        password:
            password, // Idealmente não trafegar senha no objeto de usuário logado
        admin: true, // Campo obrigatório
      );

      const token = 'fake-jwt-token-xyz-123';

      print('Login realizado com sucesso: ${user.email}');
      return (user, token);
    } else {
      throw Exception('Credenciais inválidas. Tente admin / qualquer_senha');
    }
  }
}
