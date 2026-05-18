import 'package:flutter/material.dart';
import 'package:posty/core/constants/app_images.dart';
import 'package:posty/core/extensions/responsive_padding_extension.dart';
import 'package:posty/core/extensions/responsive_size_extension.dart';
import 'package:posty/core/extensions/responsive_sized_box_extension.dart';
import 'package:posty/core/theme/app_colors.dart';
import 'package:posty/features/main/view_model/home_view_model.dart';
import 'package:posty/features/main/widgets/drawer/custom_drawer.dart';

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
      ),
      body: SafeArea(
        child: ListenableBuilder(
          listenable: _viewModel,
          builder: (context, _) {
            switch (_viewModel.state) {
              case HomeState.loading:
                return const Center(child: CircularProgressIndicator());

              case HomeState.error:
                return Center(
                  child: Padding(
                    padding: 16.allPadding,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.error_outline,
                          color: AppColors.red,
                          size: 48,
                        ),
                        16.verticalSizedBox,
                        Text(
                          _viewModel.errorMessage,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        16.verticalSizedBox,
                        ElevatedButton(
                          onPressed: () => _viewModel.fetchFirstPosts(),
                          child: const Text('إعادة المحاولة'),
                        ),
                      ],
                    ),
                  ),
                );

              case HomeState.empty:
                return const Center(
                  child: Text('لا توجد منشورات متاحة حالياً.'),
                );

              case HomeState.loaded:
                return ListView.builder(
                  controller: _scrollController,
                  padding: 16.horizontalPadding,
                  itemCount:
                      _viewModel.posts.length +
                      (_viewModel.isFetchingMore ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index == _viewModel.posts.length) {
                      return const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Center(child: CircularProgressIndicator()),
                      );
                    }

                    final post = _viewModel.posts[index];

                    return Padding(
                      padding: 8.verticalPadding,
                      child: Card(
                        child: Padding(
                          padding: 8.allPadding,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                post.title,
                                style: Theme.of(context).textTheme.titleMedium
                                    ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.firstColorAlt,
                                    ),
                              ),
                              16.verticalSizedBox,
                              Text(
                                post.body,
                                style: Theme.of(context).textTheme.bodyMedium
                                    ?.copyWith(color: AppColors.textColor),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
            }
          },
        ),
      ),
    );
  }
}
