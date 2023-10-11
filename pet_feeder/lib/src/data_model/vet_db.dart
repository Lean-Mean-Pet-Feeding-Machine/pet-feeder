/// The data associated with veterinarians.
class VetData {
  VetData({
    required this.id,
    required this.userName,
    required this.vetID,
  });

  String id;
  String userName;
  String vetID;
}

/// Provides access to and operations on veterinary data.
class VetDB {
  final List<VetData> _vets = [
    VetData(
      id: 'vet-001',
      userName: '@animaldoc',
      vetID: 'V601',
    ),
    VetData(
      id: 'vet-002',
      userName: '@catvet',
      vetID: 'V501',
    ),
    VetData(
      id: 'vet-003',
      userName: '@dogvet',
      vetID: 'V401',
    ),
    // Add more vet data as needed
  ];

  VetData getVet(String vetID) {
    return _vets.firstWhere((vetData) => vetData.vetID == vetID);
  }

  VetData getVetByUsername(String userName) {
    return _vets.firstWhere((vetData) => vetData.userName == userName);
  }
}

VetDB vetDB = VetDB();
