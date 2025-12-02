// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prediction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Prediction _$PredictionFromJson(Map<String, dynamic> json) => Prediction(
  place: json['place'] as String?,
  placeId: json['placeId'] as String?,
  text: json['text'] == null
      ? null
      : TextInfo.fromJson(json['text'] as Map<String, dynamic>),
  structuredFormat: json['structuredFormat'] == null
      ? null
      : StructuredFormat.fromJson(
          json['structuredFormat'] as Map<String, dynamic>,
        ),
  types:
      (json['types'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const <String>[],
);

Map<String, dynamic> _$PredictionToJson(Prediction instance) =>
    <String, dynamic>{
      'place': instance.place,
      'placeId': instance.placeId,
      'text': instance.text,
      'structuredFormat': instance.structuredFormat,
      'types': instance.types,
    };
