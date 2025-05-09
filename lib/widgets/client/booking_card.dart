import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jack_of_all_trades/config/theme/app_colors.dart';
import 'package:jack_of_all_trades/models/booking_model.dart';
import 'package:jack_of_all_trades/widgets/common/custom_button.dart';

class BookingCard extends StatelessWidget {
  final BookingModel booking;
  final VoidCallback? onViewDetails;
  final VoidCallback? onCancel;
  final VoidCallback? onTrackHandyman;
  final VoidCallback? onChat;
  final VoidCallback? onAddReview;

  const BookingCard({
    super.key,
    required this.booking,
    this.onViewDetails,
    this.onCancel,
    this.onTrackHandyman,
    this.onChat,
    this.onAddReview,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildStatusHeader(context),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  booking.serviceName,
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                _buildInfoRow(
                  context,
                  Icons.calendar_today,
                  'Date & Time',
                  '${DateFormat('EEE, MMM d, yyyy').format(booking.scheduledDate)} at ${booking.scheduledTime}',
                ),
                const SizedBox(height: 8),
                _buildInfoRow(
                  context,
                  Icons.location_on,
                  'Location',
                  booking.address ?? 'No location specified',
                ),
                const SizedBox(height: 8),
                _buildInfoRow(
                  context,
                  Icons.attach_money,
                  'Price',
                  '\$${booking.finalPrice?.toStringAsFixed(2) ?? booking.price.toStringAsFixed(2)}',
                ),
                if (booking.notes != null && booking.notes!.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  _buildInfoRow(context, Icons.note, 'Notes', booking.notes!),
                ],
                const SizedBox(height: 16),
                _buildActionButtons(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusHeader(BuildContext context) {
    Color statusColor;
    String statusText;

    switch (booking.status) {
      case 'pending':
        statusColor = AppColors.warning;
        statusText = 'Pending Confirmation';
        break;
      case 'confirmed':
        statusColor = AppColors.info;
        statusText = 'Confirmed';
        break;
      case 'in_progress':
        statusColor = AppColors.primary;
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
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: statusColor.withOpacity(0.1),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
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
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: statusColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(
    BuildContext context,
    IconData icon,
    String label,
    String value,
  ) {
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
              const SizedBox(height: 2),
              Text(value, style: Theme.of(context).textTheme.bodyMedium),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    final List<Widget> buttons = [];

    if (booking.status == 'pending' || booking.status == 'confirmed') {
      buttons.add(
        CustomButton(
          label: 'Cancel',
          onPressed: onCancel ?? () {},
          type: ButtonType.outline,
          icon: Icons.cancel,
        ),
      );
    }

    if (booking.status == 'in_progress') {
      buttons.add(
        CustomButton(
          label: 'Track',
          onPressed: onTrackHandyman ?? () {},
          type: ButtonType.primary,
          icon: Icons.location_on,
        ),
      );
    }

    if (booking.status == 'in_progress' || booking.status == 'confirmed') {
      buttons.add(
        CustomButton(
          label: 'Chat',
          onPressed: onChat ?? () {},
          type: ButtonType.secondary,
          icon: Icons.chat,
        ),
      );
    }

    if (booking.status == 'completed' && booking.paymentStatus == 'paid') {
      buttons.add(
        CustomButton(
          label: 'Add Review',
          onPressed: onAddReview ?? () {},
          type: ButtonType.primary,
          icon: Icons.star,
        ),
      );
    }

    buttons.add(
      CustomButton(
        label: 'Details',
        onPressed: onViewDetails ?? () {},
        type: ButtonType.text,
        icon: Icons.info,
      ),
    );

    return Wrap(spacing: 8, runSpacing: 8, children: buttons);
  }
}
