import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

class Node {
  final double rating;
  final String question;
  final String category;

  Node({required this.rating, required this.question, required this.category});

  String toString() {
    return this.question + " " + this.rating.toString() + " " + this.category;
  }

  factory Node.fromJson(Map<String, dynamic> jsonData) {
    return Node(
      rating: jsonData['rating'],
      question: jsonData['question'],
      category: jsonData['category'],
    );
  }

  static String encode(List<Node> node) => json.encode(
        node.map<Map<String, dynamic>>((node) => Node.toMap(node)).toList(),
      );

  static List<Node> decode(String node) => (json.decode(node) as List<dynamic>)
      .map<Node>((item) => Node.fromJson(item))
      .toList();

  static Map<String, dynamic> toMap(Node music) => {
        'rating': music.rating,
        'question': music.question,
        'category': music.category,
      };
}
