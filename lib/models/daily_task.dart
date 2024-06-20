import 'dart:convert';

class DailyTasks {
  List<DailyTask>? dailyTasks;

  DailyTasks({
    this.dailyTasks,
  });

  factory DailyTasks.fromJson(String str) =>
      DailyTasks.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DailyTasks.fromMap(Map<String, dynamic> json) => DailyTasks(
        dailyTasks: json["daily_tasks"] == null
            ? []
            : List<DailyTask>.from(
                json["daily_tasks"]!.map((x) => DailyTask.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "daily_tasks": dailyTasks == null
            ? []
            : List<dynamic>.from(dailyTasks!.map((x) => x.toMap())),
      };
}

class DailyTask {
  int? id;
  int? userId;
  int? projectId;
  String? taskDesc;

  DailyTask({
    this.id,
    this.userId,
    this.projectId,
    this.taskDesc,
  });

  factory DailyTask.fromJson(String str) => DailyTask.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DailyTask.fromMap(Map<String, dynamic> json) => DailyTask(
        id: json["id"],
        userId: json["user_id"],
        projectId: json["project_id"],
        taskDesc: json["task_desc"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "user_id": userId,
        "project_id": projectId,
        "name": taskDesc,
      };
}
