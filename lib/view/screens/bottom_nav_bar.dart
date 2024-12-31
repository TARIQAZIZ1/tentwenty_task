import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import '../../core/cubits/bottom_nav/bottom_nav_cubit.dart';
import '../../core/utils/enums.dart';
import '../widgets/bottom_nav_bar.dart';
import '../widgets/shared_widgets/base_scaffold_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final children = BottomNavItem.values.map((e) => e.child).toList();

    useEffect(() {
      return null;
    }, []);

    return BaseScaffoldWidget(
      body: BlocBuilder<BottomNavBarCubit, BottomNavState>(
        builder: (context, state) {
          return BottomNavBar();
        },
      ),
    );
  }
}


