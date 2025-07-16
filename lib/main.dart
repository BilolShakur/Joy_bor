import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// Blocs and Data Layers
import 'package:joy_bor/features/place/data/datasource/product_remote_datasource_impl.dart';
import 'package:joy_bor/features/place/data/repositories/product_repository_impl.dart';
import 'package:joy_bor/features/place/domain/usecases/get_all_products.dart';
import 'package:joy_bor/features/place/presentation/bloc/product_bloc/product_bloc.dart';
import 'package:joy_bor/features/place/presentation/bloc/search_bloc/search_bloc.dart';
import 'features/notification/data/datasource/notification_remote_datasource_impl.dart';
import 'features/notification/data/repositories/notification_repository_impl.dart';
import 'features/notification/domain/usecases/get_all_notifications.dart';
import 'features/notification/domain/usecases/get_notification_by_id.dart';
import 'features/notification/domain/usecases/post_notification.dart';
import 'features/notification/presentation/bloc/notification_bloc.dart';
import 'features/notification/presentation/bloc/notification_event.dart';

// UI Pages
import 'auth/screens/login_screen.dart';
import 'auth/screens/signup_screen.dart';
import 'package:joy_bor/features/place/presentation/pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();


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

  // Notification feature dependencies
  final notificationRemoteDatasource = NotificationRemoteDataSourceImpl(dio);
  final notificationRepository = NotificationRepositoryImpl(
    notificationRemoteDatasource,
  );
  final getAllNotifications = GetAllNotifications(notificationRepository);
  final getNotificationById = GetNotificationById(notificationRepository);
  final postNotification = PostNotification(notificationRepository);

  runApp(
    MyApp(
      isLoggedIn: token != null,
      getAllProducts: getAllProducts,
      repository: repository,
      getAllNotifications: getAllNotifications,
      getNotificationById: getNotificationById,
      postNotification: postNotification,
      flutterLocalNotificationsPlugin: flutterLocalNotificationsPlugin,
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
      ],
      child: MaterialApp(
        title: 'JoyBor',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark(),
        initialRoute: isLoggedIn ? '/home' : '/',
        routes: {
          '/': (context) => LoginScreen(),
          '/signup': (context) => const SignUpScreen(),
          '/home': (context) => const HomePageWithLogout(),
        },
      ),
    );
  }
}

class HomePageWithLogout extends StatelessWidget {
  const HomePageWithLogout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('JoyBor Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              final prefs = await SharedPreferences.getInstance();
              await prefs.remove('token');
              Navigator.pushReplacementNamed(context, '/');
            },
          ),
        ],
      ),
      body: const HomePage(), // your actual home page UI
    );
  }
}
