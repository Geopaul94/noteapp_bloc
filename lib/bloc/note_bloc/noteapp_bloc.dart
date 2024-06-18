import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'noteapp_event.dart';
part 'noteapp_state.dart';

class NoteappBloc extends Bloc<NoteappEvent, NoteappState> {
  NoteappBloc() : super(NoteappInitial()) {
    on<NoteappEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
