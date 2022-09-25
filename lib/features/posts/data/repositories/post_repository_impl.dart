import 'package:dartz/dartz.dart';
import 'package:posts_clean_architecher_app/core/error/failure.dart';
import 'package:posts_clean_architecher_app/features/posts/domain/entities/post.dart';
import 'package:posts_clean_architecher_app/features/posts/domain/repositories/post_repository.dart';

import '../data_sources/post_local_data_source.dart';
import '../data_sources/post_remote_data_source.dart';

class PostRepositoryImpl implements PostRepository {
  final PostRemoteDateSource remoteDateSource;
  final PostLocalDateSource localDateSource;

  const PostRepositoryImpl(
      {required this.remoteDateSource, required this.localDateSource});

  @override
  Future<Either<Failure, List<Post>>> getAllPosts() async {
    await remoteDateSource.getAllPosts();
    await localDateSource.getCachedPosts();

    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Unit>> addPost(Post post) {
    // TODO: implement addPost
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Unit>> deletePosts(int id) {
    // TODO: implement deletePosts
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Unit>> updatePost(Post post) {
    // TODO: implement updatePost
    throw UnimplementedError();
  }
}
