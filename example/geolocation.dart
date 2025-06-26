library;

import 'dart:async';
import 'dart:io';

import 'package:neom_maps_services/geolocation.dart';
import 'package:neom_maps_services/src/utils.dart';

final geolocation =
    GoogleMapsGeolocation(apiKey: Platform.environment['API_KEY']);

Future<void> main() async {
  var params = {
    'considerIp': 'false',
    'wifiAccessPoints': [
      {
        'macAddress': '00:25:9c:cf:1c:ac',
        'signalStrength': '-43',
        'signalToNoiseRatio': '0'
      },
      {
        'macAddress': '00:25:9c:cf:1c:ad',
        'signalStrength': '-55',
        'signalToNoiseRatio': '0'
      }
    ]
  };

  // No params -> google uses current location
  var res = await geolocation.getGeolocation();

  // works with map/json
  res = await geolocation.getGeolocationFromMap(params);

  // define optional parameter explicit
  res = await geolocation.getGeolocation(considerIp: false);

  if (res.isOkay) {
    logger.d('Latitude: ${res.location?.lat}');
    logger.d('Longitude: ${res.location?.lng}');
    logger.d('Accuracy: ${res.accuracy}');
  } else {
    logger.d(res.error?.message);
  }

  geolocation.dispose();
}
