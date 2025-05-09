import 'package:flutter/material.dart';
import 'package:jack_of_all_trades/config/theme/app_colors.dart';
import 'package:jack_of_all_trades/models/booking_model.dart';
import 'package:jack_of_all_trades/widgets/client/booking_card.dart';

class BookingHistoryScreen extends StatefulWidget {
  static const String routeName = '/client/bookings';

  const BookingHistoryScreen({super.key});

  @override
  State<BookingHistoryScreen> createState() => _BookingHistoryScreenState();
}

class _BookingHistoryScreenState extends State<BookingHistoryScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _isLoading = true;

  // Mock booking data
  final List<BookingModel> _upcomingBookings = [
    BookingModel(
      id: '1',
      clientId: 'client1',
      handymanId: 'handyman1',
      serviceId: '1',
      serviceName: 'Home Cleaning',
      status: 'confirmed',
      scheduledDate: DateTime.now().add(const Duration(days: 2)),
      scheduledTime: '10:00 AM',
      address: '123 Main St, Birkirkara, Malta',
      notes: 'Please focus on kitchen and bathrooms',
      price: 45.0,
      paymentStatus: 'pending',
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
      updatedAt: DateTime.now().subtract(const Duration(days: 1)),
    ),
    BookingModel(
      id: '2',
      clientId: 'client1',
      handymanId: 'handyman2',
      serviceId: '3',
      serviceName: 'Plumbing Services',
      status: 'pending',
      scheduledDate: DateTime.now().add(const Duration(days: 5)),
      scheduledTime: '2:00 PM',
      address: '123 Main St, Birkirkara, Malta',
      notes: 'Leaking faucet in the kitchen',
      price: 60.0,
      paymentStatus: 'pending',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
  ];

  final List<BookingModel> _activeBookings = [
    BookingModel(
      id: '3',
      clientId: 'client1',
      handymanId: 'handyman3',
      serviceId: '4',
      serviceName: 'Furniture Assembly',
      status: 'in_progress',
      scheduledDate: DateTime.now(),
      scheduledTime: '3:00 PM',
      address: '123 Main St, Birkirkara, Malta',
      notes: 'IKEA wardrobe assembly',
      price: 50.0,
      paymentStatus: 'pending',
      startTime: DateTime.now().subtract(const Duration(hours: 1)),
      createdAt: DateTime.now().subtract(const Duration(days: 2)),
      updatedAt: DateTime.now().subtract(const Duration(hours: 1)),
    ),
  ];

  final List<BookingModel> _pastBookings = [
    BookingModel(
      id: '4',
      clientId: 'client1',
      handymanId: 'handyman1',
      serviceId: '2',
      serviceName: 'Electrical Repair',
      status: 'completed',
      scheduledDate: DateTime.now().subtract(const Duration(days: 3)),
      scheduledTime: '11:00 AM',
      address: '123 Main St, Birkirkara, Malta',
      price: 65.0,
      finalPrice: 75.0,
      paymentStatus: 'paid',
      startTime: DateTime.now().subtract(const Duration(days: 3, hours: 2)),
      endTime: DateTime.now().subtract(const Duration(days: 3, hours: 1)),
      createdAt: DateTime.now().subtract(const Duration(days: 5)),
      updatedAt: DateTime.now().subtract(const Duration(days: 3)),
    ),
    BookingModel(
      id: '5',
      clientId: 'client1',
      handymanId: 'handyman2',
      serviceId: '1',
      serviceName: 'Home Cleaning',
      status: 'cancelled',
      scheduledDate: DateTime.now().subtract(const Duration(days: 7)),
      scheduledTime: '9:00 AM',
      address: '123 Main St, Birkirkara, Malta',
      price: 45.0,
      cancelReason: 'Handyman unavailable',
      createdAt: DateTime.now().subtract(const Duration(days: 10)),
      updatedAt: DateTime.now().subtract(const Duration(days: 8)),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _loadBookings();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _loadBookings() async {
    // Simulate loading delay
    await Future.delayed(const Duration(seconds: 1));

    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Bookings'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          tabs: const [
            Tab(text: 'Upcoming'),
            Tab(text: 'Active'),
            Tab(text: 'Past'),
          ],
        ),
      ),
      body:
          _isLoading
              ? const Center(child: CircularProgressIndicator())
              : TabBarView(
                controller: _tabController,
                children: [
                  _buildBookingsList(_upcomingBookings, 'No upcoming bookings'),
                  _buildBookingsList(_activeBookings, 'No active bookings'),
                  _buildBookingsList(_pastBookings, 'No past bookings'),
                ],
              ),
    );
  }

  Widget _buildBookingsList(List<BookingModel> bookings, String emptyMessage) {
    if (bookings.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.calendar_today,
              size: 64,
              color: AppColors.textSecondary,
            ),
            const SizedBox(height: 16),
            Text(
              emptyMessage,
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Your bookings will appear here',
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
      itemCount: bookings.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: BookingCard(
            booking: bookings[index],
            onViewDetails: () {
              // TODO: Navigate to booking details
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('View Details - Coming Soon')),
              );
            },
            onCancel:
                bookings[index].status == 'pending' ||
                        bookings[index].status == 'confirmed'
                    ? () {
                      _showCancelDialog(bookings[index]);
                    }
                    : null,
            onTrackHandyman:
                bookings[index].status == 'in_progress'
                    ? () {
                      // TODO: Navigate to tracking screen
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Track Handyman - Coming Soon'),
                        ),
                      );
                    }
                    : null,
            onChat:
                (bookings[index].status == 'confirmed' ||
                        bookings[index].status == 'in_progress')
                    ? () {
                      // TODO: Navigate to chat screen
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Chat - Coming Soon')),
                      );
                    }
                    : null,
            onAddReview:
                bookings[index].status == 'completed' &&
                        bookings[index].paymentStatus == 'paid'
                    ? () {
                      _showReviewDialog(bookings[index]);
                    }
                    : null,
          ),
        );
      },
    );
  }

  void _showCancelDialog(BookingModel booking) {
    final TextEditingController _reasonController = TextEditingController();

    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Cancel Booking'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Are you sure you want to cancel this booking?',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _reasonController,
                  decoration: const InputDecoration(
                    labelText: 'Reason for cancellation',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 3,
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('No, Keep Booking'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  // TODO: Implement actual cancellation logic
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Booking cancelled successfully'),
                    ),
                  );
                  setState(() {
                    // Update the booking status in the mock data
                    booking.status = 'cancelled';
                    booking.cancelReason =
                        _reasonController.text.isNotEmpty
                            ? _reasonController.text
                            : 'Cancelled by client';
                    booking.updatedAt = DateTime.now();

                    // Move from upcoming to past
                    _upcomingBookings.remove(booking);
                    _pastBookings.add(booking);
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.error,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Yes, Cancel'),
              ),
            ],
          ),
    );
  }

  void _showReviewDialog(BookingModel booking) {
    double _rating = 5.0;
    final TextEditingController _commentController = TextEditingController();

    showDialog(
      context: context,
      builder:
          (context) => StatefulBuilder(
            builder:
                (context, setState) => AlertDialog(
                  title: const Text('Add Review'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'How was your ${booking.serviceName} service?',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      const SizedBox(height: 16),
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(5, (index) {
                            return IconButton(
                              icon: Icon(
                                index < _rating
                                    ? Icons.star
                                    : Icons.star_border,
                                color: Colors.amber,
                                size: 32,
                              ),
                              onPressed: () {
                                setState(() {
                                  _rating = index + 1;
                                });
                              },
                            );
                          }),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: _commentController,
                        decoration: const InputDecoration(
                          labelText: 'Your comments (optional)',
                          border: OutlineInputBorder(),
                        ),
                        maxLines: 3,
                      ),
                    ],
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cancel'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        // TODO: Implement actual review submission logic
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Review submitted successfully'),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                      ),
                      child: const Text('Submit Review'),
                    ),
                  ],
                ),
          ),
    );
  }
}
