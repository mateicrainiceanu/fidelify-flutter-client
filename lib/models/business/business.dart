import 'package:fidelify_client/models/business/business_permissions.dart';

class Business {
  final String id;
  final String identifier;
  final String name;
  final String? pictureUrl;
  final String? website;
  final String onlineStatus;
  final BusinessPermissions? permissions;

  Business({
    required this.id,
    required this.identifier,
    required this.name,
    this.pictureUrl,
    this.website,
    required this.onlineStatus,
    this.permissions,
  });

  factory Business.fromJson(Map<String, dynamic> json) {
    return Business(
      id: json['id'] as String,
      identifier: json['identifier'] as String,
      name: json['name'] as String,
      pictureUrl: json['pictureUrl'] as String?,
      website: json['website'] as String?,
      onlineStatus: json['onlineStatus'] as String,
      permissions: (json['permissions'] != null
          ? BusinessPermissions.fromJson(
              json['permissions'] as Map<String, dynamic>)
          : null),
    );
  }
}
