import 'dart:convert';

class User {
  UserClass? user;

  User({
    this.user,
  });

  factory User.fromJson(String str) => User.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory User.fromMap(Map<String, dynamic> json) => User(
        user: json["user"] == null ? null : UserClass.fromMap(json["user"]),
      );

  Map<String, dynamic> toMap() => {
        "user": user?.toMap(),
      };
}

class UserClass {
  int? id;
  String? name;
  String? email;
  List<WorkingProject>? workingProjects;
  WorkingHours? workingHours;

  UserClass({
    this.id,
    this.name,
    this.email,
    this.workingProjects,
    this.workingHours,
  });

  factory UserClass.fromJson(String str) => UserClass.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserClass.fromMap(Map<String, dynamic> json) => UserClass(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        workingProjects: json["working_projects"] == null
            ? []
            : List<WorkingProject>.from(json["working_projects"]!
                .map((x) => WorkingProject.fromMap(x))),
        workingHours: json["working_hours"] == null
            ? null
            : WorkingHours.fromMap(json["working_hours"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "email": email,
        "working_projects": workingProjects == null
            ? []
            : List<dynamic>.from(workingProjects!.map((x) => x.toMap())),
        "working_hours": workingHours?.toMap(),
      };
}

class WorkingHours {
  String? startTime;
  String? endTime;

  WorkingHours({
    this.startTime,
    this.endTime,
  });

  factory WorkingHours.fromJson(String str) =>
      WorkingHours.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory WorkingHours.fromMap(Map<String, dynamic> json) => WorkingHours(
        startTime: json["start_time"],
        endTime: json["end_time"],
      );

  Map<String, dynamic> toMap() => {
        "start_time": startTime,
        "end_time": endTime,
      };
}

class WorkingProject {
  int? id;
  String? name;

  WorkingProject({
    this.id,
    this.name,
  });

  factory WorkingProject.fromJson(String str) =>
      WorkingProject.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory WorkingProject.fromMap(Map<String, dynamic> json) => WorkingProject(
        id: json["id"],
        name: json["project_name"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "project_name": name,
      };
}
