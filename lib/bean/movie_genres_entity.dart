import 'package:json_annotation/json_annotation.dart';

part 'movie_genres_entity.g.dart';


@JsonSerializable()
class MovieGenresEntity extends Object {

  @JsonKey(name: 'genres')
  List<Genres> genres;

  MovieGenresEntity(this.genres,);

  factory MovieGenresEntity.fromJson(Map<String, dynamic> srcJson) => _$MovieGenresEntityFromJson(srcJson);

  Map<String, dynamic> toJson() => _$MovieGenresEntityToJson(this);

}


@JsonSerializable()
class Genres extends Object {

  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'name')
  String name;
  ///是否被选中
  bool isCheck = false;

  Genres(this.id,this.name,);

  factory Genres.fromJson(Map<String, dynamic> srcJson) => _$GenresFromJson(srcJson);

  Map<String, dynamic> toJson() => _$GenresToJson(this);

}


