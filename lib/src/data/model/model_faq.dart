class FaqModel {
  final int id;
  final String title;
  final String link;
  final bool? isPdf;

  FaqModel({
    required this.id,
    required this.title,
    required this.link,
    required this.isPdf,
  });

  factory FaqModel.fromJson(Map<String, dynamic> json) {
    return FaqModel(
      id: json['id'],
      title: json['title'],
      link: json['link'],
      isPdf: json['isPdf'],
    );
  }
}
