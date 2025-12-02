// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'place_details_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlacesDetailsResponse _$PlacesDetailsResponseFromJson(
  Map<String, dynamic> json,
) => PlacesDetailsResponse(
  status: json['status'] as String,
  errorMessage: json['error_message'] as String?,
  result: PlaceDetails.fromJson(json['result'] as Map<String, dynamic>),
  htmlAttributions:
      (json['html_attributions'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      [],
);

Map<String, dynamic> _$PlacesDetailsResponseToJson(
  PlacesDetailsResponse instance,
) => <String, dynamic>{
  'status': instance.status,
  'error_message': instance.errorMessage,
  'result': instance.result,
  'html_attributions': instance.htmlAttributions,
};
