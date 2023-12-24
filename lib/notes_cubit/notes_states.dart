abstract class NotesScreenStates{}

class NotesScreenInitState extends NotesScreenStates{}
class NotesDeleteLoadingState extends NotesScreenStates {}
class NotesDeleteDoneState extends NotesScreenStates {}
class NotesDeleteErrorState extends NotesScreenStates {
  final error;

  NotesDeleteErrorState(this.error);
}


//Update Database
class DBUpdateLoadingState extends NotesScreenStates {}
class DBUpdateDoneState extends NotesScreenStates {}
class DBUpdateErrorState extends NotesScreenStates {
  final error;

  DBUpdateErrorState(this.error);
}