class ServiceModel {
  final String id;
  final String name;
  final String description;
  final String category;
  final double basePrice;
  final String? imageUrl;
  final int estimatedDuration; // in minutes
  final List<String>? tags;
  final bool isPopular;
  final bool isAvailable;
  final DateTime createdAt;
  final DateTime updatedAt;

  ServiceModel({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.basePrice,
    this.imageUrl,
    required this.estimatedDuration,
    this.tags,
    this.isPopular = false,
    this.isAvailable = true,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    return ServiceModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      category: json['category'],
      basePrice: json['basePrice'].toDouble(),
      imageUrl: json['imageUrl'],
      estimatedDuration: json['estimatedDuration'],
      tags: json['tags'] != null ? List<String>.from(json['tags']) : null,
      isPopular: json['isPopular'] ?? false,
      isAvailable: json['isAvailable'] ?? true,
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'category': category,
      'basePrice': basePrice,
      'imageUrl': imageUrl,
      'estimatedDuration': estimatedDuration,
      'tags': tags,
      'isPopular': isPopular,
      'isAvailable': isAvailable,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
