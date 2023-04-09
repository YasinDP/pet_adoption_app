import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pet_adoption_app/implementations/adoption_impl.dart';
import 'package:pet_adoption_app/models.dart';
import 'package:pet_adoption_app/utils/helper_utils/functions.dart';

final appProvider = ChangeNotifierProvider<AppNotifier>((ref) => AppNotifier());

class AppNotifier with ChangeNotifier {
  List<Adoption> get userAdoptions => AdoptionImplementation.userAdoptions;

  //

  void fetchData() async {
    await AdoptionImplementation.fetchData();
    notifyListeners();
  }

  void addData(String petId) {
    AdoptionImplementation.addData(
      Adoption(
        petId: petId,
        adoptedTime: DateTime.now(),
      ),
    );
    notifyListeners();
  }

  void clearData() async {
    if (userAdoptions.isEmpty) {
      showToast("You havent made any adoptions yet to clear history");
      return;
    }
    await AdoptionImplementation.clearData();
    showToast("Adoption History has been cleared");
    notifyListeners();
  }

  //

  bool isAdopted(String petId) => AdoptionImplementation.isAdopted(petId);

  // Search & Filter
  List<Pet> _displayedPets = Pet.all;
  List<Pet> _paginatedPets = [];
  List<Pet> get paginatedPets => _paginatedPets;

  int get availablePets => _displayedPets.length;

  // search statuses
  bool _allLoaded = false;
  bool get allLoaded => _allLoaded;

  bool _refreshing = false;
  bool get refreshing => _refreshing;

  bool _loading = false;
  bool get loading => _loading;

  String _query = "";
  String _selectedCategory = "all";
  String get selectedCategory => _selectedCategory;

  void updateCategory(String categoryId) {
    _selectedCategory = categoryId;
    search();
  }

  void updatePets() async {
    _loading = true;
    notifyListeners();
    await Future.delayed(500.milliseconds);
    int start = _paginatedPets.length;
    int end = start + paginationLimit;
    List<Pet> newPets = _displayedPets.sublist(
      start,
      min(_displayedPets.length, end),
    );
    _paginatedPets.addAll(newPets);
    if (newPets.length < paginationLimit) {
      _allLoaded = true;
    }
    _loading = false;
    notifyListeners();
  }

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
    _refreshing = true;
    _allLoaded = false;
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
    _refreshing = false;
    notifyListeners();
  }

  //

  List<Pet> getAdoptedPetsInMonth(DateTime month) {
    List<Pet> adoptedPets = AdoptionImplementation.getAdoptedPetsInMonth(month);
    return adoptedPets;
  }
}
