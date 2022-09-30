import 'package:equatable/equatable.dart';

class Posts extends Equatable {
  final int id;
  final String title;
  final String body;

  Posts({required this.id, required this.title, required this.body});

  @override
  List<Object?> get props => [id, title, body];

  factory Posts.fromJson(Map<String, dynamic> json) {
    Posts posts =
        Posts(id: json['id'], title: json['title'], body: json['body']);
    return posts;
  }
}
