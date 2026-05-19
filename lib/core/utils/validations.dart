import 'package:flutter/material.dart';
import 'package:posty/l10n/app_localizations.dart';

class Validations {
  static String? validateName(String? value, BuildContext context) {
    if (value == null || value.isEmpty) {
      return AppLocalizations.of(context)?.pleaseEnterYourName;
    }
    if (value.length < 3) {
      return AppLocalizations.of(context)?.nameMustBeAtLeast3Characters;
    }
    return null;
  }

  static String? validateEmail(String? value, BuildContext context) {
    final emailRegExp = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    if (value == null || value.isEmpty) {
      return AppLocalizations.of(context)?.pleaseEnterYourEmail;
    }
    if (!emailRegExp.hasMatch(value)) {
      return AppLocalizations.of(context)?.invalidEmailFormat;
    }
    return null;
  }

  static String? validatePassword(String? value, BuildContext context) {
    if (value == null || value.isEmpty) {
      return AppLocalizations.of(context)?.pleaseEnterYourPassword;
    }
    if (value.length < 8) {
      return AppLocalizations.of(context)?.passwordMustBeAtLeast8Characters;
    }
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return AppLocalizations.of(context)?.mustContainAtLeastOneUppercaseLetter;
    }
    if (!value.contains(RegExp(r'[0-9]'))) {
      return AppLocalizations.of(context)?.mustContainAtLeastOneNumber;
    }
    return null;
  }

  static String? validateConfirmPassword(
    String? value,
    String password,
    BuildContext context,
  ) {
    if (value == null || value.isEmpty) {
      return AppLocalizations.of(context)?.pleaseConfirmYourPassword;
    }
    if (value != password) {
      return AppLocalizations.of(context)?.passwordsDoNotMatch;
    }
    return null;
  }

  static String? validatePhone(String? value, BuildContext context) {
    if (value == null || value.isEmpty) {
      return AppLocalizations.of(context)?.pleaseEnterYourPhoneNumber;
    }
    final phoneRegExp = RegExp(r"^\+?[0-9]{7,15}$");
    if (!phoneRegExp.hasMatch(value)) {
      return AppLocalizations.of(context)?.invalidPhoneNumberFormat;
    }
    return null;
  }

  static String? validateAddress(String? value, BuildContext context) {
    if (value == null || value.isEmpty) {
      return AppLocalizations.of(context)?.pleaseEnterYourAddress;
    }
    if (value.length < 10) {
      return AppLocalizations.of(context)?.addressTooShort;
    }
    return null;
  }
}
