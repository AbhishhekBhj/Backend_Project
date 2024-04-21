import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'dart:developer';
import 'package:mygymbuddy/features/add%20water%20drank/bloc/bloc/water_drink_bloc.dart';
import 'package:mygymbuddy/features/calories/bloc/calories_bloc.dart';
import 'package:mygymbuddy/features/custommeal/bloc/custommeal_bloc.dart';
import 'package:mygymbuddy/features/internet/bloc/bloc/internet_bloc.dart';
import 'package:mygymbuddy/features/login/bloc/login_bloc.dart';
import 'package:mygymbuddy/features/measurements/bloc/bloc/measurements_bloc.dart';
import 'package:mygymbuddy/features/signup/bloc/signup_bloc.dart';
import 'package:mygymbuddy/firebase_options.dart';
import 'package:mygymbuddy/firebaseapi/firebase_api.dart';
import 'package:mygymbuddy/functions/exercise.dart';
import 'package:mygymbuddy/provider/themes/theme_provider.dart';
import 'package:mygymbuddy/services/notification_service.dart';
import 'package:mygymbuddy/services/notification_services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:khalti_flutter/khalti_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'features/food/bloc/bloc/food_bloc.dart';
import 'features/home/bloc/home_bloc.dart';
import 'features/profile/bloc/bloc/profile_bloc.dart';
import 'features/workout/bloc/bloc/workout_bloc.dart';
import 'screens/splash_screen/splash_screen.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:mygymbuddy/services/notification_service.dart';

// Import other necessary files and packages

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  FirebaseMessaging messaging = FirebaseMessaging.instance;
  // await messaging.requestPermission(

  // );
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  log('User granted permission: ${settings.authorizationStatus}');

  tz.initializeTimeZones();

  SharedPreferences preferences = await SharedPreferences.getInstance();

  await FirebaseAPI().initialize();
  NotificationService().initNotification();

  final appDocumentDir = await getApplicationDocumentsDirectory();

  Hive.init(appDocumentDir.path);
  Hive.registerAdapter(ExerciseAdapter());

  runApp(KhaltiScope(
    // Replace publicKey with your actual Khalti public key
    publicKey: "test_public_key_b6776fa7f40440ff864e4b820202c91e",
    builder: (context, navigatorKey) {
      return ChangeNotifierProvider(
        create: (BuildContext context) {
          return ThemeProvider(
            isDarkMode: preferences.getBool('isDarkTheme') ?? false,
          );
        },
        child: const MyAppContent(),
      );
    },
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  NotificationServices notificationServices = NotificationServices();

  @override
  void initState() {
    super.initState();
    // Initialize your notification services here
    notificationServices.requestNotificationPermission();
    notificationServices.forgroundMessage();
    notificationServices.firebaseInit(context);
    notificationServices.setupInteractMessage(context);
    notificationServices.isTokenRefresh();

    notificationServices.getDeviceToken().then((value) {
      if (kDebugMode) {
        print('device token');
        print(value);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MyAppContent();
  }
}

class MyAppContent extends StatefulWidget {
  const MyAppContent({Key? key}) : super(key: key);

  @override
  State<MyAppContent> createState() => _MyAppContentState();
}

class _MyAppContentState extends State<MyAppContent> {
  final navigatorKey = GlobalKey<NavigatorState>();
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MultiBlocProvider(
          providers: [
            // Add all your Bloc providers here
            BlocProvider<FoodBloc>(
              create: (BuildContext context) => FoodBloc(),
            ),
            BlocProvider<HomeBloc>(
              create: (BuildContext context) => HomeBloc(),
            ),
            BlocProvider<WaterDrinkBloc>(
              create: (BuildContext context) => WaterDrinkBloc(),
            ),
            BlocProvider<WorkoutBloc>(
              create: (BuildContext context) => WorkoutBloc(),
            ),
            BlocProvider<SignupBloc>(
              create: (BuildContext context) => SignupBloc(),
            ),
            BlocProvider<InternetBloc>(
              create: (BuildContext context) => InternetBloc(),
            ),
            BlocProvider<LoginBloc>(
              create: (BuildContext context) => LoginBloc(),
            ),
            BlocProvider<MeasurementsBloc>(
              create: (BuildContext context) => MeasurementsBloc(),
            ),
            BlocProvider<CaloriesBloc>(
              create: (BuildContext context) => CaloriesBloc(),
            ),
            BlocProvider<ProfileBloc>(
              create: (BuildContext context) => ProfileBloc(),
            ),
            BlocProvider<CustommealBloc>(
              create: (context) => CustommealBloc(),
            )
          ],
          child: GetMaterialApp(
            localizationsDelegates: [
              KhaltiLocalizations.delegate,
            ],
            navigatorKey: navigatorKey,
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
