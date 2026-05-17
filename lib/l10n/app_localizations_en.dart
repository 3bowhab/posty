// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get helloWorld => 'Hello World!';

  @override
  String get invalidEmailOrPassword => 'Invalid email or password';

  @override
  String get userDisabled => 'User disabled';

  @override
  String get tooManyRequests => 'Too many requests. Try again later.';

  @override
  String get checkYourInternetConnection => 'Check your internet connection';

  @override
  String get invalidEmail => 'Invalid email';

  @override
  String get operationNotAllowed => 'Operation not allowed';

  @override
  String get emailAlreadyInUse => 'Email already in use';

  @override
  String get weakPassword => 'The password provided is too weak';

  @override
  String get requiresRecentLogin =>
      'This operation is sensitive and requires recent authentication. Log in again before retrying.';

  @override
  String get credentialAlreadyInUse =>
      'This credential is already associated with a different user account.';

  @override
  String get accountExistsWithDifferentCredential =>
      'An account already exists with a different credential.';

  @override
  String get requestTimeout => 'Request timeout. Please try again.';

  @override
  String get sessionExpired => 'Session expired. Please log in again.';

  @override
  String get anErrorOccurredPleaseTryAgain =>
      'An error occurred. Please try again.';

  @override
  String get pleaseEnterYourName => 'Please enter your name';

  @override
  String get nameMustBeAtLeast3Characters =>
      'Name must be at least 3 characters';

  @override
  String get pleaseEnterYourEmail => 'Please enter your email';

  @override
  String get invalidEmailFormat => 'Invalid email format';

  @override
  String get pleaseEnterYourPassword => 'Please enter your password';

  @override
  String get passwordMustBeAtLeast8Characters =>
      'Password must be at least 8 characters';

  @override
  String get mustContainAtLeastOneUppercaseLetter =>
      'Must contain at least one uppercase letter';

  @override
  String get mustContainAtLeastOneNumber => 'Must contain at least one number';

  @override
  String get pleaseConfirmYourPassword => 'Please confirm your password';

  @override
  String get passwordsDoNotMatch => 'Passwords do not match';

  @override
  String get pleaseEnterYourPhoneNumber => 'Please enter your phone number';

  @override
  String get invalidPhoneNumberFormat => 'Invalid phone number format';

  @override
  String get pleaseEnterYourAddress => 'Please enter your address';

  @override
  String get addressTooShort => 'Address must be at least 10 characters';
}
