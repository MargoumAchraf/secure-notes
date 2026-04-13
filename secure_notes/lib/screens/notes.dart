import 'package:flutter/material.dart';
import 'package:securenotes/screens/add_note.dart';
import 'package:securenotes/screens/update_note.dart';
import '../models/note.dart';
import '../services/database_service.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  final db = DatabaseService();
  List<Note> notes = [];

  @override
  void initState() {
    super.initState();
    loadNotes();
  }

  Future<void> loadNotes() async {
    final data = await db.getAllNotes();
    setState(() {
      notes = data;
    });
  }

  Future<void> confirmDeleteAll() async {
    final confirm = await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Delete All Notes"),
          content: const Text("Are you sure you want to delete all notes?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text("Delete"),
            ),
          ],
        );
      },
    );

    if (confirm == true) {
      await db.deleteAllNotes();
      loadNotes();

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("All notes deleted")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Notes"),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_forever),
            onPressed: confirmDeleteAll,
          ),
        ],
      ),

      body: notes.isEmpty
          ? const Center(child: Text("No notes yet"))
          : ReorderableListView.builder(
              itemCount: notes.length,

              onReorder: (oldIndex, newIndex) {
                setState(() {
                  if (newIndex > oldIndex) {
                    newIndex -= 1;
                  }

                  final item = notes.removeAt(oldIndex);
                  notes.insert(newIndex, item);
                });
              },

              itemBuilder: (context, index) {
                final note = notes[index];

                return Dismissible(
                  key: ValueKey(note.id ?? index),

                  direction: DismissDirection.endToStart,

                  confirmDismiss: (direction) async {
                    return await showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text("Delete Note"),
                          content: const Text(
                            "Are you sure you want to delete this note?",
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context, false),
                              child: const Text("Cancel"),
                            ),
                            TextButton(
                              onPressed: () => Navigator.pop(context, true),
                              child: const Text("Delete"),
                            ),
                          ],
                        );
                      },
                    );
                  },

                  onDismissed: (direction) async {
                    if (note.id != null) {
                      await db.deleteNote(note.id!);
                      loadNotes();

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Note deleted")),
                      );
                    }
                  },

                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),

                  child: ListTile(
                    title: Text(note.title),
                    subtitle: Text(note.description),

                    onTap: () async {
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => EditNoteScreen(note: note),
                        ),
                      );

                      if (result == true) {
                        loadNotes();
                      }
                    },
                  ),
                );
              },
            ),

      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddNoteScreen()),
          );

          if (result == true) {
            loadNotes();
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
