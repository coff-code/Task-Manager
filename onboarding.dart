import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:task_manager/home.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  final pageController=PageController();
  bool islast=false;
  bool isanimated=false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    onAnimated();
  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      //satck

      body: Stack(
        children: [

          //pageview

          PageView(
            physics: NeverScrollableScrollPhysics(),
            controller: pageController,
            onPageChanged: (value) {
              islast=value==2;
              setState(() {
                
              });
            },
            children: [

              //1.container

              Container(
                decoration:BoxDecoration(
                  color: Colors.black,

                  //image

                  image: DecorationImage(image:AssetImage("assets/images/o2.jpg"),fit: BoxFit.cover, ),
                ) ,

                //animatedcontainer

                child: AnimatedContainer(
                  padding: EdgeInsets.symmetric(vertical: isanimated?200:0),
                  duration: Duration(milliseconds: 1800),
                  child: Column(
                    children: [

                      //1.text

                      Text("Welcome to Tasker",style: GoogleFonts.aboreto(
                        fontSize: 27,
                        fontWeight: FontWeight.bold,
                        color:
                        isanimated?
                         Colors.white:Colors.transparent
                      ),),
                      SizedBox(height: 15,),

                      //2.text

                      Text("Easily Manage Your\nDaily Tasks",style: GoogleFonts.aBeeZee(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color:  isanimated?
                         Colors.white:Colors.transparent
                      ),)
                  
                    ],
                  ),
                ),
              ),

              //2.contaner

              
              Container(
                decoration:BoxDecoration(
                  color: Colors.black,

                  //image

                image: DecorationImage(image:AssetImage("assets/images/o1.jpg"),fit: BoxFit.cover, ),
                ) ,
                child: Align(
                  alignment: Alignment(-0.40, -0.50),
                  child: Text("Small\nSteps\nEvery\nDay",style: GoogleFonts.aBeeZee(
                    fontSize: 45,
                    fontWeight: FontWeight.bold,
                    color: Colors.brown.shade200
                  ),),
                ),
              ),

              //3.container

              
              Container(
                decoration:BoxDecoration(
                  color: Colors.black,

                  //image

                  image: DecorationImage(image:AssetImage("assets/images/o3.jpg"),fit: BoxFit.cover, ),
                 ) ,
                child: Align(
                  alignment: Alignment(-0.40, -0.50),
                  child: Text("Think.\nPlan.\nExecute.",style: GoogleFonts.aBeeZee(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                  ),),
                ),
              )
            ],
          ),

          //align

          AnimatedPositioned(
            duration: Duration(milliseconds: 1500),
           bottom: isanimated? 70:-70,

            //row

            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
              
                  //smoothpageindicator
              
                  SmoothPageIndicator(
                    onDotClicked: (index) {
                      pageController.animateToPage(index, duration: Duration(milliseconds: 500), curve: Curves.linear);
                    },
                    controller:pageController , count: 3,effect: ColorTransitionEffect(
                    activeDotColor: Colors.white,
                    dotHeight: 5,
                    dotWidth: 30
                  ),),
                 
              
                  //Nextbutton
              
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(
                         islast?
                    Colors.white70:
                        Colors.blueGrey.shade800),
                      shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                      fixedSize: WidgetStatePropertyAll(Size(150, 50))
                    ),
                    onPressed: ()async {
                      if(islast==true){
                        final sharedpref= await SharedPreferences.getInstance();
                        sharedpref.setBool("HomePage", true);
                        Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.rightToLeft,child: home_page()));
                      }else{
                    pageController.nextPage(duration: Duration(milliseconds: 500), curve:Easing.legacy);
              
                      }
                  }, child: Text(
                    islast?
                    "Get Started":
                    "Next",style: TextStyle(color: 
                     islast?
                    Colors.black:
                    Colors.white,fontSize: 19),))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  //future Function
  
  Future onAnimated()async{
    await Future.delayed(Duration(milliseconds: 1000));
    setState(() {
      isanimated=true;
    });
  }


}