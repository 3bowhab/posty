import 'package:flutter/material.dart';
import 'package:posty/core/constants/app_images.dart';
import 'package:posty/core/extensions/responsive_padding_extension.dart';
import 'package:posty/core/extensions/responsive_size_extension.dart';
import 'package:posty/core/extensions/responsive_sized_box_extension.dart';
import 'package:posty/core/theme/app_colors.dart';
import 'package:posty/core/utils/toast_utils.dart';
import 'package:posty/features/main/view/create_post_view.dart';
import 'package:posty/features/main/view/post_details_view.dart';
import 'package:posty/features/main/view_model/home_view_model.dart';
import 'package:posty/features/main/widgets/drawer/custom_drawer.dart';
import 'package:posty/l10n/app_localizations.dart';
import 'package:posty/data/models/post_model.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final HomeViewModel _viewModel = HomeViewModel();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _viewModel.fetchFirstPosts();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent * 0.9) {
      _viewModel.fetchMorePosts();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: AppBar(
        title: Image.asset(
          Assets.imagesLogoHorizontal,
          height: 100.height,
          fit: BoxFit.contain,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_box_outlined),
            onPressed: () => _navigateToCreatePost(context),
          ),
        ],
      ),
      body: SafeArea(
        child: ListenableBuilder(
          listenable: _viewModel,
          builder: (context, _) {
            _handleOfflineToast(context);

            switch (_viewModel.state) {
              case HomeState.loading:
                return _buildLoading();
              case HomeState.error:
                return _buildError(context);
              case HomeState.empty:
                return _buildEmpty(context);
              case HomeState.loaded:
                return _buildPostList();
            }
          },
        ),
      ),
    );
  }

  void _handleOfflineToast(BuildContext context) {
    if (_viewModel.isOffline) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ToastUtils.showErrorToast(
          AppLocalizations.of(context)!.checkYourInternetConnection,
          context,
        );
        _viewModel.resetOfflineState();
      });
    }
  }

  Widget _buildLoading() {
    return const Center(child: CircularProgressIndicator());
  }

  Widget _buildEmpty(BuildContext context) {
    return Center(child: Text(AppLocalizations.of(context)!.noPostsAvailable));
  }

  Widget _buildError(BuildContext context) {
    return Center(
      child: Padding(
        padding: 16.allPadding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, color: AppColors.red, size: 48),
            16.verticalSizedBox,
            Text(
              _viewModel.errorMessage,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            16.verticalSizedBox,
            ElevatedButton(
              onPressed: () => _viewModel.fetchFirstPosts(),
              child: Text(AppLocalizations.of(context)!.tryAgain),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPostList() {
    return ListView.builder(
      controller: _scrollController,
      padding: 16.horizontalPadding,
      itemCount: _viewModel.posts.length + (_viewModel.isFetchingMore ? 1 : 0),
      itemBuilder: (context, index) {
        if (index == _viewModel.posts.length) {
          return _buildFetchMoreLoader();
        }
        return _buildPostCard(context, _viewModel.posts[index]);
      },
    );
  }

  Widget _buildFetchMoreLoader() {
    return const Padding(
      padding: EdgeInsets.all(16.0),
      child: Center(child: CircularProgressIndicator()),
    );
  }

  Widget _buildPostCard(BuildContext context, PostModel post) {
    return Padding(
      padding: 8.verticalPadding,
      child: GestureDetector(
        onTap: () => _navigateToPostDetails(context, post),
        child: Card(
          child: Padding(
            padding: 8.allPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  post.title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.firstColorAlt,
                  ),
                ),
                16.verticalSizedBox,
                Text(
                  post.body,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
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

  void _navigateToCreatePost(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CreatePostView()),
    );
  }

  void _navigateToPostDetails(BuildContext context, PostModel post) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PostDetailsView(post: post)),
    );
  }
}
