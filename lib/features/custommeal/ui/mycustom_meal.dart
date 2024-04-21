import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mygymbuddy/data/models/calorie_logging_model.dart';
import 'package:mygymbuddy/features/calories/bloc/calories_bloc.dart';
import 'package:mygymbuddy/functions/shared_preference_functions.dart';
import '../../../data/models/food_model.dart';
import '../bloc/custommeal_bloc.dart';

class MyCustomMealPage extends StatefulWidget {
  const MyCustomMealPage({Key? key}) : super(key: key);

  @override
  State<MyCustomMealPage> createState() => _MyCustomMealPageState();
}

class _MyCustomMealPageState extends State<MyCustomMealPage> {
  late CustommealBloc custommealBloc;
  late CaloriesBloc caloriesBloc;

  @override
  void initState() {
    super.initState();
    custommealBloc = BlocProvider.of<CustommealBloc>(context);
    custommealBloc.add(GetMyCustomMeal());
    caloriesBloc = BlocProvider.of<CaloriesBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Custom Meal'),
      ),
      body: BlocConsumer<CustommealBloc, CustommealState>(
        listener: (context, state) {
          if (state is CaloriesLoggingLoadingState) {
            Fluttertoast.showToast(
                msg: "Logging Calories",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.green,
                textColor: Colors.white);
          }
          if (state is CaloriesLoggingSuccessState) {
            Fluttertoast.showToast(
                msg: "Calories logged successfully",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.green,
                textColor: Colors.white);
          }

          if (state is CaloriesLoggingErrorState) {
            Fluttertoast.showToast(
                msg: "Failed to log calories",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white);
          }
        },
        builder: (context, state) {
          if (state is CustommealLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CustommealLoaded) {
            log(state.customMealModel.toString());
            return ListView.separated(
              itemCount: 4,
              separatorBuilder: (context, index) => const Divider(),
              itemBuilder: (context, sectionIndex) {
                List<FoodModel>? meals;
                String title;
                switch (sectionIndex) {
                  case 0:
                    meals = state.customMealModel.breakFast;
                    title = 'Breakfast';
                    break;
                  case 1:
                    meals = state.customMealModel.lunch;
                    title = 'Lunch';
                    break;
                  case 2:
                    meals = state.customMealModel.dinner;
                    title = 'Dinner';
                    break;
                  case 3:
                    meals = state.customMealModel.snacks;
                    title = 'Snacks';
                    break;
                  default:
                    meals = [];
                    title = 'Unknown';
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        title,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: meals?.length ?? 0,
                      itemBuilder: (context, index) {
                        final meal = meals![index];
                        return Column(
                          children: [
                            ListTile(
                              title: Text(
                                "Food Name:${meal.foodName}",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(
                                ' Serving Size: ${meal.foodServingSize} g',
                                style: const TextStyle(color: Colors.grey),
                              ),
                              leading: CachedNetworkImage(
                                imageUrl: meal.foodImage ?? '',
                                placeholder: (context, url) =>
                                    const CircularProgressIndicator(),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                                width: 50,
                                height: 50,
                                fit: BoxFit.cover,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                caloriesBloc.add(CaloriesConsumedLogEvent(
                                    caloriesLog: CaloriesLog(
                                        caloriesConsumed:
                                            meal.foodCaloriesPerServing!,
                                        servingConsumed: meal.foodServingSize!,
                                        proteinConsumed:
                                            meal.foodProteinPerServing!,
                                        carbsConsumed:
                                            meal.foodCarbsPerServing!,
                                        fatsConsumed:
                                            meal.foodProteinPerServing!,
                                        timestamp: DateTime.now(),
                                        username: UserDataManager
                                            .userData["user_id"]
                                            .toString(),
                                        foodConsumed: meal.id)));
                              },
                              child: Container(
                                width: 50,
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Text(
                                  'Add',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            )
                          ],
                        );
                      },
                    ),
                    BlocBuilder<CaloriesBloc, CaloriesState>(
                      builder: (context, state) {
                        if (state is CaloriesLoggingLoadingState) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (state is CaloriesLoggingSuccessState) {
                          return const SizedBox();
                        } else if (state is CaloriesLoggingErrorState) {
                          return const SizedBox();
                        } else {
                          return const SizedBox();
                        }
                      },
                    ),
                  ],
                );
              },
            );
          } else if (state is CustommealError) {
            return Center(child: Text(state.message));
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
