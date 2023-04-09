import 'package:collection/collection.dart';
import 'package:pet_adoption_app/implementations/repository.dart';

import 'package:pet_adoption_app/models.dart';

class AdoptionImplementation {
  static Repository adoptionRepository = Repository();

  //
  static List<Adoption> _userAdoptions = [];
  static List<Adoption> get userAdoptions => _userAdoptions;

  static Future<void> fetchData() async =>
      _userAdoptions = await adoptionRepository.getData();

  static Future<void> updateData() async =>
      adoptionRepository.saveData(_userAdoptions);

  static void addData(Adoption adoption) {
    _userAdoptions.add(adoption);
    updateData();
  }

  static void clearData() {
    _userAdoptions.clear();
    updateData();
  }

  //
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
