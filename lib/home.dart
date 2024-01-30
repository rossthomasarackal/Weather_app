import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather/formScreen.dart';
import 'package:weather/mycontroller.dart';
import 'package:weather/weatherhome.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  MyController myController= Get.put(MyController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
         title: const Text('Users List'),
        actions: [
          IconButton(
              onPressed: (){
              Get.to(()=>FormScreen());
              },
              icon: const Icon(Icons.add)
          )
        ],
      ),
      body:

      Padding(padding: const EdgeInsets.all(10),
        child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Home page',
                  style: TextStyle(fontSize: 20,
                  fontWeight: FontWeight.bold) ,
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount:myController.list.length ,
                      itemBuilder: (ctx, index){
                      return Card(
                        color:const Color.fromARGB(150, 67, 201, 172),
                        child: GestureDetector(
                          child: ListTile(
                            trailing: Switch(
                                        value: myController.list[index][2],
                                        activeColor: Colors.white,
                                        onChanged: (value){
                                          setState(() {
                                            myController.list[index][2] =value;
                                          });
                                        }
                                    ),

                            title: Text(myController.list[index][0]),
                            subtitle: Text(myController.list[index][1]),
                          ),
                          onTap: (){
                            Get.to(()=>const WeatherHome());
                          },
                        ),
                      );
                      },

                  ),
                )
              ],
            ),
        ),
      ),
    );
  }
}
