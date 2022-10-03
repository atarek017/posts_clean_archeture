part of 'mange_posts_bloc.dart';

abstract class MangePostsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class MangePostsInitial extends MangePostsState {
  @override
  List<Object?> get props => [];
}

class LoadingMangePostsState extends MangePostsState {
  @override
  List<Object?> get props => [];
}

class ErrorMangePostsState extends MangePostsState {
  final String massage;

  ErrorMangePostsState({required this.massage});

  @override
  List<Object?> get props => [massage];
}

class MessageMangePostsState extends MangePostsState {
  final String massage;

  MessageMangePostsState({required this.massage});

  @override
  List<Object?> get props => [massage];
}
