import 'package:equatable/equatable.dart';

class UserProfilingModel with EquatableMixin {
  UserProfilingModel({this.status, this.message, this.data});

  UserProfilingModel.fromJson(Map<String, dynamic>? json) {
    status = json?['status'] as bool?;
    message = json?['message'] as String?;
    data = (json?['data'] as List<dynamic>)
        .map((dynamic x) => Question.fromJson(x as Map<String, dynamic>))
        .toList();
  }

  bool? status;
  String? message;
  List<Question>? data;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((Question v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  List<Object?> get props => <Object?>[
        status,
        data,
        message,
      ];
}

class Question with EquatableMixin {
  Question({this.id, this.questionText, this.choices});

  Question.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int?;
    questionText = json['question_text'] as String?;
    choices = (json['choices'] as List<dynamic>)
        .map((dynamic x) => Choices.fromJson(x as Map<String, dynamic>))
        .toList();
  }

  int? id;
  String? questionText;
  List<Choices>? choices;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['question_text'] = questionText;
    if (choices != null) {
      data['choices'] = choices!.map((Choices v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  List<Object?> get props => <Object?>[
        id,
        questionText,
        choices,
      ];
}

class Choices {
  Choices({this.id, this.choiceText});

  Choices.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int?;
    choiceText = json['choice_text'] as String?;
  }

  int? id;
  String? choiceText;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['choice_text'] = choiceText;
    return data;
  }
}

class UserProfilingAnswers with EquatableMixin {
  UserProfilingAnswers({
    this.status,
    this.message,
    this.answers,
  });

  UserProfilingAnswers.fromJson(Map<String, dynamic>? json) {
    status = json?['status'] as bool?;
    message = json?['message'] as String?;
    answers = (json?['data'] as List<dynamic>)
        .map((dynamic x) => Answer.fromJson(x as Map<String, dynamic>))
        .toList();
  }

  bool? status;
  String? message;
  List<Answer>? answers;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'data': List<dynamic>.from(
            answers?.map((Answer x) => x.toJson()) ?? <Answer>[]),
      };

  @override
  List<Object?> get props => <Object?>[
        status,
        message,
        answers,
      ];
}

class Answer with EquatableMixin {
  Answer({
    this.questionId,
    this.choiceId,
  });

  factory Answer.fromJson(Map<String, dynamic> json) => Answer(
        questionId: json['question_id'] as int?,
        choiceId: json['choice_id'] as int?,
      );

  int? questionId;
  int? choiceId;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'question_id': questionId,
        'choice_id': choiceId,
      };

  @override
  List<Object?> get props => <Object?>[
        questionId,
        choiceId,
      ];
}
