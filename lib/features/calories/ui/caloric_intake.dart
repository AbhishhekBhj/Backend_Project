import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

import '../bloc/calories_bloc.dart';

class CaloricIntakePage extends StatefulWidget {
  CaloricIntakePage({Key? key, required this.username}) : super(key: key);

  final String username;

  @override
  State<CaloricIntakePage> createState() => _CaloricIntakePageState();
}

class _CaloricIntakePageState extends State<CaloricIntakePage> {
  late CaloriesBloc caloriesBloc;

  @override
  void initState() {
    super.initState();
    caloriesBloc = BlocProvider.of<CaloriesBloc>(context);
    caloriesBloc.add(CaloriesIntakeRequestEvent());

    log('Username: ${widget.username}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Caloric Intake'),
      ),
      body: BlocBuilder<CaloriesBloc, CaloriesState>(
        builder: (context, state) {
          if (state is CaloriesIntakeRequestLoadingState) {
            return const Center(
              child: CupertinoActivityIndicator(),
            );
          } else if (state is CaloriesIntakeRequestSuccessState) {
            final caloricIntakeList = state.caloricIntakeList;
            if (caloricIntakeList.isEmpty) {
              return const Center(
                child: Text('No data available'),
              );
            } else {
              return ListView.builder(
                itemCount: caloricIntakeList.length,
                itemBuilder: (context, index) {
                  final caloricData = caloricIntakeList[index];
                  final date = DateTime.parse(caloricData['timestamp']);
                  final formattedDate = DateFormat.yMd().add_Hm().format(date);

                  // Check if the intake is from today
                  final today = DateTime.now();
                  final intakeDate = DateTime(date.year, date.month, date.day);
                  final isToday = today.year == intakeDate.year &&
                      today.month == intakeDate.month &&
                      today.day == intakeDate.day;

                  return Card(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      title: Text(
                        'Calories Consumed: ${caloricData['calories_consumed']}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 8),
                          Text('Date: $formattedDate'),
                          Text(
                            'Servings Size Consumed: ${caloricData['serving_consumed']}',
                          ),
                          Text(
                              'Protein Consumed: ${caloricData['protein_consumed']}'),
                          if (!isToday)
                            const Text(
                              'This intake is from a previous date.',
                              style: TextStyle(color: Colors.red),
                            ),
                        ],
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          // Show modal bottom sheet if not today's intake
                          if (!isToday) {
                            Fluttertoast.showToast(
                              msg: 'Cannot delete previous date intake',
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0,
                            );
                          } else {
                            caloriesBloc.add(
                                CaloriesLogDeleteEvent(id: caloricData['id']));
                          }
                        },
                      ),
                    ),
                  );
                },
              );
            }
          } else if (state is CaloriesLogDeleteSuccessState) {
            caloriesBloc.add(CaloriesIntakeRequestEvent());
            return const Center(
              child: CupertinoActivityIndicator(),
            );
          } else if (state is CaloriesLogDeleteErrorState) {
            return const Center(
              child: Text('Error deleting data'),
            );
          } else if (state is CaloriesIntakeRequestErrorState) {
            return const Center(
              child: Text('Error fetching data'),
            );
          }
          return const Center(
            child: Text('Unknown state'),
          );
        },
      ),
    );
  }
}

// class DataWidget extends StatefulWidget {
//   const DataWidget({
//     Key? key,
//     required this.caloricIntakeList,
//     required this.caloriesBloc,
//   }) : super(key: key);

//   final List caloricIntakeList;
//   final CaloriesBloc caloriesBloc;

//   @override
//   State<DataWidget> createState() => _DataWidgetState();
// }

// class _DataWidgetState extends State<DataWidget> {
//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       itemCount: widget.caloricIntakeList.length,
//       itemBuilder: (context, index) {
//         final caloricData = widget.caloricIntakeList[index];
//         final date = DateTime.parse(caloricData['timestamp']);
//         final formattedDate = DateFormat.yMd().add_Hm().format(date);

//         // Check if the intake is from today
//         final today = DateTime.now();
//         final intakeDate = DateTime(date.year, date.month, date.day);
//         final isToday = today.year == intakeDate.year &&
//             today.month == intakeDate.month &&
//             today.day == intakeDate.day;

//         return Card(
//           margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//           elevation: 4,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(12),
//           ),
//           child: ListTile(
//             title: Text(
//               'Calories Consumed: ${caloricData['calories_consumed']}',
//               style: const TextStyle(
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             subtitle: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const SizedBox(height: 8),
//                 Text('Date: $formattedDate'),
//                 Text(
//                   'Servings Size Consumed: ${caloricData['serving_consumed']}',
//                 ),
//                 Text('Protein Consumed: ${caloricData['protein_consumed']}'),
//                 if (!isToday)
//                   const Text(
//                     'This intake is from a previous date.',
//                     style: TextStyle(color: Colors.red),
//                   ),
//               ],
//             ),
//             trailing: IconButton(
//               icon: const Icon(Icons.delete, color: Colors.red),
//               onPressed: () {
//                 // Show modal bottom sheet if not today's intake
//                 if (!isToday) {
//                   Fluttertoast.showToast(
//                     msg: 'Cannot delete previous date intake',
//                     toastLength: Toast.LENGTH_SHORT,
//                     gravity: ToastGravity.BOTTOM,
//                     timeInSecForIosWeb: 1,
//                     backgroundColor: Colors.red,
//                     textColor: Colors.white,
//                     fontSize: 16.0,
//                   );
//                 } else {
//                   widget.caloriesBloc
//                       .add(CaloriesLogDeleteEvent(id: caloricData['id']));
//                 }
//               },
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
