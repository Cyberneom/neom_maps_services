
import 'package:json_annotation/json_annotation.dart';

import '../use_cases/google_response_status.dart';
import 'prediction.dart';

part 'place_autocomplete_response.g.dart';

@JsonSerializable()
class PlacesAutocompleteResponse extends GoogleResponseStatus {
  @JsonKey(defaultValue: <Prediction>[])
  final List<Prediction> predictions;

  PlacesAutocompleteResponse({
    required super.status,
    super.errorMessage,
    required this.predictions,
  });

  factory PlacesAutocompleteResponse.fromJson(Map<String, dynamic> json) =>
      _$PlacesAutocompleteResponseFromJson(json);
  Map<String, dynamic> toJson() => _$PlacesAutocompleteResponseToJson(this);
}
