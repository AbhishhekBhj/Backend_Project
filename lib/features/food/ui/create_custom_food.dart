import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mygymbuddy/features/food/bloc/bloc/food_bloc.dart';
import 'package:mygymbuddy/functions/shared_preference_functions.dart';

import '../../../data/models/food_item.dart';

class CreateCustomFood extends StatefulWidget {
  const CreateCustomFood({Key? key}) : super(key: key);

  @override
  State<CreateCustomFood> createState() => _CreateCustomFoodState();
}

class _CreateCustomFoodState extends State<CreateCustomFood> {
  late FoodBloc _foodBloc;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _caloriesController = TextEditingController();
  final TextEditingController _servingSizeController = TextEditingController();
  final TextEditingController _proteinController = TextEditingController();
  final TextEditingController _carbsController = TextEditingController();
  final TextEditingController _fatController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _foodBloc = BlocProvider.of<FoodBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Create Custom Food'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(labelText: 'Food Name'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the food name';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _descriptionController,
                    decoration: const InputDecoration(labelText: 'Description'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the description';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _caloriesController,
                    decoration: const InputDecoration(
                        labelText: 'Calories per Serving'),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the calories per serving';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _servingSizeController,
                    decoration: const InputDecoration(
                        labelText: 'Serving Size (in grams)'),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the serving size';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _proteinController,
                    decoration: const InputDecoration(
                        labelText: 'Protein per Serving (in grams)'),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the protein per serving';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _carbsController,
                    decoration: const InputDecoration(
                        labelText: 'Carbohydrates per Serving (in grams)'),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the carbohydrates per serving';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _fatController,
                    decoration: const InputDecoration(
                        labelText: 'Fat per Serving (in grams)'),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the fat per serving';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16.0),
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          _foodBloc.add(CreateCustomFoodClickedEvent(
                              foodItem: FoodItem(
                                  userId: UserDataManager.userData['user_id']
                                      .toString()!,
                                  foodName: _nameController.text,
                                  foodDescription: _descriptionController.text,
                                  foodCaloriesPerServing:
                                      double.parse(_caloriesController.text),
                                  foodServingSize:
                                      double.parse(_servingSizeController.text),
                                  foodProteinPerServing:
                                      double.parse(_proteinController.text),
                                  foodCarbsPerServing:
                                      double.parse(_carbsController.text),
                                  foodFatPerServing:
                                      double.parse(_fatController.text))));
                        }
                      },
                      child: Container(
                          width: 100.0,
                          height: 40.0,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: const Center(
                              child: Text(
                            'Submit',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold),
                          ))),
                    ),
                  ),
                  BlocConsumer<FoodBloc, FoodState>(
                    listener: (context, state) {
                      if (state is FoodUploadSuccess) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Food added successfully')));
                        Navigator.pop(context);
                      }
                    },
                    builder: (context, state) {
                      if (state is FoodUploadLoading) {
                        return const Center(
                          child: CupertinoActivityIndicator(),
                        );
                      }
                      return Container();
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
