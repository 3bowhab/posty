import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:posty/core/constants/app_images.dart';
import 'package:posty/core/constants/app_routes.dart';
import 'package:posty/core/extensions/responsive_padding_extension.dart';
import 'package:posty/core/extensions/responsive_size_extension.dart';
import 'package:posty/core/extensions/responsive_sized_box_extension.dart';
import 'package:posty/core/utils/custom_button.dart';
import 'package:posty/core/utils/custom_text_form_field.dart';
import 'package:posty/core/utils/dialog_utils.dart';
import 'package:posty/core/utils/firebase_exceptions.dart';
import 'package:posty/core/utils/toast_utils.dart';
import 'package:posty/core/utils/validations.dart';
import 'package:posty/features/auth/view_model/register_view_model.dart';
import 'package:posty/features/auth/widgets/auth_with_google_button.dart';
import 'package:posty/features/auth/widgets/create_or_dont_have_account.dart';
import 'package:posty/features/auth/widgets/or_row.dart';
import 'package:posty/l10n/app_localizations.dart';
import 'package:posty/providers/user_provider.dart';
import 'package:provider/provider.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RegisterViewModel(),
      child: Consumer<RegisterViewModel>(
        builder: (context, viewModel, child) {
          return GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Scaffold(
              body: SafeArea(
                child: SingleChildScrollView(
                  padding: 16.horizontalPadding,
                  child: Form(
                    key: viewModel.formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildLogo(),
                        _buildHeaderText(context),
                        20.verticalSizedBox,
                        _buildFormFields(context, viewModel),
                        30.verticalSizedBox,
                        _buildRegisterButton(context, viewModel),
                        30.verticalSizedBox,
                        _buildLoginOption(context),
                        20.verticalSizedBox,
                        const OrRow(),
                        20.verticalSizedBox,
                        _buildGoogleSignUp(context),
                        20.verticalSizedBox,
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildLogo() {
    return Center(
      child: SizedBox(
        height: 200.height,
        child: Image.asset(Assets.imagesLogo),
      ),
    );
  }

  Widget _buildHeaderText(BuildContext context) {
    final theme = Theme.of(context);
    final localizations = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          localizations.letsGetStarted,
          style: theme.textTheme.headlineMedium!.copyWith(
            color: theme.colorScheme.onSecondary,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          localizations.createAnAccountToUnlockAllFeatures,
          style: theme.textTheme.bodyMedium!.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }

  Widget _buildFormFields(BuildContext context, RegisterViewModel viewModel) {
    final localizations = AppLocalizations.of(context)!;

    return Column(
      children: [
        CustomTextFormField(
          controller: viewModel.nameController,
          validator: (value) => Validations().validateName(value, context),
          hintText: localizations.enterYourName,
          labelText: localizations.name,
          prefixIcon: Icons.person_outline,
          keyboardType: TextInputType.name,
        ),
        16.verticalSizedBox,
        CustomTextFormField(
          controller: viewModel.emailController,
          validator: (value) => Validations().validateEmail(value, context),
          labelText: localizations.email,
          hintText: localizations.enterYourEmail,
          prefixIcon: Icons.email_outlined,
          keyboardType: TextInputType.emailAddress,
        ),
        16.verticalSizedBox,
        CustomTextFormField(
          controller: viewModel.passwordController,
          validator: (value) => Validations().validatePassword(value, context),
          labelText: localizations.password,
          hintText: localizations.enterYourPassword,
          prefixIcon: Icons.lock_outline,
          suffixIcon: Icons.visibility_off_outlined,
          isPassword: true,
          keyboardType: TextInputType.text,
        ),
        16.verticalSizedBox,
        CustomTextFormField(
          controller: viewModel.confirmPasswordController,
          validator: (value) => Validations().validateConfirmPassword(
            value,
            viewModel.passwordController.text,
            context,
          ),
          labelText: localizations.confirmPassword,
          hintText: localizations.confirmYourPassword,
          prefixIcon: Icons.lock_outline,
          suffixIcon: Icons.visibility_off_outlined,
          isPassword: true,
          keyboardType: TextInputType.text,
        ),
      ],
    );
  }

  Widget _buildRegisterButton(
    BuildContext context,
    RegisterViewModel viewModel,
  ) {
    return CustomButton(
      onPressed: () => _handleRegisterAction(context, viewModel),
      label: AppLocalizations.of(context)!.signUp,
    );
  }

  Future<void> _handleRegisterAction(
    BuildContext context,
    RegisterViewModel viewModel,
  ) async {
    try {
      DialogUtils.showLoadingDialog(context);
      final uid = await viewModel.register();

      if (!context.mounted) return;
      Navigator.pop(context);

      if (uid != null) {
        await context.read<UserProvider>().getUserData(uid);
        if (!context.mounted) return;

        ToastUtils.showSuccessToast(
          AppLocalizations.of(context)!.accountCreatedSuccessfully,
          context,
        );
        Navigator.pushReplacementNamed(context, AppRoutes.homeView);
      }
    } on FirebaseAuthException catch (e) {
      if (!context.mounted) return;
      Navigator.pop(context);
      ToastUtils.showErrorToast(
        FirebaseAuthExceptions.getMessage(e, context),
        context,
      );
    } catch (e) {
      if (!context.mounted) return;
      Navigator.pop(context);
      ToastUtils.showErrorToast(e.toString(), context);
    }
  }

  Widget _buildLoginOption(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    return CreateOrDontHaveAccount(
      text: localizations.alreadyHaveAnAccount,
      textButton: localizations.login,
      onTap: () => Navigator.pushReplacementNamed(context, AppRoutes.loginView),
    );
  }

  Widget _buildGoogleSignUp(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    return AuthWithgoogleButton(
      label: localizations.signupwithgoogle,
      toastMessage: localizations.accountCreatedSuccessfully,
    );
  }
}
