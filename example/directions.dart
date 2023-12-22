library google_maps_webservice.directions.example;

import 'dart:async';
import 'dart:io';

import 'package:neom_maps_services/directions.dart';

final directions =
    GoogleMapsDirections(apiKey: Platform.environment['API_KEY']);

Future<void> main() async {
  var res =
      await directions.directionsWithAddress('Paris, France', 'Rennes, France');

  print(res.status);
  if (res.isOkay) {
    print('${res.routes.length} routes');
    for (var r in res.routes) {
      print(r.summary);
      print(r.bounds);
    }
  } else {
    print(res.errorMessage);
  }

  directions.dispose();
}
