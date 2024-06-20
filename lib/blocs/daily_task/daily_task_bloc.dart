import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:my_macos_app/api_repository/daily_task_service.dart';
import 'package:my_macos_app/base_bloc/base_bloc.dart';
import 'package:my_macos_app/models/daily_task.dart';

part 'daily_task_event.dart';
part 'daily_task_state.dart';

class DailyTaskBloc extends BaseBloc<DailyTaskEvent, DailyTaskState> {
  DailyTaskBloc() : super(DailyTaskInitial());

  DailyTaskAppState dailyTaskAppState = DailyTaskAppState();

  DailyTaskService dailyTaskService = DailyTaskService();

  FutureOr<void> _getDailyTasks(
      GetDailyTasks event, Emitter<DailyTaskState> emit) async {
    emit(DailyTaskLoading());

    final DailyTasks? dailyTasks = await DailyTaskService.getDailyTasks();

    emit(dailyTaskAppState..dailyTasks = dailyTasks);
  }

  FutureOr<void> _addDailyTask(
      AddDailyTask event, Emitter<DailyTaskState> emit) async {
    emit(DailyTaskLoading());
    await DailyTaskService.addDailyTask(objToApi: {
      "daily_task": {"task_desc": event.name}
    });

    emit(dailyTaskAppState);
    add(GetDailyTasks());
  }

  FutureOr<void> _deleteDailyTask(
      DeleteDailyTask event, Emitter<DailyTaskState> emit) async {
    emit(DailyTaskDeleteLoading());
    await DailyTaskService.deleteDailyTask(id: event.id);

    emit(dailyTaskAppState);
    add(GetDailyTasks());
  }

  @override
  Future<void> eventHandlerMethod(
      DailyTaskEvent event, Emitter<DailyTaskState> emit) async {
    switch (event.runtimeType) {
      case const (GetDailyTasks):
        return _getDailyTasks(event as GetDailyTasks, emit);
      case const (AddDailyTask):
        return _addDailyTask(event as AddDailyTask, emit);
      case const (DeleteDailyTask):
        return _deleteDailyTask(event as DeleteDailyTask, emit);
    }
  }

  @override
  DailyTaskState getErrorState() {
    return DailyTaskError();
  }
}
