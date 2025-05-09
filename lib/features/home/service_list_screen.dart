import 'package:flutter/material.dart';
import 'package:jack_of_all_trades/config/theme/app_colors.dart';
import 'package:jack_of_all_trades/models/service_model.dart';
import 'package:jack_of_all_trades/widgets/client/service_card.dart';

class ServiceListScreen extends StatefulWidget {
  static const String routeName = '/client/services';

  const ServiceListScreen({super.key});

  @override
  State<ServiceListScreen> createState() => _ServiceListScreenState();
}

class _ServiceListScreenState extends State<ServiceListScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedCategory = '';

  // Mock data for services
  final List<ServiceModel> _allServices = [
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
    ServiceModel(
      id: '5',
      name: 'Window Cleaning',
      description: 'Professional window cleaning for a crystal-clear view',
      category: 'Cleaning',
      basePrice: 40.0,
      estimatedDuration: 90,
      isPopular: false,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
    ServiceModel(
      id: '6',
      name: 'Painting Service',
      description: 'Interior painting service for walls, ceilings, and trims',
      category: 'Painting',
      basePrice: 75.0,
      estimatedDuration: 240,
      isPopular: false,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
    ServiceModel(
      id: '7',
      name: 'Garden Maintenance',
      description:
          'Lawn mowing, pruning, weed control, and general garden care',
      category: 'Gardening',
      basePrice: 55.0,
      estimatedDuration: 180,
      isPopular: false,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
    ServiceModel(
      id: '8',
      name: 'Furniture Moving',
      description:
          'Help with moving furniture within your home or to a new location',
      category: 'Moving',
      basePrice: 70.0,
      estimatedDuration: 180,
      isPopular: false,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
  ];

  List<ServiceModel> get _filteredServices {
    return _allServices.where((service) {
      final matchesSearch =
          service.name.toLowerCase().contains(
            _searchController.text.toLowerCase(),
          ) ||
          service.description.toLowerCase().contains(
            _searchController.text.toLowerCase(),
          );

      final matchesCategory =
          _selectedCategory.isEmpty || service.category == _selectedCategory;

      return matchesSearch && matchesCategory;
    }).toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Services'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          _buildSearchBar(),
          _buildCategoryFilter(),
          Expanded(child: _buildServicesList()),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: 'Search for services',
          hintStyle: TextStyle(color: AppColors.textSecondary),
          prefixIcon: const Icon(Icons.search),
          suffixIcon:
              _searchController.text.isNotEmpty
                  ? IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      setState(() {
                        _searchController.clear();
                      });
                    },
                  )
                  : null,
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
        onChanged: (value) {
          setState(() {});
        },
      ),
    );
  }

  Widget _buildCategoryFilter() {
    return Container(
      height: 50,
      margin: const EdgeInsets.only(bottom: 16),
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          _buildCategoryChip('All', ''),
          ..._getUniqueCategories()
              .map((category) => _buildCategoryChip(category, category))
              .toList(),
        ],
      ),
    );
  }

  Widget _buildCategoryChip(String label, String value) {
    final isSelected = _selectedCategory == value;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedCategory = value;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.border,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : AppColors.textDark,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget _buildServicesList() {
    if (_filteredServices.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search_off, size: 64, color: AppColors.textSecondary),
            const SizedBox(height: 16),
            Text(
              'No services found',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Try changing your search or filter criteria',
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: AppColors.textSecondary),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _filteredServices.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: ServiceCard(
            service: _filteredServices[index],
            isHorizontal: true,
          ),
        );
      },
    );
  }

  List<String> _getUniqueCategories() {
    final categories =
        _allServices.map((service) => service.category).toSet().toList();
    categories.sort();
    return categories;
  }
}
