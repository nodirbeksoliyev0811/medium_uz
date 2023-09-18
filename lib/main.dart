import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medium_uz/cubits/article/article_cubit.dart';
import 'package:medium_uz/cubits/auth/auth_cubit.dart';
import 'package:medium_uz/cubits/homework/homework_cubit.dart';
import 'package:medium_uz/cubits/profile/profile_cubit.dart';
import 'package:medium_uz/cubits/tabs/tabs_cubit.dart';
import 'package:medium_uz/cubits/user_data/user_data_cubit.dart';
import 'package:medium_uz/cubits/web/web_cubit.dart';
import 'package:medium_uz/data/network/api_service.dart';
import 'package:medium_uz/data/repositories/article_repository.dart';
import 'package:medium_uz/data/repositories/auth_repository.dart';
import 'package:medium_uz/data/repositories/homework_repository.dart';
import 'package:medium_uz/data/repositories/profile_repository.dart';
import 'package:medium_uz/data/repositories/web_repository.dart';
import 'package:medium_uz/service/service_locator.dart';

import 'cubits/add/article_add_cubit.dart';
import 'data/local/storage_repository.dart';
import 'presentation/app_routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await StorageRepository.getInstance();

  setup();

  runApp(App(apiService: ApiService()));
}

class App extends StatelessWidget {
  const App({super.key, required this.apiService});

  final ApiService apiService;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => AuthRepository()),
        RepositoryProvider(create: (context) => ArticleRepository()),
        RepositoryProvider(create: (context) => HomeworkRepository()),
        RepositoryProvider(create: (context) => WebsiteRepository()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthCubit(authRepository: context.read<AuthRepository>()),
          ),
          BlocProvider(
            create: (context) => ArticleCubit(articleRepository: context.read<ArticleRepository>()),
          ),
          BlocProvider(
            create: (context) => ArticleAddCubit(ArticleRepository()),
          ),
          BlocProvider(
            create: (context) => WebCubit(websiteRepository: context.read<WebsiteRepository>()),
          ),
          BlocProvider(
            create: (context) => HomeworkCubit(
              context.read<HomeworkRepository>(),
            ),
          ),
          BlocProvider(
            create: (context) => UserDataCubit(),
          ),
          BlocProvider(
            create: (context) => TabsCubit(),
          ),
          BlocProvider(
            create: (context) => ProfileCubit(
              profileRepository: ProfileRepository(),
            ),
          ),
        ],
        child: const MyApp(),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return const MaterialApp(
          themeMode: ThemeMode.light,
          debugShowCheckedModeBanner: false,
          onGenerateRoute: AppRoutes.generateRoute,
          initialRoute: RouteNames.splashScreen,
        );
      },
    );
  }
}
