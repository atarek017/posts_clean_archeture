import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_clean_architecher_app/features/posts/domain/entities/post.dart';
import 'package:posts_clean_architecher_app/features/posts/presentation/bloc/mange_posts/mange_posts_bloc.dart';

class FormWidget extends StatefulWidget {
  final bool isUpdatePost;
  final Post? post;

  const FormWidget({required this.isUpdatePost, this.post, Key? key})
      : super(key: key);

  @override
  State<FormWidget> createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _tittleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();

  @override
  void initState() {
    if (widget.isUpdatePost) {
      _tittleController.text = widget.post!.title;
      _bodyController.text = widget.post!.body;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: TextFormField(
              controller: _tittleController,
              validator: (val) => val!.isEmpty ? "Title can't be empty" : null,
              decoration: const InputDecoration(hintText: "Tittle"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: TextFormField(
              controller: _bodyController,
              validator: (val) => val!.isEmpty ? "Body can't be empty" : null,
              decoration: const InputDecoration(hintText: "Body"),
              minLines: 6,
              maxLines: 6,
            ),
          ),
          ElevatedButton.icon(
            onPressed: buttonFunction,
            icon: widget.isUpdatePost ? Icon(Icons.edit) : Icon(Icons.add),
            label: Text(widget.isUpdatePost ? "Update" : "Add"),
          ),
        ],
      ),
    );
  }

  void buttonFunction() {
    bool isValid = _formKey.currentState?.validate() ?? false;

    if (isValid) {
      final post = Post(
          id: widget.post?.id ?? 0,
          body: _bodyController.text,
          title: _tittleController.text);

      if (widget.isUpdatePost) {
        context.read<MangePostsBloc>().add(UpdatePostEvent(post: post));
      } else {
        context.read<MangePostsBloc>().add(AddPostEvent(post: post));
      }
    }
     }
}
