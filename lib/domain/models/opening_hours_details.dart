
import 'package:json_annotation/json_annotation.dart';

import '../../utils/neom_maps_utilities.dart';

part 'opening_hours_details.g.dart';

@JsonSerializable()
class OpeningHoursDetail {
  @JsonKey(defaultValue: false)
  final bool openNow;

  @JsonKey(defaultValue: <OpeningHoursPeriod>[])
  final List<OpeningHoursPeriod> periods;

  @JsonKey(defaultValue: <String>[])
  final List<String> weekdayText;

  OpeningHoursDetail({
    this.openNow = false,
    this.periods = const <OpeningHoursPeriod>[],
    this.weekdayText = const <String>[],
  });

  factory OpeningHoursDetail.fromJson(Map<String, dynamic> json) =>
      _$OpeningHoursDetailFromJson(json);
  Map<String, dynamic> toJson() => _$OpeningHoursDetailToJson(this);
}

@JsonSerializable()
class OpeningHoursPeriodDate {
  final int day;
  final String time;

  /// UTC Time
  @Deprecated('use `toDateTime()`')
  DateTime get dateTime => toDateTime();

  DateTime toDateTime() => dayTimeToDateTime(day, time);

  OpeningHoursPeriodDate({required this.day, required this.time});

  factory OpeningHoursPeriodDate.fromJson(Map<String, dynamic> json) =>
      _$OpeningHoursPeriodDateFromJson(json);
  Map<String, dynamic> toJson() => _$OpeningHoursPeriodDateToJson(this);
}

@JsonSerializable()
class OpeningHoursPeriod {
  final OpeningHoursPeriodDate? open;
  final OpeningHoursPeriodDate? close;

  OpeningHoursPeriod({this.open, this.close});

  factory OpeningHoursPeriod.fromJson(Map<String, dynamic> json) =>
      _$OpeningHoursPeriodFromJson(json);
  Map<String, dynamic> toJson() => _$OpeningHoursPeriodToJson(this);
}
