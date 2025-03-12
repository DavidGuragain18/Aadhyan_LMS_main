import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learn_management_system/features/home/presentation/state/home_state.dart';

final homeViewModelProvider = StateNotifierProvider<HomeViewModel, HomeState>((ref){
  return HomeViewModel();
});

class HomeViewModel extends StateNotifier<HomeState>{
  HomeViewModel() : super(HomeState.initial());

  void onChangeIndex(int index){
    state = state.copyWith(index: index);
  }
}