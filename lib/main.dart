import 'package:digital_nfc_card/Screen/Login/LoginScreen.dart';
import 'package:digital_nfc_card/Screen/Profile/VisibleProfileScreen.dart';
import 'package:flutter/material.dart';
import 'package:digital_nfc_card/Screen/HomeScreen.dart';
import 'package:digital_nfc_card/Providers/UserDataProvider.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:go_router/go_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferences.getInstance();
  UserDataProvider userDataProvider = UserDataProvider();
  // Set preferred orientation to portrait
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((value) => runApp(
        ChangeNotifierProvider(
          create: (context) => userDataProvider,
          child: MaterialApp.router(
            debugShowCheckedModeBanner: false,
            routerConfig: GoRouter(
                errorBuilder: (context, state) => const LoginScreen(),
                routes: [
                  GoRoute(
                    path: "/",
                    builder: (_, __) => const HomeScreen(),
                    // routes: [
                    //   GoRoute(
                    //     path: "login",
                    //     builder: (_, __) => const LoginScreen(),
                    //   ),
                    //   GoRoute(
                    //     path: "profile",
                    //     builder: (_, __) => const ProfileScreen(),
                    //   ),
                    //   GoRoute(
                    //     path: "settingsNFCCardsScreen",
                    //     builder: (_, __) => const SettingsDigitalNFCCardProductsScreen(),
                    //   ),
                    // ],
                  ),
                  GoRoute(
                    path: "/users/:id/:cardId",
                    builder: (context, state) {
                      return VisibleProfileScreen(state.pathParameters['id'],
                          state.pathParameters['cardId']);
                    },
                  ),
                ]),
          ),
        ),
      ));
}
