part of 'daily_task_bloc.dart';

abstract class DailyTaskEvent {}

class GetDailyTasks extends DailyTaskEvent {}

class AddDailyTask extends DailyTaskEvent {
  AddDailyTask({this.name});
  final String? name;
}

class DeleteDailyTask extends DailyTaskEvent {
  DeleteDailyTask({this.id});
  final int? id;
}
