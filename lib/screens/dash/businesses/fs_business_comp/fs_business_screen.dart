import 'package:fidelify_client/models/business/business.dart';
import 'package:fidelify_client/providers/businesses_provider.dart';
import 'package:fidelify_client/screens/dash/businesses/fs_business_comp/business_edit_menu.dart';
import 'package:fidelify_client/screens/dash/businesses/fs_business_comp/fs_business_app_bar.dart';
import 'package:flutter/material.dart';

import '../../../../widgets/business_status_indicator.dart';
import '../../../error_screen.dart';

class FSBusinessScreen extends StatefulWidget {
  final Business business;
  final BusinessProvider businessProvider;

  const FSBusinessScreen({required this.business, super.key, required this.businessProvider});

  @override
  State<FSBusinessScreen> createState() => _FSBusinessScreenState();
}

class _FSBusinessScreenState extends State<FSBusinessScreen> {

  late Business? business = widget.businessProvider.businesses.firstWhere((b) => b.id == widget.business.id);

  @override
  Widget build(BuildContext context) {

    bool showAdmin = widget.business.hasSomePermission;

    if (business == null) return const ErrorScreen(text: "Business not found");

    return Scaffold(
      appBar: FSBusinessAppBar(business: business!),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: RefreshIndicator(
          onRefresh: () async {
            final business = await widget.businessProvider.refreshBusiness(withStringId: widget.business.id);
            if (business == null) {return;}
            setState(() {
              this.business = business;
            });
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              spacing: 10,
              children: [
                if (showAdmin) BusinessStatusIndicator(st: business!.onlineStatus, textColor: Colors.black),
                if (showAdmin) BusinessEditMenu(business: business!, businessProvider: widget.businessProvider),
              ],
            ),
          ),
        )
      ),
    );
  }
}
