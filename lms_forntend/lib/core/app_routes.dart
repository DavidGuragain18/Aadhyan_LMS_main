import 'package:learn_management_system/ai_chatbot/chat_page.dart';
import 'package:learn_management_system/choose_course.dart';
import 'package:learn_management_system/core/test.dart';
import 'package:learn_management_system/features/auth/presentation/view/getting_started.dart';
import 'package:learn_management_system/features/auth/presentation/view/login_view.dart';
import 'package:learn_management_system/features/auth/presentation/view/register_view.dart';
import 'package:learn_management_system/features/competedbook/presentation/view/book_completed_detail_view.dart';
import 'package:learn_management_system/features/competedbook/presentation/view/book_completed_view.dart';
import 'package:learn_management_system/features/course/presentation/view/select_course.dart';
import 'package:learn_management_system/features/home/dashboard_view.dart';
import 'package:learn_management_system/features/home/presentation/view/bottom_view.dart';
import 'package:learn_management_system/features/competedbook/presentation/view/books_detail_view.dart';
import 'package:learn_management_system/features/home/searc_page_view.dart';
import 'package:learn_management_system/features/home/widgets_page/id_card.dart';
import 'package:learn_management_system/features/profile/presentation/widgets/edit_profile.dart';

class AppRoute {
  AppRoute._();

  static const String bottomViewRoute = '/bottomViewRoute';
  static const String registerViewRoute = '/registerviewroute';
  static String loginViewRoute = '/loginViewRoute';
  static String chooseCourseRoute = '/chooseCourseRoute';
  static String gettingStartedRoute = '/gettingStartedRoute';
  static String dashboardViewRoute = '/dashboardViewRoute';
  static String testViewRoute = '/testViewRoute';
  static String editprofileViewRoute = '/editprofileViewRoute';
  static String selectcourseViewRoute = '/selectcourseViewRoute';
  static String idCardViewRoute = '/idCardViewRoute';
  static String chatPageViewRoute = '/chatPageViewRoute';
  static String booksViewRoute = '/booksViewRoute';
  static String searchpageViewRoute = '/searchpageViewRoute';
  static String bookCompletedViewRoute = '/bookCompletedViewRoute';
  static String bookCompleteddetaildViewRoute = '/bookCompleteddetaildViewRoute';

  static getApplicationRoute() {
    return {
      registerViewRoute: (context) => const RegisterView(),
      gettingStartedRoute: (context) => const GettingStarted(),
      loginViewRoute: (context) => const LoginView(),
      dashboardViewRoute: (context) => const DashboardView(),
      bottomViewRoute: (context) => BottomView(),
      chooseCourseRoute: (context) => const ChooseCourse(),
      testViewRoute: (context) => const Test(),
      editprofileViewRoute: (context) => const EditProfileView(),
      selectcourseViewRoute: (context) => const SelectCourseView(),
      chatPageViewRoute: (context) => const ChatPage(),
      idCardViewRoute: (context) => const IdCard(),
      booksViewRoute: (context) => const BooksDetailView(),
      searchpageViewRoute: (context) => const SearcPageView(),
      bookCompletedViewRoute: (context) => const BookCompletedView(),
      bookCompleteddetaildViewRoute: (context) => const BookCompletedDetailView(),
    };
  }
}
