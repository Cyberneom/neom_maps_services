// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'places_search_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlacesSearchResult _$PlacesSearchResultFromJson(Map<String, dynamic> json) =>
    PlacesSearchResult(
      id: json['id'] as String?,
      reference: json['reference'] as String,
      name: json['name'] as String,
      placeId: json['place_id'] as String,
      formattedAddress: json['formatted_address'] as String?,
      photos:
          (json['photos'] as List<dynamic>?)
              ?.map((e) => Photo.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      altIds:
          (json['alt_ids'] as List<dynamic>?)
              ?.map((e) => AlternativeId.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      types:
          (json['types'] as List<dynamic>?)?.map((e) => e as String).toList() ??
          [],
      permanentlyClosed: json['permanently_closed'] as bool? ?? false,
      icon: json['icon'] as String?,
      geometry: json['geometry'] == null
          ? null
          : Geometry.fromJson(json['geometry'] as Map<String, dynamic>),
      openingHours: json['opening_hours'] == null
          ? null
          : OpeningHoursDetail.fromJson(
              json['opening_hours'] as Map<String, dynamic>,
            ),
      scope: json['scope'] as String?,
      priceLevel: $enumDecodeNullable(_$PriceLevelEnumMap, json['price_level']),
      rating: json['rating'] as num?,
      vicinity: json['vicinity'] as String?,
    );

Map<String, dynamic> _$PlacesSearchResultToJson(PlacesSearchResult instance) =>
    <String, dynamic>{
      'icon': instance.icon,
      'geometry': instance.geometry,
      'name': instance.name,
      'opening_hours': instance.openingHours,
      'photos': instance.photos,
      'place_id': instance.placeId,
      'scope': instance.scope,
      'alt_ids': instance.altIds,
      'price_level': _$PriceLevelEnumMap[instance.priceLevel],
      'rating': instance.rating,
      'types': instance.types,
      'vicinity': instance.vicinity,
      'formatted_address': instance.formattedAddress,
      'permanently_closed': instance.permanentlyClosed,
      'id': instance.id,
      'reference': instance.reference,
    };

const _$PriceLevelEnumMap = {
  PriceLevel.free: 0,
  PriceLevel.inexpensive: 1,
  PriceLevel.moderate: 2,
  PriceLevel.expensive: 3,
  PriceLevel.veryExpensive: 4,
};
