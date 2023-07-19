// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_favorite.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FavoriteModel _$FavoriteModelFromJson(Map<String, dynamic> json) =>
    FavoriteModel(
      json['favoriteId'] as int,
      json['userId'] as int,
      json['cityId'] as int,
      json['listingsId'] as int,
    );

Map<String, dynamic> _$FavoriteModelToJson(FavoriteModel instance) =>
    <String, dynamic>{
      'favoriteId': instance.favoriteId,
      'userId': instance.userId,
      'cityId': instance.cityId,
      'listingsId': instance.listingsId,
    };
