import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class NetworkController extends GetxController{

  callGetApi(String apiName) async{
    try {
      final response = await http.get(Uri.parse(apiName));

      if(response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return null;
      }

    }catch(e) {
      print(e);
    }
  }

}