import 'package:heidi/src/data/model/model.dart';

class PrivacyPageModel {
  final String banner;
  final String whoWeAre;
  final List<String> whatWeDo;
  final List<UserModel> team;

  PrivacyPageModel(
    this.banner,
    this.whoWeAre,
    this.whatWeDo,
    this.team,
  );

  factory PrivacyPageModel.fromJson(Map<String, dynamic> json) {
    final Iterable refactorTeam = json['team'] ?? [];

    final listTeam = refactorTeam.map((item) {
      return UserModel.fromJson(item);
    }).toList();

    return PrivacyPageModel(
      json['banner'] ?? 'Unknown',
      json['who_we_are'] ?? 'Unknown',
      json['what_we_do'].cast<String>() ?? [],
      listTeam,
    );
  }
}
