import 'package:ChatApp/main.dart';
import 'package:flutter/material.dart';

class Admin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Center(
        child:Container(
          height: 220,
        child: Column(
       mainAxisAlignment: MainAxisAlignment.spaceAround,
       crossAxisAlignment: CrossAxisAlignment.center,
       mainAxisSize: MainAxisSize.min,
       children: [
        SizedBox( width: MediaQuery.of(context).size.width*.5,height:60,     child: RaisedButton.icon(onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (_)=>MyHomePage(kind:"Admin")));
        }, icon: Icon(Icons.supervised_user_circle_rounded,size: 22,color: Colors.white,), label: Text("Sign in as a Admin"),color: Colors.red,)),
        SizedBox( width: MediaQuery.of(context).size.width*.5,height:60,    child: RaisedButton.icon(onPressed: (){Navigator.of(context).push(MaterialPageRoute(builder: (_)=>MyHomePage(kind:"User")));}, icon: Icon(Icons.supervised_user_circle_sharp,size: 22,color:Colors.white), label: Text("Sign in as a User"),color: Colors.blue[400],)),
        

       ],
        )
        )
      )
      
    );
  }
}