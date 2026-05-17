import 'package:flutter/material.dart';
import 'package:posty/core/constants/app_images.dart';
import 'package:posty/core/constants/app_routes.dart';
import 'package:posty/core/utils/custom_button.dart';
import 'package:posty/core/utils/dialog_utils.dart';
import 'package:posty/core/utils/toast_utils.dart';
import 'package:provider/provider.dart';
import '../view_model/google_auth_view_model.dart';

class AuthWithgoogleButton extends StatelessWidget {
  final String label;
  final String toastMessage;

  const AuthWithgoogleButton({
    super.key,
    required this.label,
    required this.toastMessage,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => GoogleAuthViewModel(),
      child: Consumer<GoogleAuthViewModel>(
        builder: (context, viewModel, child) {
          return CustomButton(
            onPressed: () async {
              try {
                DialogUtils.showLoadingDialog(context);

                // استدعاء الـ Logic من الـ ViewModel
                await viewModel.handleGoogleSignIn(context);

                if (!context.mounted) return;
                Navigator.pop(context);

                ToastUtils.showSuccessToast(toastMessage, context);
                Navigator.pushReplacementNamed(context, AppRoutes.homeView);
              } catch (e) {
                if (!context.mounted) return;
                Navigator.pop(context);

                if (!e.toString().contains('canceled')) {
                  ToastUtils.showErrorToast(e.toString(), context);
                }
              }
            },
            labelWidget: Text(
              label,
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
                fontWeight: FontWeight.bold
              ),
            ),
            icon: Image.asset(Assets.imagesGoogle),
            backgroundColor: Theme.of(context).colorScheme.surface,
            borderSideColor: Theme.of(context).colorScheme.onSurfaceVariant,
          );
        },
      ),
    );
  }
}
