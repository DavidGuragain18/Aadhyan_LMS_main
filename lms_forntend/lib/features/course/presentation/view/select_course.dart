// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:learn_management_system/config/common/app_color.dart';
// import 'package:learn_management_system/config/common/reusable_text.dart';
// import 'package:learn_management_system/features/course/presentation/viewmodel/course_view_model.dart';

// class SelectCourseView extends ConsumerStatefulWidget {
//   const SelectCourseView({Key? key}) : super(key: key);

//   @override
//   ConsumerState<ConsumerStatefulWidget> createState() =>
//       _SelectCourseViewState();
// }

// class _SelectCourseViewState extends ConsumerState<SelectCourseView> {
//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       ref.read(courseViewModelProvider.notifier).getCourse();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final courseState = ref.watch(courseViewModelProvider);

//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           onPressed: () {
//             Navigator.pop(context);
//           },
//           icon: Icon(
//             Icons.arrow_back_ios,
//             color: Colors.white,
//           ),
//         ),
//         title: ReusableText(
//           text: 'Select Course',
//           fontSize: 20,
//           fontWeight: FontWeight.w500,
//           color: Colors.white,
//         ),
//         backgroundColor: Color(kButton.value),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             ReusableText(
//               text: "Please select course to Start your journey",
//               fontSize: 18,
//               fontWeight: FontWeight.bold,
//               color: Colors.red,
//             ),
//             SizedBox(height: 10),
//             if (courseState.isLoading)
//               Center(child: CircularProgressIndicator())
//             else if (courseState.error != null)
//               Center(
//                 child: Text(
//                   'Error: ${courseState.error}',
//                   style: TextStyle(color: Colors.red),
//                 ),
//               )
//             else if (courseState.courses == null ||
//                 courseState.courses!.isEmpty)
//               Center(child: Text('No courses available'))
//             else
//               Expanded(
//                 child: ListView.builder(
//                   itemCount: courseState.courses!.length,
//                   itemBuilder: (context, index) {
//                     final course = courseState.courses![index];
//                     return ListTile(
//                       horizontalTitleGap: 20,
//                       minVerticalPadding: 20,
//                       leading: CircleAvatar(
//                         radius: 30,
//                         backgroundImage: NetworkImage('${course.image}'),
//                       ),
//                       title: ReusableText(
//                         text: '${course.name}',
//                         fontSize: 18,
//                         fontWeight: FontWeight.w800,
//                         color: Color(kDark.value),
//                       ),
//                       onTap: () async {
//                         if (course.id != null) {
//                           await ref
//                               .read(courseViewModelProvider.notifier)
//                               .selectCourse(course.id!, context,);
//                         } else {
//                           // Handle the case where course.id is null
//                           ScaffoldMessenger.of(context).showSnackBar(
//                             SnackBar(
//                               content: Text('Course ID is null'),
//                             ),
//                           );
//                         }
//                       },
//                     );
//                   },
//                 ),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learn_management_system/config/common/app_color.dart';
import 'package:learn_management_system/config/common/reusable_text.dart';
import 'package:learn_management_system/features/course/presentation/viewmodel/course_view_model.dart';
import 'package:learn_management_system/core/app_routes.dart'; // Import your AppRoute file

class SelectCourseView extends ConsumerStatefulWidget {
  const SelectCourseView({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SelectCourseViewState();
}

class _SelectCourseViewState extends ConsumerState<SelectCourseView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      ref.read(courseViewModelProvider.notifier).getCourse();
    });
  }

  @override
  Widget build(BuildContext context) {
    final courseState = ref.watch(courseViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pushNamed(context, AppRoute.loginViewRoute);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
        title: ReusableText(
          text: 'Select Course',
          fontSize: 20,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
        backgroundColor: Color(kButton.value),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ReusableText(
              text: "Please select a course to start your journey",
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.red,
            ),
            SizedBox(height: 10),
            if (courseState.isLoading)
              Center(child: CircularProgressIndicator())
            else if (courseState.error != null)
              Center(
                child: Text(
                  'Error: ${courseState.error}',
                  style: TextStyle(color: Colors.red),
                ),
              )
            else if (courseState.courses == null ||
                courseState.courses!.isEmpty)
              Center(child: Text('No courses available'))
            else
              Expanded(
                child: ListView.builder(
                  itemCount: courseState.courses!.length,
                  itemBuilder: (context, index) {
                    final course = courseState.courses![index];
                    return ListTile(
                      horizontalTitleGap: 20,
                      minVerticalPadding: 20,
                      leading: CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage('${course.image}'),
                      ),
                      title: ReusableText(
                        text: '${course.name}',
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: Color(kDark.value),
                      ),
                      onTap: () async {
                        if (course.id != null) {
                          await ref
                              .read(courseViewModelProvider.notifier)
                              .selectCourse(course.id!, context);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Course ID is null'),
                            ),
                          );
                        }
                      },
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
