
class Food {
  List<Foods> foods;

  Food({this.foods});

  Food.fromJson(Map<String, dynamic> json) {
    if (json['foods'] != null) {
      foods = new List<Foods>();
      json['foods'].forEach((v) {
        foods.add(new Foods.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.foods != null) {
      data['foods'] = this.foods.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Foods {
  Category category;

  Foods({this.category});

  Foods.fromJson(Map<String, dynamic> json) {
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.category != null) {
      data['category'] = this.category.toJson();
    }
    return data;
  }
}

class Category {
  String name;
  int id;
  List<Item> items;

  Category({this.name, this.items, this.id});

  Category.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    if (json['items'] != null) {
      items = new List<Item>();
      json['items'].forEach((v) {
        items.add(new Item.fromJson(v));
      });
      id = json['id'];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    if (this.items != null) {
      data['items'] = this.items.map((v) => v.toJson()).toList();
    }
    data['id'] = this.id;
    return data;
  }
}

class Item {
  String name;
  int gi;
  int id;

  Item({this.name, this.gi, this.id});

  Item.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    gi = json['gi'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['gi'] = this.gi;
    data['id'] = this.id;
    return data;
  }
}