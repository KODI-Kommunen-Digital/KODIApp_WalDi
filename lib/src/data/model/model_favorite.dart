import 'package:json_annotation/json_annotation.dart';

part 'model_favorite.g.dart';

@JsonSerializable(explicitToJson: true)
class FavoriteModel {
  final int favoriteId;
  final int userId;
  final int cityId;
  final int listingsId;

  FavoriteModel(
    this.favoriteId,
    this.userId,
    this.cityId,
    this.listingsId,
  );

  factory FavoriteModel.fromJson(Map<String, dynamic> json) =>
      _$FavoriteModelFromJson(json);

  Map<String, dynamic> toJson() => _$FavoriteModelToJson(this);
}
