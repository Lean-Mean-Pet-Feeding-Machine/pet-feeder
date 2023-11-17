// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pet_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$petDatabaseHash() => r'56e142480e3a2a237d96845b006adab5ed00e97c';

/// See also [petDatabase].
@ProviderFor(petDatabase)
final petDatabaseProvider = AutoDisposeProvider<PetDatabase>.internal(
  petDatabase,
  name: r'petDatabaseProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$petDatabaseHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef PetDatabaseRef = AutoDisposeProviderRef<PetDatabase>;
String _$petsHash() => r'1ed129b6990fa168f681d968056074ed20d7255a';

/// See also [pets].
@ProviderFor(pets)
final petsProvider = AutoDisposeStreamProvider<List<Pet>>.internal(
  pets,
  name: r'petsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$petsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef PetsRef = AutoDisposeStreamProviderRef<List<Pet>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
