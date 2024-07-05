// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_list_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieListEntity _$MovieListEntityFromJson(Map<String, dynamic> json) =>
    MovieListEntity(
      (json['page'] as num).toInt(),
      (json['results'] as List<dynamic>)
          .map((e) => Results.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['total_pages'] as num).toInt(),
      (json['total_results'] as num).toInt(),
    );

Map<String, dynamic> _$MovieListEntityToJson(MovieListEntity instance) =>
    <String, dynamic>{
      'page': instance.page,
      'results': instance.results,
      'total_pages': instance.totalPages,
      'total_results': instance.totalResults,
    };

Results _$ResultsFromJson(Map<String, dynamic> json) => Results(
      json['adult'] as bool,
      (json['genre_ids'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
      (json['id'] as num).toInt(),
      json['original_language']??"" as String,
      json['original_title']??"" as String,
      json['overview']??"" as String,
      (json['popularity'] as num).toDouble(),
      json['poster_path']??"" as String,
      json['release_date']??"" as String,
      json['title']??"" as String,
      json['video'] as bool,
      (json['vote_average'] as num).toInt(),
      (json['vote_count'] as num).toInt(),
    );

Map<String, dynamic> _$ResultsToJson(Results instance) => <String, dynamic>{
      'adult': instance.adult,
      'genre_ids': instance.genreIds,
      'id': instance.id,
      'original_language': instance.originalLanguage,
      'original_title': instance.originalTitle,
      'overview': instance.overview,
      'popularity': instance.popularity,
      'poster_path': instance.posterPath,
      'release_date': instance.releaseDate,
      'title': instance.title,
      'video': instance.video,
      'vote_average': instance.voteAverage,
      'vote_count': instance.voteCount,
    };
