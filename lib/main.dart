import 'package:chatjob/Hive/localdata.dart';
import 'package:chatjob/const.dart';

import 'package:chatjob/cubits/observer.dart';
import 'package:chatjob/firebase_options.dart';
import 'package:chatjob/generated/codegen_loader.g.dart';
import 'package:chatjob/helpers/router.dart';
import 'package:chatjob/method/notifications.dart';

import 'package:chatjob/screens/newsplash.dart';
import 'package:chatjob/screens/settings/settings.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:easy_localization/easy_localization.dart';

late SharedPreferences pref;
main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Get the device token
  deviceToken = await getDeviceToken();
  Bloc.observer = MyBlocObserver();
  FirebaseMessaging.onBackgroundMessage(backgroundmessagehandel);
  pref = await SharedPreferences.getInstance();
  final appDocumentDirectory = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  loginbox = await openbox('login');
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.black.withOpacity(0),
      statusBarBrightness: Brightness.dark,
      systemNavigationBarColor: const Color.fromRGBO(2, 20, 31, 1)));

  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  runApp(
    EasyLocalization(
        supportedLocales: const [Locale('en', 'US'), Locale('cs', 'CZ')],
        path: 'assets/lang', // <-- change the path of the translation files
        fallbackLocale: const Locale('en', 'US'),
        assetLoader: const CodegenLoader(),
        child: const Home()),
  );
  //runApp(const Home());
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  @override
  void initState() {
    super.initState();
    remove();
  }

  remove() async {
    await Future.delayed(const Duration(milliseconds: 200));
    FlutterNativeSplash.remove();
  }

  final FirebaseMessagingService firebaseMessagingService =
      FirebaseMessagingService();
  @override
  Widget build(BuildContext context) {
    firebaseMessagingService.setupFirebase(context);

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      title: 'JP',
      navigatorKey: navigatorKey,
      onGenerateRoute: onGenerateRoute,
      theme: ThemeData.dark().copyWith(
          pageTransitionsTheme: const PageTransitionsTheme(builders: {
            TargetPlatform.android: CupertinoPageTransitionsBuilder(),
          }),
          scaffoldBackgroundColor: const Color.fromRGBO(2, 20, 31, 1),
          appBarTheme: AppBarTheme(
              titleTextStyle: Theme.of(context)
                  .textTheme
                  .displayLarge!
                  .copyWith(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFFF9F9F9)),
              backgroundColor: const Color.fromRGBO(2, 20, 31, 1),
              elevation: 0),
          textTheme: TextTheme(
              displayLarge: GoogleFonts.poppins(
            fontSize: 18,
            color: const Color(0xFFCFCECA),
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w300,
          ))),
      debugShowCheckedModeBanner: false,
      home: const NewSplashScreen(),
    );
  }

  // Future<void> handleDynamicLink(Map<String, dynamic> message) async {
  //   // Check if the message contains a Dynamic Link
  //   if (message.containsKey('data')) {
  //     final dynamicLink = message['data']['dynamicLink'];
  //     if (dynamicLink != null) {
  //       // Handle the Dynamic Link here
  //       print("Received Dynamic Link: $dynamicLink");
  //       // Navigate to the relevant screen based on the Dynamic Link
  //       if (dynamicLink.contains("detail")) {
  //         // Navigate to the detail page
  //         await Navigator.pushNamed(context, '/detail');
  //       }
  //     }
  //   }

  Future<void> myBackgroundMessageHandler(RemoteMessage message) async {
    print("Handling a background message: ${message.messageId}");
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => SettingsScreen(admin: loginbox!.get('Admin'))));
  }
}
