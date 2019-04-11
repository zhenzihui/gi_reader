import 'package:flutter/material.dart';
import 'package:gi_reader/model/Food.dart';
import 'package:gi_reader/tool/Utils.dart';

class FoodList extends StatefulWidget {
  @override
  State createState() {
    return FoodListState();
  }
}

class FoodListState extends State<FoodList> {
  Future<List<Category>> _getData() {
    final q = Utils.getFoodJson();
    return q.then(
        (json) => Food.fromJson(json).foods.map((f) => f.category).toList());
  }

  Widget _listItem(Item item) {
    return ListTile(title: Text(item.name), subtitle: Text("gi: ${item.gi}"));
  }

  Widget _foodList(BuildContext context, AsyncSnapshot snapshot) {
    List<Category> categories = snapshot.data;
    var _items = categories.expand((c) => c.items.map((item) => item)).toList();
    return new ListView.builder(
        padding: EdgeInsets.all(10),
        itemCount: _items.length,
        itemBuilder: (BuildContext _context, int i) {
          print("itemBuilderIndex: $i");
          if (i.isOdd) return new Divider();
          return _listItem(_items[i]);
        });
  }

  Widget _foodDataBuilder() {
    return FutureBuilder(
      future: _getData(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return Text("加载中。。。");
          default:
            print(snapshot.error);
            if (snapshot.hasError)
              return AlertDialog(
                title: Text("ERROR"),
                content: Text("${snapshot.error.toString()}"),
              );
            else
              return _foodList(context, snapshot);
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _getData().then((list) {
      print(list.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _foodDataBuilder(),
    );
  }
}
