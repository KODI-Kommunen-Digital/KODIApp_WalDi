// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_favorites_detail_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FavoriteDetailsModel _$FavoriteDetailsModelFromJson(
        Map<String, dynamic> json) =>
    FavoriteDetailsModel(
      json['id'] as int,
      json['userId'] as int,
      json['title'] as String,
      json['place'] as String?,
      json['category'] as String?,
      json['description'] as String,
      json['media'] as String?,
      json['categoryId'] as int?,
      json['subcategoryId'] as int?,
      json['address'] as String,
      json['email'] as String?,
      json['phone'] as String?,
      json['website'] as String?,
      json['price'] as int?,
      json['discountPrice'] as int?,
      json['logo'] as String?,
      json['statusId'] as int?,
      json['sourceId'] as int?,
      (json['longitude'] as num?)?.toDouble(),
      (json['latitude'] as num?)?.toDouble(),
      json['villageId'] as int?,
      json['startDate'] as String,
      json['endDate'] as String,
      json['createdAt'] as String,
    );

Map<String, dynamic> _$FavoriteDetailsModelToJson(
        FavoriteDetailsModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'title': instance.title,
      'category': instance.category,
      'place': instance.place,
      'description': instance.description,
      'media': instance.media,
      'categoryId': instance.categoryId,
      'subcategoryId': instance.subcategoryId,
      'address': instance.address,
      'email': instance.email,
      'phone': instance.phone,
      'website': instance.website,
      'price': instance.price,
      'discountPrice': instance.discountPrice,
      'logo': instance.logo,
      'statusId': instance.statusId,
      'sourceId': instance.sourceId,
      'longitude': instance.longitude,
      'latitude': instance.latitude,
      'villageId': instance.villageId,
      'startDate': instance.startDate,
      'endDate': instance.endDate,
      'createdAt': instance.createdAt,
    };
