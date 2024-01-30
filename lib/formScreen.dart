import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather/home.dart';
import 'package:weather/mycontroller.dart';

class FormScreen extends StatelessWidget {
  FormScreen({super.key});
  final formKey= GlobalKey<FormState>();
  MyController myController= Get.find();
  final fController= TextEditingController();
  final lController= TextEditingController();
  final eController= TextEditingController();
  bool toggle = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text('Form'),
        // actions: [
        //   IconButton(
        //       onPressed: (){
        //
        //       },
        //       icon: const Icon(Icons.add)
        //   )
        // ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Center(

          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: TextFormField(
                      controller: fController,
                    maxLength: 45,
                    decoration:
                    InputDecoration(
                        label: const Text('First Name'),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)
                      )
                      )
                    ),
                ),

                Container(
                  child: TextFormField(
                    controller: lController,
                    maxLength: 45,
                    decoration: InputDecoration(
                      label:const Text('Last Name'),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)
                        )
                    ),
                  ),
                ),
                Container(
                  child: TextFormField(
                    controller: eController,
                    maxLength: 45,
                    decoration: InputDecoration(
                      label: const Text('Email'),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)
                        )
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                      ),
                        onPressed: (){
                          myController.fetch([fController.text, eController.text, true ]);
                          Get.to(()=>HomeScreen());
                        },
                        child: const Text('Submit')
                    ),
                  ],
                ),
              ],

            ),
          ),
        ),
      ),
    );
  }
}
