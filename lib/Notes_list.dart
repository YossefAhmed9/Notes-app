import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app_training/database_cubit/cubit.dart';
import 'package:notes_app_training/models/model.dart';
import 'package:notes_app_training/notes_cubit/notes_cubit.dart';
import 'package:notes_app_training/notes_cubit/notes_states.dart';

class NotesList extends StatelessWidget {
  const NotesList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NotesCubit, NotesScreenStates>(
      listener: (context, state) {},
      builder: (context, state) {
        NotesCubit cubit = NotesCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text('Your notes'),
          ),
          body: ListView.separated(
              itemBuilder: (context, index) {
                TextEditingController updateTitle = TextEditingController(
                    text: DBModel.fromJson(DBCubit.get(context).result, index)
                        .title);
                TextEditingController updateNote = TextEditingController(
                    text: DBModel.fromJson(DBCubit.get(context).result, index)
                        .note);

                return Container(
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Card(
                    color: Colors.blueGrey,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                showBottomSheet(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Container(
                                        padding: EdgeInsets.all(16.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text('Update Note:'),
                                            SizedBox(height: 16.0),
                                            TextFormField(
                                              controller: updateTitle,
                                              decoration: InputDecoration(
                                                  labelText: 'First Name',
                                                  border: OutlineInputBorder()),
                                            ),
                                            SizedBox(height: 16.0),
                                            TextFormField(
                                              controller: updateNote,
                                              decoration: InputDecoration(
                                                  labelText: 'Last Name',
                                                  border: OutlineInputBorder()),
                                            ),
                                            SizedBox(height: 16.0),
                                            ElevatedButton(
                                              onPressed: () {
                                                cubit.updateData(
                                                    title: updateTitle.text,
                                                    note: updateNote.text,
                                                    id: index+1,
                                                    context: context);
                                                print('DONE');
                                              },
                                              child: Text('Submit'),
                                            ),
                                          ],
                                        ),
                                      );
                                    });
                              },
                              child: Column(
                                children: [
                                  Text(
                                    'title: ${DBModel.fromJson(DBCubit.get(context).result, index).title}',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                  Text(
                                    '${DBModel.fromJson(DBCubit.get(context).result, index).note}',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Column(
                            children: [
                              IconButton(
                                onPressed: () {
                                  cubit.deleteData(
                                      id: DBModel.fromJson(DBCubit.get(context).result, index).id,
                                      context: context);
                                },
                                icon: Icon(CupertinoIcons.trash),
                                color: Colors.red,
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(color: Colors.black12),
                  width: double.infinity,
                  height: 2,
                );
              },
              itemCount: DBCubit.get(context).result.length),
        );
      },
    );
  }
}
