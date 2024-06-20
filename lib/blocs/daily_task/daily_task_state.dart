part of 'daily_task_bloc.dart';

abstract class DailyTaskState extends ErrorState {}

class DailyTaskAppState extends DailyTaskState {
  DailyTaskAppState({this.dailyTasks});
  DailyTasks? dailyTasks;
}

final class DailyTaskInitial extends DailyTaskState {}

final class DailyTaskLoading extends DailyTaskState {}

final class DailyTaskDeleteLoading extends DailyTaskState {}

final class DailyTaskError extends DailyTaskState {}
