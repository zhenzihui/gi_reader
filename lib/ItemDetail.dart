import 'package:flutter/material.dart';
import 'model/Food.dart';
import 'package:gi_reader/tool/Utils.dart';

class ItemDetail extends StatelessWidget {
  final Item _item;

  ItemDetail(this._item);

  Future<Widget> _buildBody() {
   return Utils.getImageUrl().map((urls) {
         Center(
        child: Image.network(imagesUrls.removeLast()),
    );
    });

  }

  FutureBuilder _buildBody()



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_item.name),
      ),
      body:,
    );
  }
}