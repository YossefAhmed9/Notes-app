import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app_training/database_cubit/states.dart';
import 'package:sqflite/sqflite.dart';


class DBCubit extends Cubit<DBStates> {
  DBCubit() : super(DBInitState());

  static DBCubit get(context) => BlocProvider.of(context);


  Database? database;

  Future<void> createDatabase() async {

    await openDatabase(
      'Notes.db',
      version: 1,
      onCreate: (database, version) async {
        print('database created');
       await database
            .execute(
            'CREATE TABLE notes (id INTEGER PRIMARY KEY, title TEXT, note TEXT)')
            .then((value) {
          print('table created');
        }).catchError((error) {
          print('Error When Creating Table ${error.toString()}');
        });
      },
      onOpen: (database) {
        getDataFromDatabase(database);
        print('database opened');
      },
    ).then((value) {
      database = value;
      emit(AppCreateDatabase());
    });
  }

  updateData({
    required int? value,
    required int id,
  }) async {
    emit(DBUpdateLoadingState());
    int? currentValue = result[id - 1]['account'];
    print('This is current value $currentValue');
    int? userValue = result[0]['account'] - value;
    int? updatedValue = currentValue! + value!;
    database?.rawUpdate(
      'UPDATE Users SET account = ? WHERE id = ?',
      [updatedValue, id],
    ).then((value) {
      print('This is updated value $updatedValue');
      getDataFromDatabase(database);
    });
    database?.rawUpdate(
      'UPDATE Users SET account = ? WHERE id = ?',
      [userValue, 1],
    ).then((value) {
      print('This is user Value $userValue');
      getDataFromDatabase(database);
      emit(DBUpdateDoneState());
    }).catchError((error){
      print(error.toString());
      print(error.runtimeType);
    }).catchError((error){
      print(error.runtimeType);
      print(error.toString());
      emit(DBUpdateErrorState(error));
    });

  }

  insertToDatabase({
    required title,
    required note,
  }) async {
    emit(InsertDBLoadingState());
    await database?.transaction((txn) async {
      txn
          .rawInsert(
        'INSERT INTO notes(title, note) VALUES("$title", "$note")',
      )
          .then((value) {
        print('$value inserted successfully');
        getDataFromDatabase(database);
        emit(InsertDBDoneState());
      }).catchError((error) {
        emit(InsertDBErrorState(error));
        print('Error When Inserting New Record ${error.toString()}');
        print('Error When Inserting New Record ${error.runtimeType}');
      });
    });
  }

  List result = [];

  void getDataFromDatabase(database) {
    emit(GetDBLoadingState());
    database.rawQuery('SELECT * FROM notes').then((value) {
      result = [];
      result.addAll(value);

      print('THIS IS THE LENGTH: ${result.length}');
      print(value);
      emit(GetDBDoneState());
    });
  }



}
