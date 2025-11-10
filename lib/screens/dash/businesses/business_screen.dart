import 'package:fidelify_client/providers/businesses_provider.dart';
import 'package:fidelify_client/screens/dash/businesses/business_tile_view.dart';
import 'package:fidelify_client/screens/dash/businesses/edit_business_data_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/business/business.dart';

class BusinessScreen extends StatelessWidget {
  const BusinessScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final businessProvider = context.watch<BusinessProvider>();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 16,
        children: [
          ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(
                        builder: (context) =>
                            EditBusinessDataScreen(
                              onFinish: businessProvider.addBusiness,
                            ),
                    ),
                );
              },
              child: const Row(
                spacing: 10,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add),
                  Text("Enroll your business")
                ],
              ),
          ),

          BusinessTileView(business: Business.mockBusiness),

        ],
      ),
    );
  }
}