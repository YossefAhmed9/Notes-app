import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app_training/core/database_cubit/cubit.dart';
import 'package:notes_app_training/models/model.dart';
import 'package:notes_app_training/notes_cubit/notes_cubit.dart';
import 'package:notes_app_training/notes_cubit/notes_states.dart';

class NotesList extends StatefulWidget {
  const NotesList({super.key});

  @override
  State<NotesList> createState() => _NotesListState();
}

class _NotesListState extends State<NotesList> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NotesCubit, NotesScreenStates>(
      listener: (context, state) {},
      builder: (context, state) {
        NotesCubit cubit = NotesCubit.get(context);
        Random random=Random();

        List colors=[
          Colors.amberAccent,
          Colors.pinkAccent,
          Colors.blueAccent,
          Colors.lightGreenAccent,
          Colors.cyanAccent,
          Colors.indigoAccent,
          Colors.teal,
          Colors.brown[300],
          Colors.lightBlue,
        ];
        return Scaffold(
          appBar: AppBar(
            title: const Text('Your notes'),
          ),
          body: DBCubit.get(context).result.isEmpty ?  const Center(child: Text('No Notes',style: TextStyle(fontSize: 25,fontWeight: FontWeight.w700),),) : ListView.separated(
              itemBuilder: (context, index) {
                TextEditingController updateTitle = TextEditingController(
                    text: DBModel.fromJson(DBCubit.get(context).result, index).title);

                TextEditingController updateNote = TextEditingController(
                    text: DBModel.fromJson(DBCubit.get(context).result, index).note);

                return Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Card(
                    color: colors[random.nextInt(colors.length)],
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
                                        decoration: BoxDecoration(
                                          color: Colors.deepPurple[100]
                                        ),
                                        padding: const EdgeInsets.all(16.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            const Text('Update Note:',style: TextStyle(fontWeight: FontWeight.w700),),
                                            const SizedBox(height: 16.0),
                                            TextFormField(
                                              controller: updateTitle,
                                              decoration: const InputDecoration(
                                                  labelText: 'Update title',
                                                  border: OutlineInputBorder()),
                                            ),
                                            const SizedBox(height: 16.0),
                                            TextFormField(
                                              maxLines: 20,
                                              controller: updateNote,
                                              decoration: const InputDecoration(
                                                  labelText: 'Update note',
                                                  border: OutlineInputBorder()),
                                            ),
                                            const SizedBox(height: 16.0),
                                            Container(
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(20),
                                                color: Colors.cyanAccent
                                              ),
                                              child: MaterialButton(
                                                onPressed: () {
                                                  setState(() {
                                                    cubit.updateData(
                                                        title: updateTitle.text,
                                                        note: updateNote.text,
                                                        id: index+1,
                                                        context: context);
                                                    if (kDebugMode) {
                                                      print('DONE');
                                                    }
                                                  });
                                                },
                                                child: const Text('Save'),
                                              ),
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
                                    style: const TextStyle(
                                        color: Colors.black87, fontSize: 20),
                                  ),
                                  Text(
                                    DBModel.fromJson(DBCubit.get(context).result, index).note,
                                    style: const TextStyle(
                                        color: Colors.black87, fontSize: 20),
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
                                icon: const Icon(CupertinoIcons.trash),
                                color: Colors.white,
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
                  decoration: const BoxDecoration(color: Colors.black12),
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
