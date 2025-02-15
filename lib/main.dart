import 'package:flutter/material.dart';
import 'package:projectpractice01/data/api/api_service.dart';
import 'package:projectpractice01/data/local/local_database_service.dart';
import 'package:projectpractice01/provider/bookmark/local_database_provider.dart';
import 'package:projectpractice01/provider/detail/tourism_detail_provider.dart';
import 'package:projectpractice01/provider/home/tourism_list_provider.dart';
import 'package:projectpractice01/provider/index_nav_provider.dart';
import 'package:projectpractice01/screen/detail/detail_screen.dart';
import 'package:projectpractice01/screen/main/main_screen.dart';
import 'package:projectpractice01/static/navigation_route.dart';
import 'package:projectpractice01/style/theme/tourism_theme.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => IndexNavProvider(),
        ),
        // todo-03-action-07: remove this injection
        // ChangeNotifierProvider(
        //   create: (context) => BookmarkListProvider(),
        // ),
        Provider(
          create: (context) => ApiServices(),
        ),
        ChangeNotifierProvider(
          create: (context) => TourismListProvider(
            context.read<ApiServices>(),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => TourismDetailProvider(
            context.read<ApiServices>(),
          ),
        ),
        // todo-02-provider-08: register the provider
        Provider(
          create: (context) => LocalDatabaseService(),
        ),
        ChangeNotifierProvider(
          create: (context) => LocalDatabaseProvider(
            context.read<LocalDatabaseService>(),
          ),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tourism App',
      theme: TourismTheme.lightTheme,
      darkTheme: TourismTheme.darkTheme,
      themeMode: ThemeMode.system,
      initialRoute: NavigationRoute.mainRoute.name,
      routes: {
        NavigationRoute.mainRoute.name: (context) => const MainScreen(),
        NavigationRoute.detailRoute.name: (context) => DetailScreen(
              tourismId: ModalRoute.of(context)?.settings.arguments as int,
            ),
      },
    );
  }
}
