import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:joy_bor/features/home/presentation/bloc/product_event.dart';
import 'package:joy_bor/features/profile/presentation/screen/my_profile_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:easy_localization/easy_localization.dart';

import 'features/home/presentation/pages/home_page.dart';
import 'features/auth/presentation/pages/login_page.dart';
import 'features/auth/presentation/pages/signup_page.dart';
import 'features/home/data/datasource/product_remote_datasource_impl.dart';
import 'features/home/data/repositories/product_repository_impl.dart';
import 'features/home/domain/usecases/get_all_products.dart';
import 'features/home/presentation/bloc/product_bloc.dart';
import 'features/place/presentation/bloc/search_bloc/search_bloc.dart';
import 'features/notification/data/datasource/notification_remote_datasource_impl.dart';
import 'features/notification/data/repositories/notification_repository_impl.dart';
import 'features/notification/domain/usecases/get_all_notifications.dart';
import 'features/notification/domain/usecases/get_notification_by_id.dart';
import 'features/notification/domain/usecases/post_notification.dart';
import 'features/notification/presentation/bloc/notification_bloc.dart';
import 'features/notification/presentation/bloc/notification_event.dart';
import 'features/place/presentation/pages/sort_cubit.dart';
import 'features/place/presentation/pages/search_history_cubit.dart';
import 'features/auth/data/auth_repository.dart';
import 'features/auth/presentation/bloc/signup_cubit.dart';
import 'features/auth/presentation/bloc/login_cubit.dart';
import 'features/auth/presentation/bloc/otp_cubit.dart';
import 'features/on_boarding/screens/splash_page.dart';
import 'features/on_boarding/screens/onboarding_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');
  const InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);

  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('token');

  final dio = Dio();
  final remoteDatasource = ProductRemoteDatasourceImpl(dio);
  final repository = ProductRepositoryImpl(remoteDatasource);
  final getAllProducts = GetAllProducts(repository);

  final notificationRemoteDatasource = NotificationRemoteDataSourceImpl(dio);
  final notificationRepository = NotificationRepositoryImpl(
    notificationRemoteDatasource,
  );
  final getAllNotifications = GetAllNotifications(notificationRepository);
  final getNotificationById = GetNotificationById(notificationRepository);
  final postNotification = PostNotification(notificationRepository);

  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('en'),
        Locale('ru'),
        Locale('uz'),
        Locale('kk'),
      ],
      path: 'assets/translations',
      fallbackLocale: Locale('en'),
      child: MyApp(
        isLoggedIn: token != null,
        getAllProducts: getAllProducts,
        repository: repository,
        getAllNotifications: getAllNotifications,
        getNotificationById: getNotificationById,
        postNotification: postNotification,
        flutterLocalNotificationsPlugin: flutterLocalNotificationsPlugin,
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  final GetAllProducts getAllProducts;
  final ProductRepositoryImpl repository;
  final GetAllNotifications getAllNotifications;
  final GetNotificationById getNotificationById;
  final PostNotification postNotification;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  const MyApp({
    super.key,
    required this.isLoggedIn,
    required this.getAllProducts,
    required this.repository,
    required this.getAllNotifications,
    required this.getNotificationById,
    required this.postNotification,
    required this.flutterLocalNotificationsPlugin,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SignUpCubit>(create: (_) => SignUpCubit(AuthRepository())),
        BlocProvider<LoginCubit>(create: (_) => LoginCubit(AuthRepository())),
        BlocProvider<OtpCubit>(create: (_) => OtpCubit(AuthRepository())),
        BlocProvider<ProductBloc>(
          create: (_) => ProductBloc(getAllProducts)..add(LoadProductsEvent()),
        ),
        BlocProvider<SearchBloc>(create: (_) => SearchBloc(repository)),
        BlocProvider<NotificationBloc>(
          create: (_) => NotificationBloc(
            getAllNotifications: getAllNotifications,
            getNotificationById: getNotificationById,
            postNotification: postNotification,
            flutterLocalNotificationsPlugin: flutterLocalNotificationsPlugin,
          )..add(FetchAllNotifications()),
        ),
        BlocProvider<SortCubit>(create: (_) => SortCubit()),
        BlocProvider<SearchHistoryCubit>(create: (_) => SearchHistoryCubit()),
      ],
      child: ScreenUtilInit(
        designSize: const Size(414, 896),
        child: MaterialApp(
          title: 'JoyBor',
          debugShowCheckedModeBanner: false,
          theme: ThemeData.dark(),
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          initialRoute: '/MyProfile',
          routes: {
            '/splash': (context) => SplashPage(),
            '/onboarding': (context) => OnboardingPage(),
            '/Login': (context) => LoginScreen(),
            '/signup': (context) => const SignUpScreen(),
            '/home': (context) => HomePage(),
            '/MyProfile': (context) => MyProfileScreen(),
          },
        ),
      ),
    );
  }
}
