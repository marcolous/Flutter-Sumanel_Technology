class UserModel {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String username;
  final String phoneNumber;
  final int readingStage;
  final int readingStar;
  final bool isVerified;
  final bool isStaff;
  final String subscriptionType;
  final DateTime? subscriptionEndDate;
  final int? ownedClassroomId;
  final bool? belongsToClassroom;

  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.username,
    required this.phoneNumber,
    required this.readingStage,
    required this.readingStar,
    required this.isVerified,
    required this.isStaff,
    required this.subscriptionType,
    this.subscriptionEndDate,
    this.ownedClassroomId,
    required this.belongsToClassroom,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      email: json['email'] as String,
      username: json['username'] as String,
      phoneNumber: json['phone_number'].toString(),
      readingStage: json['reading_stage'] as int,
      readingStar: json['reading_star'] as int,
      isVerified: json['is_verified'] as bool,
      isStaff: json['is_staff'] as bool,
      subscriptionType: json['subscription_type'] as String,
      subscriptionEndDate: json['subscription_end_date'] != null
          ? DateTime.tryParse(json['subscription_end_date'])
          : null, // Handle null or incorrect formats
      ownedClassroomId: json['owned_classroom_id'] != null
          ? json['owned_classroom_id'] as int
          : null,
      belongsToClassroom: json['belongs_to_classroom'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'username': username,
      'phone_number': phoneNumber,
      'reading_stage': readingStage,
      'reading_star': readingStar,
      'is_verified': isVerified,
      'is_staff': isStaff,
      'subscription_type': subscriptionType,
      'subscription_end_date': subscriptionEndDate?.toIso8601String(),
      'owned_classroom_id': ownedClassroomId,
      'belongs_to_classroom': belongsToClassroom,
    };
  }
}
