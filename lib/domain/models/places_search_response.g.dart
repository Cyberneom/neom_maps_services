// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'places_search_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlacesSearchResponse _$PlacesSearchResponseFromJson(
  Map<String, dynamic> json,
) => PlacesSearchResponse(
  status: json['status'] as String,
  errorMessage: json['error_message'] as String?,
  results:
      (json['results'] as List<dynamic>?)
          ?.map((e) => PlacesSearchResult.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
  htmlAttributions:
      (json['html_attributions'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      [],
  nextPageToken: json['next_page_token'] as String?,
);

Map<String, dynamic> _$PlacesSearchResponseToJson(
  PlacesSearchResponse instance,
) => <String, dynamic>{
  'status': instance.status,
  'error_message': instance.errorMessage,
  'results': instance.results,
  'html_attributions': instance.htmlAttributions,
  'next_page_token': instance.nextPageToken,
};
