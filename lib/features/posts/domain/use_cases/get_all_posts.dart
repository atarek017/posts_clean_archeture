import 'package:dartz/dartz.dart';
import 'package:posts_clean_architecher_app/features/posts/domain/repositories/post_repository.dart';

import '../../../../core/error/failure.dart';
import '../entities/post.dart';

class GetAllPostsUseCase {
  final PostRepository repository;

  GetAllPostsUseCase(this.repository);

  Future<Either<Failure, List<Post>>> call() async {
    return await repository.getAllPosts();
  }
}
