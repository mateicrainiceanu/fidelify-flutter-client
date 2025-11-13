import 'package:fidelify_client/screens/dash/businesses/fs_business_comp/fs_business_view.dart';
import 'package:fidelify_client/utils/logger.dart';
import 'package:fidelify_client/widgets/business_status_indicator.dart';
import 'package:flutter/material.dart';

import '../../../models/business/business.dart';
import '../../../providers/businesses_provider.dart';

class BusinessTileView extends StatelessWidget {
  final Business business;
  final BusinessProvider businessProvider;

  const BusinessTileView({required this.business, required this.businessProvider, super.key});

  static const String _fallbackAsset = 'assets/images/business_default.jpg';

  @override
  Widget build(BuildContext context) {
    final imageUrl = business.pictureUrl?.isNotEmpty == true
        ? business.pictureUrl!
        : "";

    return SizedBox(
      height: 200,
      child: Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 4,
        margin: const EdgeInsets.all(0),
        child: InkWell(
          onTap: () {
            Log.info("Tapped on widget business ${business.name} [${business.identifier}]");
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => FSBusinessView(business: business, businessProvider: businessProvider)),
            );
          },
          child: Stack(
            alignment: Alignment.bottomLeft,
            children: [
              Positioned.fill(
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                      _fallbackAsset,
                      fit: BoxFit.cover,
                    );
                  },
                ),
              ),

              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withValues(alpha: 0.1),
                        Colors.black.withValues(alpha: 0.2),
                        Colors.black.withValues(alpha: 0.2),
                        Colors.black.withValues(alpha: 0.7),
                        Colors.black.withValues(alpha: 0.9),
                      ],
                    ),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (business.shouldShowStatus) BusinessStatusIndicator(st: business.onlineStatus),
                    const Spacer(),
                    Text(
                      business.name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        shadows: [
                          Shadow(
                            color: Colors.black26,
                            blurRadius: 4,
                            offset: Offset(1, 1),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      business.identifier,
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.9),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}