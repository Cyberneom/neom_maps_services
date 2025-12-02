
import 'package:json_annotation/json_annotation.dart';

import '../use_cases/google_response_status.dart';
import 'places_search_result.dart';

part 'places_search_response.g.dart';

@JsonSerializable()
class PlacesSearchResponse extends GoogleResponseStatus {
  @JsonKey(defaultValue: [])
  final List<PlacesSearchResult> results;

  /// JSON html_attributions
  @JsonKey(defaultValue: [])
  final List<String> htmlAttributions;

  /// JSON next_page_token
  final String? nextPageToken;

  PlacesSearchResponse({
    required super.status,
    super.errorMessage,
    this.results = const [],
    this.htmlAttributions = const [],
    this.nextPageToken,
  });

  factory PlacesSearchResponse.fromJson(Map<String, dynamic> json) =>
      _$PlacesSearchResponseFromJson(json);
  Map<String, dynamic> toJson() => _$PlacesSearchResponseToJson(this);
}
