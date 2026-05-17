import 'package:flutter/material.dart';
import 'package:posty/core/extensions/responsive_padding_extension.dart';
import 'package:posty/core/utils/lang_and_theme.dart';
import 'package:posty/l10n/app_localizations.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      floatingActionButton: LangAndTheme(),
      body: Padding(
        padding: 16.allPadding,
        child: Text(AppLocalizations.of(context)!.helloWorld),
      ),
    );
  }
}