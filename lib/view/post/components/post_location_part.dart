import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pesostagram/deta_models/location.dart';
import 'package:pesostagram/style.dart';
import 'package:pesostagram/view/post/screens/map_screen.dart';
import 'package:pesostagram/view_models/post_view_model.dart';
import 'package:provider/src/provider.dart';

class PostLocationPart extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final postViewModel = context.watch<PostViewModel>();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        title: Text(
          postViewModel.locationString,
          style: postLocationTextStyle,
        ),
        subtitle: _latLngPart(postViewModel.location, context),
        trailing: IconButton(
          icon: FaIcon(FontAwesomeIcons.mapMarkerAlt),
          // TODO mapButton
          onPressed: () => openMapScreen(context, postViewModel.location),
        ),
      ),
    );
  }

  _latLngPart(Location? location, BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Chip(
            label: Text("緯度")
        ),
        SizedBox(width: 8.0,),
        Text((location != null) ? location.latitude.toStringAsFixed(2) : "0.00"),
        Chip(
            label: Text("経度")
        ),
        SizedBox(width: 8.0,),
        Text((location != null) ? location.longitude.toStringAsFixed(2) : "0.00"),
      ],
    );
  }

  openMapScreen(BuildContext context, Location? location) {

    if (location == null) return;

    Navigator.push(context, MaterialPageRoute(
        builder: (_) => MapScreen(
            location: location)
    )
    );
  }
}
