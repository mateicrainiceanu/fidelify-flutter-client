import 'dart:collection';

import 'package:fidelify_client/models/business/business.dart';
import 'package:fidelify_client/providers/api_service.dart';
import 'package:flutter/cupertino.dart';

class BusinessProvider extends ChangeNotifier {
  final ApiService api = ApiService.instance;

  final List<Business> _businesses = [];
  UnmodifiableListView<Business> get businesses => UnmodifiableListView(_businesses);

  // Future<void> fetchBusiness() async {
  //   final response = await api.get('businesses');
  // }

  void addBusiness(Business? business) {
    if (business == null || _businesses.contains(business)) return;

    _businesses.insert(0, business);
    notifyListeners();
  }

}