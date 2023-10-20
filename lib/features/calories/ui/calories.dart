import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:mygymbuddy/colours/colours.dart';
import 'package:mygymbuddy/features/calories/bloc/calories_bloc.dart';
import 'package:mygymbuddy/data/models/food_model.dart';
import 'package:mygymbuddy/features/calories/ui/calories_loggind.dart';

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
                      icon: Icon(Icons.arrow_back)),
                  Text(
                    "Search Calories",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  )
                ],
              ),
              buildSearchTextField(),
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
                    case CaloriesLoadingState:
                      return SizedBox(); // Don't display anything during loading
                    case CaloriesFetchingState:
                      return Center(child: CircularProgressIndicator());
                    case CaloriesFoundSuccessState:
                      return Expanded(
                        child: buildFoodList(
                            (state as CaloriesFoundSuccessState).foodModel),
                      );

                    case CaloriesFoundErrorState:
                      return Container(
                        child: Center(
                          child: Text("Food Item Not found in our Database"),
                        ),
                      );
                    default:
                      return SizedBox();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSearchTextField() {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: TextFormField(
          controller: foodNameController,
          decoration: InputDecoration(
            labelText: 'Enter Food Name to find its Nutritional Content',
            border: OutlineInputBorder(),
            suffixIcon: IconButton(
              onPressed: () {
                print(foodNameController.text);
                if (foodNameController.text.isNotEmpty) {
                  caloriesBloc.add(CaloriesSearchByNameEvent(
                    foodModel: FoodModel(name: foodNameController.text),
                  ));
                }
              },
              icon: Icon(Icons.search),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildFoodList(List<FoodModel> foodModel) {
    if (foodModel.isNotEmpty) {
      return Container(
        height: 500,
        child: ListView.builder(
          itemCount: foodModel.length,
          itemBuilder: (context, index) {
            final foodItem = foodModel[index];
            return GestureDetector(
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CaloriesLoggingPage(
                            data: foodItem,callback:widget.callback
                          ))),
              child: Container(
                padding: EdgeInsets.all(16.0),
                margin: EdgeInsets.all(16.0),
                color: MyColors.lightPurple,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Name: ${foodItem.name}'),
                    Text(
                        'Calories per Serving: ${foodItem.caloriesPerServing.toString()}'),
                    Text('Serving Size: ${foodItem.servingSize.toString()} gm'),
                    Text(
                        'Protein per Serving: ${foodItem.proteinPerServing.toString()} gm'),
                  ],
                ),
              ),
            );
          },
        ),
      );
    } else {
      return SizedBox();
    }
  }
}
