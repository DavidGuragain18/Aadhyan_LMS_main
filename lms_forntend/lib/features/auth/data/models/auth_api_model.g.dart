// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthApiModel _$AuthApiModelFromJson(Map<String, dynamic> json) => AuthApiModel(
      fullName: json['fullName'] as String?,
      email: json['email'] as String?,
      userName: json['userName'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      password: json['password'] as String?,
      selectedCourse: (json['selectedCourse'] as List<dynamic>?)
          ?.map((e) => CourseModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      image: json['image'] as String?,
      books: (json['books'] as List<dynamic>?)
          ?.map((e) => BookModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      bookCompleted: (json['bookCompleted'] as List<dynamic>?)
          ?.map((e) => BookCompletedModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AuthApiModelToJson(AuthApiModel instance) =>
    <String, dynamic>{
      'fullName': instance.fullName,
      'email': instance.email,
      'userName': instance.userName,
      'phoneNumber': instance.phoneNumber,
      'password': instance.password,
      'selectedCourse': instance.selectedCourse,
      'image': instance.image,
      'books': instance.books,
      'bookCompleted': instance.bookCompleted,
    };
