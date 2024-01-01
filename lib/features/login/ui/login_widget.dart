// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:mygymbuddy/colours/colours.dart';
// import 'package:mygymbuddy/features/home/ui/common_ui.dart';
// import 'package:mygymbuddy/features/login/ui/login_form_widget.dart';
// import 'package:mygymbuddy/features/signup/ui/signup.dart';
// import 'package:mygymbuddy/features/signup/ui/welcome_widget.dart';
// import 'package:mygymbuddy/utils/texts/texts.dart';

// class LoginWidget extends StatefulWidget {
//   const LoginWidget({super.key});

//   @override
//   State<LoginWidget> createState() => _LoginWidgetState();
// }

// class _LoginWidgetState extends State<LoginWidget> {
//   @override
//   Widget build(BuildContext context) {
//     final textTheme = Theme.of(context).textTheme;
//     final TextEditingController usernameController = TextEditingController();
//     final TextEditingController passwordController = TextEditingController();
//     final screenWidth = MediaQuery.of(context).size.width;

//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           appName,
//           style: textTheme.headlineMedium,
//         ),
//         centerTitle: true,
//         backgroundColor: MyColors.accentPurple,
//       ),
//       body: ListView(
//         children: [
//           UpperWelcome(textTheme: textTheme),
//           LowerWelcome(
//             textTheme: textTheme,
//             subTitle: loginJourney,
//           ),
//           SizedBox(height: 10),
//           LoginForm(
//             usernameController: usernameController,
//             passwordController: passwordController,
//             usernameLabel: usernameLabel,
//             passwordLabel: passwordLabel,
//             usernameHintText: usernameHintText,
//             passwordHintText: passwordHintText,
//           ),
//           ElevatedButton(
//             onPressed: () {
//               Get.to(BaseClass());
//             },
//             style: ElevatedButton.styleFrom(
//               backgroundColor:
//                   MyColors.darkPurple, // Background color of button
//               elevation: 3, // Elevation of button
//               shape: RoundedRectangleBorder(
//                 borderRadius:
//                     BorderRadius.circular(15), // Smaller border radius
//               ),
//               padding: EdgeInsets.symmetric(
//                   horizontal: 26, vertical: 10), // Adjust padding
//             ),
//             child: Text(
//               login,
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 14, // Smaller font size
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//           SizedBox(height: 10),
//           Padding(
//             padding: EdgeInsets.only(left: screenWidth * 0.25),
//             child: GestureDetector(
//               child: Text(dontHaveAccount, style: TextStyle(fontSize: 12)),
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                       builder: (context) =>
//                           Signup()), // Navigate to the Login page
//                 );
//               },
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
