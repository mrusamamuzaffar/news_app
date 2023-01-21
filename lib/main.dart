import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:news_app/cubits/articles/cubit.dart';
import 'package:news_app/cubits/top_headlines/cubit.dart';
import 'package:news_app/models/article/article.dart';
import 'package:news_app/models/article/article_source.dart';
import 'package:news_app/models/news.dart';
import 'package:news_app/providers/category_provider.dart';
import 'package:news_app/providers/tab_provider.dart';
import 'package:news_app/providers/theme_provider.dart';
import 'package:news_app/screens/dashboard/dashboard.dart';
import 'package:news_app/screens/splash/splash.dart';
import 'package:news_app/screens/top_stories/top_stories.dart';
import 'package:provider/provider.dart';
import 'configs/core_theme.dart' as theme;

void main() async {
  await Hive.initFlutter();

  await dotenv.load(fileName: ".env");

  Hive.registerAdapter<News>(NewsAdapter());
  Hive.registerAdapter<Article>(ArticleAdapter());
  Hive.registerAdapter<ArticleSource>(ArticleSourceAdapter());

  await Hive.openBox('app');
  await Hive.openBox('newsBox');
  await Hive.openBox('articlesbox');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return MultiProvider(
      providers: [
        BlocProvider(create: (_) => ArticlesCubit()),
        BlocProvider(create: (_) => TopHeadlinesCubit()),
        ChangeNotifierProvider(create: (_) => TabProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => CategoryProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialChild(
            provider: themeProvider,
          );
        },
      ),
    );
  }
}

class MaterialChild extends StatelessWidget {
  final ThemeProvider provider;
  const MaterialChild({
    Key? key,
    required this.provider,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'News App',
      debugShowCheckedModeBanner: false,
      themeMode: provider.isDark ? ThemeMode.dark : ThemeMode.light,
      theme: theme.themeLight,
      darkTheme: theme.themeDark,
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => const SplashScreen(),
        '/dashboard': (context) => const DashboardScreen(),
        '/top-stories': (context) => const TopStoriesScreen(),
      },
    );
  }
}
