import 'package:ecommerceappgetx/consts/consts.dart';
import 'package:ecommerceappgetx/controllers/bindings.dart';
import 'package:ecommerceappgetx/views/splash_screen/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: appname,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.transparent,
        appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(
            color: darkFontGrey
          ),
            backgroundColor: Colors.transparent,
          elevation: 0
        ),
        fontFamily: regular,

      ),

      home: const SplashScreen(),
      initialBinding : AllBindings()
      //home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
