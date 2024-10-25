import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shuttle_monitor_web/pages/page_login.dart' as login;
import 'package:shuttle_monitor_web/pages/page_oper.dart' as screen;
import 'package:shuttle_monitor_web/pages/page_mag.dart' as screen;
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const System());
}

class CustomRouter {
  static GoRouter router = GoRouter(routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => login.loginBox(context),
    ),
    GoRoute(
      name: 'oper',
      path: '/oper',
      builder: (context, state) => screen.operScreen(context),
    ),
    GoRoute(
      name: 'mag',
      path: '/mag',
      builder: (context, state) => screen.magScreen(),
    ),
  ]);
}

class System extends StatefulWidget {
  const System({super.key});

  @override
  State<System> createState() => _SystemState();
}

class _SystemState extends State<System> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: CustomRouter.router,
    );
  }
}
