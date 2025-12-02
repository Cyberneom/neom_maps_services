
import 'package:json_annotation/json_annotation.dart';

import 'display_name.dart';
import 'location.dart';

part 'place_details.g.dart';

@JsonSerializable()
class PlaceDetails {

  final String? id;

  @JsonKey(name: 'formattedAddress')
  final String? formattedAddress;

  final Location? location;

  @JsonKey(name: 'displayName')
  final DisplayName? displayName;

  ///DEPRECATED
  // final List<AddressComponent>? addressComponents;
  // /// JSON adr_address
  // final String? adrAddress;
  //
  // final String? formattedPhoneNumber;
  // final String? reference;
  // final String? icon;
  // final String name;
  //
  // final OpeningHoursDetail? openingHours;
  // final List<Photo>? photos;
  //
  // final String placeId;
  //
  // final String? internationalPhoneNumber;
  //
  // final PriceLevel? priceLevel;
  // final num? rating;
  // final String? scope;
  //
  //
  // final List<String>? types;
  // final String? url;
  // final num? utcOffset;
  //
  // final String? website;
  // final List<Review>? reviews;
  // final Geometry? geometry;

  PlaceDetails({
    this.id,
    this.formattedAddress,
    this.location,
    this.displayName,
    // this.adrAddress,
    // required this.name,
    // required this.placeId,
    // this.utcOffset,
    // this.internationalPhoneNumber,
    // this.addressComponents = const [],
    // this.photos = const [],
    // this.types = const [],
    // this.reviews = const [],
    // this.formattedPhoneNumber,
    // this.reference,
    // this.icon,
    // this.rating,
    // this.openingHours,
    // this.priceLevel,
    // this.scope,
    // this.url,
    // this.website,
    // this.geometry,
  });

  factory PlaceDetails.fromJson(Map<String, dynamic> json) =>
      _$PlaceDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$PlaceDetailsToJson(this);
}
