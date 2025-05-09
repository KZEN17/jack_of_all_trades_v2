import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jack_of_all_trades/config/theme/app_colors.dart';
import 'package:jack_of_all_trades/models/service_model.dart';
import 'package:jack_of_all_trades/widgets/common/custom_button.dart';

class ServiceDetailsScreen extends StatefulWidget {
  static const String routeName = '/client/services/:id';
  final String serviceId;

  const ServiceDetailsScreen({super.key, required this.serviceId});

  @override
  State<ServiceDetailsScreen> createState() => _ServiceDetailsScreenState();
}

class _ServiceDetailsScreenState extends State<ServiceDetailsScreen> {
  late ServiceModel _service;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadService();
  }

  Future<void> _loadService() async {
    try {
      // Mock loading delay
      await Future.delayed(const Duration(milliseconds: 500));

      // Find service with the matching ID from our mock data
      // In a real app, this would be a call to your backend or local database
      _service = _getMockService(widget.serviceId);

      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error loading service: ${e.toString()}'),
            backgroundColor: AppColors.error,
          ),
        );
        context.pop();
      }
    }
  }

  ServiceModel _getMockService(String id) {
    // This is a mock function to get service data
    // In a real app, this would come from your API or database
    final mockServices = {
      '1': ServiceModel(
        id: '1',
        name: 'Home Cleaning',
        description:
            'We provide comprehensive home cleaning services that include dusting, vacuuming, mopping, kitchen and bathroom cleaning, and more. Our professional cleaners use eco-friendly products and ensure every corner of your home sparkles.',
        category: 'Cleaning',
        basePrice: 45.0,
        estimatedDuration: 120,
        isPopular: true,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
      '2': ServiceModel(
        id: '2',
        name: 'Electrical Repair',
        description:
            'Our licensed electricians can diagnose and fix all your electrical problems. Services include outlet installation, light fixture replacement, circuit breaker repairs, wiring upgrades, and troubleshooting electrical issues. Safety is our top priority.',
        category: 'Electrical',
        basePrice: 65.0,
        estimatedDuration: 90,
        isPopular: true,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
      '3': ServiceModel(
        id: '3',
        name: 'Plumbing Services',
        description:
            'Our plumbing professionals handle everything from fixing leaky faucets and clogged drains to replacing pipes and installing fixtures. We offer quick, reliable service with upfront pricing and guaranteed workmanship.',
        category: 'Plumbing',
        basePrice: 60.0,
        estimatedDuration: 90,
        isPopular: true,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
      '4': ServiceModel(
        id: '4',
        name: 'Furniture Assembly',
        description:
            'Save time and avoid frustration by letting our experts assemble your furniture. We work with all types of flat-pack furniture from IKEA, Wayfair, Amazon, and more. Our assemblers bring their own tools and leave your space clean.',
        category: 'Assembly',
        basePrice: 50.0,
        estimatedDuration: 120,
        isPopular: true,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
    };

    if (mockServices.containsKey(id)) {
      return mockServices[id]!;
    } else {
      throw Exception('Service not found');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          _isLoading
              ? const Center(child: CircularProgressIndicator())
              : CustomScrollView(
                slivers: [
                  _buildAppBar(),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildServiceHeader(),
                          const SizedBox(height: 24),
                          _buildServiceDescription(),
                          const SizedBox(height: 24),
                          _buildServiceDetails(),
                          const SizedBox(height: 24),
                          _buildWhatsIncluded(),
                          const SizedBox(
                            height: 80,
                          ), // Extra space for bottom bar
                        ],
                      ),
                    ),
                  ),
                ],
              ),
      bottomSheet: _isLoading ? null : _buildBottomBar(),
    );
  }

  Widget _buildAppBar() {
    return SliverAppBar(
      expandedHeight: 200,
      pinned: true,
      backgroundColor: _getCategoryColor(),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => context.pop(),
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          color: _getCategoryColor(),
          child: Center(
            child: Icon(_getCategoryIcon(), size: 80, color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget _buildServiceHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          _service.name,
          style: Theme.of(
            context,
          ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: _getCategoryColor().withOpacity(0.1),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                _service.category,
                style: TextStyle(
                  color: _getCategoryColor(),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Icon(Icons.schedule, size: 16, color: AppColors.textSecondary),
            const SizedBox(width: 4),
            Text(
              _formatDuration(_service.estimatedDuration),
              style: TextStyle(color: AppColors.textSecondary),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(
                  'Starting at ',
                  style: TextStyle(color: AppColors.textSecondary),
                ),
                Text(
                  '\$${_service.basePrice.toStringAsFixed(2)}',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Icon(Icons.star, color: Colors.amber, size: 20),
                const SizedBox(width: 4),
                Text(
                  '4.8', // Mock rating
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 4),
                Text(
                  '(124)', // Mock review count
                  style: TextStyle(color: AppColors.textSecondary),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildServiceDescription() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Description',
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        Text(
          _service.description,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }

  Widget _buildServiceDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Service Details',
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        _buildDetailRow(
          Icons.access_time,
          'Duration',
          _formatDuration(_service.estimatedDuration),
        ),
        const SizedBox(height: 8),
        _buildDetailRow(Icons.category, 'Category', _service.category),
        const SizedBox(height: 8),
        _buildDetailRow(
          Icons.attach_money,
          'Starting Price',
          '\$${_service.basePrice.toStringAsFixed(2)}',
        ),
        const SizedBox(height: 8),
        _buildDetailRow(
          Icons.people,
          'Service Provider',
          'Professional ${_service.category} Experts',
        ),
      ],
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 20, color: AppColors.textSecondary),
        const SizedBox(width: 8),
        Text('$label: ', style: TextStyle(color: AppColors.textSecondary)),
        Text(value, style: TextStyle(fontWeight: FontWeight.w600)),
      ],
    );
  }

  Widget _buildWhatsIncluded() {
    // Mock data for what's included
    final includedItems = [
      'Professional service providers',
      'All necessary equipment and supplies',
      'Satisfaction guarantee',
      'Insured service',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'What\'s Included',
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        ...includedItems.map(
          (item) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.check_circle, color: AppColors.success, size: 20),
                const SizedBox(width: 8),
                Expanded(child: Text(item)),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            spreadRadius: 1,
            blurRadius: 10,
            offset: Offset(0, -5),
          ),
        ],
      ),
      child: CustomButton(
        label: 'Book Now',
        onPressed: () => context.push('/client/book/${_service.id}'),
        type: ButtonType.primary,
        width: double.infinity,
        icon: Icons.calendar_today,
      ),
    );
  }

  Color _getCategoryColor() {
    switch (_service.category.toLowerCase()) {
      case 'cleaning':
        return AppColors.cleaning;
      case 'electrical':
        return AppColors.electrical;
      case 'plumbing':
        return AppColors.plumbing;
      case 'painting':
        return AppColors.painting;
      case 'carpentry':
        return AppColors.carpentry;
      case 'gardening':
        return AppColors.gardening;
      case 'moving':
        return AppColors.moving;
      case 'assembly':
        return AppColors.assembly;
      default:
        return AppColors.primary;
    }
  }

  IconData _getCategoryIcon() {
    switch (_service.category.toLowerCase()) {
      case 'cleaning':
        return Icons.cleaning_services;
      case 'electrical':
        return Icons.electric_bolt;
      case 'plumbing':
        return Icons.plumbing;
      case 'painting':
        return Icons.format_paint;
      case 'carpentry':
        return Icons.handyman;
      case 'gardening':
        return Icons.yard;
      case 'moving':
        return Icons.local_shipping;
      case 'assembly':
        return Icons.build;
      default:
        return Icons.home_repair_service;
    }
  }

  String _formatDuration(int minutes) {
    if (minutes < 60) {
      return '$minutes min';
    } else {
      final hours = minutes ~/ 60;
      final remainingMinutes = minutes % 60;
      if (remainingMinutes == 0) {
        return '$hours hr';
      } else {
        return '$hours hr $remainingMinutes min';
      }
    }
  }
}
