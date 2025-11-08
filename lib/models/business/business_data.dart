import 'business.dart';

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