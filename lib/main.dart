// import ;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:mygymbuddy/features/home/bloc/home_bloc.dart';
import 'package:mygymbuddy/screens/splash_screen/splash_screen.dart';

// Import Firebase Core

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
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: SplashScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
