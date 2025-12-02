
import 'package:json_annotation/json_annotation.dart';


part 'photo.g.dart';

@JsonSerializable()
class Photo {
  /// JSON photo_reference
  final String photoReference;
  final num height;
  final num width;

  /// JSON html_attributions
  @JsonKey(defaultValue: <String>[])
  final List<String> htmlAttributions;

  Photo({
    required this.photoReference,
    required this.height,
    required this.width,
    this.htmlAttributions = const <String>[],
  });

  factory Photo.fromJson(Map<String, dynamic> json) => _$PhotoFromJson(json);
  Map<String, dynamic> toJson() => _$PhotoToJson(this);
}
