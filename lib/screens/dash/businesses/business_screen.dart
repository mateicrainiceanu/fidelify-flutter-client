import 'package:fidelify_client/screens/dash/businesses/edit_business_data_screen.dart';
import 'package:fidelify_client/utils/logger.dart';
import 'package:flutter/material.dart';

class BusinessScreen extends StatelessWidget {
  const BusinessScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                              onFinish: (b) {
                                //TODO: Handle business enrollment
                                Log.info("EditBusinessDataScreen.onFinish => ${b?.id} ${b?.identifier}");
                              },
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



        ],
      ),
    );
  }
}