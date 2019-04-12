import 'dart:async' show Future;
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:gi_reader/model/Conf.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:gi_reader/model/Image.dart';

class Utils {
  static Dio _dio = new Dio();

  static Future<File> _getLocalFile() async {
    String path = (await getApplicationDocumentsDirectory()).path;
    return getConf().then((conf) => File("$path/${conf.giData}"));
  }

  static void _saveFile(File file, String json) {
    file.writeAsString(json);
  }

  static Future<Map<String, dynamic>> getFoodJson({bool strict = false}) async {
    final String url = await getConf().then((c) => c.url + c.giData);
    File file = await _getLocalFile();
    try {
      return await _dio.get(url).then((json) {
        _saveFile(file, json.toString());
        return jsonDecode(json.toString());
      });
    } catch (ex) {
      print("network error, using local data");
      return file.readAsString().then((content) => jsonDecode(content));
    }
  }

  //拿到图片url
  static Future<List<String>> getImageUrl({int amount: 1}) async {
    String url = "${(await getConf()).imageUrl}/$amount";
    return _dio.get(url).then((resJson) {
      return GankImage.fromJson(jsonDecode(resJson.toString())).results.map((r) => r.url).toList();
    });
  }

  static Future<Conf> getConf() {
    return rootBundle
        .loadString("assets/conf.json")
        .then((conf) => Conf.fromJson(jsonDecode(conf)));
  }
}
