import 'dart:developer';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:mygymbuddy/features/calories/ui/caloric_pdf.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

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

  List<dynamic> caloricIntakeList = [];

  Future<void> _createPDF() async {
    final PdfDocument document = PdfDocument();
    final PdfPage page = document.pages.add();

    final PdfGrid grid = PdfGrid();

    grid.columns.add(count: 11);
    grid.headers.add(1);

    // Add headers
    grid.headers[0].cells[0].value = 'ID';
    grid.headers[0].cells[1].value = 'Calories Consumed';
    grid.headers[0].cells[2].value = 'Serving Consumed';
    grid.headers[0].cells[3].value = 'Protein Consumed';
    grid.headers[0].cells[4].value = 'Carbs Consumed';
    grid.headers[0].cells[5].value = 'Fats Consumed';
    grid.headers[0].cells[6].value = 'Timestamp';
    grid.headers[0].cells[7].value = 'Created At';
    grid.headers[0].cells[8].value = 'Updated At';
    grid.headers[0].cells[9].value = 'Username';
    grid.headers[0].cells[10].value = 'Food Consumed';

    // Add data
    for (int i = 0; i < caloricIntakeList.length; i++) {
      final Map<String, dynamic> data = caloricIntakeList[i];
      grid.rows.add();
      for (int j = 0; j < data.keys.length; j++) {
        grid.rows[i].cells[j].value = data.values.elementAt(j).toString();
      }
    }

    // Set style
    grid.style.cellPadding = PdfPaddings();
    grid.style.font = PdfStandardFont(PdfFontFamily.helvetica, 8);

    // Draw grid
    grid.draw(page: page, bounds: const Rect.fromLTWH(0, 0, 0, 0));

    // Save PDF
    final List<int> bytes = await document.save();
    document.dispose();

    // Save and open PDF
    saveAndOpenPdf(Uint8List.fromList(bytes), 'caloric_intake.pdf');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Caloric Intake'),
        actions: [
          Visibility(
            visible: caloricIntakeList.isNotEmpty,
            child: BlocListener<CaloriesBloc, CaloriesState>(
              listener: (context, state) {
                if (state is CaloriesIntakeRequestSuccessState) {
                  caloricIntakeList = state.caloricIntakeList;
                  log(caloricIntakeList.toString());
                }
              },
              child: TextButton(
                onPressed: _createPDF,
                child: Text('View in  PDF'),
              ),
            ),
          )
        ],
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
                            'Username: ${caloricData['username']['username']}',
                          ),
                          Text(
                            'Food Consumed: ${caloricData['food_consumed']['food_name']}',
                          ),
                          Text(
                            'Servings Size Consumed: ${caloricData['serving_consumed']}',
                          ),
                          Text(
                            'Protein Consumed: ${caloricData['protein_consumed']}',
                          ),
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
