import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager/DataBase.dart';
import 'package:task_manager/home.dart';
import 'package:task_manager/onboarding.dart';

Future main()async{
  WidgetsFlutterBinding.ensureInitialized();
  final pref= await SharedPreferences.getInstance();
  final page= pref.getBool("HomePage")??false;
  runApp(MyApp(value: page,));
}
class MyApp extends StatelessWidget {
  final bool value;
  const MyApp({super.key,required this.value});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => DBBackend.DBEXtr,)
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home:value?home_page(): Onboarding(),
      ),
    );
  }
}
