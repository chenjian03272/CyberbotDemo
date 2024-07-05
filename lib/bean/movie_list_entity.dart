import 'dart:ffi';

import 'package:json_annotation/json_annotation.dart';

part 'movie_list_entity.g.dart';


@JsonSerializable()
class MovieListEntity extends Object {

  @JsonKey(name: 'page')
  int page;

  @JsonKey(name: 'results')
  List<Results> results;

  @JsonKey(name: 'total_pages')
  int totalPages;

  @JsonKey(name: 'total_results')
  int totalResults;

  MovieListEntity(this.page,this.results,this.totalPages,this.totalResults,);

  factory MovieListEntity.fromJson(Map<String, dynamic> srcJson) => _$MovieListEntityFromJson(srcJson);

  Map<String, dynamic> toJson() => _$MovieListEntityToJson(this);

}


@JsonSerializable()
class Results extends Object {

  @JsonKey(name: 'adult')
  bool adult;

  @JsonKey(name: 'genre_ids')
  List<int> genreIds;

  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'original_language')
  String originalLanguage;

  @JsonKey(name: 'original_title')
  String originalTitle;

  @JsonKey(name: 'overview')
  String overview;

  @JsonKey(name: 'popularity')
  double popularity;

  @JsonKey(name: 'poster_path')
  String posterPath;

  @JsonKey(name: 'release_date')
  String releaseDate;

  @JsonKey(name: 'title')
  String title;

  @JsonKey(name: 'video')
  bool video;

  @JsonKey(name: 'vote_average')
  int voteAverage;

  @JsonKey(name: 'vote_count')
  int voteCount;

  Results(this.adult,this.genreIds,this.id,this.originalLanguage,this.originalTitle,this.overview,this.popularity,this.posterPath,this.releaseDate,this.title,this.video,this.voteAverage,this.voteCount,);

  factory Results.fromJson(Map<String, dynamic> srcJson) => _$ResultsFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ResultsToJson(this);

  Map<String, dynamic> toSqlJson() {
    String ids = '';
    for(int id in genreIds){
      if(ids == ''){
        ids = id.toString();
      }else{
        ids = "$ids,$id";
      }
    }

    return <String, dynamic>{
      'adult': adult?1:0,
      'genre_ids': ids,
      'id': id,
      'original_language': originalLanguage,
      'original_title': originalTitle,
      'overview': overview,
      'popularity': popularity.toString(),
      'poster_path': posterPath,
      'release_date': releaseDate,
      'title': title,
      'video': video?1:0,
      'vote_average': voteAverage,
      'vote_count': voteCount,
    };
  }

  factory Results.fromSqlJson(Map<String, dynamic> json){
    String ids = json['genre_ids'];
    List<int> gids = [];
    if(ids.isNotEmpty){
      List<String> genres = ids.split(",");
      for(String gid in genres){
        gids.add(int.parse(gid));
      }
    }

    return Results(
      json['adult'] == 1,
      gids,
      (json['id'] as num).toInt(),
      json['original_language']??"",
      json['original_title']??"" as String,
      json['overview']??"" as String,
      (json['popularity']??0 as num).toDouble(),
      json['poster_path']??"" as String,
      json['release_date']??"" as String,
      json['title']??"" as String,
      json['video'] == 1,
      (json['vote_average']??0 as num).toInt(),
      (json['vote_count']??0 as num).toInt(),
    );
  }


  Map<String, String> toStringJson() {
    String ids = '';
    for(int id in genreIds){
      if(ids == ''){
        ids = id.toString();
      }else{
        ids = "$ids,$id";
      }
    }

    return <String, String>{
      'adult': '${adult?1:0}',
      'genre_ids': ids,
      'id': id.toString(),
      'original_language': originalLanguage,
      'original_title': originalTitle,
      'overview': overview,
      'popularity': popularity.toString(),
      'poster_path': posterPath,
      'release_date': releaseDate,
      'title': title,
      'video': '${video?1:0}',
      'vote_average': voteAverage.toString(),
      'vote_count': voteCount.toString(),
    };
  }

  factory Results.fromStringJson(Map<String, String?> json){
    String ids = json['genre_ids']??"";
    List<int> gids = [];
    if(ids.isNotEmpty){
      List<String> genres = ids.split(",");
      for(String gid in genres){
        gids.add(int.parse(gid));
      }
    }

    return Results(
      int.parse(json['adult']??"0") == 1,
      gids,
      int.parse(json['id']??"0"),
      json['original_language']??"",
      json['original_title']??"" ,
      json['overview']??"" ,
      double.parse(json['popularity']??"0"),
      json['poster_path']??"" ,
      json['release_date']??"" ,
      json['title']??"" ,
      int.parse(json['video']??"0") == 1,
      int.parse(json['vote_average']??"0"),
      int.parse(json['vote_count']??"0"),
    );
  }

}


