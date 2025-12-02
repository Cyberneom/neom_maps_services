
import 'package:json_annotation/json_annotation.dart';


part 'place.g.dart';

@JsonSerializable()
class Place {
  @JsonKey(name: 'placeId')
  final String? placeId;

  Place({this.placeId});

  factory Place.fromJson(Map<String, dynamic> json) => _$PlaceFromJson(json);
  Map<String, dynamic> toJson() => _$PlaceToJson(this);
}
