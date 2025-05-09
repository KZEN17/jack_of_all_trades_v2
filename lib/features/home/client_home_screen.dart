import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jack_of_all_trades/config/theme/app_colors.dart';
import 'package:jack_of_all_trades/widgets/client/category_card.dart';
import 'package:jack_of_all_trades/widgets/client/service_card.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

// Temporary mock data - will be replaced with actual data
import 'package:jack_of_all_trades/models/service_model.dart';

class ClientHomeScreen extends StatefulWidget {
  static const String routeName = '/client/home';

  const ClientHomeScreen({super.key});

  @override
  State<ClientHomeScreen> createState() => _ClientHomeScreenState();
}

class _ClientHomeScreenState extends State<ClientHomeScreen> {
  int _currentBannerIndex = 0;
  final CarouselSliderController _carouselController =
      CarouselSliderController();

  // Mock data for banners
  final List<Map<String, dynamic>> _banners = [
    {
      'title': 'Special Discount',
      'description': 'Get 20% off on all cleaning services',
      'color': AppColors.cleaning,
    },
    {
      'title': 'New Service',
      'description': 'Try our new furniture assembly service',
      'color': AppColors.assembly,
    },
    {
      'title': 'Refer & Earn',
      'description': 'Invite friends and get €10 credit',
      'color': AppColors.primary,
    },
  ];

  // Mock data for popular services
  final List<ServiceModel> _popularServices = [
    ServiceModel(
      id: '1',
      name: 'Home Cleaning',
      description:
          'Complete house cleaning service including kitchen, bathroom, and living areas',
      category: 'Cleaning',
      basePrice: 45.0,
      estimatedDuration: 120,
      isPopular: true,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
    ServiceModel(
      id: '2',
      name: 'Electrical Repair',
      description:
          'Fix electrical issues, install fixtures, and replace outlets',
      category: 'Electrical',
      basePrice: 65.0,
      estimatedDuration: 90,
      isPopular: true,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
    ServiceModel(
      id: '3',
      name: 'Plumbing Services',
      description: 'Fix leaks, clear clogs, and install fixtures',
      category: 'Plumbing',
      basePrice: 60.0,
      estimatedDuration: 90,
      isPopular: true,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
    ServiceModel(
      id: '4',
      name: 'Furniture Assembly',
      description: 'Assembly of flat-pack furniture from any store',
      category: 'Assembly',
      basePrice: 50.0,
      estimatedDuration: 120,
      isPopular: true,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildAppBar(),
              _buildSearchBar(),
              _buildBannerSlider(),
              _buildCategories(),
              _buildPopularServices(),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hello, John!',
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
              Text(
                'What service do you need today?',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
          Row(
            children: [
              IconButton(
                onPressed: () => context.push('/notifications'),
                icon: const Icon(Icons.notifications_outlined),
              ),
              GestureDetector(
                onTap: () => context.push('/client/profile'),
                child: const CircleAvatar(
                  radius: 20,
                  backgroundColor: AppColors.primary,
                  child: Text('J'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search for services',
          hintStyle: TextStyle(color: AppColors.textSecondary),
          prefixIcon: const Icon(Icons.search),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(vertical: 12),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: AppColors.border),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: AppColors.primary, width: 2),
          ),
        ),
        onTap: () {
          // For now just navigate to services screen
          context.push('/client/services');
        },
        readOnly: true,
      ),
    );
  }

  Widget _buildBannerSlider() {
    return Column(
      children: [
        CarouselSlider(
          items:
              _banners.map((banner) {
                return Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(horizontal: 6),
                  decoration: BoxDecoration(
                    color: banner['color'].withOpacity(0.1),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: banner['color'].withOpacity(0.3)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                banner['title'],
                                style: Theme.of(
                                  context,
                                ).textTheme.titleLarge?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: banner['color'],
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                banner['description'],
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              const SizedBox(height: 12),
                              ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: banner['color'],
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 8,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: const Text('Learn More'),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Center(
                            child: Icon(
                              _getBannerIcon(banner['title']),
                              size: 80,
                              color: banner['color'].withOpacity(0.7),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
          carouselController: _carouselController,
          options: CarouselOptions(
            height: 180,
            aspectRatio: 16 / 9,
            viewportFraction: 0.9,
            initialPage: 0,
            enableInfiniteScroll: true,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 5),
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
            autoPlayCurve: Curves.fastOutSlowIn,
            enlargeCenterPage: true,
            onPageChanged: (index, reason) {
              setState(() {
                _currentBannerIndex = index;
              });
            },
          ),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children:
              _banners.asMap().entries.map((entry) {
                return Container(
                  width: 8,
                  height: 8,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color:
                        _currentBannerIndex == entry.key
                            ? AppColors.primary
                            : AppColors.border,
                  ),
                );
              }).toList(),
        ),
      ],
    );
  }

  Widget _buildCategories() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Categories',
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
              TextButton(
                onPressed: () => context.push('/client/services'),
                child: Text(
                  'See All',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 120,
            child: GridView.count(
              crossAxisCount: 4,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: CategoryCard.getCategories().take(4).toList(),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 120,
            child: GridView.count(
              crossAxisCount: 4,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: CategoryCard.getCategories().skip(4).take(4).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPopularServices() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Popular Services',
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
              TextButton(
                onPressed: () => context.push('/client/services'),
                child: Text(
                  'See All',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          StaggeredGrid.count(
            crossAxisCount: 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            children:
                _popularServices
                    .map((service) => ServiceCard(service: service))
                    .toList(),
          ),
        ],
      ),
    );
  }

  IconData _getBannerIcon(String title) {
    if (title.contains('Cleaning')) {
      return Icons.cleaning_services;
    } else if (title.contains('Assembly')) {
      return Icons.build;
    } else if (title.contains('Refer')) {
      return Icons.people;
    } else {
      return Icons.home_repair_service;
    }
  }
}
