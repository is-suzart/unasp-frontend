import 'package:atomic/ui/atoms/app_text_atom.dart';
import 'package:entities/theme.dart';
import 'package:flutter/material.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    // Layout responsivo simples:
    // No desktop/tablet, as stats ficam em linha.
    // As colunas de "Atividades" e "Ações" ficam lado a lado.

    return SingleChildScrollView(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          AppTextAtom.h2(
            'Bem-vindo ao Portal UNASP',
            fontWeight: FontWeight.w700,
          ),
          const SizedBox(height: 8),
          AppTextAtom.body(
            'Gerencie o conteúdo e a comunidade da sua igreja',
            color: UnaspColors.dimGray,
          ),

          const SizedBox(height: 32),

          // Stats Row
          const _StatsRow(),

          const SizedBox(height: 32),

          // Content Columns (Activities + Actions)
          LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth > 900) {
                return const Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: _RecentActivitiesCard()),
                    SizedBox(width: 24),
                    Expanded(child: _QuickActionsCard()),
                  ],
                );
              } else {
                return const Column(
                  children: [
                    _RecentActivitiesCard(),
                    SizedBox(height: 24),
                    _QuickActionsCard(),
                  ],
                );
              }
            },
          ),
        ],
      ),
    );
  }
}

// --- Stats Widgets ---

class _StatsRow extends StatelessWidget {
  const _StatsRow();

  @override
  Widget build(BuildContext context) {
    // On narrower screens, wrap or scroll. Here using Wrap for simplicity or LayoutBuilder.
    // For this mock, simple Row with flex works for desktop.

    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 800;

        if (isMobile) {
          return const Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: _StatCard(
                      title: 'Total de Páginas',
                      value: '12',
                      trend: '+2 este mês',
                      icon: Icons.description_outlined,
                      color: Colors.blue,
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: _StatCard(
                      title: 'Usuários Ativos',
                      value: '1,284',
                      trend: '+18% vs mês anterior',
                      icon: Icons.people_outline,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: _StatCard(
                      title: 'Posts no Blog',
                      value: '48',
                      trend: '+5 esta semana',
                      icon: Icons.bar_chart_rounded,
                      color: Colors.purple,
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: _StatCard(
                      title: 'Taxa de Engajamento',
                      value: '84%',
                      trend: '+12% vs mês anterior',
                      icon: Icons.trending_up,
                      color: Colors.orange,
                    ),
                  ),
                ],
              ),
            ],
          );
        }

        return const Row(
          children: [
            Expanded(
              child: _StatCard(
                title: 'Total de Páginas',
                value: '12',
                trend: '+2 este mês',
                icon: Icons.description_outlined,
                color: Color(0xFF2196F3), // Blue 500
              ),
            ),
            SizedBox(width: 24),
            Expanded(
              child: _StatCard(
                title: 'Usuários Ativos',
                value: '1,284',
                trend: '+18% vs mês anterior',
                icon: Icons.people_outline,
                color: Color(0xFF00C853), // Green A700
              ),
            ),
            SizedBox(width: 24),
            Expanded(
              child: _StatCard(
                title: 'Posts no Blog',
                value: '48',
                trend: '+5 esta semana',
                icon: Icons.bar_chart_rounded,
                color: Color(0xFFAA00FF), // Purple A700
              ),
            ),
            SizedBox(width: 24),
            Expanded(
              child: _StatCard(
                title: 'Taxa de Engajamento',
                value: '84%',
                trend: '+12% vs mês anterior',
                icon: Icons.trending_up,
                color: Color(0xFFFF6D00), // Orange A700
              ),
            ),
          ],
        );
      },
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final String trend;
  final IconData icon;
  final Color color;

  const _StatCard({
    required this.title,
    required this.value,
    required this.trend,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.withValues(alpha: 0.1)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppTextAtom.body(
                      title,
                      color: UnaspColors.dimGray,
                      fontSize: 14,
                    ),
                    const SizedBox(height: 8),
                    AppTextAtom.h2(value, fontWeight: FontWeight.bold),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: Colors.white, size: 20),
              ),
            ],
          ),
          const SizedBox(height: 16),
          AppTextAtom.body(
            trend,
            color: const Color(0xFF00C853), // Green for positive trend
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ],
      ),
    );
  }
}

// --- Recent Activities ---

class _RecentActivitiesCard extends StatelessWidget {
  const _RecentActivitiesCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.withValues(alpha: 0.1)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppTextAtom.h3('Atividades Recentes', fontWeight: FontWeight.bold),
          const SizedBox(height: 24),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 4,
            separatorBuilder: (_, _) => const Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Divider(height: 1, thickness: 0.5),
            ),
            itemBuilder: (context, index) {
              return const _ActivityItem(
                title: 'Nova página criada',
                subtitle: 'Eventos 2026',
                time: '2 horas atrás',
              );
            },
          ),
        ],
      ),
    );
  }
}

class _ActivityItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final String time;

  const _ActivityItem({
    required this.title,
    required this.subtitle,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    // Hardcoded mocks for variations based on index effectively
    // But since we are mocking multiple rows, we can just pass data
    // Or randomize for effect?
    // Let's rely on props.

    // For the "Blue dot", simple minimal design
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 6),
          width: 8,
          height: 8,
          decoration: const BoxDecoration(
            color: Color(0xFF2979FF), // Blue Acccent
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppTextAtom.body(
                title,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
              const SizedBox(height: 4),
              AppTextAtom.body(
                subtitle,
                color: UnaspColors.dimGray,
                fontSize: 13,
              ),
            ],
          ),
        ),
        AppTextAtom.body(time, color: UnaspColors.dimGray, fontSize: 12),
      ],
    );
  }
}

// --- Quick Actions ---

class _QuickActionsCard extends StatelessWidget {
  const _QuickActionsCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.withValues(alpha: 0.1)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppTextAtom.h3('Ações Rápidas', fontWeight: FontWeight.bold),
          const SizedBox(height: 24),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 1.5, // retangular
            children: const [
              _ActionTile(
                title: 'Nova Página',
                subtitle: 'Criar página',
                icon: Icons.note_add_outlined,
                color: Color(0xFFE3F2FD), // Blue 50
                iconColor: Color(0xFF1565C0), // Blue 800
              ),
              _ActionTile(
                title: 'Novo Post',
                subtitle: 'Escrever artigo',
                icon: Icons.post_add_outlined,
                color: Color(0xFFE8F5E9), // Green 50
                iconColor: Color(0xFF2E7D32), // Green 800
              ),
              _ActionTile(
                title: 'Comunidade',
                subtitle: 'Gerenciar grupos',
                icon: Icons.groups_outlined,
                color: Color(0xFFF3E5F5), // Purple 50
                iconColor: Color(0xFF6A1B9A), // Purple 800
              ),
              _ActionTile(
                title: 'Relatórios',
                subtitle: 'Ver análises',
                icon: Icons.bar_chart_outlined,
                color: Color(0xFFFFF3E0), // Orange 50
                iconColor: Color(0xFFEF6C00), // Orange 800
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ActionTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final Color iconColor;

  const _ActionTile({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: iconColor, size: 24),
            const Spacer(),
            AppTextAtom.body(title, fontWeight: FontWeight.bold, fontSize: 14),
            const SizedBox(height: 4),
            AppTextAtom.body(
              subtitle,
              color: UnaspColors.dimGray,
              fontSize: 12,
            ),
          ],
        ),
      ),
    );
  }
}
