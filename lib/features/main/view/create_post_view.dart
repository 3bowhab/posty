import 'package:flutter/material.dart';
import 'package:posty/core/extensions/responsive_padding_extension.dart';
import 'package:posty/core/extensions/responsive_sized_box_extension.dart';
import 'package:posty/core/theme/app_colors.dart';
import 'package:posty/core/utils/custom_text_form_field.dart';
import 'package:posty/core/utils/toast_utils.dart';
import 'package:posty/features/main/view_model/create_post_view_model.dart';
import 'package:posty/l10n/app_localizations.dart';

class CreatePostView extends StatefulWidget {
  const CreatePostView({super.key});

  @override
  State<CreatePostView> createState() => _CreatePostViewState();
}

class _CreatePostViewState extends State<CreatePostView> {
  final CreatePostViewModel _viewModel = CreatePostViewModel();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _bodyController.dispose();
    super.dispose();
  }

  void _submitPost() {
    if (_formKey.currentState!.validate()) {
      _viewModel.createPost(
        title: _titleController.text.trim(),
        body: _bodyController.text.trim(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(localizations.createNewPost)),
      body: SafeArea(
        child: ListenableBuilder(
          listenable: _viewModel,
          builder: (context, _) {
            if (_viewModel.state == CreatePostState.success) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                ToastUtils.showSuccessToast(
                  localizations.postPublishedSuccess,
                  context,
                );
                _viewModel.resetState();
                Navigator.pop(context);
              });
            }

            if (_viewModel.state == CreatePostState.error) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                ToastUtils.showErrorToast(_viewModel.errorMessage, context);
                _viewModel.resetState();
              });
            }

            return Padding(
              padding: 16.allPadding,
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        localizations.whatIsOnYourMind,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColors.firstColorAlt,
                        ),
                      ),
                      24.verticalSizedBox,
                      CustomTextFormField(
                        controller: _titleController,
                        labelText: localizations.titleLabel,
                        hintText: localizations.titleHint,
                        prefixIcon: Icons.title_outlined,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return localizations.titleValidationError;
                          }
                          return null;
                        },
                      ),
                      16.verticalSizedBox,
                      CustomTextFormField(
                        controller: _bodyController,
                        labelText: localizations.contentLabel,
                        hintText: localizations.contentHint,
                        prefixIcon: Icons.description_outlined,
                        maxLines: 5,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return localizations.contentValidationError;
                          }
                          return null;
                        },
                      ),
                      32.verticalSizedBox,
                      ElevatedButton(
                        onPressed: _viewModel.state == CreatePostState.loading
                            ? null
                            : _submitPost,
                        child: _viewModel.state == CreatePostState.loading
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: AppColors.whiteColor,
                                ),
                              )
                            : Text(
                                localizations.publishNow,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
