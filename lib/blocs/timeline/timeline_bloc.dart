import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:my_macos_app/api_repository/daily_task_service.dart';
import 'package:my_macos_app/base_bloc/base_bloc.dart';
import 'package:my_macos_app/models/daily_task.dart';
import 'package:my_macos_app/models/projects.dart';

import '../../api_repository/timeline_service.dart';
import '../../models/time_line.dart';

part 'timeline_event.dart';
part 'timeline_state.dart';

class TimeLineBloc extends BaseBloc<TimeLineEvent, TimeLineState> {
  TimeLineBloc() : super(TimeLineInitial());

  // TimeLineState timeLineState = TimeLineState();
  GetTimeLineSuccess getTimeLineSuccess = GetTimeLineSuccess();
  TimeLineService timeLineService = TimeLineService();

  FutureOr<void> _getTimeLine(
      GetTimeLine event, Emitter<TimeLineState> emit) async {
    emit(TimeLineLoading());

    final List<TimeLine>? timeLine = await TimeLineService.getTimeLineTasks(queryParams: <String, dynamic>{
      'date': "20:06:2024",
    });
    emit(getTimeLineSuccess..timeLine = timeLine);
  }

  @override
  Future<void> eventHandlerMethod(
      TimeLineEvent event, Emitter<TimeLineState> emit) async {
    switch (event.runtimeType) {
      case const (GetTimeLine):
        return _getTimeLine(event as GetTimeLine, emit);
    }
  }

  @override
  TimeLineState getErrorState() {
    return TimeLineError();
  }
}
