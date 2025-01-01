import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tentwenty_task/utils/bloc_providers.dart';
import 'package:tentwenty_task/utils/size_utils.dart';
import 'package:tentwenty_task/view/widgets/bottom_nav_bar.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return SizerUtils(
      builder: (context, orientation) {
        return MultiBlocProvider(
          providers: BlocProviders.providers,
          child: MaterialApp(
            title: 'TenTwenty Task',
            debugShowCheckedModeBanner: false,
            home:  BottomNavBar(),
          ),
        );
      },
    );
  }
}
