import 'dart:async' show Future;
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:gi_reader/model/Conf.dart';

class Utils {
  static Dio _dio = new Dio();

  static Future<Map<String, dynamic>> getFoodJson() async {
    final String url = await getConf().then((c) => c.url + c.giData);
    return _dio.get(url).then((json) => jsonDecode(json.toString()));
  }

  static Future<Conf> getConf() {
    return rootBundle
        .loadString("assets/conf.json")
        .then((conf) => Conf.fromJson(jsonDecode(conf)));
  }
}
