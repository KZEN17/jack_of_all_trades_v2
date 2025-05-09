import 'package:flutter/material.dart';
import 'package:jack_of_all_trades/config/theme/app_colors.dart';
import 'package:jack_of_all_trades/models/booking_model.dart';
import 'package:intl/intl.dart';

class JobsScreen extends StatefulWidget {
  static const String routeName = '/handyman/jobs';

  const JobsScreen({super.key});

  @override
  State<JobsScreen> createState() => _JobsScreenState();
}

class _JobsScreenState extends State<JobsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  // Mock data for jobs
  final List<BookingModel> _upcomingJobs = [
    BookingModel(
      id: '1',
      clientId: 'client1',
      handymanId: 'handyman1',
      serviceId: '1',
      serviceName: 'Home Cleaning',
      status: 'confirmed',
      scheduledDate: DateTime.now().add(const Duration(days: 1)),
      scheduledTime: '10:00 AM',
      address: '123 Main St, Birkirkara, Malta',
      price: 45.0,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
    BookingModel(
      id: '2',
      clientId: 'client2',
      handymanId: 'handyman1',
      serviceId: '3',
      serviceName: 'Plumbing Services',
      status: 'confirmed',
      scheduledDate: DateTime.now().add(const Duration(days: 2)),
      scheduledTime: '2:00 PM',
      address: '456 Oak Ave, Sliema, Malta',
      price: 60.0,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
  ];

  final List<BookingModel> _activeJobs = [
    BookingModel(
      id: '3',
      clientId: 'client3',
      handymanId: 'handyman1',
      serviceId: '2',
      serviceName: 'Electrical Repair',
      status: 'in_progress',
      scheduledDate: DateTime.now(),
      scheduledTime: '3:30 PM',
      address: '789 Pine Rd, Valletta, Malta',
      price: 75.0,
      startTime: DateTime.now().subtract(const Duration(hours: 1)),
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
  ];

  final List<BookingModel> _completedJobs = [
    BookingModel(
      id: '4',
      clientId: 'client4',
      handymanId: 'handyman1',
      serviceId: '4',
      serviceName: 'Furniture Assembly',
      status: 'completed',
      scheduledDate: DateTime.now().subtract(const Duration(days: 1)),
      scheduledTime: '11:00 AM',
      address: '101 Cedar Ln, St. Julian\'s, Malta',
      price: 50.0,
      finalPrice: 55.0,
      paymentStatus: 'paid',
      startTime: DateTime.now().subtract(const Duration(days: 1, hours: 2)),
      endTime: DateTime.now().subtract(const Duration(days: 1)),
      createdAt: DateTime.now().subtract(const Duration(days: 2)),
      updatedAt: DateTime.now().subtract(const Duration(days: 1)),
    ),
    BookingModel(
      id: '5',
      clientId: 'client5',
      handymanId: 'handyman1',
      serviceId: '3',
      serviceName: 'Plumbing Services',
      status: 'completed',
      scheduledDate: DateTime.now().subtract(const Duration(days: 3)),
      scheduledTime: '9:00 AM',
      address: '202 Maple Ave, Mdina, Malta',
      price: 60.0,
      finalPrice: 65.0,
      paymentStatus: 'paid',
      startTime: DateTime.now().subtract(const Duration(days: 3, hours: 2)),
      endTime: DateTime.now().subtract(const Duration(days: 3, hours: 1)),
      createdAt: DateTime.now().subtract(const Duration(days: 4)),
      updatedAt: DateTime.now().subtract(const Duration(days: 3)),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Jobs'),
        backgroundColor: AppColors.secondary,
        foregroundColor: Colors.white,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          tabs: const [
            Tab(text: 'Upcoming'),
            Tab(text: 'Active'),
            Tab(text: 'Completed'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildJobsList(_upcomingJobs, 'No upcoming jobs'),
          _buildJobsList(_activeJobs, 'No active jobs'),
          _buildJobsList(_completedJobs, 'No completed jobs'),
        ],
      ),
    );
  }

  Widget _buildJobsList(List<BookingModel> jobs, String emptyMessage) {
    if (jobs.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.work_off, size: 64, color: AppColors.textSecondary),
            const SizedBox(height: 16),
            Text(
              emptyMessage,
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Jobs will appear here when available',
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
      itemCount: jobs.length,
      itemBuilder: (context, index) {
        return _buildJobCard(jobs[index]);
      },
    );
  }

  Widget _buildJobCard(BookingModel job) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
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
          _buildJobHeader(job),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        job.serviceName,
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Text(
                      '\$${job.finalPrice?.toStringAsFixed(2) ?? job.price.toStringAsFixed(2)}',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: AppColors.secondary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                _buildInfoRow(
                  icon: Icons.person,
                  label: 'Client',
                  value: 'John Doe', // Mock client name
                ),
                const SizedBox(height: 8),
                _buildInfoRow(
                  icon: Icons.calendar_today,
                  label: 'Date & Time',
                  value:
                      '${DateFormat('EEE, MMM d, yyyy').format(job.scheduledDate)} at ${job.scheduledTime}',
                ),
                const SizedBox(height: 8),
                _buildInfoRow(
                  icon: Icons.location_on,
                  label: 'Location',
                  value: job.address ?? 'No address provided',
                ),
                if (job.notes != null && job.notes!.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  _buildInfoRow(
                    icon: Icons.note,
                    label: 'Notes',
                    value: job.notes!,
                  ),
                ],
                const SizedBox(height: 16),
                _buildJobActions(job),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildJobHeader(BookingModel job) {
    Color statusColor;
    String statusText;

    switch (job.status) {
      case 'pending':
        statusColor = AppColors.warning;
        statusText = 'Pending Confirmation';
        break;
      case 'confirmed':
        statusColor = AppColors.info;
        statusText = 'Confirmed';
        break;
      case 'in_progress':
        statusColor = AppColors.secondary;
        statusText = 'In Progress';
        break;
      case 'completed':
        statusColor = AppColors.success;
        statusText = 'Completed';
        break;
      case 'cancelled':
        statusColor = AppColors.error;
        statusText = 'Cancelled';
        break;
      default:
        statusColor = AppColors.textSecondary;
        statusText = 'Unknown Status';
    }

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      decoration: BoxDecoration(
        color: statusColor.withOpacity(0.1),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
      ),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: statusColor,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            statusText,
            style: TextStyle(color: statusColor, fontWeight: FontWeight.bold),
          ),
          const Spacer(),
          if (job.paymentStatus != null)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color:
                    job.paymentStatus == 'paid'
                        ? AppColors.success.withOpacity(0.1)
                        : AppColors.warning.withOpacity(0.1),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                job.paymentStatus == 'paid' ? 'Paid' : 'Payment Pending',
                style: TextStyle(
                  color:
                      job.paymentStatus == 'paid'
                          ? AppColors.success
                          : AppColors.warning,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 18, color: AppColors.textSecondary),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(color: AppColors.textSecondary),
              ),
              Text(value, style: Theme.of(context).textTheme.bodyMedium),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildJobActions(BookingModel job) {
    // Different actions based on job status
    if (job.status == 'confirmed') {
      return Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {
                // TODO: Implement start job functionality
                _showStartJobConfirmation(job);
              },
              icon: const Icon(Icons.play_arrow, size: 16),
              label: const Text('Start Job'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.secondary,
                foregroundColor: Colors.white,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {
                // TODO: Implement navigation functionality
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Navigation - Coming Soon')),
                );
              },
              icon: const Icon(Icons.navigation, size: 16),
              label: const Text('Navigate'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: AppColors.secondary,
                side: BorderSide(color: AppColors.secondary),
              ),
            ),
          ),
        ],
      );
    } else if (job.status == 'in_progress') {
      return Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {
                // TODO: Implement complete job functionality
                _showCompleteJobConfirmation(job);
              },
              icon: const Icon(Icons.check_circle, size: 16),
              label: const Text('Complete Job'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.success,
                foregroundColor: Colors.white,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {
                // TODO: Implement chat functionality
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Chat - Coming Soon')),
                );
              },
              icon: const Icon(Icons.chat, size: 16),
              label: const Text('Chat'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: AppColors.secondary,
                side: BorderSide(color: AppColors.secondary),
              ),
            ),
          ),
        ],
      );
    } else if (job.status == 'completed') {
      return ElevatedButton.icon(
        onPressed: () {
          // TODO: Implement view details functionality
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('View Details - Coming Soon')),
          );
        },
        icon: const Icon(Icons.visibility, size: 16),
        label: const Text('View Details'),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.secondary,
          foregroundColor: Colors.white,
        ),
      );
    } else {
      return ElevatedButton.icon(
        onPressed: () {
          // TODO: Implement view details functionality
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('View Details - Coming Soon')),
          );
        },
        icon: const Icon(Icons.visibility, size: 16),
        label: const Text('View Details'),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.secondary,
          foregroundColor: Colors.white,
        ),
      );
    }
  }

  void _showStartJobConfirmation(BookingModel job) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Start Job'),
            content: Text(
              'Are you sure you want to start the ${job.serviceName} job?',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  // TODO: Implement actual job starting logic
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Job started successfully')),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.secondary,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Start'),
              ),
            ],
          ),
    );
  }

  void _showCompleteJobConfirmation(BookingModel job) {
    final TextEditingController _additionalChargeController =
        TextEditingController();
    final TextEditingController _notesController = TextEditingController();

    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Complete Job'),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Job: ${job.serviceName}',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _additionalChargeController,
                    decoration: InputDecoration(
                      labelText: 'Additional Charge (if any)',
                      hintText: '0.00',
                      prefixText: '\$',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _notesController,
                    decoration: InputDecoration(
                      labelText: 'Completion Notes',
                      hintText: 'Add any notes about the completed job',
                      border: OutlineInputBorder(),
                    ),
                    maxLines: 3,
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  // TODO: Implement actual job completion logic
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Job completed successfully')),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.success,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Complete'),
              ),
            ],
          ),
    );
  }
}
