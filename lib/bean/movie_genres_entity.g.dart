// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_genres_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieGenresEntity _$MovieGenresEntityFromJson(Map<String, dynamic> json) =>
    MovieGenresEntity(
      (json['genres'] as List<dynamic>)
          .map((e) => Genres.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MovieGenresEntityToJson(MovieGenresEntity instance) =>
    <String, dynamic>{
      'genres': instance.genres,
    };

Genres _$GenresFromJson(Map<String, dynamic> json) => Genres(
      (json['id'] as num).toInt(),
      json['name'] as String,
    );

Map<String, dynamic> _$GenresToJson(Genres instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };
