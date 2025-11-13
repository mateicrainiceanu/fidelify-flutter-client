import 'package:fidelify_client/models/business/business.dart';
import 'package:flutter/material.dart';

class BusinessStatusIndicator extends StatelessWidget {

  final OnlineStatus st;
  final Color textColor;

  const BusinessStatusIndicator({required this.st, this.textColor = Colors.white, super.key});

  Color _getColor() {
    switch (st) {
      case OnlineStatus.online:
        return Colors.green;
      case OnlineStatus.pendingValidation:
        return Colors.yellow;
      case OnlineStatus.pendingPayment:
        return Colors.blue;
      case OnlineStatus.hidden:
        return Colors.grey;
      default:
        return Colors.yellow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (st != OnlineStatus.online)
          Text(st.getText(), style: TextStyle(color: textColor)),

        if (st != OnlineStatus.online)
          const SizedBox(width: 8),

        CircleAvatar(
          radius: 10,
          backgroundColor: _getColor()
        ),
      ],
    );
  }

}