import '../utils/logger.dart';

class AuthUser {
  final AUser user;
  final String token;

  AuthUser({
    required this.user,
    required this.token,
  });

  factory AuthUser.fromJson(Map<String, dynamic> json) {
    Log.trace("AuthUser.fromJson : \n user: ${json['user']} \n token: ${json['token']}");
    return AuthUser(
      user: AUser.fromJson(json['user']),
      token: json['token'],
    );
  }
}

class AUser {
  final String id;
  final String email;
  final String? fname;
  final String? lname;
  final String? phone;
  final DateTime? bdate;
  final DateTime createdAt;
  final DateTime updatedAt;

  String? get bdateStr => bdate?.toLocal().toString().split(' ')[0].split('-').reversed.join('.');

  AUser({
    required this.id,
    required this.email,
    this.fname,
    this.lname,
    this.phone,
    this.bdate,
    required this.createdAt,
    required this.updatedAt,
  });

  factory AUser.fromJson(Map<String, dynamic> json) {
    return AUser(
      id: json['id'],
      email: json['email'],
      fname: json['fname'] as String?,
      lname: json['lname'] as String?,
      phone: json['phone'] as String?,
      bdate: json['bdate'] != null ? DateTime.parse(json['bdate']) : null,
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}
