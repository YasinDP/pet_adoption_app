import 'package:flutter_test/flutter_test.dart';
import 'package:pet_adoption_app/models.dart';

void main() {
  group("Filter pets by category id", () {
    test("Filter pets by Category 'dogs' should return exactly 3 items", () {
      // Arrange
      String dogsCategoryId = "dogs";
      // Act
      List<Pet> pets = Pet.byCategory(dogsCategoryId);
      // Assert
      expect(pets.length, 3);
    });

    test("Filter pets by Category 'parrots' should return exactly 1 item", () {
      // Arrange
      String dogsCategoryId = "parrots";
      // Act
      List<Pet> pets = Pet.byCategory(dogsCategoryId);
      // Assert
      expect(pets.length, 1);
    });
  });
}
