
import 'package:json_annotation/json_annotation.dart';

part 'text_info.g.dart';

@JsonSerializable()
class TextInfo {

  final String? text;
  final List<dynamic>? matches;

  TextInfo({this.text, this.matches});

  factory TextInfo.fromJson(Map<String, dynamic> json) =>
      _$TextInfoFromJson(json);

  Map<String, dynamic> toJson() => _$TextInfoToJson(this);
}
