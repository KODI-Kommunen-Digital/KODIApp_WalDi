// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_favorites_detail_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FavoriteDetailsModel _$FavoriteDetailsModelFromJson(
        Map<String, dynamic> json) =>
    FavoriteDetailsModel(
      (json['id'] as num).toInt(),
      (json['userId'] as num).toInt(),
      json['title'] as String,
      json['place'] as String?,
      json['category'] as String?,
      json['description'] as String,
      json['media'] as String?,
      (json['categoryId'] as num?)?.toInt(),
      (json['subcategoryId'] as num?)?.toInt(),
      json['address'] as String,
      json['email'] as String?,
      json['phone'] as String?,
      json['website'] as String?,
      (json['price'] as num?)?.toInt(),
      (json['discountPrice'] as num?)?.toInt(),
      json['logo'] as String?,
      (json['statusId'] as num?)?.toInt(),
      (json['sourceId'] as num?)?.toInt(),
      (json['longitude'] as num?)?.toDouble(),
      (json['latitude'] as num?)?.toDouble(),
      (json['villageId'] as num?)?.toInt(),
      json['expiryDate'] as String?,
      json['startDate'] as String?,
      json['endDate'] as String?,
      json['createdAt'] as String,
      json['pdf'] as String?,
      (json['cityId'] as num?)?.toInt(),
    )..externalId = json['externalId'] as String?;

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
      'externalId': instance.externalId,
      'price': instance.price,
      'discountPrice': instance.discountPrice,
      'logo': instance.logo,
      'statusId': instance.statusId,
      'sourceId': instance.sourceId,
      'longitude': instance.longitude,
      'latitude': instance.latitude,
      'villageId': instance.villageId,
      'expiryDate': instance.expiryDate,
      'startDate': instance.startDate,
      'endDate': instance.endDate,
      'createdAt': instance.createdAt,
      'pdf': instance.pdf,
      'cityId': instance.cityId,
    };
