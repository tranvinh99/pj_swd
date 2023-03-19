import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class PostModel {
  final String? id;
  final String? title;
  final String? description;
  final String? status;
  final String? buildings;
  final String? rooms;
  final String? userPosting;
  final String? createdAt;
  final String? updatedAt;
  final String? img;

  PostModel({
    this.id,
    this.title,
    this.description,
    this.status,
    this.buildings,
    this.rooms,
    this.userPosting,
    this.createdAt,
    this.img,
    this.updatedAt,
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
      'img': img,
    };
  }

  factory PostModel.fromMap(Map<String, dynamic> map) {
    return PostModel(
      id: map['_id'] ?? 'unknowned',
      title: map['title'] ?? 'unknowned',
      description: map['description'] ?? 'unknowned',
      status: map['status'] ?? 'unknowned',
      buildings: map['buildings'] ?? 'unknowned',
      rooms: map['rooms'] ?? 'unknowned',
      userPosting: map['userPosting'] ?? 'unknowned',
      createdAt: map['createdAt'] ?? 'unknowned',
      updatedAt: map['updatedAt'] ?? 'unknowned',
      img: map['img'],
    );
  }

  String toJson() => json.encode(toMap());

  factory PostModel.fromJson(String source) =>
      PostModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
