import 'package:fidelify_client/models/business/business.dart';
import 'package:fidelify_client/providers/businesses_provider.dart';
import 'package:fidelify_client/screens/dash/businesses/edit_business_data_screen.dart';
import 'package:fidelify_client/utils/theme.dart';
import 'package:fidelify_client/widgets/titles.dart';
import 'package:flutter/material.dart';

class BusinessEditMenu extends StatelessWidget {
  final Business business;
  final BusinessProvider businessProvider;

  const BusinessEditMenu({required this.business, required this.businessProvider, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          spacing: 10,
          children: [
            const H3Title("Edit business"),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => EditBusinessDataScreen(
                          business: business,
                          onFinish: businessProvider.modifyBusiness,
                        ),
                      ),
                    );
                  },
                  style: ButtonThemes.roundedBtnStyle,
                  child: const Icon(Icons.edit),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
