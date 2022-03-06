import 'package:flutter/material.dart';

import '../../../deta_models/item.dart';
import '../../feed/components/sub/image_from_url.dart';

class MapPostsGridPart extends StatelessWidget {
  final List<Item> itemList;

  const MapPostsGridPart({required this.itemList});

  @override
  Widget build(BuildContext context) {
    return SliverGrid.count(
      crossAxisCount: 2,
      //リストが必要
      children: itemList.isEmpty
          ? [Container()]
          : List.generate(  //リストを生成してくれる。foreachはリストから取り出して処理
        itemList.length,
            (int index) => Card(
              margin: EdgeInsets.zero,

              child: Column(
                children: [
                  Expanded(
                    flex: 2,
                    child: ImageFromUrl(
                      imageUrl: itemList[index].itemUrl,
                    ),
                  ),

                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 40.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 8.0),
                          //名前
                          Text(itemList[index].itemName),
                          //値段 ハート
                          Row(
                            children: [
                              Text("¥${itemList[index].price.toString()}"),
                              SizedBox(width: 60),
                              Icon(Icons.favorite),
                            ],
                          )
                        ],
                      ),
                    )
                  )
                ],
              ),
            ) //Card

          //
      ),
    );
  }
}
