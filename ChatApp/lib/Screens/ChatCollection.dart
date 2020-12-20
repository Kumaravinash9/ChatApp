


import 'package:ChatApp/Screens/ChatBox.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatCollection extends StatelessWidget {
  String uid;
  final String username;
  ChatCollection(this.uid,this.username);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body:StreamBuilder(stream: FirebaseFirestore.instance.collection("user").snapshots(),builder: (context,AsyncSnapshot<dynamic>snapshot){
        
       if(snapshot.hasData) 
       {
         return ListView.builder(itemCount:snapshot.data.documents.length,itemBuilder: (_,index){
         if(snapshot.data.documents[index].id!=uid)
         return  Column(
           children: [
             Card(
                            child: ListTile(
                 contentPadding: const EdgeInsets.only(top:8,left: 5,right:5,bottom: 8),
                         leading: snapshot.data.documents[index]['url'].length==0?CircleAvatar(child: Text(snapshot.data.documents[index]["username"].toString().substring(0,1)),radius: 25,):CircleAvatar(child: SizedBox(),backgroundImage:NetworkImage(snapshot.data.documents[index]["url"]),radius: 25,),
                         title: Text(snapshot.data.documents[index]["username"],style: TextStyle(fontWeight: FontWeight.w500,fontSize: 15,color: Colors.black,fontFamily: "Roboto"),),
                         onTap: () async{
                           DocumentReference docRef= FirebaseFirestore.instance.collection('user').doc(FirebaseAuth.instance.currentUser.uid).collection("friends").doc(snapshot.data.documents[index].id);
                           DocumentSnapshot ref= await docRef.get();
                          if(ref.data()==null)
                    {
                docRef.set({
     'chats':List<dynamic>(),});}
      DocumentReference docRefi= FirebaseFirestore.instance.collection('user').doc(snapshot.data.documents[index].id).collection("friends").doc(FirebaseAuth.instance.currentUser.uid);
      DocumentSnapshot refi= await docRefi.get();
       if(refi.data()==null)
      {
            await docRefi.set({
            'chats':List<dynamic>(),
      });
      }
            Navigator.of(context).push(new MaterialPageRoute(builder: (_)=>
          
            ChatBox(snapshot.data.documents[index].id,snapshot.data.documents[index]["username"],snapshot.data.documents[index]['url'])));},),
             ), 
           ],
         );});}
                      return CircularProgressIndicator();
              
                          }), 
      
    );
  }
}