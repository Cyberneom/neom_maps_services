
import 'package:json_annotation/json_annotation.dart';

import 'text_info.dart';

part 'structured_format.g.dart';

@JsonSerializable()
class StructuredFormat {

  @JsonKey(name: 'mainText')
  final TextInfo? mainText;

  @JsonKey(name: 'secondaryText')
  final TextInfo? secondaryText;

  StructuredFormat({
    required this.mainText,
    this.secondaryText,
  });

  factory StructuredFormat.fromJson(Map<String, dynamic> json) =>
      _$StructuredFormatFromJson(json);

  Map<String, dynamic> toJson() => _$StructuredFormatToJson(this);
}
