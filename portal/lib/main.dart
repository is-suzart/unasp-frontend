import 'package:atomic/ui/theme/atomic_theme.dart';
import 'package:flutter/material.dart';
import 'package:portal/core/di/injection.dart';
import 'view/login.dart';

void main() {
  // 🔧 Inicializa todas as dependências ANTES de rodar o app
  setupDependencies();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Portal UNASP',
      debugShowCheckedModeBanner: false,
      theme: AtomicTheme.lightTheme,
      home: const LoginPage(),
    );
  }
}
