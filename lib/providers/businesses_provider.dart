import 'dart:collection';

import 'package:fidelify_client/models/business/business_models.dart';
import 'package:fidelify_client/providers/api_service.dart';
import 'package:fidelify_client/utils/logger.dart';
import 'package:fidelify_client/utils/toast.dart';
import 'package:flutter/cupertino.dart';

class BusinessProvider extends ChangeNotifier {
  final ApiService api = ApiService.instance;

  final List<Business> _businesses = [];
  UnmodifiableListView<Business> get businesses => UnmodifiableListView(_businesses);
  bool _isLoading = true;
  bool get isLoading => _isLoading;

  BusinessProvider() {
    init();
  }

  void init() {
    fetchBusiness();
  }

  Future<void> fetchBusiness() async {
    _businesses.removeRange(0, _businesses.length);

    final response = await api.get<BusinessListResponse>(
        path: "/api/v1/businesses",
        params: {
          'for': 'admin' // Modify here to get business for user
        },
        parser: BusinessListResponse.fromJson
    );

    if (NetworkStatus.error == response.status) {
      Toast.error("Error loading businesses");
      _isLoading = false;
      notifyListeners();
      return;
    }

    _isLoading = false;
    _businesses.addAll(response.val!.businesses);

    notifyListeners();
  }

  void addBusiness(Business? business) {
    if (business == null || _businesses.contains(business)) return;

    _businesses.insert(0, business);
    notifyListeners();
  }

  void modifyBusiness(Business? business) {
    if (business == null) return;

    final index = _businesses.indexWhere((element) => element.id == business.id);
    if (index == -1) return;

    _businesses[index] = business;
    notifyListeners();
  }

  Future<Business?> refreshBusiness({required String withStringId}) async {

    Log.info("Refreshing business with id: $withStringId");

    final response = await api.get<Business>(
      path: "/api/v1/business/$withStringId",
      parser: Business.fromJson
    );

    if (response.status == NetworkStatus.ok) {
      Log.info("Refresh business ok");
      final index = _businesses.indexWhere((element) => element.id == withStringId);
      if (index == -1) return response.val;

      _businesses[index] = response.val!;
      notifyListeners();
      return response.val;
    }

    Log.error("Refresh business error");
    Toast.error("${response.error?.message ?? "An error occurred"} ${response.error?.code ?? 0}");
    return null;

  }

}