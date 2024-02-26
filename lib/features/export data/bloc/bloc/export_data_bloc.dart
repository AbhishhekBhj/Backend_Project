import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'export_data_event.dart';
part 'export_data_state.dart';

class ExportDataBloc extends Bloc<ExportDataEvent, ExportDataState> {
  ExportDataBloc() : super(ExportDataInitial()) {
    on<ExportDataEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
