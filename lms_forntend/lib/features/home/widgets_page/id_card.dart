import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learn_management_system/config/common/app_color.dart';
import 'package:learn_management_system/config/common/reusable_text.dart';
import 'package:learn_management_system/features/profile/presentation/view_model/profile_view_model.dart';

class IdCard extends ConsumerStatefulWidget {
  const IdCard({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _IdCardState();
}

class _IdCardState extends ConsumerState<IdCard> {
  @override
  Widget build(BuildContext context) {
    final profileState = ref.watch(profileViewModelProvider);
    final profile = profileState.users?.first;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kButton,
        title: const ReusableText(
          text: 'ID Card',
          fontSize: 20,
          fontWeight: FontWeight.w500,
          color: kLight,
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              height: 500,
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(width: 2, color: kButton),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8,
                    spreadRadius: 4,
                  ),
                ],
              ),
              child: Column(
                // mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [kButton, kButton.withOpacity(0.8)],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ReusableText(
                          text: 'Digital ID',
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: kLight,
                        ),
                        const SizedBox(height: 16),
                        Container(
                          height: 120,
                          width: 120,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            border: Border.all(width: 4, color: kDark),
                            borderRadius: BorderRadius.circular(60),
                          ),
                          child: CircleAvatar(
                            backgroundColor: Colors.transparent,
                            radius: 50,
                            backgroundImage: profile?.image != null &&
                                    profile!.image!.isNotEmpty
                                ? NetworkImage(profile!.image!)
                                : AssetImage('assets/images/login_icon.png'),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        ReusableText(
                          text: '${profile!.userName}',
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: kDark,
                        ),
                        const SizedBox(height: 8),
                        ReusableText(
                          text: 'Student',
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: kDark.withOpacity(0.7),
                        ),
                        const SizedBox(height: 16),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(12.0),
                          decoration: BoxDecoration(
                            color: kLight,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 4,
                                spreadRadius: 2,
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.usb_rounded, color: kDark),
                                  const SizedBox(width: 8),
                                  ReusableText(
                                      text: '${profile.id}',
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: kDark),
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(Icons.badge, color: kDark),
                                  const SizedBox(width: 8),
                                  ReusableText(
                                    text: 'Full Name: ${profile.fullName}',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: kDark,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  Icon(Icons.business, color: kDark),
                                  const SizedBox(width: 8),
                                  ReusableText(
                                    text: 'Contact: ${profile.phoneNumber}',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: kDark,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  Icon(Icons.business, color: kDark),
                                  const SizedBox(width: 8),
                                  ReusableText(
                                    text:
                                        'Selected Course: ${profile.selectedCourse!.first.name}',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: kDark,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  Icon(Icons.calendar_today, color: kDark),
                                  const SizedBox(width: 8),
                                  ReusableText(
                                    text: 'Valid Till: ',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: kDark,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 40,
            ),
            ReusableText(
                text: 'ID Card For LearnEase',
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: kButton)
          ],
        ),
      ),
    );
  }
}
