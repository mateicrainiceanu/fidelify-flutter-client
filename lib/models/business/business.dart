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

  static final mockBusiness = Business(
    id: 'a1b2c3d4-e5f6-7890-abcd-ef1234567890',
    identifier: 'fidelify_coffee_shop',
    name: 'Fidelify Coffee Shop',
    pictureUrl: 'https://images.unsplash.com/photo-1472851294608-062f824d29cc?ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&q=80&w=1170',
    website: 'https://fidelifycoffee.com',
    onlineStatus: 'online',
    permissions: const BusinessPermissions(
      id: '3a60b158-104c-4b80-8af2-b7aa67676db7',
      isCreator: true,
      canCreate: true,
      canEditOffer: true,
      canSeeOffer: true,
      canValidateOffer: true,
    ),
  );
}
