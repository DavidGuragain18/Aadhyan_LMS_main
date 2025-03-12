import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learn_management_system/config/common/app_color.dart';
import 'package:learn_management_system/features/home/presentation/view_model/home_view_model.dart';

class BottomView extends ConsumerStatefulWidget {
  const BottomView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BottomViewState();
}

class _BottomViewState extends ConsumerState<BottomView> {
  @override
  Widget build(BuildContext context) {
    final homeState = ref.watch(homeViewModelProvider);
    return Scaffold(
      body: homeState.lstWidget[homeState.index],
      bottomNavigationBar: Container(
        child: GNav(
          tabs: const [
            GButton(
              icon: Icons.home,
              text: 'Home',
            ),
            GButton(
              icon: Icons.usb_rounded,
              text: 'Course',
            ),
            GButton(
              icon: Icons.verified,
              text: 'Profile',
            ),
            GButton(
              icon: Icons.settings,
              text: 'Settings',
            ),
          ],
          tabBackgroundColor: kButton,
          backgroundColor: kButton,
          activeColor: kLight,
          color: kLight,
          hoverColor: kLight,
          onTabChange: (index) {
            ref.read(homeViewModelProvider.notifier).onChangeIndex(index);
          },
        ),
      ),
    );
  }
}
