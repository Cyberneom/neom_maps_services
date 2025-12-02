
import 'package:json_annotation/json_annotation.dart';

import '../../utils/enums/travel_mode.dart';
import '../use_cases/google_response_status.dart';
import 'core.dart';
import 'location.dart';

part 'directions.g.dart';

@JsonSerializable()
class DirectionsResponse extends GoogleResponseStatus {
  /// JSON geocoded_waypos
  @JsonKey(defaultValue: <GeocodedWaypoint>[])
  final List<GeocodedWaypoint> geocodedWaypoints;

  @JsonKey(defaultValue: <Route>[])
  final List<Route> routes;

  DirectionsResponse({
    required super.status,
    super.errorMessage,
    required this.geocodedWaypoints,
    required this.routes,
  });

  factory DirectionsResponse.fromJson(Map<String, dynamic> json) =>
      _$DirectionsResponseFromJson(json);
  Map<String, dynamic> toJson() => _$DirectionsResponseToJson(this);
}

@JsonSerializable()
class Waypoint {
  final String value;

  Waypoint({required this.value});

  static Waypoint fromAddress(String address) => Waypoint(value: address);

  static Waypoint fromLocation(Location location) =>
      Waypoint(value: location.toString());

  static Waypoint fromPlaceId(String placeId) =>
      Waypoint(value: 'place_id:$placeId');

  static Waypoint fromEncodedPolyline(String polyline) =>
      Waypoint(value: 'enc:$polyline:');

  static Waypoint optimize() => Waypoint(value: 'optimize:true');

  @override
  String toString() => value;

  factory Waypoint.fromJson(Map<String, dynamic> json) =>
      _$WaypointFromJson(json);
  Map<String, dynamic> toJson() => _$WaypointToJson(this);
}

@JsonSerializable()
class GeocodedWaypoint {
  /// JSON geocoder_status
  final String geocoderStatus;

  /// JSON place_id
  final String placeId;

  @JsonKey(defaultValue: <String>[])
  final List<String> types;

  /// JSON partial_match
  @JsonKey(defaultValue: false)
  final bool partialMatch;

  GeocodedWaypoint({
    required this.geocoderStatus,
    required this.placeId,
    this.types = const <String>[],
    this.partialMatch = false,
  });

  factory GeocodedWaypoint.fromJson(Map<String, dynamic> json) =>
      _$GeocodedWaypointFromJson(json);
  Map<String, dynamic> toJson() => _$GeocodedWaypointToJson(this);
}

@JsonSerializable()
class Route {
  final String summary;

  @JsonKey(defaultValue: <Leg>[])
  final List<Leg> legs;

  final String copyrights;

  /// JSON overview_polyline
  final Polyline overviewPolyline;

  final List warnings;

  /// JSON waypoint_order
  @JsonKey(defaultValue: <num>[])
  final List<num> waypointOrder;

  final Bounds bounds;

  final Fare? fare;

  Route({
    required this.summary,
    required this.legs,
    required this.copyrights,
    required this.overviewPolyline,
    required this.warnings,
    required this.waypointOrder,
    required this.bounds,
    this.fare,
  });

  factory Route.fromJson(Map<String, dynamic> json) => _$RouteFromJson(json);
  Map<String, dynamic> toJson() => _$RouteToJson(this);
}

abstract class _Step {
  /// JSON start_location
  final Location startLocation;

  /// JSON end_location
  final Location endLocation;

  final Value duration;

  final Value distance;

  _Step({
    required this.startLocation,
    required this.endLocation,
    required this.duration,
    required this.distance,
  });
}

@JsonSerializable()
class Leg extends _Step {
  @JsonKey(defaultValue: <Step>[])
  final List<Step> steps;

  /// JSON start_address
  final String startAddress;

  /// JSON end_address
  final String endAddress;

  /// JSON duration_in_traffic
  final Value? durationInTraffic;

  /// JSON arrival_time
  final Time? arrivalTime;

  /// JSON departure_time
  final Time? departureTime;

  Leg({
    required this.steps,
    required this.startAddress,
    required this.endAddress,
    this.durationInTraffic,
    this.arrivalTime,
    this.departureTime,
    required super.startLocation,
    required super.endLocation,
    required super.duration,
    required super.distance,
  });

  factory Leg.fromJson(Map<String, dynamic> json) => _$LegFromJson(json);
  Map<String, dynamic> toJson() => _$LegToJson(this);
}

@JsonSerializable()
class Step extends _Step {
  /// JSON travel_mode
  final TravelMode travelMode;

  /// JSON html_instructions
  final String htmlInstructions;
  final String? maneuver;
  final Polyline polyline;

  /// JSON transit_details
  final TransitDetails? transitDetails;

  Step({
    required this.travelMode,
    required this.htmlInstructions,
    required this.polyline,
    required super.startLocation,
    required super.endLocation,
    required super.duration,
    required super.distance,
    this.transitDetails,
    this.maneuver,
  });

  factory Step.fromJson(Map<String, dynamic> json) => _$StepFromJson(json);
  Map<String, dynamic> toJson() => _$StepToJson(this);
}

@JsonSerializable()
class Polyline {
  final String points;

  Polyline({required this.points});

  factory Polyline.fromJson(Map<String, dynamic> json) =>
      _$PolylineFromJson(json);
  Map<String, dynamic> toJson() => _$PolylineToJson(this);
}

@JsonSerializable()
class Value {
  final num value;
  final String text;

  Value({required this.value, required this.text});

  factory Value.fromJson(Map<String, dynamic> json) => _$ValueFromJson(json);
  Map<String, dynamic> toJson() => _$ValueToJson(this);
}

@JsonSerializable()
class Fare extends Value {
  final String currency;

  Fare({required this.currency, required super.value, required super.text});

  factory Fare.fromJson(Map<String, dynamic> json) => _$FareFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$FareToJson(this);
}

@JsonSerializable()
class Time extends Value {
  /// JSON time_zone
  final String timeZone;

  Time({required this.timeZone, required super.value, required super.text});

  factory Time.fromJson(Map<String, dynamic> json) => _$TimeFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$TimeToJson(this);
}

@JsonSerializable()
class TransitDetails {
  /// JSON arrival_stop
  final Stop arrivalStop;

  /// JSON departure_stop
  final Stop departureStop;

  /// JSON arrival_time
  final Time arrivalTime;

  /// JSON departure_time
  final Time departureTime;

  final String headsign;

  final num headway;

  /// JSON num_stops
  final num numStops;

  TransitDetails({
    required this.arrivalStop,
    required this.departureStop,
    required this.arrivalTime,
    required this.departureTime,
    required this.headsign,
    required this.headway,
    required this.numStops,
  });

  factory TransitDetails.fromJson(Map<String, dynamic> json) =>
      _$TransitDetailsFromJson(json);
  Map<String, dynamic> toJson() => _$TransitDetailsToJson(this);
}

@JsonSerializable()
class Stop {
  final String name;
  final Location location;

  Stop({required this.name, required this.location});

  factory Stop.fromJson(Map<String, dynamic> json) => _$StopFromJson(json);
  Map<String, dynamic> toJson() => _$StopToJson(this);
}

@JsonSerializable()
class Line {
  final String name;

  /// JSON short_name
  final String shortName;

  final String color;

  final List<TransitAgency> agencies;

  final String url;

  final String icon;

  /// JSON text_color
  final String textColor;

  final VehicleType vehicle;

  Line({
    required this.name,
    required this.shortName,
    required this.color,
    required this.agencies,
    required this.url,
    required this.icon,
    required this.textColor,
    required this.vehicle,
  });

  factory Line.fromJson(Map<String, dynamic> json) => _$LineFromJson(json);
  Map<String, dynamic> toJson() => _$LineToJson(this);
}

@JsonSerializable()
class TransitAgency {
  final String name;
  final String url;
  final String phone;

  TransitAgency({
    required this.name,
    required this.url,
    required this.phone,
  });

  factory TransitAgency.fromJson(Map<String, dynamic> json) =>
      _$TransitAgencyFromJson(json);
  Map<String, dynamic> toJson() => _$TransitAgencyToJson(this);
}

@JsonSerializable()
class VehicleType {
  final String name;
  final String type;
  final String icon;

  /// JSON local_icon
  final String localIcon;

  VehicleType({
    required this.name,
    required this.type,
    required this.icon,
    required this.localIcon,
  });

  factory VehicleType.fromJson(Map<String, dynamic> json) =>
      _$VehicleTypeFromJson(json);
  Map<String, dynamic> toJson() => _$VehicleTypeToJson(this);

  bool isType(String type) => type.toLowerCase() == this.type.toLowerCase();

  static const rail = 'RAIL';
  static const metroRail = 'METRO_RAIL';
  static const subway = 'SUBWAY';
  static const tram = 'TRAM';
  static const monorail = 'MONORAIL';
  static const heavyRail = 'HEAVY_RAIL';
  static const commuterTrain = 'COMMUTER_TRAIN';
  static const highSpeedTrain = 'HIGH_SPEED_TRAI';
  static const bus = 'BUS';
  static const intercityBus = 'INTERCITY_BUS';
  static const trolleyBus = 'TROLLEYBUS';
  static const shareTaxi = 'SHARE_TAXI';
  static const ferry = 'FERRY';
  static const cableCar = 'CABLE_CARE';
  static const gondolaLift = 'GONDOLA_LIFT';
  static const funicular = 'FUNICULAR';
  static const other = 'OTHER';
}
