import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:posty/l10n/app_localizations.dart';

class FirebaseAuthExceptions {
  static final Map<String, String Function(BuildContext)> _errors = {
    // 🔐 Login 
    'invalid-credential': (context) =>
        AppLocalizations.of(context)!.invalidEmailOrPassword,

    'invalid-login-credentials': (context) =>
        AppLocalizations.of(context)!.invalidEmailOrPassword,

    'user-disabled': (context) => AppLocalizations.of(context)!.userDisabled,

    'too-many-requests': (context) =>
        AppLocalizations.of(context)!.tooManyRequests,

    'network-request-failed': (context) =>
        AppLocalizations.of(context)!.checkYourInternetConnection,

    'invalid-email': (context) => AppLocalizations.of(context)!.invalidEmail,

    'operation-not-allowed': (context) =>
        AppLocalizations.of(context)!.operationNotAllowed,

    // 📝 Register
    'email-already-in-use': (context) =>
        AppLocalizations.of(context)!.emailAlreadyInUse,

    'weak-password': (context) => AppLocalizations.of(context)!.weakPassword,

    // 🔄 Re-auth / Linking
    'requires-recent-login': (context) =>
        AppLocalizations.of(context)!.requiresRecentLogin,

    'credential-already-in-use': (context) =>
        AppLocalizations.of(context)!.credentialAlreadyInUse,

    'account-exists-with-different-credential': (context) =>
        AppLocalizations.of(context)!.accountExistsWithDifferentCredential,

    // 🌍 General
    'internal-error': (context) =>
        AppLocalizations.of(context)!.anErrorOccurredPleaseTryAgain,

    'timeout': (context) => AppLocalizations.of(context)!.requestTimeout,

    'user-token-expired': (context) =>
        AppLocalizations.of(context)!.sessionExpired,
  };

  static String getMessage(
    FirebaseAuthException exception,
    BuildContext context,
  ) {
    return _errors[exception.code]?.call(context) ??
        AppLocalizations.of(context)!.anErrorOccurredPleaseTryAgain;
  }
}
