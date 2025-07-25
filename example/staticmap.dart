library;

import 'dart:io';

import 'package:neom_maps_services/src/utils.dart';
import 'package:neom_maps_services/staticmap.dart';

final apiKey = Platform.environment['API_KEY'] ?? '';

void main() {
  final staticMap = StaticMap(
    apiKey,
    markers: List.from([
      Location(lat: 23.721160, lng: 90.394435),
      Location(lat: 23.732322, lng: 90.385142),
    ]),
    path: Path(
      enc: 'svh~F`j}uOusC`bD',
      color: 'black',
    ),
    scale: false,
  );

  logger.d(staticMap.getUrl());
}
