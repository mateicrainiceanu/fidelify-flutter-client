import 'package:fidelify_client/models/business/business.dart';
import 'package:fidelify_client/providers/businesses_provider.dart';
import 'package:fidelify_client/screens/dash/businesses/edit_business_data_screen.dart';
import 'package:fidelify_client/utils/theme.dart';
import 'package:fidelify_client/widgets/titles.dart';
import 'package:flutter/material.dart';

import '../../../../utils/toast.dart';

class BusinessEditMenu extends StatelessWidget {
  final Business business;
  final BusinessProvider businessProvider;

  const BusinessEditMenu({required this.business, required this.businessProvider, super.key});

  void _onViewChangePressed() {
    if (business.onlineStatus != OnlineStatus.online || business.onlineStatus != OnlineStatus.hidden) {
      Toast.warning("You can't modify the business status unless it's approved");
      return;
    }
  }

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
                //CHANGE _ VISIBILITY ICON
                ElevatedButton(
                  onPressed: _onViewChangePressed,
                  style: ButtonThemes.fromElevatedButtonWithColors(bgColor: business.onlineStatus == OnlineStatus.online ? Colors.green : Colors.grey),
                  child: const Icon(Icons.remove_red_eye_rounded),
                ),

                // EDIT BTN
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
