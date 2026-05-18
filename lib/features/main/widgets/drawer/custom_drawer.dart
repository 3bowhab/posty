import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:posty/core/constants/app_routes.dart';
import 'package:posty/core/theme/app_colors.dart';
import 'package:posty/core/utils/toast_utils.dart';
import 'package:posty/features/main/widgets/drawer/custom_list_tile.dart';
import 'package:posty/features/main/widgets/drawer/list_tile_row.dart';
import 'package:posty/l10n/app_localizations.dart';
import 'package:posty/providers/language_provider.dart';
import 'package:posty/providers/theme_provider.dart';
import 'package:posty/providers/user_provider.dart';
import 'package:provider/provider.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final languageProvider = Provider.of<LanguageProvider>(context);
    final userProvider = context.watch<UserProvider>().currentUser;

    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  userProvider?.name ?? '',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.whiteColor,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  userProvider?.email ?? '',
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(color: AppColors.whiteColor),
                ),
              ],
            ),
          ),
          CustomListTile(
            title: AppLocalizations.of(context)!.theme,
            icon: Icons.format_paint_outlined,
            list: const ['Light', 'Dark'],
            initialValue: themeProvider.currentMode == ThemeMode.light
                ? 'Light'
                : 'Dark',
            onChanged: (value) {
              themeProvider.toggleTheme(
                value == 'Light' ? ThemeMode.light : ThemeMode.dark,
              );
            },
          ),
          Divider(),
          CustomListTile(
            title: AppLocalizations.of(context)!.language,
            icon: Icons.language,
            list: ['English', 'العربية'],
            initialValue: languageProvider.currentLanguage == 'en'
                ? 'English'
                : 'العربية',
            onChanged: (value) {
              languageProvider.changeLanguage(value == 'English' ? 'en' : 'ar');
            },
          ),
          Divider(),
          ListTile(
            title: ListTileRow(
              icon: Icons.logout_outlined,
              title: AppLocalizations.of(context)!.logout,
            ),
            onTap: () {
              showDialog(
                context: context,
                builder: (dialogContext) => AlertDialog(
                  title: Text(AppLocalizations.of(context)!.confirmLogout),
                  content: Text(
                    AppLocalizations.of(context)!.areYouSureYouWantToLogout,
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(dialogContext),
                      child: Text(
                        AppLocalizations.of(context)!.cancel,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                    TextButton(
                      onPressed: () async {
                        Navigator.pop(dialogContext);

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
                      child: Text(
                        AppLocalizations.of(context)!.confirm,
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(
                              color: Theme.of(context).colorScheme.error,
                            ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
