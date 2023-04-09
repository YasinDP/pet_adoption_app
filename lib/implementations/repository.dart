import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pet_adoption_app/models.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Repository {
  final String kAdoptionsKey = "adoptions";
  void saveData(List<Adoption> adoptions) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(
        kAdoptionsKey,
        adoptions
            .map(
              (e) => jsonEncode(e),
            )
            .toList());
  }

  Future<List<Adoption>> getData() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final List<String>? items = prefs.getStringList(kAdoptionsKey);
      return items
              ?.map(
                (e) => Adoption.fromJson(
                  jsonDecode(e) as Map<String, dynamic>,
                ),
              )
              .toList() ??
          [];
    } catch (e) {
      debugPrint(e.toString());
      return [];
    }
  }
}
