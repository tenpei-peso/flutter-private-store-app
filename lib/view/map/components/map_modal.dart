import 'package:flutter/material.dart';
import 'package:pesostagram/deta_models/owner.dart';
import 'package:pesostagram/view/map/sub/map_modal_detail_page.dart';
import 'package:pesostagram/view/map/sub/map_posts_grid_part.dart';
import 'package:pesostagram/view_models/map_view_model.dart';
import 'package:provider/provider.dart';

class MapModal extends StatelessWidget {
  final Owner markerOwner;

  const MapModal({required this.markerOwner});

  @override
  Widget build(BuildContext context) {
    final mapViewModel = context.read<MapViewModel>();
    //futureBuilderでピンのオーナーIDから一致する投稿持ってきてgridに渡す
    Future(() => mapViewModel.getItemByOwnerId(markerOwner.ownerId),);
    var item = mapViewModel.items;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios_new, color: Colors.black54,),
              onPressed: () => Navigator.pop(context)
            ),
            pinned: true,
            floating: true,
            backgroundColor: Colors.white30,
            expandedHeight: 250.0,
            flexibleSpace: FlexibleSpaceBar(
              background: MapModalDetailPage(markerOwner: markerOwner,)
            ),
          ),
          mapViewModel.isProcessing
          ? CircularProgressIndicator()
          : MapPostsGridPart(itemList: item)
        ],
      ),
    );

}}