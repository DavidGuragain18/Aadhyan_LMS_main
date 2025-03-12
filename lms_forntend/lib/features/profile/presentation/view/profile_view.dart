import 'package:babstrap_settings_screen/babstrap_settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learn_management_system/config/common/app_color.dart';
import 'package:learn_management_system/config/common/reusable_text.dart';
import 'package:learn_management_system/core/app_routes.dart';
import 'package:learn_management_system/features/profile/presentation/view_model/profile_view_model.dart';

class ProfileView extends ConsumerStatefulWidget {
  const ProfileView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfileViewState();
}

class _ProfileViewState extends ConsumerState<ProfileView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await ref.read(profileViewModelProvider.notifier).getProfile();
    });
  }

  @override
  Widget build(BuildContext context) {
    final profilestate = ref.watch(profileViewModelProvider);
    final profile = profilestate.users?.first;
    final _gap = SizedBox(
      height: 20,
    );

    return Scaffold(
      appBar: AppBar(
          backgroundColor: kButton,
          title: const ReusableText(
              text: 'My Profile',
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: kLight)),
      body: SafeArea(
        child: profilestate.isLoading
            ? Center(child: CircularProgressIndicator())
            : profile == null
                ? Center(child: Text('No profile data available.'))
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 5,
                      ),
                      Card(
                        elevation: 7,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        color: Color(kButton.value),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 50),
                                child: CircleAvatar(
                                  backgroundColor: Colors.transparent,
                                  radius: 50,
                                  backgroundImage: profile.image != null &&
                                          profile.image!.isNotEmpty
                                      ? NetworkImage(profile.image!)
                                      : AssetImage(
                                          'assets/images/login_icon.png'),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              ReusableText(
                                  text: '${profile.userName}'.toUpperCase(),
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Color(kLight.value)),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ReusableText(
                                          text: 'FullName',
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black),
                                      _gap,
                                      ReusableText(
                                          text: 'Email',
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black),
                                      _gap,
                                      ReusableText(
                                          text: 'PhoneNumber',
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black),
                                      _gap,
                                      ReusableText(
                                          text: 'SelectedCourse',
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ReusableText(
                                          text: '${profile.fullName}',
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black),
                                      _gap,
                                      ReusableText(
                                          text: '${profile.email}',
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black),
                                      _gap,
                                      ReusableText(
                                          text: '${profile.phoneNumber}',
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black),
                                      _gap,
                                      ReusableText(
                                          text:
                                              '${profile.selectedCourse!.first.name}',
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black),
                                    ],
                                  ),
                                ],
                              ),
                              _gap,
                              SettingsItem(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, AppRoute.editprofileViewRoute);
                                },
                                icons: Icons.edit,
                                iconStyle: IconStyle(
                                  iconsColor: Colors.white,
                                  withBackground: true,
                                  backgroundColor: Colors.red,
                                ),
                                title: 'Edit Profile',
                                subtitle: "Update",
                              ),
                              _gap,
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Image.asset(
                                    'assets/images/for_profile.png'),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
      ),
    );
  }
}
