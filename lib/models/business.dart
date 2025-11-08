class Business {
  final String id;
  final String identifier;
  final String name;
  final String? pictureUrl;
  final String? website;
  final String onlineStatus;

  Business({
    required this.id,
    required this.identifier,
    required this.name,
    this.pictureUrl,
    this.website,
    required this.onlineStatus
  });

  factory Business.fromJson(Map<String, dynamic> json) {
    return Business(
      id: json['id'] as String,
      identifier: json['identifier'] as String,
      name: json['name'] as String,
      pictureUrl: json['pictureUrl'] as String?,
      website: json['website'] as String?,
      onlineStatus: json['onlineStatus'] as String
    );
  }

}

class BusinessData {
  String? id;
  String? identifier;
  String? name;
  String? pictureUrl;
  String? website;

  BusinessData({
    this.id,
    this.identifier,
    this.name,
    this.pictureUrl,
    this.website
  });

  factory BusinessData.fromBusiness(Business b) {
    return BusinessData(
      id: b.id,
      identifier: b.identifier,
      name: b.name,
      pictureUrl: b.pictureUrl,
      website: b.website
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'identifier': identifier,
      'name': name,
      'pictureUrl': pictureUrl,
      'website': website
    };
  }
}