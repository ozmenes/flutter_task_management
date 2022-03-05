import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';

import 'utils/constants.dart';
import 'pages/homepage.dart';
import 'providers/theme_provider.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context)=>ThemeProvider(),
      builder: (context,_){
        final themeProvider = Provider.of<ThemeProvider>(context);
        return GetMaterialApp(
          title: 'Flutter Demo',
          themeMode: themeProvider.themeMode,
          theme: MyThemes.lightTheme,
          darkTheme: MyThemes.darkTheme,
          debugShowCheckedModeBanner: false,
          home: const HomePage(title: 'Flutter Demo Home Page'),
        );
      },
    );
  }
}
