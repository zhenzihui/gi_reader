
class Conf {
  String url;
  String giData;

  Conf({this.url, this.giData});

  Conf.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    giData = json['gi_data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['gi_data'] = this.giData;
    return data;
  }
}