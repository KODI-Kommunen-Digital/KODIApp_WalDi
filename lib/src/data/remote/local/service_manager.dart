import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:heidi/src/data/model/model_citizen_service.dart';

class ServiceManager {
  static Future<List<CitizenServiceModel>> initializeServices() async {
    String configPath = dotenv.env['SERVICES_CONFIG']!;
    String jsonData = await rootBundle.loadString(configPath);
    List<dynamic> data = jsonDecode(jsonData);

    return data
        .map((item) => CitizenServiceModel(
              imageUrl: item['imageUrl'],
              imageLink: item['imageLink'],
              arguments: item['arguments'],
              categoryId: item['categoryId'],
            ))
        .toList();
  }
}
