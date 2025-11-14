import 'package:fidelify_client/models/business/business.dart';
import 'package:fidelify_client/providers/businesses_provider.dart';
import 'package:fidelify_client/screens/dash/businesses/fs_business_comp/business_edit_menu.dart';
import 'package:fidelify_client/screens/dash/businesses/fs_business_comp/fs_business_app_bar.dart';
import 'package:flutter/material.dart';

import '../../../../widgets/business_status_indicator.dart';

class FSBusinessScreen extends StatelessWidget {
  final Business business;
  final BusinessProvider businessProvider;

  const FSBusinessScreen({required this.business, super.key, required this.businessProvider});


  @override
  Widget build(BuildContext context) {

    bool showAdmin = business.hasSomePermission;

    return Scaffold(
      appBar: FSBusinessAppBar(business: business),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: RefreshIndicator(
          onRefresh: () async {
            await Future.delayed(const Duration(seconds: 2));
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              spacing: 10,
              children: [
                if (showAdmin) BusinessStatusIndicator(st: business.onlineStatus, textColor: Colors.black),
                if (showAdmin) BusinessEditMenu(business: business, businessProvider: businessProvider),
              ],
            ),
          ),
        )
      ),
    );
  }
}
