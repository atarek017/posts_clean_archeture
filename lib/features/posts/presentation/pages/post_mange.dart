import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_clean_architecher_app/features/posts/domain/entities/post.dart';
import 'package:posts_clean_architecher_app/features/posts/presentation/bloc/mange_posts/mange_posts_bloc.dart';
import 'package:posts_clean_architecher_app/features/posts/presentation/pages/posts_page.dart';
import 'package:posts_clean_architecher_app/features/posts/presentation/widgets/loading_widget.dart';

import '../../../../core/utils/snackbar_messag.dart';
import '../widgets/form_widget.dart';

class PostMangeScreen extends StatelessWidget {
  final Post? post;
  final bool isUpdate;

  const PostMangeScreen({this.post, required this.isUpdate, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isUpdate ? "Edit Post" : "Add Post"),
      ),
      body: _buildBody(context),
    );
  }

  /// body
  Widget _buildBody(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: BlocConsumer<MangePostsBloc, MangePostsState>(
          listener: (BuildContext context, Object? state) {
            /// message sucess
            if (state is MessageMangePostsState) {
              SnackBarMessage()
                  .showSucessSnackBar(message: state.massage, context: context);
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (_) => const PostsPage()),
                  (route) => false);
            }

            /// error state
            if (state is ErrorMangePostsState) {
              SnackBarMessage()
                  .showErrorSnackBar(message: state.massage, context: context);
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (_) => const PostsPage()),
                  (route) => false);
            }
          },
          builder: (BuildContext context, state) {
            /// loading
            if (state is LoadingMangePostsState) {
              return const LoadingWidget();
            }

            return FormWidget(
                isUpdatePost: isUpdate, post: isUpdate ? post : null);
          },
        ),
      ),
    );
  }
}
