import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pet_feeder/features/pet/domain/pet.dart';
import '../../../repositories/firestore/firestore_path.dart';
import '../../../repositories/firestore/firestore_service.dart';

/// Provides access to the Firestore database storing [Pet] documents.
class PetDatabase {
  PetDatabase(this.ref);

  final ProviderRef<PetDatabase> ref;

  final _service = FirestoreService.instance;

  Stream<List<Pet>> watchPets() => _service.watchCollection(
      path: FirestorePath.pets(),
      builder: (data, documentId) => Pet.fromJson(data!));

  Stream<Pet> watchPetData(String petId) => _service.watchDocument(
      path: FirestorePath.pet(petId),
      builder: (data, documentId) => Pet.fromJson(data!));

  Future<List<Pet>> fetchPetDatas() => _service.fetchCollection(
      path: FirestorePath.pets(),
      builder: (data, documentId) => Pet.fromJson(data!));

  Future<Pet> fetchPetData(String petId) => _service.fetchDocument(
      path: FirestorePath.pet(petId),
      builder: (data, documentId) => Pet.fromJson(data!));

  Future<void> setPetData(Pet pet) => _service.setData(
      path: FirestorePath.pet(pet.id), data: pet.toJson());

  Future<void> setPetDataDelayed(Pet pet) => Future.delayed(
      const Duration(milliseconds: 2000),
      () => _service.setData(
          path: FirestorePath.pet(pet.id), data: pet.toJson()));

  Future<void> setPetDataError(Pet pet) =>
      Future.delayed(const Duration(milliseconds: 2000), () => throw Error());

  Future<void> deletePetData(Pet pet) =>
      _service.deleteData(path: FirestorePath.pet(pet.id));
}