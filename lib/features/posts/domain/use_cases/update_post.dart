import 'package:dartz/dartz.dart';
import 'package:posts_clean_architecher_app/features/posts/domain/entities/post.dart';
import 'package:posts_clean_architecher_app/features/posts/domain/repositories/post_repository.dart';

import '../../../../core/error/failure.dart';

class UpdatePostUseCase {
  final PostRepository repository;

  UpdatePostUseCase(this.repository);

  Future<Either<Failure, Unit>> call(Post post) async {
    return await repository.updatePost(post);
  }
}
