import 'package:flutter/material.dart';
import 'FoodList.dart';
import 'model/Food.dart';

void main() => runApp(GiReaderApp());

class GiReaderApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '食物GI查询器',
      theme: ThemeData(
        primarySwatch: Colors.cyan,
      ),
      home: GIListPage(title: '食物GI查询器'),
    );
  }
}

class GIListPage extends StatefulWidget {
  GIListPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _GIListPageState createState() => _GIListPageState();
}

class _GIListPageState extends State<GIListPage> {

  List<Widget> _appActions() {
    return [Icon(Icons.search, semanticLabel: "search")];
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("GI查询"),
        actions: _appActions(),
      ),
      body: FoodList(),
    );
  }
}
