
import 'dart:io';

import 'package:ChatApp/Screens/Auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'Screens/UserScreen.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: TextTheme().apply(
          fontFamily: "Roboto"
        )
        
      ),
      home: MyHomePage(),
    );
  }
}














class MyHomePage extends StatefulWidget {
 
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final auth=FirebaseAuth.instance;
  void submit(String email,String password,String username,bool isLogin,BuildContext ctx,File _image) async
  {
   UserCredential authresult;
    try{
      var dwnurl="";
           if(isLogin==false)
           {
             authresult=await auth.createUserWithEmailAndPassword(email: email, password:password);
             if(_image!=null)
              {var ref= FirebaseStorage.instance.ref().child("${FirebaseAuth.instance.currentUser.uid}/images").child("profile.jpg");
              await ref.putFile(_image);
              dwnurl = await ref.getDownloadURL();
              }



             FirebaseFirestore.instance.collection("user").doc(authresult.user.uid).set({
               "username":username,
               "email":email,
               "url": dwnurl
             });
      
           }
           else
           {
            authresult=await auth.signInWithEmailAndPassword(email: email, password: password);
           }
           if(authresult.user.uid!=null)
           Navigator.of(ctx).push(MaterialPageRoute(builder: (bctx)=>UserScreen(authresult.user.uid,username)));
    }on PlatformException catch(err){
     var message='An error occured';
      if(err.message!=null)
      message=err.message;
      print(message);
    }catch(err){
     print(err);
     Scaffold.of(ctx).showSnackBar(SnackBar(content: Text(err.toString()),backgroundColor: Colors.red,));
    }
  }



  @override
  Widget build(BuildContext context) {
                return Scaffold(
                  body:   Container(
                    decoration: BoxDecoration(
                     gradient: LinearGradient(
                       colors: [
                        Colors.pink[400],Colors.pink[300]
                       ],
                       begin: Alignment.topCenter,
                       end: Alignment.bottomCenter
                     )
        
                    ),
                     width: MediaQuery.of(context).size.width*1,
                     height: double.infinity,
                    
                    child: Center(child: AuthScreen(submit)))
      
        );
         }
       }
       


