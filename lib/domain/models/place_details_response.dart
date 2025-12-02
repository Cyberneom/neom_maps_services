
import 'package:json_annotation/json_annotation.dart';

import '../use_cases/google_response_status.dart';
import 'place_details.dart';

part 'place_details_response.g.dart';

@JsonSerializable()
class PlacesDetailsResponse extends GoogleResponseStatus {
  final PlaceDetails result;

  /// JSON html_attributions
  @JsonKey(defaultValue: <String>[])
  final List<String> htmlAttributions;

  PlacesDetailsResponse({
    required super.status,
    super.errorMessage,
    required this.result,
    required this.htmlAttributions,
  });

  factory PlacesDetailsResponse.fromJson(Map<String, dynamic> json) =>
      _$PlacesDetailsResponseFromJson(json);
  Map<String, dynamic> toJson() => _$PlacesDetailsResponseToJson(this);
}
