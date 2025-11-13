import 'package:fidelify_client/models/business/business.dart';
import 'package:fidelify_client/providers/businesses_provider.dart';
import 'package:fidelify_client/screens/dash/businesses/fs_business_comp/business_edit_menu.dart';
import 'package:fidelify_client/screens/dash/businesses/fs_business_comp/fs_business_app_bar.dart';
import 'package:flutter/material.dart';

import '../../../../widgets/business_status_indicator.dart';

class FSBusinessView extends StatelessWidget {
  final Business business;
  final BusinessProvider businessProvider;

  const FSBusinessView({required this.business, super.key, required this.businessProvider});


  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: FSBusinessAppBar(business: business),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: 10,
          children: [
            BusinessStatusIndicator(st: business.onlineStatus, textColor: Colors.black),

            BusinessEditMenu(business: business, businessProvider: businessProvider),
          ],
        )
      ),
    );
  }
}
