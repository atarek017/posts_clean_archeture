import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_clean_architecher_app/features/posts/presentation/bloc/mange_posts/mange_posts_bloc.dart';
import 'package:posts_clean_architecher_app/features/posts/presentation/bloc/posts/posts_bloc.dart';

import 'core/app_theme.dart';
import 'core/injection_container.dart' as di;
import 'features/posts/presentation/pages/posts_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.initAppModule();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (_)=>di.instance<PostsBloc>()..add(GetAllPostsEvent())),
          BlocProvider(create: (_)=>di.instance<MangePostsBloc>()),
        ],
        child: MaterialApp(
          title: 'Pasts App',
          theme: appTheme,
          debugShowCheckedModeBanner: false,
          home: const HomeScreen(),
        ));
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PostsPage();
  }
}
