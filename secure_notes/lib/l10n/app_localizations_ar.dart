// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'ملاحظات آمنة';

  @override
  String get unlockWithBiometrics => 'فتح باستخدام البصمة';

  @override
  String get authReason => 'يرجى المصادقة لعرض ملاحظاتك';

  @override
  String get authFailed => 'فشل المصادقة';

  @override
  String get noNotes => 'لا توجد ملاحظات بعد. اضغط على + لإضافة واحدة!';

  @override
  String get addNote => 'إضافة ملاحظة';

  @override
  String get editNote => 'تعديل الملاحظة';

  @override
  String get title => 'العنوان';

  @override
  String get description => 'الوصف';

  @override
  String get date => 'التاريخ';

  @override
  String get enterTitle => 'يرجى إدخال عنوان';

  @override
  String get enterDescription => 'يرجى إدخال وصف';

  @override
  String get save => 'حفظ';

  @override
  String get updateChanges => 'تحديث التغييرات';

  @override
  String get delete => 'حذف';

  @override
  String get deleteAllTitle => 'حذف جميع الملاحظات';

  @override
  String get deleteAllConfirm => 'هل أنت متأكد أنك تريد حذف جميع الملاحظات؟';

  @override
  String get deleteNoteTitle => 'حذف الملاحظة';

  @override
  String get deleteNoteConfirm => 'هل أنت متأكد أنك تريد حذف هذه الملاحظة؟';

  @override
  String get cancel => 'إلغاء';

  @override
  String get allNotesDeleted => 'تم حذف جميع الملاحظات';

  @override
  String get noteDeleted => 'تم حذف الملاحظة';
}
