class Data {
  Data({this.panNumber, this.dateOfBirth, this.name});

  Data.fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      panNumber = json['pan_number']?.toString();
      dateOfBirth = json['dob']?.toString();
      name = json['name']?.toString();
    }
  }

  String? panNumber;
  String? dateOfBirth;
  String? name;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['pan_number'] = panNumber;
    data['dob'] = dateOfBirth;
    data['name'] = name;
    return data;
  }
}
