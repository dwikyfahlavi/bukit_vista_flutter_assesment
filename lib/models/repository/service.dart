import 'dart:convert';

import 'package:bukit_vista_flutter_assesment/models/guest.dart';
import 'package:flutter/services.dart';

class Service {
  Future<List<GuestData>?> getAllGuestData() async {
    List<GuestData> gData = [];

    try {
      String response = await rootBundle.loadString('assets/dummy_data.json');
      Map<String, dynamic> data = jsonDecode(response);
      List dataList = data['data'];
      gData = dataList.map((e) => GuestData.fromJson(e)).toList();
    } catch (e) {
      print("error bos : $e");
    }
    return gData;
  }
}
