class Owner {
  final String ownerId;
  final String shopName;
  final String longitude;
  final String latitude;
  final String imageUrl;
  final String shopBio;

//<editor-fold desc="Data Methods">

  const Owner({
    required this.ownerId,
    required this.shopName,
    required this.longitude,
    required this.latitude,
    required this.imageUrl,
    required this.shopBio,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Owner &&
          runtimeType == other.runtimeType &&
          ownerId == other.ownerId &&
          shopName == other.shopName &&
          longitude == other.longitude &&
          latitude == other.latitude &&
          imageUrl == other.imageUrl &&
          shopBio == other.shopBio);

  @override
  int get hashCode =>
      ownerId.hashCode ^
      shopName.hashCode ^
      longitude.hashCode ^
      latitude.hashCode ^
      imageUrl.hashCode ^
      shopBio.hashCode;

  @override
  String toString() {
    return 'Owner{' +
        ' ownerId: $ownerId,' +
        ' shopName: $shopName,' +
        ' longitude: $longitude,' +
        ' latitude: $latitude,' +
        ' imageUrl: $imageUrl,' +
        ' shopBio: $shopBio,' +
        '}';
  }

  Owner copyWith({
    String? ownerId,
    String? shopName,
    String? longitude,
    String? latitude,
    String? imageUrl,
    String? shopBio,
  }) {
    return Owner(
      ownerId: ownerId ?? this.ownerId,
      shopName: shopName ?? this.shopName,
      longitude: longitude ?? this.longitude,
      latitude: latitude ?? this.latitude,
      imageUrl: imageUrl ?? this.imageUrl,
      shopBio: shopBio ?? this.shopBio,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'ownerId': this.ownerId,
      'shopName': this.shopName,
      'longitude': this.longitude,
      'latitude': this.latitude,
      'imageUrl': this.imageUrl,
      'shopBio': this.shopBio,
    };
  }

  factory Owner.fromMap(Map<String, dynamic> map) {
    return Owner(
      ownerId: map['ownerId'] as String,
      shopName: map['shopName'] as String,
      longitude: map['longitude'] as String,
      latitude: map['latitude'] as String,
      imageUrl: map['imageUrl'] as String,
      shopBio: map['shopBio'] as String,
    );
  }

//</editor-fold>
}