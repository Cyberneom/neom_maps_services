
import 'package:json_annotation/json_annotation.dart';


part 'alternative_id.g.dart';

@JsonSerializable()
class AlternativeId {
  /// JSON place_id
  final String placeId;

  final String scope;

  AlternativeId({required this.placeId, required this.scope});

  factory AlternativeId.fromJson(Map<String, dynamic> json) =>
      _$AlternativeIdFromJson(json);
  Map<String, dynamic> toJson() => _$AlternativeIdToJson(this);
}
