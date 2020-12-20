

import 'dart:io';
import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AuthScreen extends StatefulWidget {
 
 final void Function(String email ,String  password, String username, bool isLogin,BuildContext context,File _image)submit;
  AuthScreen(this.submit );
  @override
  _AuthScreenState createState() => _AuthScreenState();
}
class _AuthScreenState extends State<AuthScreen> {
  bool islogin;
  TextEditingController _username;
  TextEditingController _email;
  TextEditingController _password;
  String email;
  String password;
  String username;
  bool istrue;
  File _image;

  
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    islogin=false;
   email='';
   username='';
   password='';
   istrue=false;
   _image=null;
  }
  final _formkey=GlobalKey<FormState>();
  
  @override
  Widget build(BuildContext context) {
    void _trysubmit()  {
    final isvalid=_formkey.currentState.validate();
    if(isvalid){
      
      setState(() {
       _formkey.currentState.save();
       istrue=!istrue;
      widget.submit(email.trim(),password.trim(),username.trim(),islogin,context,_image);
      
      });
    }
  }
    return 
       Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
            elevation: 12,
           
            color: Colors.transparent,
            shadowColor: Colors.transparent,
            child:   Container(
              alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width*.8,
                  height:!islogin? 510:325,
                  
                  
                  color: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal:18,vertical:26),
                  child: SingleChildScrollView(
                                      child: Form(key: _formkey,
                    
                      
                      child:Column(
                        children:<Widget> [
                      if(!islogin)  Center(child: CircleAvatar(child: _image!=null?SizedBox():Icon(Icons.add_a_photo),radius: 35,backgroundImage:_image!=null? FileImage(_image):NetworkImage("https://images.unsplash.com/photo-1599110364654-5572a272237f?ixid=MXwxMjA3fDB8MHxzZWFyY2h8MzR8fHVzZXJ8ZW58MHx8MHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=600&q=60"),)),
                      if(!islogin)  SizedBox(
                      height: MediaQuery.of(context).size.height*.004,
                      ),
                         if(!islogin) Center(
                         child: FlatButton(child: Text("Add your Picture",style: TextStyle(color: Colors.red),),
                         onPressed: ()async {
                          var  pickedFile= await ImagePicker().getImage(source: ImageSource.camera);
          if (pickedFile!= null) {
            setState(() {
              _image = File(pickedFile.path);
            });
           
  
      } else {
      Scaffold.of(context).showSnackBar(SnackBar(content: Text("Please add your picture "),backgroundColor: Colors.red,duration:Duration(seconds: 2) ,));
      }}
                            
                           
                         
                         ),
                        ),
                       if(!islogin) SizedBox(
                      height: MediaQuery.of(context).size.height*.006,
                      ),

                        TextFormField(
                       decoration: InputDecoration(
                       labelText:"Email Address"
                       ),
                       obscureText: false,
                       onChanged: (value){
                         email=value;
                       },
                       controller:_email ,
                       validator: (value){
                         
                          if(value.isEmpty)
                          return 'this should not be empty';
                           return null;
                        }
                      
                      
                      ),

                      SizedBox(
                      height: MediaQuery.of(context).size.height*.016,
                      ),
                      if(islogin==false)
                      TextFormField(
                       decoration: InputDecoration(
                       labelText:"Username"
                       ),
                       obscureText: false,
                       onChanged: (value){
                         username=value;
                       },
                       controller:_username,
                      
                      
                      
                      ),
                       

                       SizedBox(
                      height: MediaQuery.of(context).size.height*.016,
                      ),
                      TextFormField(
                       decoration: InputDecoration(
                       labelText:"Password"
                       ),
                       obscureText: true,
                       onChanged: (value){
                         password=value;
                       },
                       controller:_password,
                       validator: (value){
                         
                          if(value.isEmpty)
                          return 'this should not be empty';
                           return null;
                        }
                      
                      
                      ),
                      
                     
                      SizedBox(
                      height: MediaQuery.of(context).size.height*.012,
                      ),


                        Center(
                         child: istrue?CircularProgressIndicator()  :RaisedButton(onPressed: (){
                       _trysubmit();
                           
                         },child: Text(islogin==true?"Log In":"Sign Up",style: TextStyle(color: Colors.white),),
                         color: Colors.pink[300]
                         )
                         
                        ),

                      SizedBox(
                      height: MediaQuery.of(context).size.height*.006,
                      ),

                      
                      Center(
                         child: FlatButton(child: Text(islogin==false?"I already have an account":"Create a new account",style: TextStyle(color: Colors.red),),
                         onPressed: (){
                           setState(() {
                             
                             islogin=!islogin;
                             if(_email!=null)
                             _email.clear();
                             if(_password!=null)
                             _password.clear();
                             if(_username!=null)
                             _username.clear();
                           }
                            
                           );
                         },
                         ),
                        ),
        
                    ],)),
                  )
                  
                  )
      
    );
            

  }
}