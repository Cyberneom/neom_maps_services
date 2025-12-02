import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart';

import '../../utils/enums/route_type.dart';
import '../../utils/enums/traffic_model.dart';
import '../../utils/enums/transit_mode.dart';
import '../../utils/enums/transit_routing_preferences.dart';
import '../../utils/enums/travel_mode.dart';
import '../../utils/enums/unit.dart';
import '../../utils/neom_maps_urls.dart';
import '../../utils/neom_maps_utilities.dart';
import '../domain/models/core.dart';
import '../domain/models/directions.dart';
import '../domain/models/location.dart';

/// https://developers.google.com/maps/documentation/directions/start
class GoogleMapsDirections extends GoogleWebService {
  GoogleMapsDirections({
    super.apiKey,
    super.baseUrl,
    super.httpClient,
    super.apiHeaders,
  }) : super(
    apiPath: NeomMapsUrls.directionsUrl,
  );

  Future<DirectionsResponse> directions(
      Object /*Location|String*/ origin,
      Object /*Location|String*/ destination, {
        TravelMode? travelMode,
        List<Waypoint> waypoints = const [],
        bool alternatives = false,
        @Deprecated('') RouteType? avoid,
        List<RouteType> avoids = const [],
        String? language,
        Unit? units,
        String? region,
        Object? /*DateTime|num*/ arrivalTime,
        Object? /*DateTime|num|String('now')*/ departureTime,
        List<TransitMode> transitMode = const [],
        TrafficModel? trafficModel,
        TransitRoutingPreferences? transitRoutingPreference,
      }) async {
    final url = buildUrl(
      origin: origin,
      destination: destination,
      travelMode: travelMode,
      waypoints: waypoints,
      alternatives: alternatives,
      avoids: avoids,
      language: language,
      units: units,
      region: region,
      arrivalTime: arrivalTime,
      departureTime: departureTime,
      transitMode: transitMode,
      trafficModel: trafficModel,
      transitRoutingPreference: transitRoutingPreference,
    );
    return _decode(await doGet(url, headers: apiHeaders));
  }

  Future<DirectionsResponse> directionsWithLocation(
      Location origin,
      Location destination, {
        TravelMode? travelMode,
        List<Waypoint> waypoints = const [],
        bool alternatives = false,
        @Deprecated('') RouteType? avoid,
        List<RouteType> avoids = const [],
        String? language,
        Unit? units,
        String? region,
        Object? /*DateTime|num*/ arrivalTime,
        Object? /*DateTime|num|String('now')*/ departureTime,
        List<TransitMode> transitMode = const [],
        TrafficModel? trafficModel,
        TransitRoutingPreferences? transitRoutingPreference,
      }) async {
    return directions(
      origin,
      destination,
      travelMode: travelMode,
      waypoints: waypoints,
      alternatives: alternatives,
      avoids: avoids,
      language: language,
      units: units,
      region: region,
      arrivalTime: arrivalTime,
      departureTime: departureTime,
      transitMode: transitMode,
      trafficModel: trafficModel,
      transitRoutingPreference: transitRoutingPreference,
    );
  }

  Future<DirectionsResponse> directionsWithAddress(
      String origin,
      String destination, {
        TravelMode? travelMode,
        List<Waypoint> waypoints = const [],
        bool alternatives = false,
        @Deprecated('') RouteType? avoid,
        List<RouteType> avoids = const [],
        String? language,
        Unit? units,
        String? region,
        Object? /*DateTime|num*/ arrivalTime,
        Object? /*DateTime|num|String('now')*/ departureTime,
        List<TransitMode> transitMode = const [],
        TrafficModel? trafficModel,
        TransitRoutingPreferences? transitRoutingPreference,
      }) async {
    return directions(
      origin,
      destination,
      travelMode: travelMode,
      waypoints: waypoints,
      alternatives: alternatives,
      avoids: avoids,
      language: language,
      units: units,
      region: region,
      arrivalTime: arrivalTime,
      departureTime: departureTime,
      transitMode: transitMode,
      trafficModel: trafficModel,
      transitRoutingPreference: transitRoutingPreference,
    );
  }

  String buildUrl({
    required Object /*Location|String*/ origin,
    required Object /*Location|String*/ destination,
    TravelMode? travelMode,
    List<Waypoint> waypoints = const <Waypoint>[],
    bool alternatives = false,
    @Deprecated('') RouteType? avoid,
    List<RouteType> avoids = const <RouteType>[],
    String? language,
    Unit? units,
    String? region,
    Object? /*DateTime|num*/ arrivalTime,
    Object? /*DateTime|num|String('now')*/ departureTime,
    List<TransitMode> transitMode = const <TransitMode>[],
    TrafficModel? trafficModel,
    TransitRoutingPreferences? transitRoutingPreference,
  }) {
    final params = <String, String>{};

    if (origin is! Location && origin is! String) {
      throw ArgumentError("'origin' must be a '$String' or a '$Location'");
    }
    params['origin'] = origin.toString();

    if (destination is! Location && destination is! String) {
      throw ArgumentError("'destination' must be a '$String' or a '$Location'");
    }
    params['destination'] = destination.toString();

    if (departureTime != null) {
      if (departureTime is! DateTime &&
          departureTime is! num &&
          departureTime != 'now') {
        throw ArgumentError(
            "'departureTime' must be a '$num' or a '$DateTime'");
      }

      params['departure_time'] = departureTime is DateTime
          ? (departureTime.millisecondsSinceEpoch ~/ 1000).toString()
          : departureTime.toString();
    }

    if (arrivalTime != null) {
      if (arrivalTime is! DateTime && arrivalTime is! num) {
        throw ArgumentError("'arrivalTime' must be a '$num' or a '$DateTime'");
      }

      params['arrival_time'] = arrivalTime is DateTime
          ? (arrivalTime.millisecondsSinceEpoch ~/ 1000).toString()
          : arrivalTime.toString();
    }

    if (waypoints.isNotEmpty == true) {
      if (alternatives == true) {
        throw ArgumentError(
          "'alternatives' is only available for requests without intermediate waypoints",
        );
      }

      params['waypoints'] = waypoints.join('|');
    }

    if (travelMode != null) {
      params['mode'] = travelMode.toApiString();
    }

    if (alternatives) {
      params['alternatives'] = alternatives.toString();
    }

    if (avoid != null) {
      avoids = [
        ...avoids,
        avoid,
      ];
    }

    if (avoids.isNotEmpty) {
      params['avoid'] = avoids.map((t) => t.toApiString()).join('|');
    }

    if (language != null) {
      params['language'] = language;
    }

    if (units != null) {
      params['units'] = units.toApiString();
    }

    if (region != null) {
      params['region'] = region;
    }

    if (trafficModel != null) {
      params['traffic_model'] = trafficModel.toApiString();
    }

    if (transitMode.isNotEmpty) {
      params['transit_mode'] =
          transitMode.map((t) => t.toApiString()).join('|');
    }

    if (transitRoutingPreference != null) {
      params['transit_routing_preference'] =
          transitRoutingPreference.toApiString();
    }

    if (apiKey != null) {
      params['key'] = apiKey!;
    }

    return url.replace(queryParameters: params).toString();
  }

  DirectionsResponse _decode(Response res) =>
      DirectionsResponse.fromJson(json.decode(res.body));
}
