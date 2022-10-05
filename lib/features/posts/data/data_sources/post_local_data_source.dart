import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:posts_clean_architecher_app/core/constants.dart';
import 'package:posts_clean_architecher_app/features/posts/data/models/post_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/error/exception.dart';

abstract class PostLocalDateSource {
  Future<List<PostModel>> getCachedPosts();

  Future<Unit> cachePosts(List<PostModel> posts);
}

class PostLocalDateSourceImpl implements PostLocalDateSource {
  final SharedPreferences sharedPreferences;

  PostLocalDateSourceImpl({required this.sharedPreferences});

  @override
  Future<Unit> cachePosts(List<PostModel> posts) {
    List postModelsToJson = posts
        .map<Map<String, dynamic>>((postModel) => postModel.toJson())
        .toList();
    sharedPreferences.setString(Constants.CACHED_POSTS, json.encode(postModelsToJson));
    return Future.value(unit);
  }

  @override
  Future<List<PostModel>> getCachedPosts() {
    final jsonData = sharedPreferences.getString(Constants.CACHED_POSTS);

    if (jsonData != null) {
      List decodeData = json.decode(jsonData);

      List<PostModel> jsonToPostModel = decodeData.map<PostModel>((e) => PostModel.fromJson(e)).toList();

      return Future.value(jsonToPostModel);
    } else {
      throw EmptyCacheException();
    }
  }
}
