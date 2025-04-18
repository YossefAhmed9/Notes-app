import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app_training/components.dart';
import 'package:notes_app_training/core/database_cubit/cubit.dart';
import 'Notes_list.dart';
import 'core/database_cubit/states.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DBCubit, DBStates>(
      listener: (context, state) {},
      builder: (context, state) {
        TextEditingController titleController = TextEditingController();
        TextEditingController noteController = TextEditingController();
        DBCubit cubit = DBCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                  onPressed: () {
                    navigateTo(context, const NotesList());
                  },
                  icon: const Icon(CupertinoIcons.collections))
            ],
            title: const Text(
              'Notes app',
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 25),
            ),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: defaultTextFormField(
                        TextInputType.text,
                        titleController,
                        (p0) => null,
                        (p0) => null,
                        () {},
                        'Enter the title of the note',
                        OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                        const Icon(CupertinoIcons.pen),
                        (value) => null),
                  ),
                  TextFormField(
                    keyboardType: TextInputType.multiline,
                    controller: noteController,
                    maxLines: 20,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)),
                      hintText: 'What do you think......',
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.purple,
                      ),
                      child: TextButton(
                          onPressed: () {
                            cubit.insertToDatabase(
                                title: titleController.text,
                                note: noteController.text);
                          },
                          child: const Text(
                            'Save note',
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                                color: Colors.white),
                          )),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
