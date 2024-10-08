import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shuttle_monitor_web/pages/page_login.dart' as login;
import 'package:shuttle_monitor_web/pages/page_oper.dart' as screen;
import 'package:shuttle_monitor_web/pages/page_mag.dart' as screen;

void main() {
  runApp(const System());
}

class CustomRouter {
  static GoRouter router = GoRouter(routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => login.loginBox(context),
    ),
    GoRoute(
      path: '/oper',
      builder: (context, state) => screen.operScreen(context),
    ),
    GoRoute(
      path: '/mag',
      builder: (context, state) => screen.magScreen(),
    ),
  ]);
}

class System extends StatelessWidget {
  const System({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: CustomRouter.router,
    );
  }
}
