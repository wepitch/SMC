import 'package:flutter/material.dart';
import 'package:myapp/model/counsellor_data.dart';
import 'package:myapp/model/counsellor_detail.dart';
import 'package:myapp/model/counsellor_sessions.dart';
import 'package:myapp/model/cousnellor_list_model.dart';

import '../api_service.dart';

class CounsellorDetailsProvider extends ChangeNotifier {
  List<CounsellorDetail> cousnellorlist_detail = [];
  List<CounsellorModel> counsellorModel = [];
  List<CounsellorData> counsellorData = [];

  CounsellorSessionDetails allDetails = CounsellorSessionDetails();
  CounsellorSessionDetails details = CounsellorSessionDetails();
  bool isLoading = true;

  void fetchCounsellor_detail(String id) async {
    var counsellor = await ApiService.getCounsellor_Detail(id);
    isLoading = true;
    if (counsellor.isEmpty) {
      isLoading = true;
    } else {
      cousnellorlist_detail = counsellor;
      isLoading = false;
    }

    notifyListeners();
  }

  void fetchCounsellor_details(String id) async {
    var counsellors = await ApiService.getCounsellorData();
    isLoading = true;
    if (counsellors.isEmpty) {
      isLoading = true;
    } else {
      counsellorData = counsellors;
      isLoading = false;
    }

    notifyListeners();
  }

  void fetchCounsellor_session(
      {required String id, String? date, String? sessionType}) async {
    try {
      isLoading = true;
      if (date != null) {
        var counsellor = await ApiService.getCounsellor_sessions(
            date: date, sessionType: sessionType, id: id);
        details = counsellor;
      } else {
        var counsellor = await ApiService.getCounsellor_sessions(id: id);
        allDetails = counsellor;
      }
    } finally {
      isLoading = false;
    }
    notifyListeners();
  }
}
