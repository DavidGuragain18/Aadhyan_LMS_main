// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_completed_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookCompletedModel _$BookCompletedModelFromJson(Map<String, dynamic> json) =>
    BookCompletedModel(
      id: json['id'] as String?,
      title: json['title'] as String?,
      subtitle: json['subtitle'] as String?,
      description: json['description'] as String?,
      image: json['image'] as String?,
      course: json['course'] as String?,
      level: json['level'] as String?,
    );

Map<String, dynamic> _$BookCompletedModelToJson(BookCompletedModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'subtitle': instance.subtitle,
      'description': instance.description,
      'image': instance.image,
      'course': instance.course,
      'level': instance.level,
    };
