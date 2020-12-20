

import 'package:ChatApp/Screens/ChatCollection.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserScreen extends StatefulWidget {
  final String uid;
  final String username;
  UserScreen(this.uid,this.username);


  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   
  }
  @override
  Widget build(BuildContext context) {
    return
       Scaffold(
      appBar: AppBar(title: Text("ChatApp"),
      automaticallyImplyLeading: false,
      
      actions: [
     DropdownButtonHideUnderline(
            child: DropdownButton(
         elevation: 8,
         icon:  Icon(Icons.more_vert),

              underline: null, 
                items: [
                   DropdownMenuItem(
                      child: Text("Logout"),
                      value: "logout",
                    ),
                ],
                onChanged: (value)async {
                  if(value=="logout")
                  await FirebaseAuth.instance.signOut().then((value) => Navigator.pop(context));
                }),),
                SizedBox(width:5)

      ],
      ),
    
      body: ChatCollection(widget.uid,widget.username),
             
          
    );                
}
}








