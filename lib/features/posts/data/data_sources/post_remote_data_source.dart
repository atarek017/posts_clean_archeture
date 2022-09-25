import 'package:dartz/dartz.dart';
import 'package:posts_clean_architecher_app/features/posts/data/models/post_model.dart';

abstract class PostRemoteDateSource {
  Future<List<PostModel>> getAllPosts();

  Future<Unit> deletePost(int postID);

  Future<Unit> updatePost(PostModel postModel);

  Future<Unit> addPost(PostModel postModel);
}

class PostRemoteDateSourceImpl implements PostRemoteDateSource {
  @override
  Future<Unit> addPost(PostModel postModel) {
    // TODO: implement addPost
    throw UnimplementedError();
  }

  @override
  Future<Unit> deletePost(int postID) {
    // TODO: implement deletePost
    throw UnimplementedError();
  }

  @override
  Future<List<PostModel>> getAllPosts() {
    // TODO: implement getAllPosts
    throw UnimplementedError();
  }

  @override
  Future<Unit> updatePost(PostModel postModel) {
    // TODO: implement updatePost
    throw UnimplementedError();
  }
}
