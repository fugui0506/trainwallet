class WebViewArgumentsModel {
  WebViewArgumentsModel({
    this.title,
    this.url,
  });
  String? title;
  String? url;

  factory WebViewArgumentsModel.fromJson(Map<String, dynamic> json) => WebViewArgumentsModel(
    title: json["title"],
    url: json["url"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "url": url,
  };
}
