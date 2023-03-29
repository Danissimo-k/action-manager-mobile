import 'package:action_manager/ui/pages/auth/login_page.dart';
import 'package:action_manager/ui/pages/auth/signup_page.dart';
import 'package:action_manager/ui/pages/buy_item_page.dart';
import 'package:action_manager/ui/pages/main_page.dart';
import 'package:action_manager/ui/pages/portfolio.dart';
import 'package:action_manager/ui/pages/sell_item_page.dart';
import 'package:action_manager/utils/hex_color.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(MyApp());
}

final GoRouter _router = GoRouter(initialLocation: '/signup', routes: <GoRoute>[
  GoRoute(
    path: "/",
    builder: (BuildContext context, GoRouterState state) {
      return const MainPage();
    },
  ),
  GoRoute(
    path: "/login",
    builder: (BuildContext context, GoRouterState state) {
      return LoginPage();
    },
  ),
  GoRoute(
    path: "/signup",
    builder: (BuildContext context, GoRouterState state) {
      return SignUpPage();
    },
  ),
  GoRoute(
    path: "/sell",
    builder: (BuildContext context, GoRouterState state) {
      return const SellItemPage();
    },
  ),
  GoRoute(
    path: "/buy",
    builder: (BuildContext context, GoRouterState state) {
      return const BuyItemPage();
    },
  ),
]);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: HexColor.fromHex('#554AF0'),
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Montserrat',
        buttonTheme: ButtonThemeData(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
          buttonColor: HexColor.fromHex("#2864FF"),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: HexColor.fromHex("#F6F6F6"),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: HexColor.fromHex("#E8E8E8")),
              borderRadius: BorderRadius.circular(8)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: HexColor.fromHex("#E8E8E8")),
              borderRadius: BorderRadius.circular(8)),
        ),
      ),
      routerConfig: _router,
    );
  }
}
