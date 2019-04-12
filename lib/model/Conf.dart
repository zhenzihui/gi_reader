
class Conf {
  String url;
  String giData;
  String localData;
  String imageUrl;

  Conf({this.url, this.giData});

  Conf.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    giData = json['gi_data'];
    localData = json['localData'];
    imageUrl = json['imageUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['gi_data'] = this.giData;
    data['localData'] = this.localData;
    data['imageUrl'] = this.imageUrl;
    return data;
  }
}