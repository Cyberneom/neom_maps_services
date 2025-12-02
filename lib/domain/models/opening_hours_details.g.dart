// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'opening_hours_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OpeningHoursDetail _$OpeningHoursDetailFromJson(Map<String, dynamic> json) =>
    OpeningHoursDetail(
      openNow: json['open_now'] as bool? ?? false,
      periods:
          (json['periods'] as List<dynamic>?)
              ?.map(
                (e) => OpeningHoursPeriod.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          [],
      weekdayText:
          (json['weekday_text'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
    );

Map<String, dynamic> _$OpeningHoursDetailToJson(OpeningHoursDetail instance) =>
    <String, dynamic>{
      'open_now': instance.openNow,
      'periods': instance.periods,
      'weekday_text': instance.weekdayText,
    };

OpeningHoursPeriodDate _$OpeningHoursPeriodDateFromJson(
  Map<String, dynamic> json,
) => OpeningHoursPeriodDate(
  day: (json['day'] as num).toInt(),
  time: json['time'] as String,
);

Map<String, dynamic> _$OpeningHoursPeriodDateToJson(
  OpeningHoursPeriodDate instance,
) => <String, dynamic>{'day': instance.day, 'time': instance.time};

OpeningHoursPeriod _$OpeningHoursPeriodFromJson(
  Map<String, dynamic> json,
) => OpeningHoursPeriod(
  open: json['open'] == null
      ? null
      : OpeningHoursPeriodDate.fromJson(json['open'] as Map<String, dynamic>),
  close: json['close'] == null
      ? null
      : OpeningHoursPeriodDate.fromJson(json['close'] as Map<String, dynamic>),
);

Map<String, dynamic> _$OpeningHoursPeriodToJson(OpeningHoursPeriod instance) =>
    <String, dynamic>{'open': instance.open, 'close': instance.close};
