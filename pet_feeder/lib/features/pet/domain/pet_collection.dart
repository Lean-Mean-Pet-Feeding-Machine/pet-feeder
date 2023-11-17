import 'pet.dart';

/// Encapsulates operations on the list of [Pet] returned from Firestore.
class PetCollection {
  PetCollection(pets) : _pets = pets;

  final List<Pet> _pets;

  int size() {
    return _pets.length;
  }

  Pet getPet(String petID) {
    return _pets.firstWhere((data) => data.id == petID);
  }

  List<Pet> getPets() {
    return _pets;
  }

  List<String> getPetIDs() {
    return _pets.map((data) => data.id).toList();
  }

  List<String> getPetNames() {
    return _pets.map((pet) => pet.name).toList();
  }

  String getPetIDFromName(String name) {
    return _pets.firstWhere((pet) => pet.name == name).id;
  }
}
