import 'package:flutter_test/flutter_test.dart';
import 'package:pet_adoption_app/implementations/repository.dart';
import 'package:pet_adoption_app/models.dart';

void main() {
  test("getData() should return an instance of list of adoptions on success",
      () async {
    Repository repo = Repository();
    final result = await repo.getData();
    expect(result, isInstanceOf<List<Adoption>>());
  });
}
