
import 'package:json_annotation/json_annotation.dart';



part 'matched_substring.g.dart';

@JsonSerializable()
class MatchedSubstring {
  final num offset;
  final num length;

  MatchedSubstring({
    required this.offset,
    required this.length,
  });

  factory MatchedSubstring.fromJson(Map<String, dynamic> json) =>
      _$MatchedSubstringFromJson(json);
  Map<String, dynamic> toJson() => _$MatchedSubstringToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MatchedSubstring &&
          runtimeType == other.runtimeType &&
          offset == other.offset &&
          length == other.length;

  @override
  int get hashCode => offset.hashCode ^ length.hashCode;
}
