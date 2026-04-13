import 'package:flutter/material.dart';
import '../models/note.dart';
import '../services/database_service.dart';

class AddNoteScreen extends StatefulWidget {
  const AddNoteScreen({super.key});

  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  final _formKey = GlobalKey<FormState>();

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  final db = DatabaseService();

  void saveNote() async {
    if (_formKey.currentState!.validate()) {
      await db.addNote(
        Note(
          title: titleController.text,
          description: descriptionController.text,
        ),
      );

      Navigator.pop(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Note")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // TITLE
              TextFormField(
                controller: titleController,
                decoration: const InputDecoration(labelText: "Title"),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Title is required";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              // DESCRIPTION
              TextFormField(
                controller: descriptionController,
                decoration: const InputDecoration(labelText: "Description"),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Description is required";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 20),

              ElevatedButton(onPressed: saveNote, child: const Text("Save")),
            ],
          ),
        ),
      ),
    );
  }
}
