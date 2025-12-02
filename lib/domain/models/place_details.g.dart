// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'place_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlaceDetails _$PlaceDetailsFromJson(Map<String, dynamic> json) => PlaceDetails(
  id: json['id'] as String?,
  formattedAddress: json['formattedAddress'] as String?,
  location: json['location'] == null
      ? null
      : Location.fromJson(json['location'] as Map<String, dynamic>),
  displayName: json['displayName'] == null
      ? null
      : DisplayName.fromJson(json['displayName'] as Map<String, dynamic>),
);

Map<String, dynamic> _$PlaceDetailsToJson(PlaceDetails instance) =>
    <String, dynamic>{
      'id': instance.id,
      'formattedAddress': instance.formattedAddress,
      'location': instance.location,
      'displayName': instance.displayName,
    };
