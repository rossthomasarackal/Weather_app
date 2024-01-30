
import 'package:flutter/material.dart';
import 'package:weather/home.dart';
import 'package:weather/loginscreen.dart';
import 'package:weather/onboardingscreens.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather/weatherhome.dart';
var render= true;
void main() async {

  SharedPreferences.setMockInitialValues({});
  SharedPreferences pref = await SharedPreferences.getInstance();
  render= await pref.getBool('onBoarding')?? true;
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
   MyApp({super.key});

  @override
  Widget build(BuildContext context)  {
    return  const GetMaterialApp(

      debugShowCheckedModeBanner: false,
      home:
      //render ? const OnBoardingScreens() :
      //HomeScreen(),
      //WeatherHome(),
      OnBoardingScreens()
    );
  }
}



          
          
          

