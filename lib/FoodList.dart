import 'package:flutter/material.dart';
import 'package:gi_reader/model/Food.dart';
import 'package:gi_reader/tool/Utils.dart';
import 'package:gi_reader/ItemDetail.dart';
class FoodList extends StatefulWidget {
  @override
  State createState() {
    return FoodListState();
  }
}

class FoodListState extends State<FoodList> {
  int _categoryId = 1;
  int _currentIndex = 0;

  FoodListState();

  Future<List<Category>> _getData() {
    final q = Utils.getFoodJson();
    return q.then(
        (json) => Food.fromJson(json).foods.map((f) => f.category).toList());
  }

  Widget _listItem(Item item) {
    return ListTile(
        title: Text(item.name),
        subtitle: Text("gi: ${item.gi}"),
        onTap: () => onTapItem(item),
    );
  }

  void onTapItem(Item item) {
    Navigator.push(context, new MaterialPageRoute(builder: (context) => ItemDetail(item)));
  }

  Widget _foodList(BuildContext context, AsyncSnapshot snapshot) {
    List<Category> categories = snapshot.data;
    print("categoryId: $_categoryId");
    var _items = categories
        .where((category) => category.id == _categoryId)
        .expand((c) => c.items.map((item) => item))
        .toList();
    return new ListView.builder(
        padding: EdgeInsets.all(10),
        itemCount: _items.length,
        itemBuilder: (BuildContext _context, int i) {
          print("itemBuilderIndex: $i");
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
            return AlertDialog(content: Text("加载中。。。"));
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

  // 底部

  Widget _buildNavigationBar() {
    return FutureBuilder(
      future: _bottomNavigationItems(),
      builder: (BuildContext _context, AsyncSnapshot snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return Text("没有数据");
          case ConnectionState.waiting:
            return Text("加载中。。。");
          default:
            if (snapshot.hasError) {
              return Text("Errors: ${snapshot.error.toString()}");
            } else {
              return _bottomNavigationBar(_context, snapshot);
            }
        }
      },
    );
  }

  void _onTapItems(int index) {
    setState(() {
      _categoryId = index + 1;
      _currentIndex = index;
    });
  }

  Widget _bottomNavigationBar(BuildContext _context,
      AsyncSnapshot<List<BottomNavigationBarItem>> snapshot) {
    return BottomNavigationBar(
      items: snapshot.data,
      type: BottomNavigationBarType.fixed,
      currentIndex: _currentIndex,
      onTap: (int index) => _onTapItems(index),
      fixedColor: Colors.cyanAccent,
    );
  }

  Future<List<BottomNavigationBarItem>> _bottomNavigationItems() async {
    List<Category> categories = await FoodListState()._getData();
    return categories.map((category) {
      return BottomNavigationBarItem(
          icon: Icon(Icons.local_dining),
          activeIcon: Icon(Icons.check_circle, color: Colors.cyan),
          title: Text(category.name));
    }).toList();
  }

  void onRefresh() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: RefreshIndicator(
            child: _foodDataBuilder(),
            onRefresh: () => Future.sync(() => setState(() => {}))),
      ),
      bottomNavigationBar: _buildNavigationBar(),
    );
  }
}
