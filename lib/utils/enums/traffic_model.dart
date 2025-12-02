import 'package:json_annotation/json_annotation.dart';

enum TrafficModel {
  @JsonValue('best_guess')
  bestGuess,
  pessimistic,
  optimistic,
}
