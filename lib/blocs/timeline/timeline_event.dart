part of 'timeline_bloc.dart';

abstract class TimeLineEvent {}

// class TimeLine extends TimeLineEvent {}

class GetTimeLine extends TimeLineEvent {
  GetTimeLine({this.date});
  final String? date;
}

// class DeleteDailyTask extends TimeLineEvent {
//   DeleteDailyTask({this.id});
//   final int? id;
// }
