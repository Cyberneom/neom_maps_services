import 'package:json_annotation/json_annotation.dart';

enum TransitRoutingPreferences {
  @JsonValue('less_walking')
  lessWalking,
  @JsonValue('fewer_transfers')
  fewerTransfers,
}
