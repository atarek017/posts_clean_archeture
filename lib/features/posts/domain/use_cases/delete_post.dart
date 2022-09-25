import 'package:dartz/dartz.dart';
import 'package:posts_clean_architecher_app/features/posts/domain/repositories/post_repository.dart';

import '../../../../core/error/failure.dart';

class DeletePostUseCase {
  final PostRepository repository;

  DeletePostUseCase(this.repository);

  Future<Either<Failure, Unit>> call(int postID) async {
    return await repository.deletePosts(postID);
  }
}
