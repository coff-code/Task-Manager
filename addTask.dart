import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/DataBase.dart';

class Addtask_page extends StatefulWidget {
  const Addtask_page({super.key});

  @override
  State<Addtask_page> createState() => _Addtask_pageState();
}

class _Addtask_pageState extends State<Addtask_page> {

  TextEditingController taskController=TextEditingController();
  TextEditingController descController=TextEditingController();
  TextEditingController timeController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return 
       Material(

        //stack

         child: Stack(
           children: [

            //imageContainer

             Container(
              padding: EdgeInsets.only(left: 20,top: 40,right: 15),
              height: double.infinity,
              width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage("assets/images/B1.jpg"),fit: BoxFit.cover)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(onPressed: () {
                        Navigator.pop(context);
                      }, icon: Icon(Icons.arrow_back_ios,color: Colors.white70,size: 30,)),
                    ],
                  ),
                  SizedBox(height:MediaQuery.of(context).size.height*0.07,),
                      Text("1% Better Everyday",style: GoogleFonts.aladin(fontSize: 35,color: Colors.white70),)
              
                ],
              ),),

            //Textcontainer

              Padding(
                padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: 600,
                      padding: EdgeInsets.symmetric(horizontal: 30,vertical: 50),
                      decoration: BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30)),
                      color: Colors.grey.shade600),
                      child: Column(
                        children: [

                          //Text
                         Expanded(
                          child: Text("Add Your Task",style:GoogleFonts.aboreto(fontSize: 30,fontWeight: FontWeight.bold))),

                          //Task 
                          
                        Expanded(
                          child: TextField(
                            controller: taskController,
                            cursorColor: Colors.white,
                            style: TextStyle(color: Colors.grey,fontSize: 20),
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(vertical: 25,horizontal: 20),
                                  fillColor: Colors.black,
                                  filled: true,
                                  hintText: "Task",
                                  hintStyle: TextStyle(color: Colors.grey,fontSize: 20),
                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(20),borderSide: BorderSide.none)
                                ),
                              ),
                        ),
                             
                             
                          //description
                             
                            Expanded(
                              child: TextField(
                                controller: descController,
                                                        cursorColor: Colors.white,
                                                        style: TextStyle(color: Colors.grey,fontSize: 20),
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(vertical: 25,horizontal: 20),
                                 fillColor: Colors.black,
                                  filled: true,
                                  hintText: "Description",
                                  hintStyle: TextStyle(color: Colors.grey,fontSize: 20),
                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(20),borderSide: BorderSide.none)
                                ),
                              ),
                            ),
                             
                          //Time
                          
                           Expanded(
                             child: TextField(
                              onTap: () async{
                               var time= await showTimePicker(context: context, initialTime: TimeOfDay.now(),
                               builder: (context, child) {
                                 return Theme(data: 
                                 ThemeData.from(colorScheme: ColorScheme.light(
                                  surface: Colors.grey,
                                  primary: Colors.black,
                                  secondary: Colors.black38
                                 ))
                                 , child: child!);
                               },
                               );
                               if(time!=null){
                                setState(() {
                                timeController.text=time.format(context);
                                  
                                });
                               }
                               
                              },
                              readOnly: true,
                                controller: timeController,
                                                       cursorColor: Colors.white,
                                                       style: TextStyle(color: Colors.grey,fontSize: 20),
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(vertical: 25,horizontal: 20),
                                 fillColor: Colors.black,
                                  filled: true,
                                  hintText: "Time",
                                  hintStyle: TextStyle(color: Colors.grey,fontSize: 20),
                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(20),borderSide: BorderSide.none)
                                ),
                              ),
                           ),
                         
                             
                          //Done button
                          
                          GestureDetector(
                            onTap: () {
                                                   
                            if(taskController.text.isNotEmpty&&descController.text.isNotEmpty&&timeController.text.isNotEmpty){
                          
                            
                              setState(() {
                                
                                  
                                 final taskValue=taskController.text;
                                final descValue=descController.text;
                                final timevalue=timeController.text;
                                context.read<DBBackend>().createData(taskValue, descValue, timevalue);
                              Navigator.pop(context);
                              taskController.text="";
                              descController.text="";
                              timeController.text="";
                            }
                            );}},
                            child: Container(
                              height: 60,
                              width: 150,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.black
                              ),
                              child: Center(child: Text("Done",style: TextStyle(color: Colors.grey,fontSize: 18),)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ),
              ]));
           
         
       
    
  }
}