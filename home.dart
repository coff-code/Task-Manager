import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/DataBase.dart';
import 'package:task_manager/addTask.dart';

class home_page extends StatefulWidget {
  const home_page({super.key});

  @override
  State<home_page> createState() => _home_pageState();
}

class _home_pageState extends State<home_page> {
  DBBackend? DBRef=DBBackend.DBEXtr;
 
  @override
  Widget build(BuildContext context) {
    return Container(

  //background images

    decoration: BoxDecoration(
    color: Colors.black,
    image: DecorationImage(image: AssetImage("assets/images/B1.jpg"),fit: BoxFit.cover)),
   
    //column
    
    child: Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        children: [
      
       //1.topcontainer
      
          Expanded(child: Container(

            //column

            child: Column(
              children: [
               Container(
                padding: EdgeInsets.only(left:  20,top: 60),

                //row

                 child: Row(children: [

                  //profilePic
                  
                  CircleAvatar(
                    backgroundColor: Colors.black,
                    radius: 25,
                    backgroundImage: AssetImage("assets/images/B2.jpg"),
                  ),
                  SizedBox(width: 20,),

                  //column

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    //Texts

                    children: [
                    Text("Welcome Safwan !!",style: TextStyle(color: Colors.grey,fontSize: 17),),
                    Text("Explore Tasks",style:GoogleFonts.aclonica(color: const Color.fromARGB(211, 255, 255, 255),fontSize: 20),)
                  ],)
                 ],),
               ),

               //Today Text
               
               Container(
                padding: EdgeInsets.only(left: 13,top: 15,bottom: 5),
                width: double.infinity,
                child: Text("Today",style:  GoogleFonts.aboreto(color: Colors.grey,fontWeight: FontWeight.w600,fontSize: 18),)),
              
              //Datepicker

              Container(
                padding: EdgeInsets.only(left: 10),
                height: 100,
                child: DatePicker(DateTime.now(),
                height: 100,
                width: 60,
                selectionColor: Colors.white38,
                initialSelectedDate:DateTime.now(),
                dayTextStyle: GoogleFonts.aboreto(color: Colors.grey,fontWeight: FontWeight.w600),
                 dateTextStyle:  GoogleFonts.aboreto(color: Colors.grey,fontWeight: FontWeight.w600),
                  monthTextStyle: GoogleFonts.aboreto(color: Colors.grey,fontWeight: FontWeight.w600),
                  selectedTextColor: Colors.black,
                  activeDates: [DateTime.now()],
                  deactivatedColor: Colors.grey,
                 
                   
                ),
              )
            ],),
            
          )),
      
       //2.bottomcontainer
      
          Expanded(
            flex: 2,
            child: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30)),
            color: Colors.white38),
      
            //ListViewscroll
      
            child:
               ListView(
               physics: NeverScrollableScrollPhysics(),
                padding: EdgeInsets.only(top: 25),
                children: [
                    
              //rowsizedbox
                    
                  SizedBox(
                    height: 65,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [

                     //Texts

                    Column(
                      children: [
                        Text("Your Tasks",style:  GoogleFonts.aBeeZee(fontSize: 30,fontWeight: FontWeight.bold),),
                      
                      ],
                    ),

                     //AddButton

                     ElevatedButton(
                        style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.black),
                        shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                        fixedSize: WidgetStatePropertyAll(Size.fromHeight(50))),
                        onPressed: () {
                        Navigator.push(context, PageTransition(type: PageTransitionType.rightToLeft,child: Addtask_page()));
                      }, child: Text("Add task",style: TextStyle(color: Colors.white70,fontSize: 16),))
                    ],),
                  ),    
                SizedBox(
                  height: 500,

                  //Consumer

                  child:Consumer<DBBackend>(builder: (context, provider, child) =>

                  //FutureBuilder

                   FutureBuilder(future: DBRef?.ReadData(), builder: (context, snapshot) => 
                   
                   //if empty & ListViewBuilder 
 
                   snapshot.data?.length==0?
                   Container(
                     child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                      Image.asset("assets/images/png1.png",scale: 2,),
                      SizedBox(height: 20,),
                      Text("No Tasks Yet",style: GoogleFonts.aBeeZee(
                        fontSize: 30,
                        color: Colors.black
                      ),)
                     ],),
                   ):
                   
                    ListView.builder(
                    //  padding: EdgeInsets.all(0),
                     itemCount: snapshot.data?.length??0,
                      shrinkWrap: true,
                     itemBuilder: (context, index) => 
                       Theme(
                        data: ThemeData(outlinedButtonTheme: OutlinedButtonThemeData(style: ButtonStyle(iconSize: WidgetStatePropertyAll(25)))),
                       
                       //card
                       
                        child: Card(
                            margin: EdgeInsets.symmetric(horizontal: 25,vertical: 7),
                            color: Colors.black,
                          
                           //slidable
                          
                            child: Slidable(
                                endActionPane: ActionPane(
                                  extentRatio: 0.2,
                                  motion: BehindMotion(), children: [
                              SlidableAction(onPressed: (context) {

                                //Delete & SnackBar

                                setState(() {
                                DBRef!.DeleteData(snapshot.data![index].sno);
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  behavior: SnackBarBehavior.floating,
                                  backgroundColor: Colors.white60,
                                  duration: Duration(seconds: 1),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                  content: Text("Your Task has been Removed...",style: TextStyle(color: Colors.black,fontSize: 18),)));
                                  
                                });
                              },
                              icon: Icons.delete,
                              backgroundColor: Colors.red,
                              borderRadius: BorderRadius.circular(10),
                              )
                            ]),
                             
                             //listtile
                             
                              child: ListTile(
                               contentPadding: EdgeInsets.all(9),
                                minLeadingWidth: 0,
                                horizontalTitleGap: 0,
                             
                               //checkbox
                                
                                leading: Checkbox(
                                  activeColor: Colors.grey.shade800,
                                  checkColor: Colors.black,
                                  value: snapshot.data![index].checkValue==1, onChanged: (value) {
                                  setState(() {
                                    DBRef!.UpdateData(value==true?1:0,snapshot.data![index].sno);
                                 
                                  });
                                  
                                },),
                                title: Row(
                                  children: [
                                    
                                    //title
                                    
                                    Expanded(
                                      child: Text(snapshot.data![index].title,style: TextStyle(color:snapshot.data![index].checkValue==1?Colors.grey.shade800 :Colors.white,fontSize: 20,decoration:snapshot.data![index].checkValue==1? TextDecoration.none:TextDecoration.none,decorationThickness: 2,decorationColor: Colors.grey.shade700),)),
                                  
                                   //time
                                    
                                     Text(snapshot.data![index].time,style: TextStyle(color:snapshot.data![index].checkValue==1?Colors.grey.shade800: Colors.grey,fontSize: 16,decoration:snapshot.data![index].checkValue==1? TextDecoration.none:TextDecoration.none,decorationThickness: 2,decorationColor: Colors.grey.shade700),),
                                  ],
                                ),
                                subtitle: Text(snapshot.data![index].Desc,style: TextStyle(color:snapshot.data![index].checkValue==1?Colors.grey.shade800: Colors.grey,fontSize: 18 ,decoration:snapshot.data![index].checkValue==1? TextDecoration.none:TextDecoration.none,decorationThickness: 2,decorationColor: Colors.grey.shade700),),
                              ),
                            ),
                          ),
                        ),
                      )
                   ))
                 )
                ],
              ),
            ),
          )])
      ),
    );
  }
}