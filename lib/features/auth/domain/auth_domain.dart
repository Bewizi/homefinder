import 'package:equatable/equatable.dart';

class AuthDomain extends Equatable {
  const AuthDomain({
    required this.id,
    required this.fullName,
    required this.email,
    required this.phoneNumber,
  });

  factory AuthDomain.fromMap(Map<String, String> json) {
    return AuthDomain(
      id: json['id'] ?? '',
      fullName: json['full_name'] ?? '',
      email: json['email'] ?? '',
      phoneNumber: json['phone_number'] ?? '',
    );
  }

  final String id;
  final String fullName;
  final String email;
  final String phoneNumber;

  AuthDomain copyWith({
    String? id,
    String? fullName,
    String? email,
    String? phoneNumber,
  }) {
    return AuthDomain(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'full_name': fullName,
      'email': email,
      'phone_number': phoneNumber,
    };
  }

  @override
  List<Object?> get props => [id, fullName, email, phoneNumber];
}
