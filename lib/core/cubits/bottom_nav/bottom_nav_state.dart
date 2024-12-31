part of 'bottom_nav_cubit.dart';

class BottomNavState extends Equatable {
  final BottomNavItem selectedItem;

  const BottomNavState({
    this.selectedItem = BottomNavItem.watchScreen,
  });

  const BottomNavState.initial() : this();

  @override
  List<Object> get props => [selectedItem];

  BottomNavState copyWith({BottomNavItem? selectedItem}) {
    return BottomNavState(
      selectedItem: selectedItem ?? this.selectedItem,
    );
  }
}
