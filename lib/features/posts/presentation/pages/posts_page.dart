import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_clean_architecher_app/features/posts/presentation/bloc/posts/posts_bloc.dart';
import 'package:posts_clean_architecher_app/features/posts/presentation/pages/post_mange.dart';
import 'package:posts_clean_architecher_app/features/posts/presentation/widgets/posts_widget.dart';

import '../widgets/loading_widget.dart';
import '../widgets/message_display_widget.dart';

class PostsPage extends StatelessWidget {
  const PostsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Posts"),
      ),
      body: _buildBody(),
      floatingActionButton: _buildFloatingActionButton(context),
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: BlocBuilder<PostsBloc, PostsState>(
        builder: (context, state) {
          if (state is LoadingPostsState) {
            return const LoadingWidget();
          } else if (state is LoadedPostsState) {
            return RefreshIndicator(
              onRefresh: () => _onRefresh(context),
              child: PostsListWidget(
                posts: state.posts,
              ),
            );
          } else if (state is ErrorPostsState) {
            return MessageDisplayWidget(message: state.message);
          } else {
            return Container();
          }
        },
      ),
    );
  }

  Widget _buildFloatingActionButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const PostMangeScreen(
              isUpdate: false,
            ),
          ),
        );
      },
      child: const Icon(Icons.add),
    );
  }

  Future<void> _onRefresh(BuildContext context) async {
    context.read<PostsBloc>().add(RefreshPostsEvent());
  }
}
