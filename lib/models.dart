import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:pet_adoption_app/utils/helper_utils/assets.dart';
import 'package:pet_adoption_app/utils/helper_utils/extensions.dart';
import 'package:pet_adoption_app/utils/helper_utils/functions.dart';

part 'utils/helper_utils/data.dart';

class Category {
  final String id;
  final String name;
  final String image;
  final Color backgroundColor;

  Category({
    required this.id,
    required this.name,
    required this.image,
    required this.backgroundColor,
  });

  static List<Category> get all => _categories;
  static int get count => _categories.length;
}

class Pet {
  Pet({
    required this.id,
    required this.name,
    required this.price,
    required this.images,
    required this.age,
    required this.categoryId,
  });

  static Pet? fromId(String petId) =>
      _pets.firstWhereOrNull((pet) => pet.id == petId);

  static List<Pet> get all => _pets;
  static int get count => _pets.length;

  static List<Pet> byCategory(String categoryId) => categoryId == "all"
      ? _pets
      : _pets.where((pet) => pet.categoryId == categoryId).toList();

  final String id;
  final String name;
  final double price;
  final List<String> images;
  final String age;
  final String categoryId;

  String get primaryImage => images.first;
  ImageProvider get icon => NetworkImage(primaryImage);

  Category get category =>
      _categories.firstWhereOrNull((category) => category.id == categoryId) ??
      _categories.first;

  Color get backgroundColor => category.backgroundColor;

  String get subtitle => category.name;
}

class Adoption {
  final String petId;
  final DateTime adoptedTime;

  Adoption({
    required this.petId,
    required this.adoptedTime,
  });
}

class TimelineEvent {
  final DateTime month;
  final String description;

  TimelineEvent(
    this.month,
    this.description,
  );

  static List<TimelineEvent> get all => _timelines;
}
