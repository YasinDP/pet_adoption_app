import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pet_adoption_app/implementations/adoption_impl.dart';
import 'package:pet_adoption_app/models.dart';

final appProvider = ChangeNotifierProvider<AppNotifier>((ref) => AppNotifier());

class AppNotifier with ChangeNotifier {
  List<Adoption> get userAdoptions => AdoptionImplementation.userAdoptions;

  //

  void fetchData() async {
    await AdoptionImplementation.fetchData();
    notifyListeners();
  }

  void addData(Adoption adoption) {
    AdoptionImplementation.addData(adoption);
    notifyListeners();
  }

  void clearData() {
    AdoptionImplementation.clearData();
    notifyListeners();
  }

  //

  bool isAdopted(String petId) => AdoptionImplementation.isAdopted(petId);

  // Search & Filter
  List<Pet> _displayedPets = Pet.all;
  List<Pet> _paginatedPets = Pet.all;
  List<Pet> get paginatedPets => _paginatedPets;

  // search statuses
  bool _allLoaded = false;
  bool get allLoaded => _allLoaded;

  bool _refreshing = false;
  bool get refreshing => _refreshing;

  String _query = "";
  String _selectedCategory = "all";
  String get selectedCategory => _selectedCategory;

  void updateCategory(String categoryId) {
    _selectedCategory = categoryId;
    search();
  }

  void updatePets() {
    int start = _paginatedPets.length;
    int end = start + paginationLimit;
    List<Pet> newPets = _displayedPets.sublist(
      start,
      min(_displayedPets.length, end),
    );
    _paginatedPets.addAll(newPets);
    notifyListeners();
  }

  // List<Pet> fetchPets({required int offset, required int limit}) {
  //   int end = offset + limit;
  //   return _displayedPets.sublist(
  //     offset,
  //     min(_displayedPets.length, end),
  //   );
  // }

  Timer? _debounce;
  int paginationLimit = 4;
  void updateQuery(String query) {
    if (_debounce?.isActive ?? false) {
      _debounce!.cancel();
    }
    _debounce = Timer(const Duration(milliseconds: 1000), () {
      _query = query;
      search();
    });
  }

  void search() async {
    if (_debounce?.isActive ?? false) {
      _debounce!.cancel();
    }
    _debounce = Timer(const Duration(milliseconds: 1000), () async {
      _refreshing = true;
      notifyListeners();
      await Future.delayed(500.milliseconds);
      String queryLower = _query.trim().toLowerCase();
      _displayedPets = Pet.all.where(
        (pet) {
          bool matchingCategory = _selectedCategory == "all"
              ? true
              : pet.categoryId == _selectedCategory;
          bool matchingPattern = pet.name.toLowerCase().contains(queryLower);
          return matchingCategory && matchingPattern;
        },
      ).toList();
      _paginatedPets = _displayedPets.take(paginationLimit).toList();
      notifyListeners();
    });
  }

  void valueUpdate() => notifyListeners();
}
