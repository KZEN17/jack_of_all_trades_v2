import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jack_of_all_trades/config/theme/app_colors.dart';
import 'package:jack_of_all_trades/core/services/storage_service.dart';
import 'package:jack_of_all_trades/widgets/common/custom_button.dart';
import 'package:provider/provider.dart';

import 'onboarding_page.dart';

class OnboardingScreen extends StatefulWidget {
  static const String routeName = '/onboarding';

  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardingPage> _pages = [
    const OnboardingPage(
      title: 'Find Trusted Professionals',
      description:
          'Connect with skilled and verified handymen for all your home service needs.',
      image: Icons.search,
    ),
    const OnboardingPage(
      title: 'Book Services Easily',
      description:
          'Schedule appointments at your convenience with just a few taps.',
      image: Icons.calendar_today,
    ),
    const OnboardingPage(
      title: 'Track in Real-Time',
      description:
          'Know exactly when your service provider will arrive and track their progress.',
      image: Icons.location_on,
    ),
    const OnboardingPage(
      title: 'Secure Payments',
      description:
          'Pay securely through the app once the job is completed to your satisfaction.',
      image: Icons.payment,
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onNextPage() {
    if (_currentPage < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _completeOnboarding();
    }
  }

  void _completeOnboarding() async {
    final storageService = Provider.of<StorageService>(context, listen: false);
    await storageService.setOnboardingCompleted(true);
    if (mounted) {
      context.go('/user-type');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: _pages.length,
                onPageChanged: (int page) {
                  setState(() {
                    _currentPage = page;
                  });
                },
                itemBuilder: (context, index) {
                  return _pages[index];
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      _pages.length,
                      (index) => _buildDotIndicator(index),
                    ),
                  ),
                  const SizedBox(height: 32),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _currentPage > 0
                          ? CustomButton(
                            label: 'Back',
                            onPressed: () {
                              _pageController.previousPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                            },
                            type: ButtonType.outline,
                            width: 100,
                          )
                          : const SizedBox(width: 100),
                      CustomButton(
                        label:
                            _currentPage < _pages.length - 1
                                ? 'Next'
                                : 'Get Started',
                        onPressed: _onNextPage,
                        type: ButtonType.primary,
                        width: 140,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  if (_currentPage < _pages.length - 1)
                    TextButton(
                      onPressed: _completeOnboarding,
                      child: Text(
                        'Skip',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDotIndicator(int index) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: 10,
      height: 10,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _currentPage == index ? AppColors.primary : AppColors.border,
      ),
    );
  }
}
