class DBModel{
  int id;
  String note;
  String title;

  DBModel({required this.note, required this.title,required this.id});

  factory DBModel.fromJson(dynamic json,int index){
    return DBModel(id: json[index]['id'],title: json[index]['title'],note:  json[index]['note']);
  }
}