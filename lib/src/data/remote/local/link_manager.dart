import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class LinkManager {
  static Map<int, String>? mitredenLinks;
  static Map<int, String>? virtualTourLinks;
  static Map<int, String>? cityLinks;
  static Map<int, String>? tourismLinks;

  /// Loads all links from JSON files specified in the .env file.
  static Future<void> loadLinks() async {
    await loadMitredenLinks();
    await loadVirtualTourLinks();
    await loadCityLinks();
    await loadTourismLinks();
  }

  static Future<void> loadMitredenLinks() async {
    String path = dotenv.env['MITREDEN_LINKS_JSON']!;
    mitredenLinks = await _loadLinks(path);
  }

  static Future<void> loadVirtualTourLinks() async {
    String path = dotenv.env['VIRTUAL_TOUR_LINKS_JSON']!;
    virtualTourLinks = await _loadLinks(path);
  }

  static Future<void> loadCityLinks() async {
    String path = dotenv.env['CITY_LINKS_JSON']!;
    cityLinks = await _loadLinks(path);
  }

  static Future<void> loadTourismLinks() async {
    String path = dotenv.env['TOURISM_LINKS_JSON']!;
    tourismLinks = await _loadLinks(path);
  }

  static Future<Map<int, String>?> _loadLinks(String jsonPath) async {
    try {
      String data = await rootBundle.loadString(jsonPath);
      return (jsonDecode(data) as Map)
          .map((key, value) => MapEntry(int.parse(key), value.toString()));
    } catch (e) {
      return null;
    }
  }

  static String? getMitredenLink(int cityId) => mitredenLinks?[cityId];
  static String? getVirtualTourLink(int cityId) => virtualTourLinks?[cityId];
  static String? getCityLink(int cityId) => cityLinks?[cityId];
  static String? getTourismLink(int cityId) => tourismLinks?[cityId];
}
