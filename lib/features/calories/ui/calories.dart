import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'dart:io' show Platform;
import 'package:mygymbuddy/features/calories/bloc/calories_bloc.dart';
import 'package:mygymbuddy/data/models/food_model.dart';
import 'package:mygymbuddy/features/calories/ui/calories_loggind.dart';
import 'package:mygymbuddy/provider/themes/theme_provider.dart';
import 'package:provider/provider.dart';

class CaloricInformation extends StatefulWidget {
  CaloricInformation({Key? key, required this.callback}) : super(key: key);
  Function callback;

  @override
  State<CaloricInformation> createState() => _CaloricInformationState();
}

class _CaloricInformationState extends State<CaloricInformation> {
  final CaloriesBloc caloriesBloc = CaloriesBloc();
  final TextEditingController foodNameController = TextEditingController();

  @override
  void initState() {
    caloriesBloc.add(CaloriesInitalEvent());
    super.initState();
  }

  @override
  void dispose() {
    caloriesBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    bool isDarkMode = themeProvider.getTheme == themeProvider.darkTheme;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: Platform.isAndroid
                          ? const Icon(Icons.arrow_back)
                          : Icon(Icons.arrow_back_ios)),
                  const Text(
                    "Search Calories",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  )
                ],
              ),
              buildSearchTextField(context),
              BlocConsumer<CaloriesBloc, CaloriesState>(
                bloc: caloriesBloc,
                listenWhen: (previous, current) =>
                    current is CaloriesActionState,
                buildWhen: (previous, current) =>
                    current is! CaloriesActionState,
                listener: (context, state) {},
                builder: (context, state) {
                  print(state.runtimeType);
                  switch (state.runtimeType) {
                    // case CaloriesLoadingState:
                    //   return const SizedBox(); // Don't display anything during loading
                    case CaloriesFetchingState:
                      return const Center(child: CircularProgressIndicator());
                    case CaloriesFoundSuccessState:
                      return Expanded(
                        child: buildFoodList(
                            (state as CaloriesFoundSuccessState).foodModel,
                            context,
                            isDarkMode),
                      );

                    case CaloriesFoundErrorState:
                      return Container(
                        child: const Center(
                          child: Text("Food Item Not found in our Database"),
                        ),
                      );
                    default:
                      return const SizedBox();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSearchTextField(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: TextFormField(
          onChanged: (value) {
            if (foodNameController.text.isNotEmpty) {
              caloriesBloc.add(CaloriesSearchByNameEvent(
                foodModel: FoodModel(name: foodNameController.text),
              ));
            } else {}
          },
          controller: foodNameController,
          decoration: InputDecoration(
            labelText: 'Enter Food Name to Search',
            border: const OutlineInputBorder(),
            suffixIcon: IconButton(
              onPressed: () {
                FocusManager.instance.primaryFocus?.unfocus();

                print(foodNameController.text);
                // if (foodNameController.text.isNotEmpty) {
                //   caloriesBloc.add(CaloriesSearchByNameEvent(
                //     foodModel: FoodModel(name: foodNameController.text),
                //   ));
                // }
              },
              icon: const Icon(Icons.search),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildFoodList(
      List<FoodModel> foodModel, BuildContext buildContext, bool isDarkMode) {
    if (foodModel.isNotEmpty) {
      return Container(
        height: 500,
        child: ListView.builder(
          itemCount: foodModel.length,
          itemBuilder: (context, index) {
            final foodItem = foodModel[index];
            return GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CaloriesLoggingPage(
                            data: foodItem, callback: widget.callback)));
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.white),
                  color: isDarkMode
                      ? Colors.grey.shade600
                      : Colors.deepPurpleAccent,
                ),
                padding: const EdgeInsets.all(16.0),
                margin: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Name: ${foodItem.name}',
                      style: textStyle(isDarkMode),
                    ),
                    Text(
                      'Calories per Serving: ${foodItem.caloriesPerServing.toString()}',
                      style: textStyle(isDarkMode),
                    ),
                    Text(
                      'Serving Size: ${foodItem.servingSize.toString()} gm',
                      style: textStyle(isDarkMode),
                    ),
                    Text(
                      'Protein per Serving: ${foodItem.proteinPerServing.toString()} gm',
                      style: textStyle(isDarkMode),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      );
    } else {
      return const SizedBox();
    }
  }

  TextStyle textStyle(bool isDarkMode) {
    return TextStyle(color: isDarkMode ? Colors.white : Colors.black);
  }
}
