// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get helloWorld => 'مرحبا بالعالم!';

  @override
  String get invalidEmailOrPassword => 'بريد إلكتروني أو كلمة مرور غير صحيحة';

  @override
  String get userDisabled => 'تم تعطيل حساب المستخدم';

  @override
  String get tooManyRequests => 'حاولت عدة مرات. يرجى المحاولة لاحقًا';

  @override
  String get checkYourInternetConnection => 'تحقق من اتصالك بالإنترنت';

  @override
  String get invalidEmail => 'بريد إلكتروني غير صحيح';

  @override
  String get operationNotAllowed => 'هذه العملية غير مسموحة';

  @override
  String get emailAlreadyInUse => 'البريد الإلكتروني قيد الاستخدام بالفعل';

  @override
  String get weakPassword => 'كلمة مرور ضعيفة';

  @override
  String get requiresRecentLogin => 'يتطلب تسجيل دخول حديث';

  @override
  String get credentialAlreadyInUse => 'بيانات اعتماد قيد الاستخدام بالفعل';

  @override
  String get accountExistsWithDifferentCredential =>
      'الحساب موجود ببيانات اعتماد مختلفة';

  @override
  String get requestTimeout => 'انتهت مهلة الطلب';

  @override
  String get sessionExpired => 'انتهت جلستك';

  @override
  String get anErrorOccurredPleaseTryAgain =>
      'حدث خطأ ما. يرجى المحاولة مرة أخرى';

  @override
  String get pleaseEnterYourName => 'يرجى إدخال اسمك';

  @override
  String get nameMustBeAtLeast3Characters =>
      'يجب أن يكون الاسم 3 أحرف على الأقل';

  @override
  String get pleaseEnterYourEmail => 'يرجى إدخال بريدك الإلكتروني';

  @override
  String get invalidEmailFormat => 'صيغة البريد الإلكتروني غير صحيحة';

  @override
  String get pleaseEnterYourPassword => 'يرجى إدخال كلمة المرور الخاصة بك';

  @override
  String get passwordMustBeAtLeast8Characters =>
      'يجب أن تكون كلمة المرور 8 أحرف على الأقل';

  @override
  String get mustContainAtLeastOneUppercaseLetter =>
      'يجب أن تحتوي على حرف واحد على الأقل بأحرف كبيرة';

  @override
  String get mustContainAtLeastOneNumber =>
      'يجب أن تحتوي على رقم واحد على الأقل';

  @override
  String get pleaseConfirmYourPassword => 'يرجى تأكيد كلمة المرور الخاصة بك';

  @override
  String get passwordsDoNotMatch => 'كلمات المرور غير متطابقة';

  @override
  String get pleaseEnterYourPhoneNumber => 'يرجى إدخال رقم هاتفك';

  @override
  String get invalidPhoneNumberFormat => 'صيغة رقم الهاتف غير صحيحة';

  @override
  String get pleaseEnterYourAddress => 'يرجى إدخال عنوانك';

  @override
  String get addressTooShort => 'يجب أن يكون العنوان 10 أحرف على الأقل';
}
