import 'dart:core';

import 'package:fidelify_client/models/business/business_permissions.dart';
import 'package:fidelify_client/utils/toast.dart';

import '../../utils/logger.dart';

enum OnlineStatus {
  online,
  pendingValidation,
  pendingPayment,
  hidden,
  notKnown;

  factory OnlineStatus.fromString(String status) {
    switch (status.toUpperCase()) { // Use .toUpperCase() for case-insensitivity
      case 'ONLINE':
        return OnlineStatus.online;
      case 'PENDING_VALIDATION':
        return OnlineStatus.pendingValidation;
      case 'PENDING_PAYMENT':
        return OnlineStatus.pendingPayment;
      case 'HIDDEN':
        return OnlineStatus.hidden;
      default:
        Log.warn(
            'Warning: Unknown OnlineStatus "$status", defaulting to noKnown.');
        Toast.warning(
            "Consider updating the app. A warning occurred. [BusinessOnlineStatus]");
        return OnlineStatus.notKnown;
    }
  }

  String getText() {
    switch (this) {
      case OnlineStatus.online:
        return 'online';
      case OnlineStatus.pendingValidation:
        return 'pending validation';
      case OnlineStatus.pendingPayment:
        return 'pending payment';
      case OnlineStatus.hidden:
        return 'hidden';
      default:
        return 'unknown';
    }
  }
}

class Business {
  final String id;
  final String identifier;
  final String name;
  final String? pictureUrl;
  final String? website;
  final OnlineStatus onlineStatus;
  final BusinessPermissions? permissions;
  bool get shouldShowStatus => _hasSomePermission();

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
      onlineStatus: OnlineStatus.fromString(json['onlineStatus'] as String),
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
    onlineStatus: OnlineStatus.online,
    permissions: const BusinessPermissions(
      id: '3a60b158-104c-4b80-8af2-b7aa67676db7',
      isCreator: true,
      canCreate: true,
      canEditOffer: true,
      canSeeOffer: true,
      canValidateOffer: true,
    ),
  );

  bool _hasSomePermission() {
    final bp = permissions;
    if (bp == null) return false;

    return bp.canCreate || bp.canEditOffer || bp.canSeeOffer || bp.canValidateOffer;

  }
}
