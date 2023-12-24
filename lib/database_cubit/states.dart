abstract class DBStates {}
//create and open Database
class DBInitState extends DBStates {}
class AppCreateDatabase extends DBStates {}
class DBLoadingState extends DBStates {}
class DBDoneState extends DBStates {}
class DBErrorState extends DBStates {
  final error;

  DBErrorState(this.error);
}


//Delete from Database
class DBDeleteLoadingState extends DBStates {}
class DBDeleteDoneState extends DBStates {}
class DBDeleteErrorState extends DBStates {
  final error;

  DBDeleteErrorState(this.error);
}

//Update Database
class DBUpdateLoadingState extends DBStates {}
class DBUpdateDoneState extends DBStates {}
class DBUpdateErrorState extends DBStates {
  final error;

  DBUpdateErrorState(this.error);
}


//Get Data from Database
class GetDBLoadingState extends DBStates {}
class GetDBDoneState extends DBStates {}
class GetDBErrorState extends DBStates {
  final error;

  GetDBErrorState(this.error);
}



//Insert Data to Database
class InsertDBLoadingState extends DBStates {}
class InsertDBDoneState extends DBStates {}
class InsertDBErrorState extends DBStates {
  final error;

  InsertDBErrorState(this.error);
}