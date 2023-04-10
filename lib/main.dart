import 'package:action_manager/controllers/buy_item_controller.dart';
import 'package:action_manager/controllers/market_controller.dart';
import 'package:action_manager/controllers/portfolio_controller.dart';
import 'package:action_manager/repository/auth_repository/auth_repository.dart';
import 'package:action_manager/repository/market_repository.dart';
import 'package:action_manager/repository/portfolio_repository.dart';
import 'package:action_manager/ui/pages/auth/login_page.dart';
import 'package:action_manager/ui/pages/auth/signup_page.dart';
import 'package:action_manager/ui/pages/buy_item_page.dart';
import 'package:action_manager/ui/pages/main_page.dart';
import 'package:action_manager/ui/pages/sell_item_page.dart';
import 'package:action_manager/utils/hex_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'bindings/main_page_binding.dart';
import 'controllers/auth_controller.dart';
import 'controllers/main_page_controller.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp().then((value) {
    Get.put(AuthRepository());
    Get.put(AuthController());
  });

  // Get.put(MarketRepository());
  // Get.put(MarketController());
  //
  // Get.put(PortfolioRepository());
  // Get.put(PortfolioController());

  runApp(MyApp());
}

final _tempPages = [
  GetPage(name: '/',
      page: () => MainPage(),
      binding: HomePageBinding(),
  ),
  GetPage(name: '/login', page: () => LoginPage()),
  GetPage(name: '/signup', page: () => SignUpPage()),
  GetPage(
      name: '/sell',
      page: () => SellItemPage(),
      binding:  BindingsBuilder(() { Get.lazyPut(() => BuyItemController());}),
  ),
  GetPage(
      name: '/buy',
      page: () => BuyItemPage(),
      binding:  BindingsBuilder(() { Get.lazyPut(() => BuyItemController());}),
  ),
];

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/login',
        getPages: _tempPages,
        theme: ThemeData(
          primaryColor: HexColor.fromHex('#554AF0'),
          scaffoldBackgroundColor: Colors.white,
          fontFamily: 'Montserrat',
          buttonTheme: ButtonThemeData(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0)),
            buttonColor: HexColor.fromHex("#2864FF"),
          ),
        ));
  }
}
