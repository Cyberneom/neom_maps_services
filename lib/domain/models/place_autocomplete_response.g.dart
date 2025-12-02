// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'place_autocomplete_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlacesAutocompleteResponse _$PlacesAutocompleteResponseFromJson(
  Map<String, dynamic> json,
) => PlacesAutocompleteResponse(
  status: json['status'] as String,
  errorMessage: json['error_message'] as String?,
  predictions:
      (json['predictions'] as List<dynamic>?)
          ?.map((e) => Prediction.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
);

Map<String, dynamic> _$PlacesAutocompleteResponseToJson(
  PlacesAutocompleteResponse instance,
) => <String, dynamic>{
  'status': instance.status,
  'error_message': instance.errorMessage,
  'predictions': instance.predictions,
};
