import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather/home.dart';
import 'package:weather/loginscreen.dart';

class OnBoardingScreens extends StatefulWidget {
  const OnBoardingScreens({super.key});

  @override
  State<OnBoardingScreens> createState() => _OnBoardingScreensState();
}

class _OnBoardingScreensState extends State<OnBoardingScreens> {
  late PageController _pageController;
  int _pageIndex=0;
  @override
  void initState(){
    _pageController= PageController(initialPage: 0);
    super.initState();
  }
  @override
  void dispose(){
    _pageController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child:
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Expanded(
                      child: PageView.builder(
                        itemCount: demoList.length,
                        controller: _pageController,
                          onPageChanged: (index){
                          setState(() {
                            _pageIndex=index;
                          });
                          },
                          itemBuilder: (ctx, index)=>
                              OnBoardContent(
                                image: demoList[index].image,
                                title: demoList[index].title,
                                description: demoList[index].description,
                              ),
                      ),

                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconButton(
                          onPressed: (){
                            _pageController.previousPage(
                                duration:const  Duration(milliseconds: 300),
                                curve: Curves.ease);
                          },
                          icon: const Icon(Icons.arrow_circle_left,size: 45,
                            color: Colors.deepPurpleAccent ,
                          ),
                          style: IconButton.styleFrom(
                            shape: const CircleBorder(),
                          ),
                        ),
                        SizedBox(
                          height: 50,
                          child: Row(
                            children: List.generate( demoList.length,
                              (index) => Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: DotIndicator(
                              isActive: index== _pageIndex,
                            ),
                          ))
                            ,
                          ),
                        ),

                        IconButton(
                          onPressed: (){
                            _pageController.nextPage(
                                duration:const  Duration(milliseconds: 300),
                                curve: Curves.ease);
                            if(_pageIndex==1){
                              Navigator.of(context).pushReplacement(MaterialPageRoute(
                                builder: (context) =>LoginScreen()));
                            }
                          },
                          icon: const Icon(Icons.arrow_circle_right,size: 45,
                            color: Colors.deepPurpleAccent ,
                          ),
                          style: IconButton.styleFrom(
                            shape: const CircleBorder(),
                          ),
                        ),




                      ],
                    ),
                  const SizedBox(height: 30),
                  ],
                ),
              ),

        ),
      ),
    );
  }
}

class DotIndicator extends StatelessWidget {
  const DotIndicator({
    super.key,
    this.isActive=false
  });
 final bool isActive;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: isActive? 12: 4 ,
      width: 4,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(3),
        color:isActive?  Colors.indigoAccent : Colors.blueAccent,
      ),
    );
  }
}


class OnBoard{
  final String image, title, description;
  OnBoard({
    required this.image, required this.title, required this.description
});
}
final List<OnBoard> demoList= [
  OnBoard(
      image: 'assets/images/earth.png',
      title: 'Welcome to weather App',
      description: 'A window to safest journey'),
  OnBoard(
      image: 'assets/images/all.png',
      title: 'User Friendly interface',
      description: 'Here you will see Real time weather report'),

];

class OnBoardContent extends StatelessWidget {
  OnBoardContent({
    super.key,
    required this.image,
    required this.title,
    required this.description
  });
  String image, title, description;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
          const Spacer(),
          Image.asset(
            image,
            height: 400,),
          const Spacer(),
          Text(
           title,
           style: const TextStyle(
             fontSize: 30, fontWeight: FontWeight.bold,
               color: Colors.black, fontStyle: FontStyle.italic,
           ) ,),
        const SizedBox(height: 10),
        Text(
          description,
          style:const TextStyle(
            fontSize: 15, fontStyle: FontStyle.italic,
            fontWeight: FontWeight.w500,
            color: Colors.black45,
          ),
        ),
        const SizedBox(height: 10,),
       //const Spacer(),
      ],
    );
  }
}