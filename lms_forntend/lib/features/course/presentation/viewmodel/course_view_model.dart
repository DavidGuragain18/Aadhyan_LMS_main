import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:learn_management_system/core/provider/flutter_secure_storage_provider.dart';
import 'package:learn_management_system/features/course/datasource/course_remote_datasource.dart';
import 'package:learn_management_system/features/course/presentation/state/course_state.dart';
import 'package:learn_management_system/features/home/presentation/view/bottom_view.dart';

final courseViewModelProvider =
    StateNotifierProvider<CourseViewModel, CourseState>((ref) {
  return CourseViewModel(
    ref.read(courseRemoteDatasourceProvider),
    ref.read(flutterSecureStorageProvider),
  );
});

class CourseViewModel extends StateNotifier<CourseState> {
  final CourseRemoteDatasource courseRemoteDatasource;
  final FlutterSecureStorage flutterSecureStorage;

  CourseViewModel(this.courseRemoteDatasource, this.flutterSecureStorage)
      : super(CourseState.initial());

  Future<void> getCourse() async {
    state = state.copyWith(isLoading: true);
    final result = await courseRemoteDatasource.getAllCourse();

    result.fold(
      (failure) {
        state = state.copyWith(isLoading: false, error: failure.error);
      },
      (success) {
        state = state.copyWith(
          isLoading: false,
          courses: success,
          error: null,
        );
      },
    );
  }

  Future<void> selectCourse(String courseId, BuildContext context) async {
  state = state.copyWith(isLoading: true);

  final result = await courseRemoteDatasource.selectCourse(courseId);

  result.fold(
    (failure) {
      state = state.copyWith(isLoading: false, error: failure.error);
      debugPrint('Error: ${failure.error}');
      EasyLoading.showError('Failed to select course');
    },
    (success) {
      state = state.copyWith(isLoading: false);
      EasyLoading.showSuccess('Course Selected, Go Back to Login \n Login Again');

      // Navigate only if the context is still valid and can navigate
      if (Navigator.canPop(context)) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => BottomView()),
        );
      } else {
        // Handle the scenario if the context is no longer valid
        debugPrint("Cannot navigate, context is invalid.");
      }
    },
  );
  }
}
