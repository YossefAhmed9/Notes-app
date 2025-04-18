import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app_training/core/database_cubit/cubit.dart';

import 'notes_states.dart';

class NotesCubit extends Cubit<NotesScreenStates> {
  NotesCubit() : super(NotesScreenInitState());

  static NotesCubit get(context) => BlocProvider.of(context);

  void deleteData({
    required int id,
    required BuildContext context
  }) async {
    emit(NotesDeleteLoadingState());
    DBCubit.get(context).database?.rawDelete('DELETE FROM notes WHERE id = ?', [id]).then((value) {
      DBCubit.get(context).getDataFromDatabase(DBCubit.get(context).database);
      print('This is the value from delete function $value');
      emit(NotesDeleteDoneState());
    }).catchError((error){
      print(error.runtimeType);
      print(error.toString());
      emit(NotesDeleteErrorState(error));
    });
  }


  updateData({
    required String title,
    required String note,
    required int id,
    required BuildContext context
  }) async {
    emit(DBUpdateLoadingState());
    DBCubit.get(context).database?.rawUpdate(
      'UPDATE notes SET title = "$title", note = "$note" WHERE id=$id',
    ).then((value) {
      DBCubit.get(context).getDataFromDatabase(DBCubit.get(context).database);
      emit(DBUpdateDoneState());
    }).catchError((error){
      print(error.runtimeType);
      print(error.toString());
      emit(DBUpdateErrorState(error));
    });
  }

}