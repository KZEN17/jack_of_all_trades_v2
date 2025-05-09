class BookingModel {
  final String id;
  final String clientId;
  final String? handymanId;
  final String serviceId;
  final String serviceName;
  late final String
  status; // 'pending', 'confirmed', 'in_progress', 'completed', 'cancelled'
  final DateTime scheduledDate;
  final String scheduledTime;
  final String? address;
  final double? latitude;
  final double? longitude;
  final String? notes;
  final double price;
  final double? finalPrice;
  late final String? cancelReason;
  final String? paymentStatus; // 'pending', 'paid', 'refunded'
  final String? paymentMethod;
  final DateTime? startTime;
  final DateTime? endTime;
  final DateTime createdAt;
  late final DateTime updatedAt;

  BookingModel({
    required this.id,
    required this.clientId,
    this.handymanId,
    required this.serviceId,
    required this.serviceName,
    required this.status,
    required this.scheduledDate,
    required this.scheduledTime,
    this.address,
    this.latitude,
    this.longitude,
    this.notes,
    required this.price,
    this.finalPrice,
    this.cancelReason,
    this.paymentStatus,
    this.paymentMethod,
    this.startTime,
    this.endTime,
    required this.createdAt,
    required this.updatedAt,
  });

  factory BookingModel.fromJson(Map<String, dynamic> json) {
    return BookingModel(
      id: json['id'],
      clientId: json['clientId'],
      handymanId: json['handymanId'],
      serviceId: json['serviceId'],
      serviceName: json['serviceName'],
      status: json['status'],
      scheduledDate: DateTime.parse(json['scheduledDate']),
      scheduledTime: json['scheduledTime'],
      address: json['address'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      notes: json['notes'],
      price: json['price'].toDouble(),
      finalPrice: json['finalPrice']?.toDouble(),
      cancelReason: json['cancelReason'],
      paymentStatus: json['paymentStatus'],
      paymentMethod: json['paymentMethod'],
      startTime:
          json['startTime'] != null ? DateTime.parse(json['startTime']) : null,
      endTime: json['endTime'] != null ? DateTime.parse(json['endTime']) : null,
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'clientId': clientId,
      'handymanId': handymanId,
      'serviceId': serviceId,
      'serviceName': serviceName,
      'status': status,
      'scheduledDate': scheduledDate.toIso8601String(),
      'scheduledTime': scheduledTime,
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
      'notes': notes,
      'price': price,
      'finalPrice': finalPrice,
      'cancelReason': cancelReason,
      'paymentStatus': paymentStatus,
      'paymentMethod': paymentMethod,
      'startTime': startTime?.toIso8601String(),
      'endTime': endTime?.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
