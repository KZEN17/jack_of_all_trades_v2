class UserModel {
  final String id;
  final String name;
  final String email;
  final String? phone;
  final String? address;
  final String? avatar;
  final String userType; // 'client' or 'handyman'
  final double? rating;
  final int? completedJobs;
  final List<String>? specialties; // For handyman
  final String? bio;
  final DateTime createdAt;
  final DateTime updatedAt;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.phone,
    this.address,
    this.avatar,
    required this.userType,
    this.rating,
    this.completedJobs,
    this.specialties,
    this.bio,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      address: json['address'],
      avatar: json['avatar'],
      userType: json['userType'],
      rating: json['rating']?.toDouble(),
      completedJobs: json['completedJobs'],
      specialties:
          json['specialties'] != null
              ? List<String>.from(json['specialties'])
              : null,
      bio: json['bio'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'address': address,
      'avatar': avatar,
      'userType': userType,
      'rating': rating,
      'completedJobs': completedJobs,
      'specialties': specialties,
      'bio': bio,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  UserModel copyWith({
    String? name,
    String? email,
    String? phone,
    String? address,
    String? avatar,
    double? rating,
    int? completedJobs,
    List<String>? specialties,
    String? bio,
  }) {
    return UserModel(
      id: this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      avatar: avatar ?? this.avatar,
      userType: this.userType,
      rating: rating ?? this.rating,
      completedJobs: completedJobs ?? this.completedJobs,
      specialties: specialties ?? this.specialties,
      bio: bio ?? this.bio,
      createdAt: this.createdAt,
      updatedAt: DateTime.now(),
    );
  }
}
