library;

import 'dart:async';
import 'dart:io';
import 'package:neom_maps_services/places.dart';
import 'package:neom_maps_services/src/utils.dart';

final places = GoogleMapsPlaces(apiKey: Platform.environment['API_KEY']);

Future<void> main() async {
  var sessionToken = 'xyzabc_1234';
  var res = await places.autocomplete('Amoeba', sessionToken: sessionToken);

  if (res.isOkay) {
    // list autocomplete prediction
    for (var p in res.predictions) {
      logger.d('- ${p.description}');
    }

    final placeId = res.predictions.first.placeId;
    if (placeId == null) return;

    // get detail of the first result
    var details = await places.getDetailsByPlaceId(
      placeId,
      sessionToken: sessionToken,
    );

    logger.d('\nDetails :');
    logger.d(details.result.formattedAddress);
    logger.d(details.result.formattedPhoneNumber);
    logger.d(details.result.url);
  } else {
    logger.d(res.errorMessage);
  }

  places.dispose();
}
