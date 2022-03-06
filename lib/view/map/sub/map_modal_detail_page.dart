import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../deta_models/owner.dart';
import '../../../style.dart';

class MapModalDetailPage extends StatelessWidget {
  final Owner markerOwner;

  const MapModalDetailPage({required this.markerOwner});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //トップ画像
        Container(
          height: 150,
          width: double.infinity,
          child: CachedNetworkImage(
            imageUrl: markerOwner.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        //お店名前
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(markerOwner.shopName, style: profileRecodeScoreTextStyle,),
        ),
        //お店情報
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(markerOwner.shopBio, style: commentContentStyle,),
        )
      ],
    );
  }
}
