import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:share_meal/constants/buttons.dart';
import 'package:share_meal/constants/constans.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_localizations/src/material_localizations.dart';
import 'package:flutter_localizations/src/widgets_localizations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:share_meal/constants/textfield.dart';
import 'package:share_meal/theme/theme_provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ChangeNotifierProvider(
      create: (context) => ThemeProvider(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    ColorScheme myScheme =
        ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 49, 71, 56));

    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        child: MaterialApp(
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          supportedLocales: [
            Locale('ar'),
            Locale('en'),
          ],
          locale: Locale('ar'),
          debugShowCheckedModeBanner: false,
          title: 'share meal',
          theme: Provider.of<ThemeProvider>(context).themeData,
          routes: myRoutes,
          // home: testss(),
        ));
  }
}

class testss extends StatefulWidget {
  const testss({super.key});

  @override
  State<testss> createState() => _testssState();
}

class _testssState extends State<testss> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Button(
        ch: Text("data"),
      ),
    );
  }
}
