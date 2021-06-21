import 'package:equatable/equatable.dart';

class BrancheWorkingDay extends Equatable {
  final bool open;
  final String dayAr;
  final String dayEn;
  final String startTime;
  final String endTime;

  const BrancheWorkingDay({
    this.open,
    this.dayAr,
    this.dayEn,
    this.startTime,
    this.endTime,
  });

  factory BrancheWorkingDay.fromJson(Map<String, dynamic> json) =>
      BrancheWorkingDay(
        open: json['Open'] as bool,
        dayAr: json['DayAR'] as String,
        dayEn: json['DayEN'] as String,
        startTime: json['StartTime'] as String,
        endTime: json['EndTime'] as String,
      );

  Map<String, dynamic> toJson() => {
        'Open': open,
        'DayAR': dayAr,
        'DayEN': dayEn,
        'StartTime': startTime,
        'EndTime': endTime,
      };

  BrancheWorkingDay copyWith({
    bool open,
    String dayAr,
    String dayEn,
    String startTime,
    String endTime,
  }) {
    return BrancheWorkingDay(
      open: open ?? this.open,
      dayAr: dayAr ?? this.dayAr,
      dayEn: dayEn ?? this.dayEn,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [open, dayAr, dayEn, startTime, endTime];
}
