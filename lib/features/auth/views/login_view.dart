import 'package:flutter/material.dart';
import 'package:posty/core/constants/app_images.dart';
import 'package:posty/core/constants/app_routes.dart';
import 'package:posty/core/extensions/responsive_padding_extension.dart';
import 'package:posty/core/extensions/responsive_size_extension.dart';
import 'package:posty/core/extensions/responsive_sized_box_extension.dart';
import 'package:posty/core/utils/custom_button.dart';
import 'package:posty/core/utils/custom_text_form_field.dart';
import 'package:posty/core/utils/dialog_utils.dart';
import 'package:posty/core/utils/toast_utils.dart';
import 'package:posty/core/utils/validations.dart';
import 'package:posty/features/auth/view_model/login_view_model.dart';
import 'package:posty/features/auth/widgets/auth_withgoogle_button.dart';
import 'package:posty/features/auth/widgets/create_or_dont_have_account.dart';
import 'package:posty/features/auth/widgets/or_row.dart';
import 'package:posty/l10n/app_localizations.dart';
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.welcomeBack,
          style: Theme.of(context).textTheme.headlineMedium!.copyWith(
            color: Theme.of(context).colorScheme.onSecondary,
            fontWeight: FontWeight.bold,
          ),
        ),

        Text(
          AppLocalizations.of(context)!.loginToContinueExploring,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }

  Widget _buildFormFields(BuildContext context, LoginViewModel viewModel) {
    return Column(
      children: [
        CustomTextFormField(
          controller: viewModel.emailController,
          validator: (value) => Validations().validateEmail(value, context),
          hintText: AppLocalizations.of(context)!.enterYourEmail,
          labelText: AppLocalizations.of(context)!.email,
          prefixIcon: Icons.email_outlined,
          keyboardType: TextInputType.emailAddress,
        ),

        16.verticalSizedBox,
        CustomTextFormField(
          controller: viewModel.passwordController,
          validator: (value) => Validations().validatePassword(value, context),
          labelText: AppLocalizations.of(context)!.password,
          hintText: AppLocalizations.of(context)!.enterYourPassword,
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
      onPressed: () async {
        DialogUtils.showLoadingDialog(context);
        try {
          bool success = await viewModel.login(context);
          if (!context.mounted) return;
          Navigator.pop(context);
          if (success) {
            ToastUtils.showSuccessToast(
              AppLocalizations.of(context)!.loggedInSuccessfully,
              context,
            );
            Navigator.pushReplacementNamed(context, AppRoutes.homeView);
          }
        } catch (e) {
          Navigator.pop(context);
          ToastUtils.showErrorToast(e.toString(), context);
        }
      },
      label: AppLocalizations.of(context)!.login,
    );
  }

  Widget _buildSignUpOption(BuildContext context) {
    return CreateOrDontHaveAccount(
      text: AppLocalizations.of(context)!.dontHaveAnAccount,
      textButton: AppLocalizations.of(context)!.signUp,
      onTap: () =>
          Navigator.pushReplacementNamed(context, AppRoutes.registerView),
    );
  }

  Widget _buildGoogleLogin(BuildContext context) {
    return AuthWithgoogleButton(
      label: AppLocalizations.of(context)!.loginWithGoogle,
      toastMessage: AppLocalizations.of(context)!.loggedInSuccessfully,
    );
  }
}
