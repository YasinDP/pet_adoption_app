import 'package:collection/collection.dart';

import 'package:pet_adoption_app/models.dart';

class AdoptionImplementation {
  static final List<Adoption> _userAdoptions = [
    Adoption(
      petId: "persian_cat",
      adoptedTime: DateTime.now(),
    ),
    Adoption(
      petId: "persian_cat",
      adoptedTime: DateTime.now().subtract(
        const Duration(days: 12),
      ),
    ),
    Adoption(
      petId: "persian_cat",
      adoptedTime: DateTime.now().subtract(
        const Duration(days: 45),
      ),
    ),
    Adoption(
      petId: "persian_cat",
      adoptedTime: DateTime.now().subtract(
        const Duration(days: 68),
      ),
    ),
    Adoption(
      petId: "persian_cat",
      adoptedTime: DateTime.now().subtract(
        const Duration(days: 60),
      ),
    ),
  ];

  static List<Adoption> get userAdoptions => _userAdoptions;

  static List<Pet> getAdoptedPetsInMonth(DateTime month) {
    List<Adoption> adoptions = _userAdoptions
        .where((e) =>
            e.adoptedTime.month == month.month &&
            e.adoptedTime.year == month.year)
        .toList();
    List<Pet?> petsAdopted = adoptions.map((e) => Pet.fromId(e.petId)).toList();
    return petsAdopted.whereType<Pet>().toList();
  }

  static int getAdoptionCountFromMonth(DateTime month) {
    // print("month ==> $month");
    return _userAdoptions
        .where((e) =>
            e.adoptedTime.month == month.month &&
            e.adoptedTime.year == month.year)
        .length;
  }

  static bool isAdopted(String petId) =>
      _userAdoptions.firstWhereOrNull((element) => element.petId == petId) !=
      null;
}
