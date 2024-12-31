import 'package:flutter/material.dart';
import '../../view/widgets/dashboard.dart';
import '../../view/widgets/media_library.dart';
import '../../view/widgets/more_media.dart';
import '../../view/widgets/watch_screen.dart';
import 'assets.dart';

enum BottomNavItem {
  dashboardScreen(
    icon: Assets.dashboardIcon,
    child: DashBoardScreen(),
  ),
  watchScreen(
    icon: Assets.watchIcon,
    child: WatchScreen(),
  ),

  mediaLibrary(
    icon: Assets.libraryIcon,
    child: MediaLibraryScreen(),
  ),
  moreScreen(
    icon: Assets.moreIcon,
    child: MoreScreen(),
  );

  String get label {
    switch (this) {
      case BottomNavItem.dashboardScreen:
        return 'Dashboard';
      case BottomNavItem.watchScreen:
        return 'Watch';
      case BottomNavItem.mediaLibrary:
        return 'Media Library';
      case BottomNavItem.moreScreen:
        return 'More';
    }
  }

  final String icon;

  final Widget child;

  const BottomNavItem({
    required this.icon,
    required this.child,
  });
}
