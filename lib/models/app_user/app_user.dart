import 'package:my_macos_app/models/models.dart';

class AppUser {
  AppUser({
    this.email,
    this.id,
    this.name,
    this.workingProjects,
  });

  factory AppUser.fromJson(Map<String, dynamic> json) {
    return AppUser(
      email: json['email'] as String?,
      id: json['id'] as int?,
      name: json['name'] as String?,
      workingProjects: ProjectsList.fromJson(
        json,
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'working_projects': workingProjects?.projects
          ?.map(
            (e) => e.toJson(),
          )
          .toList(),
    };
  }

  final int? id;
  final String? name;
  final String? email;
  final ProjectsList? workingProjects;
}
