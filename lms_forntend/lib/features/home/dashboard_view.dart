import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learn_management_system/config/common/app_color.dart';
import 'package:learn_management_system/config/common/reusable_text.dart';
import 'package:learn_management_system/core/app_routes.dart';
import 'package:learn_management_system/features/auth/presentation/view_model/auth_view_model.dart';
import 'package:learn_management_system/features/book/presentation/view_model/book_view_model.dart';
import 'package:learn_management_system/features/course/presentation/view/select_course.dart';
import 'package:learn_management_system/features/profile/presentation/view_model/profile_view_model.dart';

class DashboardView extends ConsumerStatefulWidget {
  const DashboardView({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DashboardViewState();
}

class _DashboardViewState extends ConsumerState<DashboardView> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await ref.read(bookViewModelProvider.notifier).getBeginnerBook();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, watch, child) {
        final authState = ref.watch(authViewModelProvider);
        final profileState = ref.watch(profileViewModelProvider);

        final bookState = ref.watch(bookViewModelProvider);

        if (authState.currentUser.selectedCourse == null ||
            authState.currentUser.selectedCourse!.isEmpty) {
          return SelectCourseView();
        } else if (profileState.isLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (profileState.error != null) {
          return Center(child: Text('Error: ${profileState.error}'));
        } else {
          return Scaffold(
            body: Stack(
              children: [
                Column(
                  children: [
                    Expanded(
                      child: Container(
                        color: kMilkLight,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 270),
                          child: ListView.builder(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            itemCount:
                                // profileState.users?.first.books!.length ?? 0,
                                bookState.books!.length ?? 0,
                            itemBuilder: (context, index) {
                              final book =
                                  // profileState.users!.first.books![index];
                                  bookState.books![index];
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 3.0),
                                child: Card(
                                  color: Color.fromARGB(255, 172, 174, 238),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  // margin: const EdgeInsets.all(8.0),
                                  elevation: 5,
                                  child: InkWell(
                                    onTap: () {
                                      // print('${book.id}');
                                      Navigator.pushNamed(
                                        context,
                                        AppRoute.booksViewRoute,
                                        arguments: book,
                                      );
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Container(
                                                height: 70,
                                                width: 100,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  image: DecorationImage(
                                                    image: _getImageProvider(
                                                        "${book.image}"),
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(width: 16),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "${book.title}",
                                                      style: TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    SizedBox(height: 8),
                                                    Text(
                                                      book.subtitle ?? '',
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.grey[600],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 16),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: ReusableText(
                                text:
                                    'Quick Access for Learn Management System',
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: kButton),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                height: 100,
                                width: 100,
                                child: InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, AppRoute.idCardViewRoute);
                                  },
                                  child: Card(
                                    elevation: 10,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5)),
                                    color: Color(kButton.value),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        CircleAvatar(
                                          backgroundColor: Colors.transparent,
                                          backgroundImage:
                                              AssetImage('assets/icons/id.png'),
                                        ),
                                        ReusableText(
                                            text: 'ID Card',
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold,
                                            color: Color(kLight.value)),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, AppRoute.bookCompletedViewRoute);
                                },
                                child: Container(
                                  height: 100,
                                  width: 100,
                                  child: Card(
                                    elevation: 10,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5)),
                                    color: Color(kButton.value),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        CircleAvatar(
                                          backgroundColor: Colors.transparent,
                                          backgroundImage: AssetImage(
                                              'assets/icons/progress.png'),
                                        ),
                                        ReusableText(
                                            text: 'Progress',
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold,
                                            color: Color(kLight.value)),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                height: 100,
                                width: 100,
                                child: InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, AppRoute.chatPageViewRoute);
                                  },
                                  child: Card(
                                    elevation: 10,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5)),
                                    color: Color(kButton.value),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        CircleAvatar(
                                          backgroundColor: Colors.transparent,
                                          backgroundImage: AssetImage(
                                              'assets/icons/chatbot.png'),
                                        ),
                                        ReusableText(
                                            text: 'ChatBot',
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold,
                                            color: Color(kLight.value)),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    )
                  ],
                ),
                Container(
                  height: 250,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [kButton, kButton.withOpacity(0.8)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ReusableText(
                              text: 'LearnEase',
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              color: kLight,
                            ),
                            ReusableText(
                              text: 'Welcome ${authState.currentUser.fullName}',
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: kLight,
                            ),
                          ],
                        ),
                        Container(
                          width: 100.0,
                          height: 100.0,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: _getProfileImageProvider(
                                  "${authState.currentUser.image}"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 16,
                  right: 16,
                  top: 200,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: InkWell(
                      onTap: () {
                        Navigator.pushNamed(
                            context, AppRoute.searchpageViewRoute);
                      },
                      child: Container(
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 10,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            children: [
                              Icon(Icons.search),
                              SizedBox(
                                width: 20,
                              ),
                              ReusableText(
                                  text: 'Tap to Search....',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: kButton),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }

  ImageProvider _getImageProvider(String imageUrl) {
    if (imageUrl.startsWith('http')) {
      return NetworkImage(imageUrl);
    } else if (imageUrl.startsWith('data:image')) {
      return MemoryImage(base64Decode(imageUrl.split(',').last));
    } else if (imageUrl.isNotEmpty) {
      // Assuming this case handles local file paths.
      return FileImage(File(imageUrl));
    } else {
      // Use a default image for invalid URLs
      return AssetImage('assets/images/logo.png');
    }
  }

  ImageProvider _getProfileImageProvider(String imageUrl) {
    if (imageUrl.startsWith('http')) {
      return NetworkImage(imageUrl);
    } else {
      // Use a default image for invalid URLs
      return AssetImage('assets/images/logo.png');
    }
  }
}
