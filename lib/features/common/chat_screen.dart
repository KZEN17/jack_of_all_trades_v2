import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jack_of_all_trades/config/theme/app_colors.dart';
import 'package:provider/provider.dart';
import 'package:jack_of_all_trades/providers/user_provider.dart';

class ChatScreen extends StatefulWidget {
  static const String routeName = '/chat/:userId';
  final String userId;

  const ChatScreen({super.key, required this.userId});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _messageController = TextEditingController();
  final _scrollController = ScrollController();
  bool _isLoading = true;
  List<ChatMessage> _messages = [];
  String _recipientName = '';
  String _bookingService = '';
  String _recipientAvatar = '';

  @override
  void initState() {
    super.initState();
    _loadChatData();
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _loadChatData() async {
    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));

    // Mock data - in a real app, this would come from your API
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final isClient = userProvider.isClient;

    if (isClient) {
      _recipientName = 'Mike (Handyman)';
      _recipientAvatar = 'M';
      _bookingService = 'Plumbing Services';
    } else {
      _recipientName = 'John (Client)';
      _recipientAvatar = 'J';
      _bookingService = 'Plumbing Services';
    }

    // Mock messages - in a real app, these would come from your API
    final mockMessages = [
      ChatMessage(
        id: '1',
        senderId: isClient ? 'handyman1' : 'client1',
        receiverId: isClient ? 'client1' : 'handyman1',
        message:
            'Hello there! I\'ll be your handyman for the plumbing service booking.',
        timestamp: DateTime.now().subtract(const Duration(days: 1, hours: 2)),
        isRead: true,
      ),
      ChatMessage(
        id: '2',
        senderId: isClient ? 'client1' : 'handyman1',
        receiverId: isClient ? 'handyman1' : 'client1',
        message:
            'Hi! Thank you. I have a leaking faucet in the kitchen that needs fixing.',
        timestamp: DateTime.now().subtract(
          const Duration(days: 1, hours: 1, minutes: 55),
        ),
        isRead: true,
      ),
      ChatMessage(
        id: '3',
        senderId: isClient ? 'handyman1' : 'client1',
        receiverId: isClient ? 'client1' : 'handyman1',
        message:
            'No problem, I can fix that. Do you know what type of faucet it is?',
        timestamp: DateTime.now().subtract(
          const Duration(days: 1, hours: 1, minutes: 50),
        ),
        isRead: true,
      ),
      ChatMessage(
        id: '4',
        senderId: isClient ? 'client1' : 'handyman1',
        receiverId: isClient ? 'handyman1' : 'client1',
        message:
            'It\'s a standard kitchen sink faucet. It\'s been dripping constantly for about a week now.',
        timestamp: DateTime.now().subtract(
          const Duration(days: 1, hours: 1, minutes: 45),
        ),
        isRead: true,
      ),
      ChatMessage(
        id: '5',
        senderId: isClient ? 'handyman1' : 'client1',
        receiverId: isClient ? 'client1' : 'handyman1',
        message:
            'Got it. I\'ll bring the necessary tools and parts. Is there anything else you need help with while I\'m there?',
        timestamp: DateTime.now().subtract(
          const Duration(days: 1, hours: 1, minutes: 40),
        ),
        isRead: true,
      ),
      ChatMessage(
        id: '6',
        senderId: isClient ? 'client1' : 'handyman1',
        receiverId: isClient ? 'handyman1' : 'client1',
        message:
            'There\'s also a small leak under the sink. If you could check that too, that would be great.',
        timestamp: DateTime.now().subtract(
          const Duration(days: 1, hours: 1, minutes: 35),
        ),
        isRead: true,
      ),
      ChatMessage(
        id: '7',
        senderId: isClient ? 'handyman1' : 'client1',
        receiverId: isClient ? 'client1' : 'handyman1',
        message:
            'No problem, I\'ll take care of both issues. See you tomorrow at 2 PM.',
        timestamp: DateTime.now().subtract(
          const Duration(days: 1, hours: 1, minutes: 30),
        ),
        isRead: true,
      ),
      ChatMessage(
        id: '8',
        senderId: isClient ? 'client1' : 'handyman1',
        receiverId: isClient ? 'handyman1' : 'client1',
        message: 'Perfect! Thank you. See you tomorrow.',
        timestamp: DateTime.now().subtract(
          const Duration(days: 1, hours: 1, minutes: 25),
        ),
        isRead: true,
      ),
      ChatMessage(
        id: '9',
        senderId: isClient ? 'handyman1' : 'client1',
        receiverId: isClient ? 'client1' : 'handyman1',
        message:
            'Hi! Just checking in to confirm our appointment for today at 2 PM.',
        timestamp: DateTime.now().subtract(const Duration(hours: 3)),
        isRead: true,
      ),
      ChatMessage(
        id: '10',
        senderId: isClient ? 'client1' : 'handyman1',
        receiverId: isClient ? 'handyman1' : 'client1',
        message: 'Yes, we\'re all set! Looking forward to it.',
        timestamp: DateTime.now().subtract(
          const Duration(hours: 2, minutes: 55),
        ),
        isRead: true,
      ),
    ];

    if (mounted) {
      setState(() {
        _messages = mockMessages;
        _isLoading = false;
      });

      // Scroll to the bottom after loading messages
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollToBottom();
      });
    }
  }

  void _sendMessage() {
    if (_messageController.text.trim().isEmpty) return;

    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final isClient = userProvider.isClient;

    final newMessage = ChatMessage(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      senderId: isClient ? 'client1' : 'handyman1',
      receiverId: isClient ? 'handyman1' : 'client1',
      message: _messageController.text.trim(),
      timestamp: DateTime.now(),
      isRead: false,
    );

    setState(() {
      _messages.add(newMessage);
      _messageController.clear();
    });

    // Scroll to bottom after sending message
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToBottom();
    });
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final isClient = userProvider.isClient;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              radius: 16,
              backgroundColor:
                  isClient ? AppColors.secondary : AppColors.primary,
              child: Text(
                _recipientAvatar,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  _recipientName,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  _bookingService,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
          ],
        ),
        backgroundColor: isClient ? AppColors.primary : AppColors.secondary,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () {
              // TODO: Show booking details
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Booking Details - Coming Soon')),
              );
            },
          ),
        ],
      ),
      body:
          _isLoading
              ? const Center(child: CircularProgressIndicator())
              : Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      controller: _scrollController,
                      padding: const EdgeInsets.all(16),
                      itemCount: _messages.length,
                      itemBuilder: (context, index) {
                        final message = _messages[index];
                        final isMe =
                            (isClient && message.senderId == 'client1') ||
                            (!isClient && message.senderId == 'handyman1');

                        // Check if we need to show date header
                        final showDateHeader =
                            index == 0 ||
                            !_isSameDay(
                              _messages[index].timestamp,
                              _messages[index - 1].timestamp,
                            );

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            if (showDateHeader)
                              _buildDateHeader(message.timestamp),
                            _buildMessageBubble(message, isMe),
                          ],
                        );
                      },
                    ),
                  ),
                  _buildMessageInput(),
                ],
              ),
    );
  }

  Widget _buildDateHeader(DateTime timestamp) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        children: [
          const Expanded(child: Divider()),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              _getDateText(timestamp),
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Expanded(child: Divider()),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(ChatMessage message, bool isMe) {
    final time = DateFormat('h:mm a').format(message.timestamp);

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment:
            isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isMe) ...[
            CircleAvatar(
              radius: 16,
              backgroundColor: AppColors.secondary,
              child: Text(
                _recipientAvatar,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
            const SizedBox(width: 8),
          ],
          Flexible(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color:
                    isMe
                        ? Provider.of<UserProvider>(context).isClient
                            ? AppColors.primary.withOpacity(0.1)
                            : AppColors.secondary.withOpacity(0.1)
                        : Colors.grey.withOpacity(0.1),
                borderRadius: BorderRadius.circular(16).copyWith(
                  bottomLeft:
                      isMe
                          ? const Radius.circular(16)
                          : const Radius.circular(0),
                  bottomRight:
                      isMe
                          ? const Radius.circular(0)
                          : const Radius.circular(16),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    message.message,
                    style: TextStyle(fontSize: 16, color: AppColors.textDark),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        time,
                        style: TextStyle(
                          fontSize: 10,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      if (isMe) ...[
                        const SizedBox(width: 4),
                        Icon(
                          message.isRead ? Icons.done_all : Icons.done,
                          size: 12,
                          color:
                              message.isRead
                                  ? AppColors.info
                                  : AppColors.textSecondary,
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ),
          if (isMe) const SizedBox(width: 24),
        ],
      ),
    );
  }

  Widget _buildMessageInput() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.attach_file),
              onPressed: () {
                // TODO: Implement file attachment
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('File Attachment - Coming Soon'),
                  ),
                );
              },
              color: AppColors.textSecondary,
            ),
            Expanded(
              child: TextField(
                controller: _messageController,
                decoration: InputDecoration(
                  hintText: 'Type a message...',
                  hintStyle: TextStyle(color: AppColors.textSecondary),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.grey.withOpacity(0.1),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                ),
                textCapitalization: TextCapitalization.sentences,
                onSubmitted: (_) => _sendMessage(),
              ),
            ),
            const SizedBox(width: 8),
            CircleAvatar(
              radius: 20,
              backgroundColor:
                  Provider.of<UserProvider>(context).isClient
                      ? AppColors.primary
                      : AppColors.secondary,
              child: IconButton(
                icon: const Icon(Icons.send),
                onPressed: _sendMessage,
                color: Colors.white,
                iconSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool _isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  String _getDateText(DateTime date) {
    final now = DateTime.now();
    final yesterday = DateTime(now.year, now.month, now.day - 1);
    final dateToCheck = DateTime(date.year, date.month, date.day);

    if (dateToCheck.compareTo(DateTime(now.year, now.month, now.day)) == 0) {
      return 'Today';
    } else if (dateToCheck.compareTo(yesterday) == 0) {
      return 'Yesterday';
    } else {
      return DateFormat('EEEE, MMMM d, y').format(date);
    }
  }
}

class ChatMessage {
  final String id;
  final String senderId;
  final String receiverId;
  final String message;
  final DateTime timestamp;
  bool isRead;

  ChatMessage({
    required this.id,
    required this.senderId,
    required this.receiverId,
    required this.message,
    required this.timestamp,
    required this.isRead,
  });
}
