import 'package:learn_management_system/features/course/model/course_model.dart';

class CourseState {
  final bool isLoading;
  final List<CourseModel>? courses;
  final String? error;

  CourseState({
    required this.isLoading,
    this.courses,
    this.error,
  });

  factory CourseState.initial() {
    return CourseState(
      isLoading: false,
      courses: null,
      error: null,
    );
  }

  CourseState copyWith({
    bool? isLoading,
    List<CourseModel>? courses,
    String? error,
  }) {
    return CourseState(
      isLoading: isLoading ?? this.isLoading,
      courses: courses ?? this.courses,
      error: error ?? this.error,
    );
  }
}
