import 'package:fidelify_client/models/business/business.dart';
import 'package:flutter/material.dart';

class FSBusinessAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Business business;

  const FSBusinessAppBar({required this.business, super.key});

  static const String _fallbackAsset = 'assets/images/business_default.jpg';

  @override
  Widget build(BuildContext context) {

    final imageUrl =
    business.pictureUrl?.isNotEmpty == true ? business.pictureUrl! : null;

    return AppBar(
      iconTheme: const IconThemeData(color: Colors.white),
      title: Text(
        business.name,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 30,
          color: Colors.white,
          shadows: [
            Shadow(
              // Consider a darker shadow for better contrast over a light image
              color: Colors.black54,
              blurRadius: 2,
              offset: Offset(1, 1),
            ),
          ],
        ),
      ),
      centerTitle: true,
      flexibleSpace: Stack(
        fit: StackFit.expand,
        children: [
          if (imageUrl != null && imageUrl.isNotEmpty)
            Image.network(
              imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Image.asset(_fallbackAsset, fit: BoxFit.cover);
              },
            )
          else
            Image.asset(_fallbackAsset, fit: BoxFit.cover),

          const DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black26,
                  Colors.black54,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
