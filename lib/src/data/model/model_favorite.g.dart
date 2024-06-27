// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_favorite.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FavoriteModel _$FavoriteModelFromJson(Map<String, dynamic> json) =>
    FavoriteModel(
      (json['favoriteId'] as num).toInt(),
      (json['userId'] as num).toInt(),
      (json['cityId'] as num).toInt(),
      (json['listingsId'] as num).toInt(),
    );

Map<String, dynamic> _$FavoriteModelToJson(FavoriteModel instance) =>
    <String, dynamic>{
      'favoriteId': instance.favoriteId,
      'userId': instance.userId,
      'cityId': instance.cityId,
      'listingsId': instance.listingsId,
    };
