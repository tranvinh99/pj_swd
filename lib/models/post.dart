import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class PostModel {
  final String id;
  final String title;
  final String description;
  final bool status;
  final String buildings;
  final String rooms;
  final String userPosting;
  final String createdAt;
  final String updatedAt;
  PostModel({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
    required this.buildings,
    required this.rooms,
    required this.userPosting,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'status': status,
      'buildings': buildings,
      'rooms': rooms,
      'userPosting': userPosting,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory PostModel.fromMap(Map<String, dynamic> map) {
    return PostModel(
      id: map['_id'] as String,
      title: map['title'] as String,
      description: map['description'] as String,
      status: map['status'] as bool,
      buildings: map['buildings'] as String,
      rooms: map['rooms'] as String,
      userPosting: map['userPosting'] as String,
      createdAt: map['createdAt'] as String,
      updatedAt: map['updatedAt'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory PostModel.fromJson(String source) =>
      PostModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
