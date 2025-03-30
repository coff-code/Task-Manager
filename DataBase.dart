import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBBackend extends ChangeNotifier{

  DBBackend._();
  static DBBackend DBEXtr=DBBackend._();
  static String TableName="My_table";
  static String TableSNO="My_SNO";
  static String TableTitle="My_Title";
  static String TableDesc="My_Desc";
  static String TableTime="My_Time";
  static String TableCheckbox="My_CheckBox";


  Database?database;

 //condition

 Future<Database>FileCondition()async{
  if(database!=null){
    return database!;
  }else{
    database= await CreateFile();
    return database!;
  }
 }


  
  //createfile

  Future<Database>CreateFile()async{
    Directory directory =await  getApplicationDocumentsDirectory();
    String directoryPath=join(directory.path,"MyFile.db");

   return  openDatabase(directoryPath,version: 1,onCreate: (db, version) {
      db.execute(
      '''
    create table $TableName(
    $TableSNO integer primary key autoincrement,
    $TableTitle text,
    $TableDesc text,
    $TableTime text,
    $TableCheckbox integer
    ) 
      '''
     );
    },);
  }

  //add queries

    //Create
    void createData(String Tabletitle,String Tabledesc,String Tabletime,)async{
      Database CD= await FileCondition();
      CD.insert(TableName, {
        TableTitle:Tabletitle,
        TableDesc:Tabledesc,
        TableTime:Tabletime,
        TableCheckbox:0
      });
        notifyListeners();

    }

    //Read
    Future<List<details>> ReadData()async{
      Database RD= await FileCondition();
      final data=await RD.query(TableName);
      List<details>Rvalues=data.map((e)=>details(e[TableTitle]as String,e[TableDesc]as String, e[TableTime]as String, e[TableCheckbox]as int,e[TableSNO]as int)).toList();
     return Rvalues;
    }

    //Update
    void UpdateData(int checkvalue,int sno)async{
      Database UD= await FileCondition();
      UD.update(TableName, {
        TableCheckbox:checkvalue
      },
      where: "$TableSNO=?",
      whereArgs: [sno]

      
      );
    }

    //Delete
    void DeleteData(int sno)async{
      Database DD= await FileCondition();
      DD.delete(TableName,
      where: "$TableSNO=?",
      whereArgs: [sno]);
      
    }
}
class details{
  String title;
  String Desc;
  String time;
  int checkValue;
  int sno;
  details(this.title,this.Desc,this.time,this.checkValue,this.sno);
}