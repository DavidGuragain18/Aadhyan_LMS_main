import 'package:flutter/material.dart';
import 'package:learn_management_system/features/course/presentation/view/course_view.dart';
import 'package:learn_management_system/features/home/dashboard_view.dart';
import 'package:learn_management_system/features/home/settings_view.dart';
import 'package:learn_management_system/features/profile/presentation/view/profile_view.dart';

class HomeState {
  final List<Widget> lstWidget;
  final int index;

  HomeState({required this.index, required this.lstWidget});

  factory HomeState.initial() {
    return HomeState(index: 0, lstWidget: [
      const DashboardView(),
      const CourseView(),
      const ProfileView(),
      SettingsView(),
    ]);
  }

  HomeState copyWith({int? index}) {
    return HomeState(index: index ?? this.index, lstWidget: lstWidget);
  }
}
