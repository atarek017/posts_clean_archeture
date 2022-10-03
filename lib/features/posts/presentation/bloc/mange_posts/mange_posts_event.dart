part of 'mange_posts_bloc.dart';

abstract class MangePostsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AddPostEvent extends MangePostsEvent {
  final Post post;

  AddPostEvent({required this.post});

  @override
  List<Object?> get props => [post];
}

class UpdatePostEvent extends MangePostsEvent {
  final Post post;

  UpdatePostEvent({required this.post});

  @override
  List<Object?> get props => [post];
}

class DeletePostEvent extends MangePostsEvent {
  final int postId;

  DeletePostEvent({required this.postId});

  @override
  List<Object?> get props => [postId];
}
