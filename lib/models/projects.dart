import 'dart:convert';

class Projects {
  List<Project>? projects;

  Projects({
    this.projects,
  });

  factory Projects.fromJson(String str) => Projects.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Projects.fromMap(Map<String, dynamic> json) => Projects(
        projects: json["projects"] == null
            ? []
            : List<Project>.from(
                json["projects"]!.map((x) => Project.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "projects": projects == null
            ? []
            : List<dynamic>.from(projects!.map((x) => x.toMap())),
      };
}

class Project {
  int? id;
  String? name;

  Project({
    this.id,
    this.name,
  });

  factory Project.fromJson(String str) => Project.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Project.fromMap(Map<String, dynamic> json) => Project(
        id: json["id"],
        name: json["project_name"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "project_name": name,
      };
}
