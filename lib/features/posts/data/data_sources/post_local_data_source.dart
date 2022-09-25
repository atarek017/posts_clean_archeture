import 'package:dartz/dartz.dart';
import 'package:posts_clean_architecher_app/features/posts/data/models/post_model.dart';

abstract class PostLocalDateSource {
  Future<List<PostModel>> getCachedPosts();

  Future<Unit> cachePost(List<PostModel> posts);
}

class PostLocalDateSourceImpl implements PostLocalDateSource {
  @override
  Future<Unit> cachePost(List<PostModel> posts) {
    // TODO: implement cachePost
    throw UnimplementedError();
  }

  @override
  Future<List<PostModel>> getCachedPosts() {
    // TODO: implement getCachedPosts
    throw UnimplementedError();
  }
}
