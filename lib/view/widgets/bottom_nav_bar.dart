import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tentwenty_task/view/widgets/shared_widgets/bottom_nav_widget.dart';
import '../../cubits/bottom_nav/bottom_nav_cubit.dart';
import '../../utils/enums.dart';

class BottomNavBar extends StatelessWidget {
  BottomNavBar({
    super.key,
  });

  final children = BottomNavItem.values.map((e) => e.child).toList();

  int getScreenIndex({required int index}) {
    return index.clamp(0, children.length - 1);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavBarCubit, BottomNavState>(
      builder: (context, state) {
        return Scaffold(
          bottomNavigationBar: const BottomNavWidget(),
          body: IndexedStack(
            index: getScreenIndex(index: state.selectedItem.index),
            children: children,
          ),
        );
      },
    );
  }
}
