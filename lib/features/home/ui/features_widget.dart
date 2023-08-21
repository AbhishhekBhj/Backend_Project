import 'package:flutter/material.dart';
import 'package:mygymbuddy/colours/colours.dart';
import 'package:mygymbuddy/data/models/app_features.dart';
import 'package:mygymbuddy/features/home/bloc/home_bloc.dart';


class HomeFeaturesWidget extends StatelessWidget {
  final HomeBloc homeBloc;
  HomeFeaturesWidget({
    super.key,
    required this.featuresList,
    required this.textTheme,
    required this.homeBloc
  });

  final List<Features> featuresList;
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
    );
  }
}
