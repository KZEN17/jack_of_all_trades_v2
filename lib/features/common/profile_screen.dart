import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jack_of_all_trades/config/theme/app_colors.dart';
import 'package:jack_of_all_trades/core/services/storage_service.dart';
import 'package:jack_of_all_trades/models/profile_item.dart';
import 'package:jack_of_all_trades/providers/theme_provider.dart';
import 'package:jack_of_all_trades/providers/user_provider.dart';
import 'package:jack_of_all_trades/widgets/common/custom_button.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  static const String routeName = '/profile';

  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProfileHeader(context, userProvider),
            const SizedBox(height: 24),
            _buildSection(
              context,
              title: 'Account',
              items: [
                ProfileItem(
                  icon: Icons.person,
                  title: 'Edit Profile',
                  onTap: () {
                    // TODO: Implement edit profile functionality
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Edit Profile - Coming Soon'),
                      ),
                    );
                  },
                ),
                ProfileItem(
                  icon: Icons.location_on,
                  title: 'Addresses',
                  onTap: () {
                    // TODO: Implement addresses functionality
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Addresses - Coming Soon')),
                    );
                  },
                ),
                ProfileItem(
                  icon: Icons.payment,
                  title: 'Payment Methods',
                  onTap: () {
                    // TODO: Implement payment methods functionality
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Payment Methods - Coming Soon'),
                      ),
                    );
                  },
                ),
                if (userProvider.isClient)
                  ProfileItem(
                    icon: Icons.favorite,
                    title: 'Saved Services',
                    onTap: () {
                      // TODO: Implement saved services functionality
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Saved Services - Coming Soon'),
                        ),
                      );
                    },
                  ),
              ],
            ),
            const SizedBox(height: 16),
            _buildSection(
              context,
              title: 'Preferences',
              items: [
                ProfileItem(
                  icon: Icons.notifications,
                  title: 'Notifications',
                  onTap: () {
                    // TODO: Implement notifications functionality
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Notifications - Coming Soon'),
                      ),
                    );
                  },
                ),
                ProfileItem(
                  icon: Icons.language,
                  title: 'Language',
                  onTap: () {
                    // TODO: Implement language functionality
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Language - Coming Soon')),
                    );
                  },
                ),
                ProfileItem(
                  icon:
                      themeProvider.isDarkMode
                          ? Icons.dark_mode
                          : Icons.light_mode,
                  title: '${themeProvider.isDarkMode ? 'Light' : 'Dark'} Mode',
                  onTap: () {
                    themeProvider.setThemeMode(
                      themeProvider.isDarkMode
                          ? ThemeMode.light
                          : ThemeMode.dark,
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildSection(
              context,
              title: 'Support',
              items: [
                ProfileItem(
                  icon: Icons.help,
                  title: 'Help & Support',
                  onTap: () {
                    // TODO: Implement help and support functionality
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Help & Support - Coming Soon'),
                      ),
                    );
                  },
                ),
                ProfileItem(
                  icon: Icons.info,
                  title: 'About Us',
                  onTap: () {
                    // TODO: Implement about us functionality
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('About Us - Coming Soon')),
                    );
                  },
                ),
                ProfileItem(
                  icon: Icons.privacy_tip,
                  title: 'Privacy Policy',
                  onTap: () {
                    // TODO: Implement privacy policy functionality
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Privacy Policy - Coming Soon'),
                      ),
                    );
                  },
                ),
                ProfileItem(
                  icon: Icons.description,
                  title: 'Terms & Conditions',
                  onTap: () {
                    // TODO: Implement terms and conditions functionality
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Terms & Conditions - Coming Soon'),
                      ),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 24),
            CustomButton(
              label: 'Logout',
              onPressed: () => _logout(context),
              type: ButtonType.outline,
              icon: Icons.logout,
              width: double.infinity,
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader(BuildContext context, UserProvider userProvider) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundColor: AppColors.primary,
            child: Text(
              'J',
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'John Doe',
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            'johndoe@example.com',
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: AppColors.textSecondary),
          ),
          const SizedBox(height: 4),
          Text(
            userProvider.isClient ? 'Client' : 'Handyman',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          CustomButton(
            label: 'Edit Profile',
            onPressed: () {
              // TODO: Implement edit profile functionality
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Edit Profile - Coming Soon')),
              );
            },
            type: ButtonType.primary,
            icon: Icons.edit,
            width: 150,
          ),
        ],
      ),
    );
  }

  Widget _buildSection(
    BuildContext context, {
    required String title,
    required List<ProfileItem> items,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.textSecondary,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: items.length,
            separatorBuilder: (context, index) => const Divider(height: 1),
            itemBuilder: (context, index) {
              return ListTile(
                leading: Icon(items[index].icon, color: AppColors.primary),
                title: Text(items[index].title),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: items[index].onTap,
              );
            },
          ),
        ),
      ],
    );
  }

  void _logout(BuildContext context) async {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Logout'),
            content: const Text('Are you sure you want to logout?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () async {
                  Navigator.pop(context);

                  final storageService = Provider.of<StorageService>(
                    context,
                    listen: false,
                  );
                  final userProvider = Provider.of<UserProvider>(
                    context,
                    listen: false,
                  );

                  await storageService.clearUserData();
                  userProvider.clearUser();

                  if (context.mounted) {
                    context.go('/login');
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.error,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Logout'),
              ),
            ],
          ),
    );
  }
}
