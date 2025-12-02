import 'package:json_annotation/json_annotation.dart';

enum TravelMode {
  @JsonValue('DRIVING')
  driving,
  @JsonValue('WALKING')
  walking,
  @JsonValue('BICYCLING')
  bicycling,
  @JsonValue('TRANSIT')
  transit,
}
