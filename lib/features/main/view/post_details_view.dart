import 'package:flutter/material.dart';
import 'package:posty/core/extensions/responsive_padding_extension.dart';
import 'package:posty/core/extensions/responsive_sized_box_extension.dart';
import 'package:posty/core/theme/app_colors.dart';
import 'package:posty/features/main/view_model/post_details_view_model.dart';
import 'package:posty/l10n/app_localizations.dart';
import 'package:posty/models/comment_model.dart';
import 'package:posty/models/post_model.dart';

class PostDetailsView extends StatefulWidget {
  final PostModel post;

  const PostDetailsView({super.key, required this.post});

  @override
  State<PostDetailsView> createState() => _PostDetailsViewState();
}

class _PostDetailsViewState extends State<PostDetailsView> {
  late final PostDetailsViewModel _viewModel;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _viewModel = PostDetailsViewModel(postId: widget.post.id);
    _viewModel.fetchFirstComments();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent * 0.9) {
      _viewModel.fetchMoreComments();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(localizations.postDetails)),
      body: SafeArea(
        child: CustomScrollView(
          controller: _scrollController,
          slivers: [
            _buildPostHeaderCard(),
            _buildCommentsSectionTitle(localizations),
            ListenableBuilder(
              listenable: _viewModel,
              builder: (context, _) {
                switch (_viewModel.state) {
                  case CommentsState.loading:
                    return _buildLoadingSliver();
                  case CommentsState.error:
                    return _buildErrorSliver(context);
                  case CommentsState.empty:
                    return _buildEmptySliver(localizations);
                  case CommentsState.loaded:
                    return _buildCommentsListSliver();
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPostHeaderCard() {
    return SliverPadding(
      padding: 16.allPadding,
      sliver: SliverToBoxAdapter(
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          child: Padding(
            padding: 16.allPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.post.title,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.firstColorAlt,
                  ),
                ),
                16.verticalSizedBox,
                Text(
                  widget.post.body,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(color: AppColors.textColor),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCommentsSectionTitle(AppLocalizations localizations) {
    return SliverPadding(
      padding: 16.horizontalPadding,
      sliver: SliverToBoxAdapter(
        child: Text(
          localizations.comments,
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildLoadingSliver() {
    return const SliverFillRemaining(
      hasScrollBody: false,
      child: Center(child: CircularProgressIndicator()),
    );
  }

  Widget _buildEmptySliver(AppLocalizations localizations) {
    return SliverFillRemaining(
      hasScrollBody: false,
      child: Center(child: Text(localizations.noComments)),
    );
  }

  Widget _buildErrorSliver(BuildContext context) {
    return SliverFillRemaining(
      hasScrollBody: false,
      child: Center(
        child: Padding(
          padding: 16.horizontalPadding,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, color: AppColors.red, size: 48),
              16.verticalSizedBox,
              Text(_viewModel.errorMessage, textAlign: TextAlign.center),
              16.verticalSizedBox,
              ElevatedButton(
                onPressed: () => _viewModel.fetchFirstComments(),
                child: Text(AppLocalizations.of(context)!.tryAgain),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCommentsListSliver() {
    return SliverPadding(
      padding: 16.horizontalPadding,
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            if (index == _viewModel.comments.length) {
              return _buildFetchMoreLoader();
            }
            return _buildCommentCard(context, _viewModel.comments[index]);
          },
          childCount:
              _viewModel.comments.length + (_viewModel.hasNextPage ? 1 : 0),
        ),
      ),
    );
  }

  Widget _buildFetchMoreLoader() {
    return Padding(
      padding: 16.allPadding,
      child: const Center(child: CircularProgressIndicator()),
    );
  }

  Widget _buildCommentCard(BuildContext context, CommentModel comment) {
    final theme = Theme.of(context);

    return Card(
      child: Padding(
        padding: 12.allPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              comment.name,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.onSecondaryContainer,
              ),
            ),
            4.verticalSizedBox,
            Text(
              comment.body,
              style: theme.textTheme.bodySmall?.copyWith(
                color: AppColors.textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
