import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:multikart_admin/pages/index/index.dart';

import 'common/language/index.dart';
import 'common/theme/theme_service.dart';
import 'config.dart';

import 'dart:html' as html;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // We're using the manual installation on non-web platforms since Google sign in plugin doesn't yet support Dart initialization.
  // See related issue: https://github.com/flutter/flutter/issues/96391
  GetStorage.init();
  Get.put(AppController());
  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: "Your Firebase Api Key",
        authDomain: "Your Firebase Auth Domain",
        projectId: "Your Firebase Project Id",
        storageBucket: "Your Firebase Storage Bucket",
        messagingSenderId: "Your Firebase Messaging Sender Id",
        appId: "Your Firebase App Id",
        measurementId: "Your Firebase Measurement Id"),
  );

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var scaffoldDrawerKey = GlobalKey<ScaffoldState>(debugLabel: "drawer");
  var scaffoldKey = GlobalKey<ScaffoldState>(debugLabel: "key2");


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    appCtrl.isLogin = html.window.localStorage[session.isLogin] ?? "false";
    SystemChrome.setApplicationSwitcherDescription(
        ApplicationSwitcherDescription(
      label: fonts.appName.tr,
      primaryColor: Theme.of(context).primaryColor.value,
    ));
    return GetMaterialApp(
      builder: (context, widget) {
        return Title(
          title: fonts.appName.tr,
          color: appCtrl.appTheme.blackColor,
          child: StreamBuilder<User?>(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
                return !snapshot.hasData
                    ? MediaQuery(
                        data: MediaQuery.of(context)
                            .copyWith(textScaleFactor: 1.0),
                        child: widget!,
                      )
                    : Login();
              }),
        );
      },
      debugShowCheckedModeBanner: false,
      translations: Language(),
      locale: const Locale('en', 'US'),
      fallbackLocale: const Locale('en', 'US'),
      // tran
      title: fonts.appName.tr,
      home: appCtrl.isLogin == "true"
          ? Title(
              title: fonts.appName.tr,
              color: appCtrl.appTheme.blackColor,
              child:  IndexLayout(scaffoldDrawerKey: scaffoldDrawerKey,scaffoldKey: scaffoldKey,))
          : Login(),
      getPages: appRoute.getPages,
      theme: AppTheme.fromType(ThemeType.light).themeData,
      darkTheme: AppTheme.fromType(ThemeType.dark).themeData,
      themeMode: ThemeService().theme,
      scrollBehavior: MyCustomScrollBehavior(),
    );
  }
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}
