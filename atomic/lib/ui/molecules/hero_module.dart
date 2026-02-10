import 'package:flutter/material.dart';

class HeroModule extends StatelessWidget {
  final String title;
  final String description;
  final String? backgroundImage;
  final VoidCallback? onCtaCompressed;

  const HeroModule({
    super.key,
    required this.title,
    required this.description,
    this.backgroundImage,
    this.onCtaCompressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(minHeight: 250),
      decoration: BoxDecoration(
        color: Colors.deepPurpleAccent,
        borderRadius: BorderRadius.circular(24),
        image: backgroundImage != null
            ? DecorationImage(
                image: NetworkImage(backgroundImage!),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.4),
                  BlendMode.darken,
                ),
              )
            : null,
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: Theme.of(
              context,
            ).textTheme.bodyLarge?.copyWith(color: Colors.white70),
          ),
          if (onCtaCompressed != null) ...[
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: onCtaCompressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.deepPurple,
              ),
              child: const Text('Saiba Mais'),
            ),
          ],
        ],
      ),
    );
  }
}
