import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:shared_preferences/shared_preferences.dart';


import '/auth/screens/signup_screen.dart';
import '/auth/screens/homePage.dart';


import '/core/gemini_service.dart/chat_view_model.dart';
import '/core/gemini_service.dart/chat_screen.dart';


import 'package:joy_bor/features/place/data/datasource/product_remote_datasource_impl.dart';
import 'package:joy_bor/features/place/data/repositories/product_repository_impl.dart';
import 'package:joy_bor/features/place/domain/usecases/get_all_products.dart';
import 'package:joy_bor/features/place/presentation/bloc/product_bloc/product_bloc.dart';
import 'package:joy_bor/features/place/presentation/bloc/search_bloc/search_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Gemini.init(apiKey: 'AIzaSyDz2U1DC4qdgEwrwDSeZTxCeSxgYFbRbEo');

  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('token');

  final dio = Dio();
  final remoteDatasource = ProductRemoteDatasourceImpl(dio);
  final repository = ProductRepositoryImpl(remoteDatasource);
  final getAllProducts = GetAllProducts(repository);

  runApp(MyApp(
    isLoggedIn: token != null,
    getAllProducts: getAllProducts,
    repository: repository,
  ));
}

class MyApp extends StatefulWidget {
  final bool isLoggedIn;
  final GetAllProducts getAllProducts;
  final ProductRepositoryImpl repository;

  const MyApp({
    super.key,
    required this.isLoggedIn,
    required this.getAllProducts,
    required this.repository,
  });

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.light;

  void _toggleTheme(bool isDark) {
    setState(() {
      _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ChatViewModel()),
        BlocProvider<ProductBloc>(
          create: (_) =>
              ProductBloc(widget.getAllProducts)..add(LoadProductsEvent()),
        ),
        BlocProvider<SearchBloc>(
          create: (_) => SearchBloc(widget.repository),
        ),
      ],
      child: MaterialApp(
        title: 'JoyBor',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        themeMode: _themeMode,
        home: widget.isLoggedIn
            ? ChatScreen(
                onThemeToggle: _toggleTheme,
                isDarkMode: _themeMode == ThemeMode.dark,
              )
            : const SignUpScreen(),

        routes: {
          '/signup': (context) => const SignUpScreen(),
          '/home': (context) => const Homepage(),
          '/chat': (context) => ChatScreen(
                onThemeToggle: _toggleTheme,
                isDarkMode: _themeMode == ThemeMode.dark,
              ),
        },
      ),
    );
  }
}