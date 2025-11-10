import 'package:fidelify_client/models/business/business.dart';

class BusinessListResponse {
  final List<Business> businesses;

  BusinessListResponse({required this.businesses});

  factory BusinessListResponse.fromJson(Map<String, dynamic> json) {
    final businessesJson = json['businesses'] as List<dynamic>? ?? [];
    return BusinessListResponse(
      businesses: businessesJson
          .map((e) => Business.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}
