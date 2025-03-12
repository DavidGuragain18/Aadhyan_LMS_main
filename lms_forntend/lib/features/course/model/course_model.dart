import 'package:json_annotation/json_annotation.dart';

part 'course_model.g.dart';

@JsonSerializable()
class CourseModel {
  @JsonKey(name: '_id')
  final String? id;
  final String? name;
  final String? description;
  final String? image;
  CourseModel({
    this.id,
    this.name,
    this.description,
    this.image,
  });

  factory CourseModel.fromJson(Map<String, dynamic> json) =>
      _$CourseModelFromJson(json);

  Map<String, dynamic> toJson() => _$CourseModelToJson(this);
}
