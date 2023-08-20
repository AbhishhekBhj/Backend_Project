import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mygymbuddy/colours/colours.dart';
import 'package:mygymbuddy/data/models/app_features.dart';
import 'package:mygymbuddy/features/home/ui/drawer.dart';
import 'package:mygymbuddy/texts/texts.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final featuresList = Features.featuresList;
    return Scaffold(
        backgroundColor: Colors.grey[100],
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text(
            appName,
            style: textTheme.displaySmall,
          ),
          centerTitle: true,
          backgroundColor: MyColors.accentPurple,
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: Icon(FontAwesomeIcons.bars),
            onPressed: () {
              _scaffoldKey.currentState?.openDrawer();
            },
          ),
        ),
        drawer: MyDrawer(), // Replace with your actual drawer content
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 10),
            child: Column(
              children: [
                GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: featuresList.length,
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    childAspectRatio: 1,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 10,
                  ),
                  itemBuilder: (context, index) => Container(
                    padding: EdgeInsets.all(9.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: MyColors.darkBlue, width: 3),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: InkWell(
                      onTap: featuresList[index].onTap,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(featuresList[index].image),
                          Text(
                            featuresList[index].title,
                            style: textTheme.headlineSmall,
                          ),
                          Text(
                            featuresList[index].subTitle,
                            style: textTheme.labelMedium,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
