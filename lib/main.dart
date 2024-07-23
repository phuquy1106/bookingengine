import 'package:bookingengine_frontend/manager/generalmanager.dart';
import 'package:bookingengine_frontend/ui/congratulations.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:bookingengine_frontend/ui/home.dart';
import 'package:bookingengine_frontend/ui/page/pagenotfound.dart';
import 'package:bookingengine_frontend/util/designmanagement.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseFunctions.instance.useFunctionsEmulator('localhost', 5001);
  Uri uri = Uri.dataFromString(html.window.location.href);
  GeneralManager.idHotel = uri.queryParameters['id'] ?? "vK1lC2zin2ig9DREPjsN";
  // await GeneralManager.getHotel();
  final GeneralManager generalManager = GeneralManager();
  // await GeneralManager.addRoomType();
  await GeneralManager.getUsersOfHotel();
  await GeneralManager.getPolicy2();
  await generalManager.loadLocalStorage();
  runApp(
    ChangeNotifierProvider(
      create: (context) => generalManager,
      child: Consumer<GeneralManager>(
        builder: (context, generalManager, _) {
          return GestureDetector(
            onTap: () => GeneralManager().unfocus(context),
            child: MaterialApp(
                onUnknownRoute: (settings) {
                  return MaterialPageRoute(
                      builder: (_) => const PageNotFound());
                },
                routes: {'main': (context) => const Congratulations()},
                onGenerateInitialRoutes: (String value) {
                  return [
                    MaterialPageRoute(builder: (_) => const HomeWidget())
                  ];
                },
                debugShowCheckedModeBanner: false,
                title: GeneralManager.hotel!.nameHotel!,
                theme: initializeTheme,
                localizationsDelegates: const [
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                supportedLocales: const [Locale('en', ''), Locale('vi', '')],
                locale: GeneralManager.locale),
          );
        },
      ),
    ),
  );
}

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: HomeWidget(),
      ),
    );
  }
}

ThemeData get initializeTheme {
  const MaterialColor kPrimaryColor = MaterialColor(
    0xff303136,
    <int, Color>{
      50: Color(0xff303136),
      100: Color(0xff303136),
      200: Color(0xff303136),
      300: Color(0xff303136),
      400: Color(0xff303136),
      500: Color(0xff303136),
      600: Color(0xff303136),
      700: Color(0xff303136),
      800: Color(0xff303136),
      900: Color(0xff303136),
    },
  );
  return ThemeData(
    primarySwatch: kPrimaryColor,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.white),
      bodyMedium: TextStyle(color: Colors.white),
      labelLarge: TextStyle(color: Colors.white),
      bodySmall: TextStyle(color: Colors.white),
      displayLarge: TextStyle(color: Colors.white),
      displayMedium: TextStyle(color: Colors.white),
      displaySmall: TextStyle(color: Colors.white),
      headlineMedium: TextStyle(color: Colors.white),
      headlineSmall: TextStyle(color: Colors.white),
      titleLarge: TextStyle(color: Colors.white),
      labelSmall: TextStyle(color: Colors.white),
      titleMedium: TextStyle(color: ColorManagement.mainBackground),
      titleSmall: TextStyle(color: Colors.white),
    ),
    iconTheme: const IconThemeData(color: Colors.white),
    primaryIconTheme: const IconThemeData(color: Colors.white),
    hintColor: const Color(0xffeddcd2),
    inputDecorationTheme: const InputDecorationTheme(),
    textSelectionTheme: const TextSelectionThemeData(
      selectionColor: Color(0xff9799a1),
    ),
    dialogTheme: DialogTheme(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),
  );
}
