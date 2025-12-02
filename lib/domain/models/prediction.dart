
import 'package:json_annotation/json_annotation.dart';

import 'structured_format.dart';
import 'text_info.dart';

part 'prediction.g.dart';

@JsonSerializable()
class Prediction {

  final String? place;

  @JsonKey(name: 'placeId')
  final String? placeId;

  final TextInfo? text;

  @JsonKey(name: 'structuredFormat')
  final StructuredFormat? structuredFormat;
  final List<String>? types;

  ///DEPRECATED final List<Term>? terms;
  ///DEPRECATED final int? distanceMeters;
  ///DEPRECATED final String? reference;
  ///DEPRECATED final List<MatchedSubstring>? matchedSubstrings;
  ///DEPRECATED final String? endOffset;
  ///DEPRECATED final String? id;

  Prediction({
    this.place,
    this.placeId,
    this.text,
    this.structuredFormat,
    this.types = const <String>[],
    ///DEPRECATED this.terms = const <Term>[],
    ///DEPRECATED this.distanceMeters,
    ///DEPRECATED this.reference,
    ///DEPRECATED this.matchedSubstrings = const <MatchedSubstring>[],
  });

  factory Prediction.fromJson(Map<String, dynamic> json) =>
      _$PredictionFromJson(json);

  Map<String, dynamic> toJson() => _$PredictionToJson(this);

  // factory Prediction.fromNewJson(Map<String, dynamic> s) {
  //   final placePrediction = s['placePrediction'] as Map<String, dynamic>? ?? {};
  //   final place = placePrediction['place'] as String ?? '';
  //   final text  = placePrediction['text']  as Map<String, dynamic>? ?? {};
  //   return Prediction(
  //     // description: text['text'] ?? '',
  //     placeId: placePrediction['id'] ?? '',
  //     matchedSubstrings: ((text['matches'] as List<dynamic>?)
  //         ?.map((m) => MatchedSubstring(
  //       offset: m['startOffset'] as int,
  //       length: (m['endOffset'] as int) - (m['startOffset'] as int),
  //     ))
  //         .toList() ??
  //         []),
  //   );
  // }
}
