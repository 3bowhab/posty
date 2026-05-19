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
import 'package:posty/features/auth/view_model/login_view_model.dart';
import 'package:posty/features/auth/widgets/auth_with_google_button.dart';
import 'package:posty/features/auth/widgets/create_or_dont_have_account.dart';
import 'package:posty/features/auth/widgets/or_row.dart';
import 'package:posty/l10n/app_localizations.dart';
import 'package:posty/providers/user_provider.dart';
import 'package:provider/provider.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LoginViewModel(),
      child: Consumer<LoginViewModel>(
        builder: (context, viewModel, child) {
          return GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Scaffold(
              body: SingleChildScrollView(
                child: SafeArea(
                  child: Padding(
                    padding: 16.horizontalPadding,
                    child: Form(
                      key: viewModel.formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildLogo(),
                          _buildWelcomeText(context),
                          20.verticalSizedBox,
                          _buildFormFields(context, viewModel),
                          20.verticalSizedBox,
                          _buildLoginButton(context, viewModel),
                          30.verticalSizedBox,
                          _buildSignUpOption(context),
                          20.verticalSizedBox,
                          const OrRow(),
                          20.verticalSizedBox,
                          _buildGoogleLogin(context),
                          20.verticalSizedBox,
                        ],
                      ),
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

  Widget _buildWelcomeText(BuildContext context) {
    final theme = Theme.of(context);
    final localizations = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          localizations.welcomeBack,
          style: theme.textTheme.headlineMedium!.copyWith(
            color: theme.colorScheme.onSecondary,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          localizations.loginToContinueExploring,
          style: theme.textTheme.bodyMedium!.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }

  Widget _buildFormFields(BuildContext context, LoginViewModel viewModel) {
    final localizations = AppLocalizations.of(context)!;

    return Column(
      children: [
        CustomTextFormField(
          controller: viewModel.emailController,
          validator: (value) => Validations().validateEmail(value, context),
          hintText: localizations.enterYourEmail,
          labelText: localizations.email,
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
      ],
    );
  }

  Widget _buildLoginButton(BuildContext context, LoginViewModel viewModel) {
    return CustomButton(
      onPressed: () => _handleLoginAction(context, viewModel),
      label: AppLocalizations.of(context)!.login,
    );
  }

  Future<void> _handleLoginAction(
    BuildContext context,
    LoginViewModel viewModel,
  ) async {
    final localizations = AppLocalizations.of(context)!;
    try {
      DialogUtils.showLoadingDialog(context);
      final uid = await viewModel.login();

      if (!context.mounted) return;
      Navigator.pop(context);

      if (uid != null) {
        await context.read<UserProvider>().getUserData(uid);
        if (!context.mounted) return;

        ToastUtils.showSuccessToast(
          localizations.loggedInSuccessfully,
          context,
        );
        Navigator.pushReplacementNamed(context, AppRoutes.homeView);
      }
    } on FirebaseAuthException catch (e) {
      if (!context.mounted) return;
      Navigator.pop(context);

      String errorMessage;
      switch (e.code) {
        case 'wrong-password':
          errorMessage = localizations.wrongPassword;
          break;
        case 'user-not-found':
          errorMessage = localizations.userNotFound;
          break;
        case 'invalid-credential':
          errorMessage = localizations.invalidCredential;
          break;
        case 'user-disabled':
          errorMessage = localizations.userDisabled;
          break;
        case 'network-request-failed':
          errorMessage = localizations.networkError;
          break;
        default:
          errorMessage = FirebaseAuthExceptions.getMessage(e, context);
      }
      ToastUtils.showErrorToast(errorMessage, context);
    } catch (e) {
      if (!context.mounted) return;
      Navigator.pop(context);
      ToastUtils.showErrorToast(e.toString(), context);
    }
  }

  Widget _buildSignUpOption(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    return CreateOrDontHaveAccount(
      text: localizations.dontHaveAnAccount,
      textButton: localizations.signUp,
      onTap: () =>
          Navigator.pushReplacementNamed(context, AppRoutes.registerView),
    );
  }

  Widget _buildGoogleLogin(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    return AuthWithgoogleButton(
      label: localizations.loginWithGoogle,
      toastMessage: localizations.loggedInSuccessfully,
    );
  }
}
