library google_maps_webservice.directions.example;

import 'dart:async';
import 'dart:io';

import 'package:neom_maps_services/directions.dart';
import 'package:neom_maps_services/src/utils.dart';

final directions =
    GoogleMapsDirections(apiKey: Platform.environment['API_KEY']);

Future<void> main() async {
  var res =
      await directions.directionsWithAddress('Paris, France', 'Rennes, France');

  logger.d(res.status);
  if (res.isOkay) {
    logger.d('${res.routes.length} routes');
    for (var r in res.routes) {
      logger.d(r.summary);
      logger.d(r.bounds);
    }
  } else {
    logger.d(res.errorMessage);
  }

  directions.dispose();
}
