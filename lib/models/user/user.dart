import 'package:my_macos_app/models/models.dart';

class User {
  User({
    this.email,
    this.id,
    this.name,
    this.workingProjects,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
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
