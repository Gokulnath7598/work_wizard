    // :id, :user_id, project:{id: , project_name:), :task_description, :status, :effort, :created_at
import 'package:my_macos_app/models/projects.dart';

class TimeLine {

  TimeLine({this.id, this.userID, this.status, this.createdAt, this.effort, this.project, this.taskDescription});

  TimeLine.fromJson(Map<String, dynamic>? json) {
    id = json?['id'] as int?;
    userID = json?['user_id'] as int?;
    project = Project.fromMap(json?['project'] as Map<String, dynamic>);
    taskDescription = json?['task_description'] as String?;
    status = json?['status'] as String?;
    effort = json?['effort'] as String?;
    createdAt = json?['created_at'] as String?;

  }
  int? id;
  int? userID;
  Project? project;
  String? taskDescription;
  String? status;
  String? effort;
  String? createdAt;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userID;
    data['project'] = project;
    data['task_description'] = taskDescription;
    data['status'] = status;
    data['effort'] = effort;
    data['created_at'] = createdAt;
    return data;
  }
}
