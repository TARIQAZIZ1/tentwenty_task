import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tentwenty_task/utils/size_utils.dart';
import 'package:tentwenty_task/view/widgets/shared_widgets/text_widget.dart';
import '../../../cubits/bottom_nav/bottom_nav_cubit.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/enums.dart';
import 'image_widget.dart';

class BottomNavWidget extends StatelessWidget {
  const BottomNavWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final BottomNavItem currentItem =
        context.select((BottomNavBarCubit cubit) => cubit.state.selectedItem);

    return ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(27),
          topRight: Radius.circular(27),
        ),
        child: AnimatedBottomNavigationBar.builder(
          shadow: Shadow(
            color: AppColors.secondaryColor.withOpacity(0.25),
            blurRadius: 20.r,
          ),
          backgroundColor: AppColors.primaryColor,
          height: 75.h,
          itemCount: BottomNavItem.values.length,
          tabBuilder: (int index, bool isActive) =>
              buildNavItem(context, BottomNavItem.values[index], isActive),
          scaleFactor: 0.5,
          activeIndex: currentItem.index,
          onTap: (index) => context
              .read<BottomNavBarCubit>()
              .navBarItem(BottomNavItem.values[index]),
          gapLocation: GapLocation.none,
          notchSmoothness: NotchSmoothness.softEdge,
        ));
  }

  Widget buildNavItem(
    BuildContext context,
    BottomNavItem item,
    bool isActive,
  ) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: EdgeInsets.only(top: 4.h),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ImageWidget(
              path: item.icon,
              color: isActive ? AppColors.onPrimaryColor : AppColors.secondaryColor,
              height: 16.h,
              width: 16.w,
            ),
            SizedBox(
              height: 5.h,
            ),
            CustomText(
              item.label,
              style: textTheme.labelSmall?.copyWith(
                color: isActive ? AppColors.onPrimaryColor : AppColors.secondaryColor,
                fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
