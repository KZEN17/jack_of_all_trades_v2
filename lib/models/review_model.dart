class ReviewModel {
  final String id;
  final String bookingId;
  final String clientId;
  final String handymanId;
  final double rating;
  final String? comment;
  final DateTime createdAt;
  final DateTime updatedAt;

  // Client and handyman details for UI display
  final String? clientName;
  final String? clientAvatar;
  final String? handymanName;
  final String? handymanAvatar;

  ReviewModel({
    required this.id,
    required this.bookingId,
    required this.clientId,
    required this.handymanId,
    required this.rating,
    this.comment,
    required this.createdAt,
    required this.updatedAt,
    this.clientName,
    this.clientAvatar,
    this.handymanName,
    this.handymanAvatar,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      id: json['id'],
      bookingId: json['bookingId'],
      clientId: json['clientId'],
      handymanId: json['handymanId'],
      rating: json['rating'].toDouble(),
      comment: json['comment'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      clientName: json['clientName'],
      clientAvatar: json['clientAvatar'],
      handymanName: json['handymanName'],
      handymanAvatar: json['handymanAvatar'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'bookingId': bookingId,
      'clientId': clientId,
      'handymanId': handymanId,
      'rating': rating,
      'comment': comment,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'clientName': clientName,
      'clientAvatar': clientAvatar,
      'handymanName': handymanName,
      'handymanAvatar': handymanAvatar,
    };
  }
}
