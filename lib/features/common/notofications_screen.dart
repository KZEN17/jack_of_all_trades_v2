import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jack_of_all_trades/config/theme/app_colors.dart';

class NotificationsScreen extends StatefulWidget {
  static const String routeName = '/notifications';

  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  bool _isLoading = true;
  List<NotificationItem> _notifications = [];

  @override
  void initState() {
    super.initState();
    _loadNotifications();
  }

  Future<void> _loadNotifications() async {
    // Simulate loading delay
    await Future.delayed(const Duration(seconds: 1));

    // Mock notifications data
    final mockNotifications = [
      NotificationItem(
        id: '1',
        title: 'Booking Confirmed',
        message:
            'Your booking for Home Cleaning has been confirmed for tomorrow at 10:00 AM.',
        type: NotificationType.booking,
        isRead: false,
        timestamp: DateTime.now().subtract(const Duration(hours: 2)),
        relatedId: '1', // Booking ID
      ),
      NotificationItem(
        id: '2',
        title: 'Handyman On The Way',
        message: 'Mike is on the way to your location for Plumbing Services.',
        type: NotificationType.update,
        isRead: true,
        timestamp: DateTime.now().subtract(const Duration(days: 1, hours: 3)),
        relatedId: '3', // Booking ID
      ),
      NotificationItem(
        id: '3',
        title: 'New Message',
        message:
            'You have a new message from Mike regarding your Plumbing Services booking.',
        type: NotificationType.message,
        isRead: false,
        timestamp: DateTime.now().subtract(const Duration(days: 1, hours: 5)),
        relatedId: 'chat123', // Chat ID
      ),
      NotificationItem(
        id: '4',
        title: 'Service Completed',
        message:
            'Your Electrical Repair service has been completed. Please provide a review!',
        type: NotificationType.booking,
        isRead: true,
        timestamp: DateTime.now().subtract(const Duration(days: 3, hours: 2)),
        relatedId: '4', // Booking ID
      ),
      NotificationItem(
        id: '5',
        title: 'Payment Confirmed',
        message:
            'Your payment of \$75.00 for Electrical Repair has been processed successfully.',
        type: NotificationType.payment,
        isRead: true,
        timestamp: DateTime.now().subtract(const Duration(days: 3, hours: 1)),
        relatedId: 'payment123', // Payment ID
      ),
      NotificationItem(
        id: '6',
        title: 'Special Offer',
        message:
            'Get 20% off on all Cleaning Services this week! Use code CLEAN20.',
        type: NotificationType.promotion,
        isRead: true,
        timestamp: DateTime.now().subtract(const Duration(days: 5)),
        relatedId: 'promo123', // Promo ID
      ),
    ];

    if (mounted) {
      setState(() {
        _notifications = mockNotifications;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        actions: [
          if (_notifications.isNotEmpty)
            TextButton(
              onPressed: () {
                setState(() {
                  for (var notification in _notifications) {
                    notification.isRead = true;
                  }
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('All notifications marked as read'),
                  ),
                );
              },
              child: const Text(
                'Mark All as Read',
                style: TextStyle(color: Colors.white),
              ),
            ),
        ],
      ),
      body:
          _isLoading
              ? const Center(child: CircularProgressIndicator())
              : _notifications.isEmpty
              ? _buildEmptyState()
              : _buildNotificationsList(),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.notifications_off,
            size: 64,
            color: AppColors.textSecondary,
          ),
          const SizedBox(height: 16),
          Text(
            'No Notifications',
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            'You don\'t have any notifications yet',
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: AppColors.textSecondary),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationsList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _notifications.length,
      itemBuilder: (context, index) {
        final notification = _notifications[index];
        return _buildNotificationCard(notification);
      },
    );
  }

  Widget _buildNotificationCard(NotificationItem notification) {
    Color _getIconColor() {
      switch (notification.type) {
        case NotificationType.booking:
          return AppColors.primary;
        case NotificationType.update:
          return AppColors.info;
        case NotificationType.message:
          return AppColors.secondary;
        case NotificationType.payment:
          return AppColors.success;
        case NotificationType.promotion:
          return AppColors.warning;
      }
    }

    IconData _getIconData() {
      switch (notification.type) {
        case NotificationType.booking:
          return Icons.calendar_today;
        case NotificationType.update:
          return Icons.update;
        case NotificationType.message:
          return Icons.chat;
        case NotificationType.payment:
          return Icons.payment;
        case NotificationType.promotion:
          return Icons.local_offer;
      }
    }

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side:
            notification.isRead
                ? BorderSide.none
                : BorderSide(color: AppColors.primary, width: 1),
      ),
      elevation: notification.isRead ? 1 : 3,
      child: InkWell(
        onTap: () {
          // Mark as read when tapped
          setState(() {
            notification.isRead = true;
          });

          // Handle notification tap based on type
          switch (notification.type) {
            case NotificationType.booking:
              // Navigate to booking details
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Navigating to booking details - Coming Soon'),
                ),
              );
              break;
            case NotificationType.message:
              // Navigate to chat
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Navigating to chat - Coming Soon'),
                ),
              );
              break;
            case NotificationType.payment:
              // Navigate to payment details
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Navigating to payment details - Coming Soon'),
                ),
              );
              break;
            case NotificationType.promotion:
              // Navigate to promotion details
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'Navigating to promotion details - Coming Soon',
                  ),
                ),
              );
              break;
            default:
              // Default action
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Notification tapped')),
              );
              break;
          }
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: _getIconColor().withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(_getIconData(), color: _getIconColor(), size: 20),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            notification.title,
                            style: TextStyle(
                              fontWeight:
                                  notification.isRead
                                      ? FontWeight.normal
                                      : FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Text(
                          _getTimeAgo(notification.timestamp),
                          style: TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      notification.message,
                      style: TextStyle(
                        color:
                            notification.isRead
                                ? AppColors.textSecondary
                                : AppColors.textDark,
                      ),
                    ),
                    if (!notification.isRead)
                      Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          margin: const EdgeInsets.only(top: 8),
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getTimeAgo(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inDays > 7) {
      return DateFormat('MMM d').format(timestamp);
    } else if (difference.inDays > 0) {
      return '${difference.inDays}d ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m ago';
    } else {
      return 'just now';
    }
  }
}

enum NotificationType { booking, update, message, payment, promotion }

class NotificationItem {
  final String id;
  final String title;
  final String message;
  final NotificationType type;
  bool isRead;
  final DateTime timestamp;
  final String? relatedId;

  NotificationItem({
    required this.id,
    required this.title,
    required this.message,
    required this.type,
    required this.isRead,
    required this.timestamp,
    this.relatedId,
  });
}
