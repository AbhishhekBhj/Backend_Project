import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:mygymbuddy/features/add%20water%20drank/bloc/bloc/water_drink_bloc.dart';
import 'package:mygymbuddy/features/calories/bloc/calories_bloc.dart';
import 'package:mygymbuddy/features/internet/bloc/bloc/internet_bloc.dart';
import 'package:mygymbuddy/features/login/bloc/login_bloc.dart';
import 'package:mygymbuddy/features/measurements/bloc/bloc/measurements_bloc.dart';
import 'package:mygymbuddy/features/signup/bloc/signup_bloc.dart';
import 'package:mygymbuddy/features/workout/bloc/bloc/workout_bloc.dart';
import 'package:mygymbuddy/firebase_options.dart';
import 'package:mygymbuddy/provider/themes/theme_provider.dart';
import 'package:mygymbuddy/screens/splash_screen/splash_screen.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'features/home/bloc/home_bloc.dart';
import 'firebaseapi/firebase_api.dart';
import 'functions/exercise.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'services/notification_services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Initialize Firebase Messaging
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  await messaging.requestPermission();

  // Initialize time zones
  tz.initializeTimeZones();

  // Initialize shared preferences
  SharedPreferences preferences = await SharedPreferences.getInstance();

  // Get the application document directory
  final appDocumentDir = await getApplicationDocumentsDirectory();

  // Initialize Firebase API
  await FirebaseAPI().initialize();
  NotificationService().initNotification();

  // Initialize Hive
  Hive.init(appDocumentDir.path);
  Hive.registerAdapter(ExerciseAdapter());

  runApp(
    ChangeNotifierProvider(
      create: (BuildContext context) {
        return ThemeProvider(
            isDarkMode: preferences.getBool('isDarkTheme') ??
                false); // dark or light theme based on the value of the shared preference
      },
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider<HomeBloc>(
              create: (BuildContext context) => HomeBloc(),
            ),
            BlocProvider<WaterDrinkBloc>(
              create: (context) => WaterDrinkBloc(),
            ),
            BlocProvider<WorkoutBloc>(
              create: (context) => WorkoutBloc(),
            ),
            BlocProvider<SignupBloc>(
              create: (context) => SignupBloc(),
            ),
            BlocProvider<InternetBloc>(
              create: (context) => InternetBloc(),
            ),
            BlocProvider<LoginBloc>(
              create: (context) => LoginBloc(),
            ),
            BlocProvider<MeasurementsBloc>(
              create: (context) => MeasurementsBloc(),
            ),
            BlocProvider<CaloriesBloc>(
              create: (context) => CaloriesBloc(),
            ),
          ],
          child: GetMaterialApp(
            title: 'My Gym Buddy',
            theme: themeProvider.getTheme,
            home: SplashScreen(),
            debugShowCheckedModeBanner: false,
          ),
        );
      },
    );
  }
}
