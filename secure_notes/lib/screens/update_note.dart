import 'package:flutter/material.dart';
import '../models/note.dart';
import '../services/database_service.dart';

class EditNoteScreen extends StatefulWidget {
  final Note note;

  const EditNoteScreen({super.key, required this.note});

  @override
  State<EditNoteScreen> createState() => _EditNoteScreenState();
}

class _EditNoteScreenState extends State<EditNoteScreen> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController titleController;
  late TextEditingController descriptionController;

  final db = DatabaseService();

  @override
  void initState() {
    super.initState();

    titleController = TextEditingController(text: widget.note.title);
    descriptionController = TextEditingController(
      text: widget.note.description,
    );
  }

  void updateNote() async {
    if (_formKey.currentState!.validate()) {
      await db.updateNote(
        Note(
          id: widget.note.id,
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
      appBar: AppBar(title: const Text("Edit Note")),
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
                  if (value == null || value.isEmpty) {
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
                  if (value == null || value.isEmpty) {
                    return "Description is required";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: updateNote,
                child: const Text("Update"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
