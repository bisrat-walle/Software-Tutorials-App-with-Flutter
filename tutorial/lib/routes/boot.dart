import 'package:flutter/material.dart';
import 'login.dart';
import 'package:lottie/lottie.dart';
class Boot extends StatefulWidget {
  @override
  _BootState createState() => _BootState();
}
class _BootState extends State<Boot> {
   @override
  void initState(){
    Future.delayed(Duration(seconds: 10),(){
      Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=> const Login()));
    });
      super.initState();
    }

  @override
  Widget build (BuildContext context){
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(),
      body:Container(
        alignment: Alignment.center,
        child:Column(
        children: [SizedBox(
          height:200,
          width:200,
          child:Lottie.asset("assets/lotties/boot.json"),),
          SizedBox(height: 20,),Text("Tutorials")],mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,)));
  }
}
