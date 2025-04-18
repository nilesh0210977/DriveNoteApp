import 'package:json_annotation/json_annotation.dart';

part 'note_model.g.dart';

@JsonSerializable()
class Note {
  final String id;
  final String title;
  String content;
  final DateTime lastModified;
  final String? driveFileId;
  
  Note({
    required this.id,
    required this.title,
    required this.content,
    required this.lastModified,
    this.driveFileId,
  });
  
  factory Note.fromJson(Map<String, dynamic> json) => _$NoteFromJson(json);
  Map<String, dynamic> toJson() => _$NoteToJson(this);
  
  Note copyWith({
    String? id,
    String? title,
    String? content,
    DateTime? lastModified,
    String? driveFileId,
  }) {
    return Note(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      lastModified: lastModified ?? this.lastModified,
      driveFileId: driveFileId ?? this.driveFileId,
    );
  }
}