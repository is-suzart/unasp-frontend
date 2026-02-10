import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:entities/user.dart';

class LoginRepository {
  // Em produção, use variáveis de ambiente. Para dev web local, localhost funciona.
  // Para emulador Android use 'http://10.0.2.2:3000'
  final String baseUrl = 'http://localhost:3000';

  Future<(UserEntity, String)> login(String email, String password) async {
    final url = Uri.parse('$baseUrl/auth/login');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final userMap = data['user'];
        final token = data['access_token'];

        final user = UserEntity(
          id: userMap['id']?.toString() ?? '',
          name: userMap['name']?.toString() ?? '',
          email: userMap['email']?.toString() ?? '',
          // A senha não é retornada pela API por segurança.
          // Mantemos vazia ou a senha digitada se necessário para algum fluxo local (evitar).
          password: '',
          admin: userMap['admin'] == true,
          communityId: userMap['communityId']?.toString() ?? '',
          position: userMap['position']?.toString() ?? 'Membro',
          image: userMap['image']?.toString(),
        );

        print('✅ Login realizado com sucesso: ${user.email}');
        return (user, token as String);
      } else if (response.statusCode == 401) {
        final error = jsonDecode(response.body);
        throw Exception(error['message'] ?? 'Credenciais inválidas');
      } else {
        throw Exception('Erro no login: ${response.statusCode}');
      }
    } catch (e) {
      if (e is Exception) rethrow; // Repassa exceções tratadas
      print('❌ Erro de conexão: $e');
      throw Exception(
        'Falha ao conectar ao servidor. Verifique se a API está rodando.',
      );
    }
  }
}
