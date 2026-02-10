# 🔄 Injeção de Dependência e Ciclo de Vida

## 🤔 O Problema Original

Quando você cria dependências manualmente no `initState`:

```dart
@override
void initState() {
  super.initState();
  controller = LoginController(repository: LoginRepository());
}
```

**Problemas:**
1. ❌ **Memory Leak**: O controller e repository ficam na memória mesmo após sair da tela
2. ❌ **Acoplamento**: O widget precisa saber COMO criar o controller
3. ❌ **Difícil de testar**: Não dá pra mockar facilmente
4. ❌ **Múltiplas instâncias**: Se o widget reconstruir, cria novas instâncias

---

## ✅ A Solução: GetIt (Service Locator)

### 📦 Como Funciona

```
┌─────────────────────────────────────────────────────────┐
│                    APLICAÇÃO INICIA                      │
│                    main() executa                        │
└────────────────────┬────────────────────────────────────┘
                     │
                     ▼
┌─────────────────────────────────────────────────────────┐
│              setupDependencies()                         │
│  ┌───────────────────────────────────────────────────┐  │
│  │  GetIt registra COMO criar cada dependência       │  │
│  │  (mas NÃO cria ainda!)                            │  │
│  └───────────────────────────────────────────────────┘  │
└────────────────────┬────────────────────────────────────┘
                     │
                     ▼
┌─────────────────────────────────────────────────────────┐
│              runApp(MyApp())                             │
│              App está rodando                            │
└────────────────────┬────────────────────────────────────┘
                     │
                     ▼
┌─────────────────────────────────────────────────────────┐
│          LoginPage é criada                              │
│                                                          │
│  initState() {                                           │
│    controller = getIt<LoginController>();  ◄─────┐      │
│  }                                               │      │
└──────────────────────────────────────────────────┼──────┘
                                                   │
                     ┌─────────────────────────────┘
                     │
                     ▼
┌─────────────────────────────────────────────────────────┐
│              GetIt CRIA as instâncias                    │
│                                                          │
│  1. Cria LoginRepository()                               │
│  2. Injeta no LoginController(repository: ...)           │
│  3. Retorna o controller pronto                          │
└────────────────────┬────────────────────────────────────┘
                     │
                     ▼
┌─────────────────────────────────────────────────────────┐
│          LoginPage usa o controller                      │
│          Usuário interage com a tela                     │
└────────────────────┬────────────────────────────────────┘
                     │
                     ▼
┌─────────────────────────────────────────────────────────┐
│      Usuário navega para outra tela                      │
│      LoginPage é destruída (dispose)                     │
│                                                          │
│  ✅ Controller é DESTRUÍDO automaticamente               │
│  ✅ Repository é DESTRUÍDO automaticamente               │
│  ✅ Memória é LIBERADA                                   │
└─────────────────────────────────────────────────────────┘
```

---

## 🏭 Tipos de Registro

### 1. `registerFactory` - **Usa para Controllers e Repositories**

```dart
getIt.registerFactory<LoginController>(
  () => LoginController(repository: getIt<LoginRepository>()),
);
```

**Comportamento:**
- ✅ Cria uma **NOVA instância** toda vez que você pede
- ✅ Quando o widget morre, a instância morre também
- ✅ **Leve**: Não fica na memória quando não está em uso
- 🎯 **Use para**: Controllers, Repositories, Use Cases

**Exemplo:**
```dart
// Primeira vez
final controller1 = getIt<LoginController>(); // Cria instância A

// Segunda vez
final controller2 = getIt<LoginController>(); // Cria instância B (diferente!)

// controller1 != controller2 ✅
```

---

### 2. `registerLazySingleton` - **Usa para Serviços Globais**

```dart
getIt.registerLazySingleton<AuthService>(() => AuthService());
```

**Comportamento:**
- ✅ Cria **UMA única instância** quando solicitada pela primeira vez
- ✅ Reutiliza a mesma instância sempre
- ⚠️ **Fica na memória** até o app fechar
- 🎯 **Use para**: Serviços de autenticação, cache, configurações globais

**Exemplo:**
```dart
// Primeira vez
final auth1 = getIt<AuthService>(); // Cria instância A

// Segunda vez
final auth2 = getIt<AuthService>(); // Retorna instância A (mesma!)

// auth1 == auth2 ✅
```

---

### 3. `registerSingleton` - **Raramente Usado**

```dart
getIt.registerSingleton<Database>(Database());
```

**Comportamento:**
- ✅ Cria a instância **IMEDIATAMENTE** (no setup)
- ⚠️ **Sempre na memória**, mesmo sem uso
- 🎯 **Use para**: Recursos que SEMPRE serão usados (ex: Database)

---

## 🧠 Como Garantir que a Aplicação Fique Leve

### ✅ Boas Práticas

1. **Use `registerFactory` para tudo que é temporário**
   ```dart
   // ✅ BOM - Cria e destrói conforme necessário
   getIt.registerFactory<LoginController>(() => LoginController(...));
   getIt.registerFactory<LoginRepository>(() => LoginRepository());
   ```

2. **Use `registerLazySingleton` apenas para serviços globais**
   ```dart
   // ✅ BOM - Serviço que precisa ser compartilhado
   getIt.registerLazySingleton<AuthService>(() => AuthService());
   getIt.registerLazySingleton<StorageService>(() => StorageService());
   ```

3. **Evite `registerSingleton` (cria instância imediatamente)**
   ```dart
   // ❌ RUIM - Cria na hora, mesmo sem usar
   getIt.registerSingleton<HeavyService>(HeavyService());
   
   // ✅ BOM - Só cria quando precisar
   getIt.registerLazySingleton<HeavyService>(() => HeavyService());
   ```

4. **Limpe recursos pesados no dispose**
   ```dart
   @override
   void dispose() {
     // Se o controller tiver streams, timers, etc
     controller.dispose(); // Implementar método dispose no controller
     super.dispose();
   }
   ```

---

## 🎯 Exemplo Completo

### 1. Setup (injection.dart)

```dart
void setupDependencies() {
  // 🏭 Repositories - Factory (leve, sem estado)
  getIt.registerFactory<LoginRepository>(() => LoginRepository());
  getIt.registerFactory<UserRepository>(() => UserRepository());
  
  // 🎮 Controllers - Factory (nova instância por tela)
  getIt.registerFactory<LoginController>(
    () => LoginController(repository: getIt()),
  );
  
  // 🌍 Serviços Globais - Lazy Singleton (compartilhado)
  getIt.registerLazySingleton<AuthService>(() => AuthService());
  getIt.registerLazySingleton<StorageService>(() => StorageService());
}
```

### 2. Uso no Widget

```dart
class _LoginPageState extends State<LoginPage> {
  late final LoginController controller;

  @override
  void initState() {
    super.initState();
    // 💉 GetIt cria uma NOVA instância
    controller = getIt<LoginController>();
  }

  // ✅ Quando o widget morre, o controller morre também
  // Não precisa de dispose() se não houver recursos pesados
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(...);
  }
}
```

---

## 📊 Comparação: Antes vs Depois

| Aspecto | Antes (Manual) | Depois (GetIt) |
|---------|---------------|----------------|
| **Criação** | `LoginController(repository: LoginRepository())` | `getIt<LoginController>()` |
| **Acoplamento** | ❌ Alto (widget conhece dependências) | ✅ Baixo (widget só pede o tipo) |
| **Testabilidade** | ❌ Difícil (precisa mockar no widget) | ✅ Fácil (registra mock no GetIt) |
| **Memória** | ⚠️ Pode vazar se não limpar | ✅ Limpa automaticamente (Factory) |
| **Reutilização** | ❌ Difícil compartilhar instâncias | ✅ Fácil (Singleton quando necessário) |

---

## 🧪 Testando com GetIt

```dart
void main() {
  setUp(() {
    // Registra mocks para testes
    getIt.registerFactory<LoginRepository>(
      () => MockLoginRepository(),
    );
  });

  tearDown(() {
    getIt.reset(); // Limpa após cada teste
  });

  test('Login com credenciais válidas', () async {
    final controller = getIt<LoginController>();
    // ... teste
  });
}
```

---

## 🎉 Resumo

✅ **GetIt gerencia o ciclo de vida automaticamente**  
✅ **Factory = Leve (cria e destrói conforme necessário)**  
✅ **Lazy Singleton = Compartilhado (uma instância global)**  
✅ **Aplicação fica leve porque só cria o que está usando**  
✅ **Fácil de testar e manter**

**A "morte" das dependências acontece automaticamente quando o widget é destruído!** 🎯
