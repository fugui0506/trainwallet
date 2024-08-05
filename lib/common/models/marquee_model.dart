import '../common.dart';

class MarqueeListModel {
  List<MarqueeModel> list;

  MarqueeListModel({required this.list});

  factory MarqueeListModel.fromJson(List<dynamic> json) =>  MarqueeListModel(
    list: json.map((i) => MarqueeModel.fromJson(i)).toList()
  );

  factory MarqueeListModel.empty() {
    return MarqueeListModel(list: []);
  }

  Map<String, dynamic> toJson() => {
    "list": list.map((i) => i.toJson()).toList(),
  };

  Future<void> update() async {
    await DioService.to.post<MarqueeListModel>(ApiPath.me.getMarquee,
      onSuccess: (code, msg, results) async {
        list = results.list;
      },
      onModel: (m) => MarqueeListModel.fromJson(m),
    );
  }
}

class MarqueeModel {
  int id;
  int createdAt;
  int updatedAt;
  String createdTime;
  String updatedTime;
  int deletedAt;
  String content;
  int sort;
  int status;

  MarqueeModel({
      required this.id,
      required this.createdAt,
      required this.updatedAt,
      required this.createdTime,
      required this.updatedTime,
      required this.deletedAt,
      required this.content,
      required this.sort,
      required this.status,
  });

  factory MarqueeModel.fromJson(Map<String, dynamic> json) => MarqueeModel(
      id: json["ID"],
      createdAt: json["createdAt"],
      updatedAt: json["updatedAt"],
      createdTime: json["createdTime"],
      updatedTime: json["updatedTime"],
      deletedAt: json["deletedAt"],
      content: json["Content"],
      sort: json["sort"],
      status: json["status"],
  );

  factory MarqueeModel.empty() => MarqueeModel(
      id: -1,
      createdAt: -1,
      updatedAt: -1,
      createdTime: '',
      updatedTime: '',
      deletedAt: -1,
      content: '',
      sort: -1,
      status: -1,
  );

  Map<String, dynamic> toJson() => {
      "ID": id,
      "createdAt": createdAt,
      "updatedAt": updatedAt,
      "createdTime": createdTime,
      "updatedTime": updatedTime,
      "deletedAt": deletedAt,
      "Content": content,
      "sort": sort,
      "status": status,
  };
}