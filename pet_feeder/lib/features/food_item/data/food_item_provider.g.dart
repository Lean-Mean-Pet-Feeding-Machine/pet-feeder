// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'food_item_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$foodItemDatabaseHash() => r'897c8363aa9aa6f342a91bfdd3d56f1354490bbe';

/// See also [foodItemDatabase].
@ProviderFor(foodItemDatabase)
final foodItemDatabaseProvider = AutoDisposeProvider<FoodItemDatabase>.internal(
  foodItemDatabase,
  name: r'foodItemDatabaseProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$foodItemDatabaseHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef FoodItemDatabaseRef = AutoDisposeProviderRef<FoodItemDatabase>;
String _$foodItemsHash() => r'429fcaec7fa0da5ae1d32dde89ae551da512fe69';

/// See also [foodItems].
@ProviderFor(foodItems)
final foodItemsProvider = AutoDisposeStreamProvider<List<FoodItem>>.internal(
  foodItems,
  name: r'foodItemsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$foodItemsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef FoodItemsRef = AutoDisposeStreamProviderRef<List<FoodItem>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
