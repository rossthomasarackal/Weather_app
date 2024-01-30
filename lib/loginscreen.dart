import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather/home.dart';
import 'package:shared_preferences/shared_preferences.dart';
class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final formKey= GlobalKey<FormState>();
  var eController = TextEditingController();
  var pController = TextEditingController();
  var eEmail='';
  var ePassword='';

  void saveCredentials() async {

    if(formKey.currentState!.validate()){
      formKey.currentState!.save();
      // Get.to(()=> const HomeScreen());

    }
    eEmail=eController.text;
    ePassword= pController.text;

    if(eEmail!='thoughtbox@google.com'&&
        ePassword!='Test@123456')
    {
      eController.clear();
      pController.clear();
    }

  }
  @override
  Widget build(BuildContext context) {
    eController.text='thoughtbox@google.com';
    pController.text='Test@123456';
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text('Login'),
      ),
      body: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Center(
            child: Form(
              key: formKey  ,
              child:Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 500,
                    child: TextFormField(
                      validator: (value) {
                        if(value.toString().trim().isEmpty){
                          return 'Email cant be null';
                        }
                        else if (!value.toString().contains('@')){
                          return 'Incorrect email format';
                        }
                        return null;
                      },
                      controller: eController,
                      maxLength: 45,
                      decoration: InputDecoration(
                        label: const Text('Email'),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)
                      ),),
                      onSaved: (value){
                        eEmail=value!;
                      },
                    ),
                  ),
                  SizedBox(
                    width: 500,
                    child: TextFormField(
                      validator: (value){
                        if(value!.length<6){
                          return 'password must contains at least 6 characters';
                        }
                        return null;
                      },
                      obscureText: true,
                      controller: pController,
                      maxLength: 45,
                      decoration: InputDecoration(
                          label: const Text('Password'),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)
                        ),
                      ),
                      onSaved: (value){
                        ePassword=value!;
                      },
                    ),
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.teal),
                      onPressed: ()async{
                         saveCredentials();
                         Navigator.of(context).pushReplacement(
                             MaterialPageRoute(builder: (context) => HomeScreen(),));
                         SharedPreferences pref = await SharedPreferences.getInstance();
                         await pref.setBool('onBoarding', false);
                      },
                      //_saveItem,
                      child:const Text('Login')),

                ],
              ),),
          )),
    );
  }
}
