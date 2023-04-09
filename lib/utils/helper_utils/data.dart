part of '../../models.dart';

List<Category> _categories = [
  Category(
    id: "all",
    name: "All",
    image: "${ImagePaths.categories}/all.png",
    backgroundColor: Colors.white,
  ),
  Category(
    id: "cats",
    name: "Cats",
    image: "${ImagePaths.categories}/cats.png",
    backgroundColor: Colors.blueGrey,
  ),
  Category(
    id: "dogs",
    name: "Dogs",
    image: "${ImagePaths.categories}/dogs.png",
    backgroundColor: Colors.brown,
  ),
  Category(
    id: "bunnies",
    name: "Bunnies",
    image: "${ImagePaths.categories}/bunnies.png",
    backgroundColor: Colors.indigo,
  ),
  Category(
    id: "parrots",
    name: "Parrots",
    image: "${ImagePaths.categories}/parrots.png",
    backgroundColor: Colors.teal,
  ),
];

List<Pet> _pets = [
  // Cats
  Pet(
    name: 'Persian Cat',
    id: 'persian_cat',
    images: [
      'https://i.imgur.com/aEilpoJ.png',
      'https://i.imgur.com/kC37kdZ.png',
      'https://i.imgur.com/znjbde2.png',
    ],
    age: '2 years 5 months',
    price: 7999,
    categoryId: "cats",
  ),
  Pet(
    name: 'British Short Hair',
    id: 'british_short_hair',
    images: [
      'https://i.imgur.com/I3Orfum.png',
      'https://i.imgur.com/L2L7R5X.png',
      'https://i.imgur.com/kz5MCWQ.png',
    ],
    age: '1 year 8 months',
    price: 4999,
    categoryId: "cats",
  ),
  Pet(
    name: 'Bengal Cat',
    id: 'bengal_cat',
    images: [
      'https://i.imgur.com/G4Z3Oc9.png',
      'https://i.imgur.com/kLQBP7N.png',
      'https://i.imgur.com/TyDig0o.png',
    ],
    age: '1 year 2 months',
    price: 8499,
    categoryId: "cats",
  ),

  // Dogs
  Pet(
    name: 'Siberian Husky',
    id: 'siberian_husky',
    images: [
      'https://i.imgur.com/icz8Kur.png',
      'https://i.imgur.com/q69vzer.png',
      'https://i.imgur.com/w84wCJJ.png',
    ],
    age: '2 years 5 months',
    price: 7999,
    categoryId: "dogs",
  ),
  Pet(
    name: 'Bulldog',
    id: 'bulldog',
    images: [
      'https://i.imgur.com/JyxVwFD.png',
      'https://i.imgur.com/tFVVwYa.png',
      'https://i.imgur.com/C6jfXG4.png',
    ],
    age: '1 year 8 months',
    price: 4999,
    categoryId: "dogs",
  ),
  Pet(
    name: 'Poodle',
    id: 'poodle',
    images: [
      'https://i.imgur.com/eizEEfN.png',
      'https://i.imgur.com/YprnT4a.png',
      'https://i.imgur.com/0JbXUuA.png',
    ],
    age: '8 months',
    price: 8499,
    categoryId: "dogs",
  ),

  // Dogs
  Pet(
    name: 'Dutch Rabbit',
    id: 'dutch_rabbit',
    images: [
      'https://i.imgur.com/PZkHTPw.png',
      'https://i.imgur.com/KcXjfKI.png',
      'https://i.imgur.com/3ZomaDD.png',
    ],
    age: '2 months',
    price: 799,
    categoryId: "bunnies",
  ),
  Pet(
    name: 'Holland Lop',
    id: 'holan_lop',
    images: [
      'https://i.imgur.com/TFSPUqe.png',
      'https://i.imgur.com/MZ51emt.png',
      'https://i.imgur.com/HI4WyAU.png',
    ],
    age: '35 days',
    price: 649,
    categoryId: "bunnies",
  ),

  // Parrot
  Pet(
    name: 'Parakeet',
    id: 'parakeet',
    images: [
      'https://i.imgur.com/N0PzGLD.png',
      'https://i.imgur.com/y8ME2cQ.png',
      'https://i.imgur.com/btuprrX.png',
    ],
    age: '1 month',
    price: 1299,
    categoryId: "parrots",
  ),
];

// Timelines

final List<TimelineEvent> _timelines = getMonthsBetween(
  startDate: lastYear(),
  endDate: currentMonth(),
).map((e) => TimelineEvent(e, e.dayMonthAndYear)).toList();
