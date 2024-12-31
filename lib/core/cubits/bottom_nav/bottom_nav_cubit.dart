import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../utils/enums.dart';
part 'bottom_nav_state.dart';

class BottomNavBarCubit extends Cubit<BottomNavState> {
  BottomNavBarCubit() : super(const BottomNavState.initial());

  void navBarItem(BottomNavItem item) {
    emit(state.copyWith(selectedItem: item));
  }
}
