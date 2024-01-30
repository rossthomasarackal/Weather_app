import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather/loginscreen.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:weather/constants.dart' as k;
import 'dart:convert';
import 'package:lottie/lottie.dart';

class WeatherHome extends StatefulWidget {
  const WeatherHome({super.key});

  @override
  State<WeatherHome> createState() => _WeatherHomeState();
}


class _WeatherHomeState extends State<WeatherHome> {
  bool isLoaded= false;
  var temp;
  num pressure=0;
  num humidity=0;
  num  cloudcoverage=0;
  var city;
  var description='';
  num wind=0;

  TextEditingController textController= TextEditingController();
  final formKey= GlobalKey<FormState>();

  @override
  void initState() {
    getCurrentLocation();
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          Lottie.network(
            'https://lottie.host/6f3dfd0c-86fa-4a0f-abdb-a3e00ea212b9/v99omDwmsT.json',
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: const Text('Weather',
                style: TextStyle(color: Color.fromARGB(255, 134, 134, 134)),
              ),
              actions: [
                IconButton(
                    onPressed: () async {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder:
                              (context) => LoginScreen(),));
                      SharedPreferences pref = await SharedPreferences.getInstance();
                      await pref.setBool('onBoarding', true);
                    },
                    icon: const Icon(Icons.logout, color: Color.fromARGB(255, 134, 134, 134),))
              ],
            ),

            body: Form(
              key: formKey,
              child: Visibility(
                visible: isLoaded,
                replacement: const  Center(child: CircularProgressIndicator()) ,
                child:  Padding(
                  padding: const EdgeInsets.all(10),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,

                      children: [
                        // const Text('Weather Home',
                        //   style: TextStyle(fontSize: 20,
                        //       fontWeight: FontWeight.bold) ,
                        // ),
                        Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.all(10),
                          width: MediaQuery.of(context).size.width*0.99,
                          height: MediaQuery.of(context).size.height*0.09,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.teal.withOpacity(0.1),
                          ),
                          child: TextFormField(
                            onFieldSubmitted: (String s){
                              setState(() {
                                city=s;
                                getCityWeather(s);
                                isLoaded=false;
                              });
                            },
                            onSaved: (value){
                              setState(() {
                                city=value;
                                //getCityWeather(value!);
                                //isLoaded=false;
                              });
                            },
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                                color: Colors.black
                            ),
                            controller: textController,
                            cursorColor: Colors.black,
                            decoration: const InputDecoration(
                                hintText: 'Search City',
                                prefixIcon: Icon(Icons.search,
                                  size: 25,
                                  color: Colors.black,
                                ),
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none
                            ),
                          ),
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Lottie.network('https://lottie.host/1352eb2b-893b-4053-8d54-dd97965a5b36/mns7kGVdz7.json',
                                  width: 80, height: 80,
                                ),

                                Text('${city}',
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color:  Color.fromARGB(255, 134, 134, 134),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Text( DateTime.now().toString().substring(10, 16),
                                style: const TextStyle(
                                  fontSize: 50,
                                  fontWeight: FontWeight.bold,
                                  color:  Color.fromARGB(255, 134, 134, 134),
                                ),),
                            ),
                          ],
                        ),

                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Text('${temp.toString().substring(0,2)} ℃',
                                  style: const TextStyle(
                                    fontSize: 60 ,
                                    fontWeight: FontWeight.bold,
                                    color:  Color.fromARGB(255, 134, 134, 134),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(20),
                              child: Text(description ,
                                style: const TextStyle(
                                  fontSize: 20 ,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 122, 122, 122),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 50),


                        Container(
                          height: MediaQuery.of(context).size.height*.30,
                          width: MediaQuery.of(context).size.width*.80,
                          margin: const EdgeInsets.all(15),
                          padding: const EdgeInsets.all(25),
                          decoration: BoxDecoration(
                            color: Colors.black12,
                            borderRadius: BorderRadius.circular(10)
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                                Column(
                                  children: [
                                    Lottie.network(
                                        'https://lottie.host/b29060bc-f67e-426e-99a0-97747bfef526/TgDfRCXNSb.json',
                                      height: 80, width: 80
                                    ),
                                    Text(wind.toString(),
                                      style: const TextStyle(
                                        fontSize:25 ,
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromARGB(255, 122, 122, 122),
                                      ),
                                    )
                                  ],
                                ),

                              Column(
                                children: [
                                  Lottie.network
                                    ('https://lottie.host/4f9149bc-7915-4386-a492-9a3e73456880/oJmOkB5nQ1.json',
                                    height: 80,
                                    width: 80,
                                  ),
                                  Text(humidity.toString(),
                                    style: const TextStyle(
                                      fontSize:30 ,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 122, 122, 122),
                                    ),
                                  ),
                                ],
                              ),

                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Column(
                                  children: [
                                    const Icon(Icons.thermostat, size: 60, color: Colors.blueAccent),
                                   const SizedBox(height: 5),
                                   Text(pressure.toString(),
                                     style: const TextStyle(
                                       fontSize:30 ,
                                       fontWeight: FontWeight.bold,
                                       color: Color.fromARGB(255, 122, 122, 122),
                                     ),
                                   )
                                  ],
                                ),
                              )
                            ],
                          )
                        ),

                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }



  getCurrentLocation() async {
   var p= await Geolocator.getCurrentPosition(
     desiredAccuracy: LocationAccuracy.low,
     forceAndroidLocationManager: true,
   );

   if(p!=null){
  print('Latitude is ${p.latitude}, Longitude is ${p.longitude}');
   getCurrentLocationWeather(p);
   }
   else{
     print('data unavailable');
   }
  }


  getCityWeather(String cityName) async {
    var client= http.Client();
    var uri= '${k.cityDomain}key=${k.apikey}&q=$cityName&aqi=${k.aqi}';
    var url= Uri.parse(uri);
    var response= await client.get(url);

    if(response.statusCode==200){
      var data= response.body;
      print(data);
      var decodedData= json.decode(data);
      print(decodedData['current']['temp_f']);
      updateUi(decodedData);
      setState(() {
        isLoaded=true;
      });
    }
    else{
      print(response.statusCode);
    }
  }



  getCurrentLocationWeather(Position position) async {
   var client= http.Client();
   var uri= '${k.domain}lat=${position.latitude}&lon=${position.longitude}&appid=${k.apiKey}';
   var url= Uri.parse(uri);
   var response= await client.get(url);

   if(response.statusCode==200){
     var data= response.body;
     print(data);
     var decodedData= json.decode(data);
     updateui(decodedData);
     setState(() {
       isLoaded=true;
     });
   }
   else{
     print(response.statusCode);
   }
  }


  updateui(var decodeddata){
    setState(() {
      if(decodeddata==null){
        temp=0;
        pressure=0;
        humidity=0;
        cloudcoverage=0;
        city='Not Available';
        description='Not Available';
        wind=0;
      }
      else{
        temp= decodeddata['main']['temp']-273;
        pressure=decodeddata['main']['pressure'];
        humidity=decodeddata['main']['humidity'];
        cloudcoverage=decodeddata['clouds']['all'];
        city=decodeddata['name'];
        description= decodeddata['weather'][0]['main'];
        wind=decodeddata['wind']['speed'];
        print(temp);
        // print(wind);
        // print(pressure);
        // print(humidity);
        // print(cloudcoverage);
      }
    });

  }

  updateUi(decodeddata){
    setState(() {
      if(decodeddata==null){
        temp=0;
        pressure=0;
        humidity=0;
        cloudcoverage=0;
        city='Not Available';
        description='Not Available';
        wind=0;
      }
      else{
        temp= decodeddata['current']['temp_c'];
      pressure=decodeddata['current']['pressure_in'];
      humidity=decodeddata['current']['humidity'];
      cloudcoverage=decodeddata['current']['cloud'];
      city=decodeddata['location']['name'];
      description= decodeddata['current']['condition']['text'];
      wind=decodeddata['current']['wind_mph'];
      print(temp);
      }
    });
  }
}
