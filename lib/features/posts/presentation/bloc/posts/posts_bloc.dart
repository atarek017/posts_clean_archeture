import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_clean_architecher_app/core/error/failure.dart';
import 'package:posts_clean_architecher_app/features/posts/domain/use_cases/get_all_posts.dart';

import '../../../../../core/strings/failures.dart';
import '../../../domain/entities/post.dart';

part 'posts_event.dart';

part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final GetAllPostsUseCase getAllPosts;

  PostsBloc({required this.getAllPosts}) : super(PostsInitial()) {
    /// get all posts event
    on<GetAllPostsEvent>((event, emit) async {
      emit(LoadingPostsState());
      final request = await getAllPosts();
      request.fold(
        (failure) {
          emit(ErrorPostsState(message: _mapFailureToMessage(failure)));
        },
        (listPosts) {
          emit(LoadedPostsState(posts: listPosts));
        },
      );
    });

    /// refresh posts event
    on<RefreshPostsEvent>((event, emit) async {
      emit(LoadingPostsState());
      final request = await getAllPosts();
      request.fold(
        (failure) {
          emit(ErrorPostsState(message: _mapFailureToMessage(failure)));
        },
        (listPosts) {
          emit(LoadedPostsState(posts: listPosts));
        },
      );
    });
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return FailureString.serverErrorMessage;
      case EmptyCacheFailure:
        return FailureString.emptyCacheFailureMessage;
      case OfflineFailure:
        return FailureString.offlineFailureMessage;
      default:
        return FailureString.unExpectedFailureMessage;
    }
  }
}
