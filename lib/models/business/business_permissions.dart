class BusinessPermissions {
  final String id;
  final bool isCreator;
  final bool canCreate;
  final bool canEditOffer;
  final bool canSeeOffer;
  final bool canValidateOffer;

  const BusinessPermissions({
    required this.id,
    required this.isCreator,
    required this.canCreate,
    required this.canEditOffer,
    required this.canSeeOffer,
    required this.canValidateOffer,
  });

  factory BusinessPermissions.fromJson(Map<String, dynamic> json) {
    return BusinessPermissions(
      id: json['id'] as String,
      isCreator: json['isCreator'] as bool,
      canCreate: json['canCreate'] as bool,
      canEditOffer: json['canEditOffer'] as bool,
      canSeeOffer: json['canSeeOffer'] as bool,
      canValidateOffer: json['canValidateOffer'] as bool,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'isCreator': isCreator,
    'canCreate': canCreate,
    'canEditOffer': canEditOffer,
    'canSeeOffer': canSeeOffer,
    'canValidateOffer': canValidateOffer,
  };
}
