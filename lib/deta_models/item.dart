import 'package:flutter/material.dart';

class Item {
  final String itemId;
  final String ownerId;
  final String itemName;
  final String itemUrl;
  final int price;

//<editor-fold desc="Data Methods">

  const Item({
    required this.itemId,
    required this.ownerId,
    required this.itemName,
    required this.itemUrl,
    required this.price,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Item &&
          runtimeType == other.runtimeType &&
          itemId == other.itemId &&
          ownerId == other.ownerId &&
          itemName == other.itemName &&
          itemUrl == other.itemUrl &&
          price == other.price);

  @override
  int get hashCode =>
      itemId.hashCode ^
      ownerId.hashCode ^
      itemName.hashCode ^
      itemUrl.hashCode ^
      price.hashCode;

  @override
  String toString() {
    return 'Item{' +
        ' itemId: $itemId,' +
        ' ownerId: $ownerId,' +
        ' itemName: $itemName,' +
        ' itemUrl: $itemUrl,' +
        ' price: $price,' +
        '}';
  }

  Item copyWith({
    String? itemId,
    String? ownerId,
    String? itemName,
    String? itemUrl,
    int? price,
  }) {
    return Item(
      itemId: itemId ?? this.itemId,
      ownerId: ownerId ?? this.ownerId,
      itemName: itemName ?? this.itemName,
      itemUrl: itemUrl ?? this.itemUrl,
      price: price ?? this.price,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'itemId': this.itemId,
      'ownerId': this.ownerId,
      'itemName': this.itemName,
      'itemUrl': this.itemUrl,
      'price': this.price,
    };
  }

  factory Item.fromMap(Map<String, dynamic> map) {
    return Item(
      itemId: map['itemId'] as String,
      ownerId: map['ownerId'] as String,
      itemName: map['itemName'] as String,
      itemUrl: map['itemUrl'] as String,
      price: map['price'] as int,
    );
  }

//</editor-fold>
}