import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_clean_architecher_app/core/strings/messages.dart';
import 'package:posts_clean_architecher_app/features/posts/domain/entities/post.dart';

import '../../../../../core/error/failure.dart';
import '../../../../../core/strings/failures.dart';
import '../../../domain/use_cases/add_post.dart';
import '../../../domain/use_cases/delete_post.dart';
import '../../../domain/use_cases/update_post.dart';

part 'mange_posts_event.dart';

part 'mange_posts_state.dart';

class MangePostsBloc extends Bloc<MangePostsEvent, MangePostsState> {
  final AddPostUseCase addPostUseCase;
  final DeletePostUseCase deletePostUseCase;
  final UpdatePostUseCase updatePostUseCase;

  MangePostsBloc({
    required this.addPostUseCase,
    required this.deletePostUseCase,
    required this.updatePostUseCase,
  }) : super(MangePostsInitial()) {
    /// add post
    on<AddPostEvent>((event, emit) async {
      emit(LoadingMangePostsState());
      final result = await addPostUseCase(event.post);

      emit(_eitherMangePostState(result, MessagesStrings.addSuccessMessage));
    });

    /// update post
    on<UpdatePostEvent>((event, emit) async {
      emit(LoadingMangePostsState());

      final result = await updatePostUseCase(event.post);

      emit(_eitherMangePostState(result, MessagesStrings.updatedSucessMessage));
    });

    /// delete post
    on<DeletePostEvent>((event, emit) async {
      emit(LoadingMangePostsState());
      final result = await deletePostUseCase(event.postId);

      emit(_eitherMangePostState(result, MessagesStrings.deletedSucessMessage));
    });
  }

  /// message failure handle
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

  MangePostsState _eitherMangePostState(
      Either<Failure, Unit> either, String message) {
    return either.fold(
        (l) => ErrorMangePostsState(massage: _mapFailureToMessage(l)),
        (r) => MessageMangePostsState(massage: message));
  }
}
