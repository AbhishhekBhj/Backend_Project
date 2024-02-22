import 'dart:developer';

import "package:cached_network_image/cached_network_image.dart";
import "package:flutter/material.dart";
import "package:flutter/widgets.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:get/get.dart";
import "package:mygymbuddy/data/models/calorie_logging_model.dart";
import "package:mygymbuddy/data/models/food_model.dart";
import "package:mygymbuddy/features/calories/bloc/calories_bloc.dart";
import "package:mygymbuddy/functions/shared_preference_functions.dart";
import "package:mygymbuddy/provider/themes/theme_provider.dart";
import "package:provider/provider.dart";
import "package:shared_preferences/shared_preferences.dart";

class CaloriesLoggingPage extends StatefulWidget {
  CaloriesLoggingPage({this.data});

  @override
  State<CaloriesLoggingPage> createState() => _CaloriesLoggingPageState();
  FoodModel? data;
}

class _CaloriesLoggingPageState extends State<CaloriesLoggingPage> {
  TextEditingController servingSizeController = TextEditingController();
  CaloriesBloc caloriesBloc = CaloriesBloc();
  late var username;
  double? servingSizeConsume;
  double? proteinPerSize;
  double? servingSize;

  @override
  void initState() {
    super.initState();
    log(widget.data!.toString());
    proteinPerSize = widget.data!.foodProteinPerServing;
    servingSize = widget.data!.foodServingSize;
    getName();
  }

  void getName() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    username = sharedPreferences.getString('username');
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    bool isDarkMode = themeProvider.getTheme == themeProvider.darkTheme;

    var dateTime = DateTime.now();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: isDarkMode ? Colors.black : Colors.deepPurpleAccent,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: const Text(
          "Add Food",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(
                height: Get.height * 0.35,
                imageUrl: "http://10.0.2.2:8000${widget.data!.foodImage}",
                errorWidget: (context, url, error) => const Icon(Icons.error),
                placeholder: (context, url) =>
                    Image.asset("assets/img/imageloading.gif"),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Food Name: ${widget.data!.foodName}",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                SizedBox(height: Get.height * 0.02),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Serving Size ${widget.data!.foodServingSize} gm",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: Get.height * 0.02),

                Row(
                  children: [
                    const Text(
                      "Servings",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: Get.width * 0.2),
                        child: TextFormField(
                          onChanged: (value) {
                            if (value.isNotEmpty) {
                              servingSizeConsume = double.parse(value);
                            } else {
                              servingSizeConsume = 0.0;
                            }
                          },
                          style: TextStyle(
                              color: isDarkMode
                                  ? Colors.black
                                  : Colors.deepPurpleAccent),
                          controller: servingSizeController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintStyle: TextStyle(
                                color: isDarkMode
                                    ? Colors.black
                                    : Colors.deepPurpleAccent),
                            hintText: "Servings",
                            contentPadding: EdgeInsets.only(left: 35),
                            fillColor: Colors.grey[200],
                            filled: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                // SizedBox(height: 20),
                SizedBox(height: Get.height * 0.01),

                SizedBox(height: Get.height * 0.01),

                _buildNutritionFact("Calories Per Serving",
                    '${widget.data!.foodCaloriesPerServing}'),
                SizedBox(height: Get.height * 0.01),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text(
                      "Time",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      "${dateTime.hour}:${dateTime.minute}",
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: Get.height * 0.01),

                Center(
                  child: Container(
                    width: Get.width * 0.45,
                    child: ElevatedButton(
                      onPressed: () async {
                        log(servingSizeConsume.runtimeType.toString());
                        FocusManager.instance.primaryFocus?.unfocus();
                        if (servingSizeConsume != null) {
                          caloriesBloc.add(CaloriesConsumedLogEvent(
                              caloriesLog: CaloriesLog(
                                  caloriesConsumed:
                                      widget.data!.foodCaloriesPerServing! *
                                          servingSizeConsume!,
                                  servingConsumed: servingSizeConsume!,
                                  proteinConsumed:
                                      proteinPerSize! * servingSizeConsume!,
                                  carbsConsumed:
                                      widget.data!.foodCarbsPerServing! *
                                          servingSizeConsume!,
                                  fatsConsumed:
                                      widget.data!.foodFatPerServing! *
                                          servingSizeConsume!,
                                  username: UserDataManager.userData["user_id"],
                                  foodConsumed: widget.data!.id,
                                  timestamp: dateTime)));
                        } else {
                          Get.snackbar(
                            "Error",
                            'Please enter serving size',
                            snackPosition: SnackPosition.BOTTOM,
                            snackStyle: SnackStyle.GROUNDED,
                          );
                        }
                      },
                      style: isDarkMode
                          ? ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            )
                          : ElevatedButton.styleFrom(
                              backgroundColor: Colors.deepPurpleAccent,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              )),
                      child: const Text(
                        "LOG FOOD",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ),
                BlocBuilder(
                    bloc: caloriesBloc,
                    builder: (context, state) {
                      if (state is CaloriesLoggingLoadingState) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is CaloriesLoggingSuccessState) {
                        return const Center(
                          child: Text("Food Logged"),
                        );
                      } else if (state is CaloriesLoggingErrorState) {
                        return const Center(
                          child: Text("Error Logging Food"),
                        );
                      } else {
                        return Container();
                      }
                    }),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNutritionFact(String label, String value) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.grey,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
