import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:posty/core/constants/app_routes.dart';
import 'package:posty/core/utils/toast_utils.dart';
import 'package:posty/features/main/widgets/custom_show_dialog.dart';
import 'package:posty/features/main/widgets/setting_widget.dart';
import 'package:posty/l10n/app_localizations.dart';
import 'package:posty/providers/user_provider.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = context.watch<UserProvider>().currentUser;
    
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Text(
                'Welcome to Posty!',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              SettingWidget(
                title: AppLocalizations.of(context)!.logout,
                trailing: CustomShowDialog(
                  title: AppLocalizations.of(context)!.confirmLogout,
                  contentText: AppLocalizations.of(
                    context,
                  )!.areYouSureYouWantToLogout,
                  onConfirm: () async {
                    await FirebaseAuth.instance.signOut();
        
                    if (context.mounted) {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                        AppRoutes.loginView,
                        (route) => false,
                      );
                    }
        
                    if (context.mounted) {
                      ToastUtils.showSuccessToast(
                        AppLocalizations.of(context)!.loggedOutSuccessfully,
                        context,
                      );
                    }
                  },
                ),
              ),
              Text(userProvider!.email), 
              Text(userProvider.name ?? ''),
            ],
          ),
        ),
      ),
    );
  }
}