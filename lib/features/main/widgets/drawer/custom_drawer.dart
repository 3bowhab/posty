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
    final theme = Theme.of(context);
    final localizations = AppLocalizations.of(context)!;

    return Drawer(
      backgroundColor: theme.colorScheme.surface,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          _buildDrawerHeader(context, theme, userProvider),
          CustomListTile(
            title: localizations.theme,
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
          const Divider(),
          CustomListTile(
            title: localizations.language,
            icon: Icons.language,
            list: const ['English', 'العربية'],
            initialValue: languageProvider.currentLanguage == 'en'
                ? 'English'
                : 'العربية',
            onChanged: (value) {
              languageProvider.changeLanguage(value == 'English' ? 'en' : 'ar');
            },
          ),
          const Divider(),
          ListTile(
            title: ListTileRow(
              icon: Icons.logout_outlined,
              title: localizations.logout,
            ),
            onTap: () => _showLogoutDialog(context, localizations, theme),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerHeader(
    BuildContext context,
    ThemeData theme,
    dynamic userProvider,
  ) {
    return DrawerHeader(
      decoration: BoxDecoration(color: theme.colorScheme.secondary),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            userProvider?.name ?? '',
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.whiteColor,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            userProvider?.email ?? '',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: AppColors.whiteColor,
            ),
          ),
        ],
      ),
    );
  }

  void _showLogoutDialog(
    BuildContext context,
    AppLocalizations localizations,
    ThemeData theme,
  ) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(localizations.confirmLogout),
        content: Text(localizations.areYouSureYouWantToLogout),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text(
              localizations.cancel,
              style: theme.textTheme.titleMedium,
            ),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(dialogContext);

              await FirebaseAuth.instance.signOut();

              if (!context.mounted) return;
              Navigator.of(
                context,
              ).pushNamedAndRemoveUntil(AppRoutes.loginView, (route) => false);

              ToastUtils.showSuccessToast(
                localizations.loggedOutSuccessfully,
                context,
              );
            },
            child: Text(
              localizations.confirm,
              style: theme.textTheme.titleMedium?.copyWith(
                color: theme.colorScheme.error,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
