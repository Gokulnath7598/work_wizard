part of 'timeline_bloc.dart';

abstract class TimeLineState extends ErrorState {}

class GetTimeLineSuccess extends TimeLineState {
  GetTimeLineSuccess({this.timeLine});
  List<TimeLine>? timeLine;
}

final class TimeLineInitial extends TimeLineState {}

final class TimeLineLoading extends TimeLineState {}

final class TimeLineError extends TimeLineState {}
