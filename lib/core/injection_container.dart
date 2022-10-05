import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:posts_clean_architecher_app/core/network/network_info.dart';
import 'package:posts_clean_architecher_app/features/posts/data/data_sources/post_local_data_source.dart';
import 'package:posts_clean_architecher_app/features/posts/data/data_sources/post_remote_data_source.dart';
import 'package:posts_clean_architecher_app/features/posts/data/repositories/post_repository_impl.dart';
import 'package:posts_clean_architecher_app/features/posts/domain/use_cases/add_post.dart';
import 'package:posts_clean_architecher_app/features/posts/domain/use_cases/delete_post.dart';
import 'package:posts_clean_architecher_app/features/posts/domain/use_cases/get_all_posts.dart';
import 'package:posts_clean_architecher_app/features/posts/domain/use_cases/update_post.dart';
import 'package:posts_clean_architecher_app/features/posts/presentation/bloc/mange_posts/mange_posts_bloc.dart';
import 'package:posts_clean_architecher_app/features/posts/presentation/bloc/posts/posts_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../features/posts/domain/repositories/post_repository.dart';

final instance = GetIt.instance;

Future<void> initAppModule() async {
  /// feature posts

  //bloc
  instance.registerFactory(() => PostsBloc(getAllPosts: instance()));
  instance.registerFactory(
    () => MangePostsBloc(
      addPostUseCase: instance(),
      deletePostUseCase: instance(),
      updatePostUseCase: instance(),
    ),
  );

  // use cases
  instance.registerLazySingleton(() => GetAllPostsUseCase(instance()));
  instance.registerLazySingleton(() => AddPostUseCase(instance()));
  instance.registerLazySingleton(() => DeletePostUseCase(instance()));
  instance.registerLazySingleton(() => UpdatePostUseCase(instance()));

  //repository
  instance.registerLazySingleton<PostRepository>(() => PostRepositoryImpl(
      remoteDateSource: instance(),
      localDateSource: instance(),
      netWorkInfo: instance()));

  //data sources
  instance.registerLazySingleton<PostRemoteDateSource>(
      () => PostRemoteDateSourceImpl(client: instance()));
  instance.registerLazySingleton<PostLocalDateSource>(
      () => PostLocalDateSourceImpl(sharedPreferences: instance()));

  /// core
  instance
      .registerLazySingleton<NetWorkInfo>(() => NetWorkInfoImpl(instance()));

  /// external
  final sharedPreferences = await SharedPreferences.getInstance();
  instance.registerLazySingleton(() => sharedPreferences);
  instance.registerLazySingleton(() => http.Client());
  instance.registerLazySingleton(() => InternetConnectionChecker());
}
