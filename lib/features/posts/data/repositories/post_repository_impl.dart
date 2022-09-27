import 'package:dartz/dartz.dart';
import 'package:posts_clean_architecher_app/core/error/exception.dart';
import 'package:posts_clean_architecher_app/core/error/failure.dart';
import 'package:posts_clean_architecher_app/features/posts/data/models/post_model.dart';
import 'package:posts_clean_architecher_app/features/posts/domain/entities/post.dart';
import 'package:posts_clean_architecher_app/features/posts/domain/repositories/post_repository.dart';

import '../../../../core/network/network_info.dart';
import '../data_sources/post_local_data_source.dart';
import '../data_sources/post_remote_data_source.dart';

typedef DeleteOrUpdateOrUpdatePost = Future<Unit> Function();

class PostRepositoryImpl implements PostRepository {
  final PostRemoteDateSource remoteDateSource;
  final PostLocalDateSource localDateSource;
  final NetWorkInfo netWorkInfo;

  const PostRepositoryImpl(
      {required this.remoteDateSource,
      required this.localDateSource,
      required this.netWorkInfo});

  @override
  Future<Either<Failure, List<Post>>> getAllPosts() async {
    if (await netWorkInfo.isConnected) {
      try {
        final remotePosts = await remoteDateSource.getAllPosts();

        localDateSource.cachePosts(remotePosts);
        return Right(remotePosts);
      } on ServerException {
        return left(ServerFailure());
      }
    } else {
      try {
        final localPosts = await localDateSource.getCachedPosts();

        return Right(localPosts);
      } on EmptyCacheException {
        return left(EmptyCacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Unit>> addPost(Post post) async {
    final PostModel postModel =
        PostModel(id: post.id, body: post.body, title: post.title);

    return await _getMessage(() {
      return remoteDateSource.addPost(postModel);
    });
  }

  @override
  Future<Either<Failure, Unit>> deletePosts(int postId) async {
    return await _getMessage(() {
      return remoteDateSource.deletePost(postId);
    });
  }

  @override
  Future<Either<Failure, Unit>> updatePost(Post post) async {
    final PostModel postModel =
        PostModel(id: post.id, body: post.body, title: post.title);

    return await _getMessage(() {
      return remoteDateSource.updatePost(postModel);
    });
  }

  Future<Either<Failure, Unit>> _getMessage(
      DeleteOrUpdateOrUpdatePost function) async {
    if (await netWorkInfo.isConnected) {
      try {
        await function();
        return const Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }
}
