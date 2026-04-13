import 'package:flutter/material.dart';
import 'package:securenotes/screens/add_note.dart';
import 'package:securenotes/screens/update_note.dart';
import 'package:securenotes/l10n/app_localizations.dart';
import 'package:securenotes/screens/locale_provider.dart'; // ✅ only this added
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
    setState(() => notes = data);
  }

  void showLanguagePicker() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Language / اللغة',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              ListTile(
                leading: const Text('🇬🇧', style: TextStyle(fontSize: 24)),
                title: const Text('English'),
                onTap: () {
                  localeNotifier.value = const Locale('en'); // ✅
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Text('🇸🇦', style: TextStyle(fontSize: 24)),
                title: const Text('العربية'),
                onTap: () {
                  localeNotifier.value = const Locale('ar'); // ✅
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> confirmDeleteAll() async {
    final loc = AppLocalizations.of(context)!;
    final confirm = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(loc.delete),
        content: const Text("Are you sure you want to delete all notes?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(loc.delete),
          ),
        ],
      ),
    );

    if (confirm == true) {
      await db.deleteAllNotes();
      loadNotes();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("All notes deleted")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(
              top: 60,
              left: 24,
              right: 24,
              bottom: 24,
            ),
            decoration: const BoxDecoration(
              color: Color(0xFF6C63FF),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(24),
                bottomRight: Radius.circular(24),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  loc.appTitle,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.language, color: Colors.white),
                      onPressed: showLanguagePicker, // ✅
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete_forever, color: Colors.white),
                      onPressed: confirmDeleteAll,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: notes.isEmpty
                ? Center(child: Text(loc.noNotes))
                : ReorderableListView.builder(
                    itemCount: notes.length,
                    onReorder: (oldIndex, newIndex) {
                      setState(() {
                        if (newIndex > oldIndex) newIndex -= 1;
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
                            builder: (context) => AlertDialog(
                              title: Text(loc.delete),
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
                                  child: Text(loc.delete),
                                ),
                              ],
                            ),
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
                            if (result == true) loadNotes();
                          },
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddNoteScreen()),
          );
          if (result == true) loadNotes();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}