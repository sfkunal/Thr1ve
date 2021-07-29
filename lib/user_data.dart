import 'package:json_annotation/json_annotation.dart';

class Node {
  double rating;
  String question;
  String category;

  Node(this.rating, this.question, this.category);

  String toString() {
    return this.question + " " + this.rating.toString() + " " + this.category;
  }
}

@JsonSerializable()
class UserData {
  List<dynamic> answerList;

  UserData(this.answerList);

  UserData.fromJson(Map<String, dynamic> json)
      : answerList = json['answerList'];

  Map<String, dynamic> toJson() => {
        'answerList': answerList,
      };
}
