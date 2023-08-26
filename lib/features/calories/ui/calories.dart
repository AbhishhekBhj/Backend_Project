import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mygymbuddy/colours/colours.dart';
import 'package:mygymbuddy/features/calories/bloc/calories_bloc.dart';
import 'package:mygymbuddy/data/models/food_model.dart';

class CaloricInformation extends StatefulWidget {
  const CaloricInformation({super.key});

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
    return Scaffold(
      body: BlocConsumer<CaloriesBloc, CaloriesState>(
        bloc: caloriesBloc,
        listenWhen: (previous, current) => current is CaloriesActionState,
        buildWhen: (previous, current) => current is! CaloriesActionState,
        listener: (context, state) {},
        builder: (context, state) {
          print(state.runtimeType);
          switch (state.runtimeType) {
            case CaloriesLoadingState:
              return Scaffold(
                body: Column(
                  children: [
                    buildSearchTextField(),
                    SizedBox(height: 16),
                  ],
                ),
              );
            case CaloriesFetchingState:
              return Center(child: CircularProgressIndicator());
            case CaloriesFoundSuccessState:
              return buildFoodList(
                  (state as CaloriesFoundSuccessState).foodModel);
            case CaloriesFoundErrorState:
              return Container(
                child: Center(
                  child: Text("Food Item Not found"),
                ),
              );
            default:
              return SizedBox();
          }
        },
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
            labelText: 'Enter Food Name to find its calorie',
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
    return ListView.builder(
      itemCount: foodModel.length,
      itemBuilder: (context, index) {
        final foodItem = foodModel[index];
        return Container(
          padding: EdgeInsets.all(16.0),
          margin: EdgeInsets.all(16.0),
          color: MyColors.primaryBlue,
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
        );
      },
    );
  }
}
