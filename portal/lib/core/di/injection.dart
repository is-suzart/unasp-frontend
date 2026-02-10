import 'package:get_it/get_it.dart';
import 'package:portal/side-effecs/login/login.dart';
import 'package:portal/update/login/login.dart';

final getIt = GetIt.instance;

/// Configura todas as dependências da aplicação
///
/// Tipos de registro:
/// - registerFactory: Cria uma NOVA instância toda vez (leve, sem estado compartilhado)
/// - registerLazySingleton: Cria UMA instância quando solicitada pela primeira vez (compartilhada)
/// - registerSingleton: Cria UMA instância imediatamente (sempre na memória)
void setupDependencies() {
  // 🏭 Repositories - Factory (nova instância toda vez, sem estado)
  getIt.registerFactory<LoginRepository>(() => LoginRepository());

  // 🎮 Controllers - Factory (nova instância por tela, limpa ao sair)
  getIt.registerFactory<LoginController>(
    () => LoginController(repository: getIt<LoginRepository>()),
  );

  // 💡 Se tivesse um serviço global (ex: AuthService), seria Singleton:
  // getIt.registerLazySingleton<AuthService>(() => AuthService());
}

/// Limpa todas as dependências (útil para testes)
void resetDependencies() {
  getIt.reset();
}
