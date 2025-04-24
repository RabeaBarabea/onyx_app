import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:onyx_task_app/features/auth/data/services/auth_service.dart';
import 'package:onyx_task_app/features/auth/logic/auth_provider.dart';
import 'package:onyx_task_app/features/auth/ui/login_screen.dart';
import 'package:onyx_task_app/features/home/data/service/home_api_service.dart';
import 'package:onyx_task_app/features/home/data/service/home_db_service.dart';
import 'package:onyx_task_app/features/home/logic/home_provider.dart';
import 'package:onyx_task_app/features/home/ui/home_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _startTimer();
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer(Duration(minutes: 2), _logout);
  }

  void _logout() {
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive) {
      _startTimer();
    } else if (state == AppLifecycleState.resumed) {
      _startTimer();
    }
  }

  @override
  Widget build(BuildContext context) {
    final dio = Dio();
    final api = HomeApi(dio);
    final db = HomeDb();
    return GestureDetector(
      onTap: _startTimer,
      onPanDown: (_) => _startTimer(),
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => AuthProvider(authService: AuthService(dio: dio)),
          ),
          ChangeNotifierProvider(create: (_) => HomeProvider(api, db)),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: '/login',
          routes: {
            '/login': (_) => LoginScreen(),
            '/home': (_) => HomeScreen(), // your actual home screen
          },
        ),
      ),
    );
  }
}
