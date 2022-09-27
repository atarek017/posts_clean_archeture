import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:posts_clean_architecher_app/core/constants.dart';
import 'package:posts_clean_architecher_app/core/error/exception.dart';
import 'package:posts_clean_architecher_app/features/posts/data/models/post_model.dart';
import 'package:http/http.dart' as http;

abstract class PostRemoteDateSource {
  Future<List<PostModel>> getAllPosts();

  Future<Unit> deletePost(int postID);

  Future<Unit> updatePost(PostModel postModel);

  Future<Unit> addPost(PostModel postModel);
}

class PostRemoteDateSourceImpl implements PostRemoteDateSource {
  final http.Client client;

  PostRemoteDateSourceImpl({required this.client});

  @override
  Future<List<PostModel>> getAllPosts() async {
    final response = await client.get(
      Uri.parse(Constants.BASE_URL + Constants.postsRoute),
      headers: Constants.HEADERS,
    );

    if (response.statusCode == 200) {
      List decodedJson = json.decode(response.body) as List;

      List<PostModel> listPostModel =
          decodedJson.map<PostModel>((e) => PostModel.fromJson(e)).toList();
      return listPostModel;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> addPost(PostModel postModel) async {
    final body = {"title": postModel.title, "body": postModel.body};

    final response = await client.post(
      Uri.parse(Constants.BASE_URL + Constants.postsRoute),
      headers: Constants.HEADERS,
      body: body,
    );

    if (response.statusCode == 201) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> deletePost(int postID) async {
    final response = await client.delete(
      Uri.parse(
          "${Constants.BASE_URL}${Constants.postsRoute}${postID.toString()}"),
      headers: Constants.HEADERS,
    );

    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> updatePost(PostModel postModel) async {
    final body = {"title": postModel.title, "body": postModel.body};

    final response = await client.patch(
      Uri.parse(
        Constants.BASE_URL + Constants.postsRoute + postModel.id.toString()),
      headers: Constants.HEADERS,
      body: body,
    );

    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }
}
