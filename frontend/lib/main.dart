import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

import 'config/routes/routes.dart';
import 'config/theme/app_themes.dart';

// THEME (MODO OSCURO)
import 'features/theme/theme_bloc.dart';

// NEWS
import 'features/daily_news/presentation/bloc/article/remote/remote_article_bloc.dart';
import 'features/daily_news/presentation/bloc/article/remote/remote_article_event.dart';
import 'features/daily_news/presentation/pages/home/daily_news.dart';

// USER ARTICLES
import 'features/user_articles/presentation/bloc/user_articles_bloc.dart';
import 'features/user_articles/presentation/bloc/user_articles_event.dart';

import 'injection_container.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await initializeDependencies();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<RemoteArticlesBloc>(
          create: (_) => sl()..add(const GetArticles()),
        ),
        BlocProvider<UserArticlesBloc>(
          create: (_) => sl()..add(GetUserArticlesEvent()),
        ),
        BlocProvider<ThemeBloc>(
          create: (_) => ThemeBloc(),
        ),
      ],

            // ⭐ Aplicamos el ThemeBloc aquí
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, themeState) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData.light(),
            darkTheme: ThemeData.dark(),
            themeMode: themeState is ThemeDark ? ThemeMode.dark : ThemeMode.light,
            onGenerateRoute: AppRoutes.onGenerateRoutes,
            home: DailyNews(),
          );
        },
      ),
    );
  }
}
