import '../models.dart';

class ProjectsList {
  ProjectsList({
    this.projects,
  });

  factory ProjectsList.fromJson(Map<String, dynamic> json) {
    return ProjectsList(
      projects: json['working_projects'] != null
          ? (json['working_projects'] as List<dynamic>).map(
              (e) {
                return Project.fromJson(
                  e as Map<String, dynamic>,
                );
              },
            ).toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'working_projects': projects
          ?.map(
            (e) => e.toJson(),
          )
          .toList(),
    };
  }

  final List<Project>? projects;
}
