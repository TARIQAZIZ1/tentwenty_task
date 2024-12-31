import 'package:flutter/material.dart';

import 'bottom_nav_widget.dart';
class BaseScaffoldWidget extends StatelessWidget {
  final Widget body;
  final AppBar? appBar;

  const BaseScaffoldWidget({
    super.key,
    required this.body,
    this.appBar,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: body,
      bottomNavigationBar: const BottomNavWidget(),
    );
  }
}
