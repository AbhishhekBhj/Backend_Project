import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mygymbuddy/colours/colours.dart';
import 'package:mygymbuddy/widgets/widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePaageState();
}

class _HomePaageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(),
      body: Center(
        child: Column(
          children: [
            Container(
              color: MyColors.accentBlue,
              child: Text("abc\n cde\n"),
            ),
            Container(
              color: MyColors.accentBlue,
              child: Text("abc\n cde\n"),
            ),
            Container(
              color: MyColors.accentBlue,
              child: Text("abc\n cde\n"),
            ),
          ],
        ),
      ),
    );
  }
}
