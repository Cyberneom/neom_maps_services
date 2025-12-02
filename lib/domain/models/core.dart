import 'package:json_annotation/json_annotation.dart';

import '../../utils/enums/route_type.dart';
import '../../utils/enums/traffic_model.dart';
import '../../utils/enums/transit_mode.dart';
import '../../utils/enums/transit_routing_preferences.dart';
import '../../utils/enums/travel_mode.dart';
import '../../utils/enums/unit.dart';
import '../use_cases/google_response_status.dart';
import 'location.dart';

part 'core.g.dart';

@JsonSerializable()
class Geometry {
  final Location location;

  /// JSON location_type
  final String? locationType;

  final Bounds? viewport;

  final Bounds? bounds;

  Geometry({
    required this.location,
    this.locationType,
    this.viewport,
    this.bounds,
  });

  factory Geometry.fromJson(Map<String, dynamic> json) =>
      _$GeometryFromJson(json);
  Map<String, dynamic> toJson() => _$GeometryToJson(this);
}

@JsonSerializable()
class Bounds {
  final Location northeast;
  final Location southwest;

  Bounds({
    required this.northeast,
    required this.southwest,
  });

  @override
  String toString() =>
      '${northeast.latitude},${northeast.longitude}|${southwest.latitude},${southwest.longitude}';

  factory Bounds.fromJson(Map<String, dynamic> json) => _$BoundsFromJson(json);
  Map<String, dynamic> toJson() => _$BoundsToJson(this);
}

abstract class GoogleResponseList<T> extends GoogleResponseStatus {
  @JsonKey(defaultValue: [])
  final List<T> results;

  GoogleResponseList(String status, String? errorMessage, this.results)
      : super(status: status, errorMessage: errorMessage);
}

abstract class GoogleResponse<T> extends GoogleResponseStatus {
  final T result;

  GoogleResponse(String status, String? errorMessage, this.result)
      : super(status: status, errorMessage: errorMessage);
}

@JsonSerializable()
class AddressComponent {
  @JsonKey(defaultValue: <String>[])
  final List<String> types;

  /// JSON long_name
  final String longName;

  /// JSON short_name
  final String shortName;

  AddressComponent({
    required this.types,
    required this.longName,
    required this.shortName,
  });

  factory AddressComponent.fromJson(Map<String, dynamic> json) =>
      _$AddressComponentFromJson(json);
  Map<String, dynamic> toJson() => _$AddressComponentToJson(this);
}

@JsonSerializable()
class _TravelMode {
  final TravelMode value;

  _TravelMode(this.value);

  // ignore: unused_element
  factory _TravelMode.fromJson(Map<String, dynamic> json) => _$TravelModeFromJson(json);
  Map<String, dynamic> toJson() => _$TravelModeToJson(this);
}

extension TravelModeExt on TravelMode {
  static TravelMode fromApiString(String mode) {
    return $enumDecode(_$TravelModeEnumMap, mode);
  }

  String toApiString() {
    return _$TravelModeEnumMap[this] ?? '';
  }
}

@JsonSerializable()
class _RouteType {
  final RouteType value;

  _RouteType(this.value);

  // ignore: unused_element
  factory _RouteType.fromJson(Map<String, dynamic> json) =>
      _$RouteTypeFromJson(json);
  Map<String, dynamic> toJson() => _$RouteTypeToJson(this);
}

extension RouteTypeExt on RouteType {
  static RouteType fromApiString(String mode) {
    return $enumDecode(_$RouteTypeEnumMap, mode);
  }

  String toApiString() {
    return _$RouteTypeEnumMap[this] ?? '';
  }
}

@JsonSerializable()
class _Unit {
  final Unit value;

  _Unit(this.value);

  // ignore: unused_element
  factory _Unit.fromJson(Map<String, dynamic> json) => _$UnitFromJson(json);
  Map<String, dynamic> toJson() => _$UnitToJson(this);
}

extension UnitExt on Unit {
  static Unit fromApiString(String mode) {
    return $enumDecode(_$UnitEnumMap, mode);
  }

  String toApiString() {
    return _$UnitEnumMap[this] ?? '';
  }
}

@JsonSerializable()
class _TrafficModel {
  final TrafficModel value;

  _TrafficModel(this.value);

  // ignore: unused_element
  factory _TrafficModel.fromJson(Map<String, dynamic> json) => _$TrafficModelFromJson(json);
  Map<String, dynamic> toJson() => _$TrafficModelToJson(this);
}

extension TrafficModelExt on TrafficModel {
  static TrafficModel fromApiString(String mode) {
    return $enumDecode(_$TrafficModelEnumMap, mode);
  }

  String toApiString() {
    return _$TrafficModelEnumMap[this] ?? '';
  }
}

@JsonSerializable()
class _TransitMode {
  final TransitMode value;

  _TransitMode(this.value);

  // ignore: unused_element
  factory _TransitMode.fromJson(Map<String, dynamic> json) =>
      _$TransitModeFromJson(json);
  Map<String, dynamic> toJson() => _$TransitModeToJson(this);
}

extension TransitModeExt on TransitMode {
  static TransitMode fromApiString(String mode) {
    return $enumDecode(_$TransitModeEnumMap, mode);
  }

  String toApiString() {
    return _$TransitModeEnumMap[this] ?? '';
  }
}

@JsonSerializable()
class _TransitRoutingPreferences {
  final TransitRoutingPreferences value;

  _TransitRoutingPreferences(this.value);

  // ignore: unused_element
  factory _TransitRoutingPreferences.fromJson(Map<String, dynamic> json) =>
      _$TransitRoutingPreferencesFromJson(json);
  Map<String, dynamic> toJson() => _$TransitRoutingPreferencesToJson(this);
}

extension TransitRoutingPreferencesExt on TransitRoutingPreferences {
  static TransitRoutingPreferences fromApiString(String mode) {
    return $enumDecode(_$TransitRoutingPreferencesEnumMap, mode);
  }

  String toApiString() {
    return _$TransitRoutingPreferencesEnumMap[this] ?? '';
  }

}
