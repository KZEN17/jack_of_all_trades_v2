import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jack_of_all_trades/config/theme/app_colors.dart';

class CategoryCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final VoidCallback? onTap;

  const CategoryCard({
    super.key,
    required this.title,
    required this.icon,
    required this.color,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:
          onTap ??
          () {
            context.push('/client/services', extra: {'category': title});
          },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 28),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  static List<CategoryCard> getCategories() {
    return [
      const CategoryCard(
        title: 'Cleaning',
        icon: Icons.cleaning_services,
        color: AppColors.cleaning,
      ),
      const CategoryCard(
        title: 'Electrical',
        icon: Icons.electric_bolt,
        color: AppColors.electrical,
      ),
      const CategoryCard(
        title: 'Plumbing',
        icon: Icons.plumbing,
        color: AppColors.plumbing,
      ),
      const CategoryCard(
        title: 'Painting',
        icon: Icons.format_paint,
        color: AppColors.painting,
      ),
      const CategoryCard(
        title: 'Carpentry',
        icon: Icons.handyman,
        color: AppColors.carpentry,
      ),
      const CategoryCard(
        title: 'Gardening',
        icon: Icons.yard,
        color: AppColors.gardening,
      ),
      const CategoryCard(
        title: 'Moving',
        icon: Icons.local_shipping,
        color: AppColors.moving,
      ),
      const CategoryCard(
        title: 'Assembly',
        icon: Icons.build,
        color: AppColors.assembly,
      ),
    ];
  }
}
