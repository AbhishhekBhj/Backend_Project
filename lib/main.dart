import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:mygymbuddy/features/home/bloc/home_bloc.dart';

import 'screens/on_boarding_screen/ui/onboarding_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (context) => HomeBloc())],
      child: GetMaterialApp(
        title: 'My Gym Buddy',
        theme: ThemeData(
          useMaterial3: true,
          
        ),
        home: OnBoardScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
