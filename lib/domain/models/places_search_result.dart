
import 'package:json_annotation/json_annotation.dart';

import '../../utils/enums/price_level.dart';
import 'alternative_id.dart';
import 'core.dart';
import 'opening_hours_details.dart';
import 'photo.dart';

part 'places_search_result.g.dart';

@JsonSerializable()
class PlacesSearchResult {
  final String? icon;
  final Geometry? geometry;
  final String name;

  /// JSON opening_hours
  final OpeningHoursDetail? openingHours;

  @JsonKey(defaultValue: [])
  final List<Photo> photos;

  /// JSON place_id
  final String placeId;

  final String? scope;

  /// JSON alt_ids
  @JsonKey(defaultValue: [])
  final List<AlternativeId> altIds;

  /// JSON price_level
  final PriceLevel? priceLevel;

  final num? rating;

  @JsonKey(defaultValue: [])
  final List<String> types;

  final String? vicinity;

  /// JSON formatted_address
  final String? formattedAddress;

  /// JSON permanently_closed
  @JsonKey(defaultValue: false)
  final bool permanentlyClosed;

  final String? id;

  final String reference;

  PlacesSearchResult({
    this.id,
    required this.reference,
    required this.name,
    required this.placeId,
    this.formattedAddress,
    this.photos = const [],
    this.altIds = const [],
    this.types = const [],
    this.permanentlyClosed = false,
    this.icon,
    this.geometry,
    this.openingHours,
    this.scope,
    this.priceLevel,
    this.rating,
    this.vicinity,
  });

  factory PlacesSearchResult.fromJson(Map<String, dynamic> json) =>
      _$PlacesSearchResultFromJson(json);
  Map<String, dynamic> toJson() => _$PlacesSearchResultToJson(this);
}
