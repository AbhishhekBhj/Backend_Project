import 'package:flutter/material.dart';
import 'package:mygymbuddy/colours/colours.dart';
import 'package:mygymbuddy/data/models/app_features.dart';
import 'package:mygymbuddy/data/models/home_features_model.dart';
import 'package:mygymbuddy/texts/texts.dart';

import '../features/home/bloc/home_bloc.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(appName),
      centerTitle: true,
      backgroundColor: MyColors.accentPurple,
    );
  }
}

class LoginFormField extends StatelessWidget {
  const LoginFormField({
    super.key,
    required this.usernameController,
    required this.usernameLabel,
    required this.usernameHintText,
    required this.passwordController,
    required this.passwordLabel,
    required this.passwordHintText,
  });

  final TextEditingController usernameController;
  final String usernameLabel;
  final String usernameHintText;
  final TextEditingController passwordController;
  final String passwordLabel;
  final String passwordHintText;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: usernameController,
          decoration: InputDecoration(
              labelText: usernameLabel, hintText: usernameHintText),
        ),
        SizedBox(height: 2.0),
        TextFormField(
          controller: passwordController,
          obscureText: true,
          decoration: InputDecoration(
              labelText: passwordLabel, hintText: passwordHintText),
        ),
      ],
    );
  }
}
class FeaturesWidget extends StatelessWidget {
  const FeaturesWidget({
    Key? key,
    required this.features,
    required this.textTheme,
    required this.homeBloc,
  }) : super(key: key);

  final List<Features> features;
  final HomeBloc homeBloc;
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              homeBloc.add(OptionIconClickedEvent());
            },
            icon: Icon(Icons.menu),
          ),
          automaticallyImplyLeading: false,
          title: Text(
            appName,
            style: textTheme.headlineMedium,
          ),
          centerTitle: true,
          backgroundColor: MyColors.accentPurple,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 10),
            child: Column(
              children: [
                GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: features.length,
                  gridDelegate:
                      const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    childAspectRatio: 1,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 10,
                  ),
                  itemBuilder: (context, index) {
                    final feature = features[index]; // Get the feature

                    return Container(
                      padding: EdgeInsets.all(9.0),
                      decoration: BoxDecoration(
                        border:
                            Border.all(color: MyColors.darkBlue, width: 3),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: InkWell(
                        onTap: feature.onTap,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(feature.image),
                            Text(
                              feature.title,
                              style: textTheme.headlineSmall,
                            ),
                            Text(
                              feature.subTitle,
                              style: textTheme.labelMedium,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
