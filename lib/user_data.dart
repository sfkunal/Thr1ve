import 'package:json_annotation/json_annotation.dart';

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
