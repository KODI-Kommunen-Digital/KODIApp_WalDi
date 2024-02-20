import 'package:json_annotation/json_annotation.dart';

part 'model_favorites_detail_list.g.dart';

@JsonSerializable(explicitToJson: true)
class FavoriteDetailsModel {
  final int id;
  final int userId;
  final String title;
  String? category;
  String? place;
  final String description;
  String? media;
  int? categoryId;
  int? subcategoryId;
  String address;
  String? email;
  String? phone;
  String? website;
  String? externalId;
  int? price;
  int? discountPrice;
  String? logo;
  int? statusId;
  int? sourceId;
  double? longitude;
  double? latitude;
  int? villageId;
  String? expiryDate;
  String? startDate;
  String? endDate;
  String createdAt;
  String? pdf;
  int? cityId;

  FavoriteDetailsModel(
      this.id,
      this.userId,
      this.title,
      this.place,
      this.category,
      this.description,
      this.media,
      this.categoryId,
      this.subcategoryId,
      this.address,
      this.email,
      this.phone,
      this.website,
      this.price,
      this.discountPrice,
      this.logo,
      this.statusId,
      this.sourceId,
      this.longitude,
      this.latitude,
      this.villageId,
      this.expiryDate,
      this.startDate,
      this.endDate,
      this.createdAt,
      this.pdf,
      this.cityId);

  factory FavoriteDetailsModel.fromJson(Map<String, dynamic> json) =>
      _$FavoriteDetailsModelFromJson(json);

  Map<String, dynamic> toJson() => _$FavoriteDetailsModelToJson(this);
}
