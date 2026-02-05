import 'package:atomic/atomic.dart';
import 'package:entities/shared/menu.dart';
import 'package:entities/shared/visual_components.dart' as entity;
import 'package:atomic/ui/theme/atomic_theme.dart';
import 'package:entities/theme.dart'; // Import Custom Theme
import 'package:flutter/material.dart';
import 'package:signals_flutter/signals_flutter.dart';

void main() {
  runApp(const ShowcaseApp());
}

final themeMode = signal(ThemeMode.light);

class ShowcaseApp extends StatelessWidget {
  const ShowcaseApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Custom UNASP Theme
    // Use the factory we created in atomic to get real fonts
    final lightTheme = AtomicTheme.lightTheme;
    final darkTheme = AtomicTheme.darkTheme;
    final mode = themeMode.watch(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Atomic Showcase',
      theme: lightTheme,
      darkTheme: darkTheme, // Add Dark Theme
      themeMode: mode, // Dynamic Theme Mode
      home: const ShowCasePage(),
    );
  }
}

class ShowCasePage extends StatefulWidget {
  const ShowCasePage({super.key});

  @override
  State<ShowCasePage> createState() => _ShowCasePageState();
}

class _ShowCasePageState extends State<ShowCasePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final ScrollController _scrollController = ScrollController();
  final Signal<bool> _isScrolled = signal(false);

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      final scrolled = _scrollController.offset > 50;
      if (_isScrolled.value != scrolled) {
        _isScrolled.value = scrolled;
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Mock Data
    final menu = MenuEntity(
      logo:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRz-hWbWfD1R7qD7Z7Xy6qT7X7y6qT7X7y6qw&s',
      items: [
        MenuItemEntity(text: 'Início', url: '/'),
        MenuItemEntity(text: 'Sobre Nós', url: '/about'),
        MenuItemEntity(text: 'Ministérios', url: '/ministries'),
        MenuItemEntity(text: 'Eventos', url: '/events'),
        MenuItemEntity(text: 'Notícias', url: '/news'),
      ],
      buttons: [
        entity.ButtonEntity(
          text: 'Aluno',
          url: '/student',
          style: entity.AppButtonStyle.outlined,
          color: entity.AppButtonColor.primary,
        ),
        entity.ButtonEntity(
          text: 'Inscreva-se',
          url: '/signup',
          style: entity.AppButtonStyle.filled,
          color: entity.AppButtonColor.primary,
        ),
      ],
    );

    final features = List.generate(
      6,
      (index) => entity.CardEntity(
        title: 'Experiência ${index + 1}',
        subtitle: 'Categoria',
        text:
            'Descubra como a UNASP transforma vidas através da educação integral e valores cristãos.',
        backgroundImage: index % 2 == 0
            ? 'https://picsum.photos/400/300?random=$index'
            : null,
        buttons: [
          entity.ButtonEntity(
            text: 'Ler Mais',
            url: '#',
            style: entity.AppButtonStyle.outlined,
            color: entity
                .AppButtonColor
                .danger, // Keeping visible color, maybe neutral or primary
          ),
        ],
        alignment: entity.VisualAlignment.left,
      ),
    );

    return Scaffold(
      key: _scaffoldKey,
      extendBodyBehindAppBar: true,
      drawer: AppDrawer(menu: menu),
      appBar: AppHeader(
        menu: menu,
        isScrolled: _isScrolled,
        onMenuPressed: () {
          _scaffoldKey.currentState?.openDrawer();
        },
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            // Hero Placeholder
            Container(
              height: 500,
              width: double.infinity,
              color: Colors.blue.shade800,
              alignment: Alignment.center,
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.school, size: 80, color: Colors.white),
                  SizedBox(height: 20),
                  Text(
                    'Bem-vindo à UNASP',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      fontFamily: UnaspFonts.title, // Forced for Hero
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 60),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Text(
                'Nossos Destaques',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ),
            const SizedBox(height: 40),

            // Feature Grid
            FeatureGrid(items: features),

            const SizedBox(height: 80),

            // Demonstration of Dynamic Fields
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Formulário Dinâmico',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 24),
                  const DynamicFormSection(),
                ],
              ),
            ),

            const SizedBox(height: 80),

            // Footer
            AppFooter(
              menu: menu,
              socialIcons: [
                entity.ButtonEntity(
                  text: '',
                  url: '#',
                  icon: 'facebook',
                  style: entity.AppButtonStyle.filled,
                  color: entity.AppButtonColor.neutral,
                ),
                entity.ButtonEntity(
                  text: '',
                  url: '#',
                  icon: 'instagram',
                  style: entity.AppButtonStyle.filled,
                  color: entity.AppButtonColor.neutral,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class DynamicFormSection extends StatefulWidget {
  const DynamicFormSection({super.key});

  @override
  State<DynamicFormSection> createState() => _DynamicFormSectionState();
}

class _DynamicFormSectionState extends State<DynamicFormSection> {
  final Map<String, dynamic> formData = {
    'name': '',
    'email': '',
    'subscribe': true,
    'is_dark_mode': false,
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Theme.of(context).colorScheme.outlineVariant),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppDynamicFields(
            values: formData,
            onFieldChanged: (key, value) {
              setState(() {
                formData[key] = value;
              });
              if (key == 'is_dark_mode') {
                themeMode.value = (value == true)
                    ? ThemeMode.dark
                    : ThemeMode.light;
              }
            },
            fields: const [
              DynamicFieldConfig(
                key: 'name',
                type: DynamicFieldType.text,
                label: 'Nome Completo',
                hint: 'Digite seu nome',
              ),
              DynamicFieldConfig(
                key: 'email',
                type: DynamicFieldType.email,
                label: 'E-mail Institucional',
                hint: 'exemplo@unasp.edu.br',
              ),
              DynamicFieldConfig(
                key: 'password',
                type: DynamicFieldType.password,
                label: 'Senha',
                hint: 'Sua senha segura',
              ),
              DynamicFieldConfig(
                key: 'subscribe',
                type: DynamicFieldType.toggle,
                label: 'Receber novidades por e-mail',
              ),
              DynamicFieldConfig(
                key: 'terms',
                type: DynamicFieldType.checkbox,
                label: 'Li e aceito os termos de uso',
              ),
              DynamicFieldConfig(
                key: 'is_dark_mode',
                type: DynamicFieldType.toggle,
                label: 'Modo Escuro (Toggle)',
              ),
            ],
          ),
          const SizedBox(height: 24),
          AppButtonAtom(
            label: 'Enviar Cadastro',
            style: AppButtonStyle.filled,
            color: AppButtonColor.primary,
            icon: Icons.send_rounded,
            onPressed: () {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text('Dados: $formData')));
            },
          ),
        ],
      ),
    );
  }
}
