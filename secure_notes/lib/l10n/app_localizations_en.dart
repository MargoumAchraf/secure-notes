// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Secure Notes';

  @override
  String get unlockWithBiometrics => 'Unlock with Biometrics';

  @override
  String get authReason => 'Please authenticate to view your notes';

  @override
  String get authFailed => 'Authentication Failed';

  @override
  String get noNotes => 'No notes yet. Tap + to add one!';

  @override
  String get addNote => 'Add Note';

  @override
  String get editNote => 'Edit Note';

  @override
  String get title => 'Title';

  @override
  String get description => 'Description';

  @override
  String get date => 'Date';

  @override
  String get enterTitle => 'Please enter a title';

  @override
  String get enterDescription => 'Please enter a description';

  @override
  String get save => 'SAVE';

  @override
  String get updateChanges => 'UPDATE CHANGES';

  @override
  String get delete => 'Delete';

  @override
  String get deleteAllTitle => 'Delete All Notes';

  @override
  String get deleteAllConfirm => 'Are you sure you want to delete all notes?';

  @override
  String get deleteNoteTitle => 'Delete Note';

  @override
  String get deleteNoteConfirm => 'Are you sure you want to delete this note?';

  @override
  String get cancel => 'Cancel';

  @override
  String get allNotesDeleted => 'All notes deleted';

  @override
  String get noteDeleted => 'Note deleted';
}
