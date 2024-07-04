import 'package:cyberbot_demo/app/logger.dart';
import 'package:json_annotation/json_annotation.dart';

part 'movie_list_entity.g.dart';

///获取电影列表数据实体
@JsonSerializable()
class MovieListEntity extends Object {

  @JsonKey(name: 'dates')
  Dates dates;

  @JsonKey(name: 'page')
  int page;

  @JsonKey(name: 'results')
  List<Results> results;

  @JsonKey(name: 'total_pages')
  int totalPages;

  @JsonKey(name: 'total_results')
  int totalResults;

  MovieListEntity(this.dates,this.page,this.results,this.totalPages,this.totalResults,);

  factory MovieListEntity.fromJson(Map<String, dynamic> srcJson) => _$MovieListEntityFromJson(srcJson);

  Map<String, dynamic> toJson() => _$MovieListEntityToJson(this);

}


@JsonSerializable()
class Dates extends Object {

  @JsonKey(name: 'maximum')
  String maximum;

  @JsonKey(name: 'minimum')
  String minimum;

  Dates(this.maximum,this.minimum,);

  factory Dates.fromJson(Map<String, dynamic> srcJson) => _$DatesFromJson(srcJson);

  Map<String, dynamic> toJson() => _$DatesToJson(this);

}


@JsonSerializable()
class Results extends Object {

  @JsonKey(name: 'adult')
  bool adult;

  @JsonKey(name: 'backdrop_path')
  String backdropPath;

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
  double voteAverage;

  @JsonKey(name: 'vote_count')
  int voteCount;

  Results(this.adult,this.backdropPath,this.genreIds,this.id,this.originalLanguage,this.originalTitle,this.overview,this.popularity,this.posterPath,this.releaseDate,this.title,this.video,this.voteAverage,this.voteCount,);

  factory Results.fromJson(Map<String, dynamic> srcJson) => _$ResultsFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ResultsToJson(this);

}


