import 'package:json_annotation/json_annotation.dart';

enum PriceLevel {
  @JsonValue(0)
  free,

  @JsonValue(1)
  inexpensive,

  @JsonValue(2)
  moderate,

  @JsonValue(3)
  expensive,

  @JsonValue(4)
  veryExpensive,
}
